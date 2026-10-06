#!/usr/bin/env python3
"""FS131-L10B: every head's statement as the kernel holds it, against the binders its file shows (the brief's step 4).

Inventory item 556: at the pin a section `variable` enters a theorem only if the theorem's statement mentions it, so a
file's reader can see a hypothesis that the kernel's statement lacks, and a check that compares text passes the whole
class. This reader compares two things that are not both text:

  kernel   the output of `data/fs131/l10b/kernel-sigs.lean` — for each theorem or axiom, the `∀`-binders of the
           constant's stored type (`BINDER <explicit|implicit|strict|inst> <prop|data> <name> : <type>`);
  file     the declaration's own signature in its `.lean` file (the binder groups between its name and the colon),
           and every typed `variable` binder in scope at it (sections and namespaces tracked; `variable … in`,
           `include`, `omit … in` read).

  tools/fs131_l10b_kernelsig.py read <kernel-sigs.out> [--reviewed FILE] [--heads FILE] [--table OUT]
  tools/fs131_l10b_kernelsig.py --self-test <kernel-sigs.out> [--reviewed FILE]

Per declaration:
  MISSING-BINDER   a named binder of the file's own signature is not a binder of the kernel's statement (fails);
  NOT-FOUND        the declaration's text was not found in its module's file (fails: nothing was compared);
  ABSENT           a `variable` binder in scope that the kernel's statement does not hold, by class:
                     type  — a `{X : Type*}`-shaped binder (no content);
                     inst  — an instance binder `[C x]`;
                     term  — any other named binder (data or a hypothesis).
                   A binder the file itself drops with `omit … in` above the declaration is OMITTED, not ABSENT:
                   the file's reader sees it. A theorem Lean generates (`f.eq_1`, `f.congr_simp`, `mk.inj`, …; the
                   pattern of `tools/fs131_l5_records.py`) has no text in the file and is counted, not compared.
                   An ABSENT inst or term is the class of item 556. It fails unless `--reviewed` lists the line
                   `<full name>\t<binder text>\t<reason>` — the reading by eye, kept as a file so the check re-runs.
  INCLUDED         a `variable` binder in scope that the kernel's statement holds (counted).
Named binders are matched by name; instance binders by their type's text with qualifying prefixes dropped and
whitespace collapsed (an instance binder of the file's own signature that matches no kernel binder that way is printed
as UNMATCHED-INST and does not fail: notation can differ; it is read by eye in the table).

`--heads FILE`: one full name per line; each must have a record (NO-RECORD fails) — so a head the records name cannot
be skipped in silence. `--table OUT`: one block per declaration (the kernel's SIG line, the file's binders, the verdicts).
Exit 0 iff no MISSING-BINDER, NOT-FOUND, NO-RECORD and no unreviewed ABSENT inst/term.

--self-test: `read` must pass; then three plants, each of which must fail with its own word, beside a partner that must
pass: (1) a prop binder of the kernel's record dropped where the file's signature names it (MISSING-BINDER);
(2) a hypothesis `variable (hplant : (1 : Nat) = 1)` planted in a scratch copy of a module, in scope of its theorems
(ABSENT term, on every theorem of that scope — the file's reader sees a hypothesis the kernel lacks); (3) a head with
no record (NO-RECORD). Partner: one section variable is read both ways — `Floor128`'s `(t : R)` is INCLUDED in the
theorems whose statements mention it and ABSENT in those that do not — so neither verdict is a blanket one.
"""
import os
import re
import sys
import tempfile

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DECL = re.compile(r'^(?:@\[[^\]]*\]\s*)*(?:private |protected |noncomputable |scoped |local )*'
                  r'(theorem|lemma|axiom|instance|def|abbrev)\s+(\S+)')
GENERATED = re.compile(r"\.(eq_\d+|eq_def|congr_simp|brecOn|binductionOn)$|\.mk\.(inj|injEq|sizeOf_spec)$")
OPEN = {'(': ')', '{': '}', '[': ']', '⦃': '⦄'}
CLOSE = {v: k for k, v in OPEN.items()}


def parse_kernel(path):
    recs, cur = {}, None
    for ln in open(path, encoding='utf-8').read().split('\n'):
        if ln.startswith('@@ '):
            _, kind, mod, name = ln.split(' ', 3)
            cur = {'kind': kind, 'module': mod, 'name': name, 'sig': '', 'binders': [], 'concl': ''}
            recs[name] = cur
        elif cur is not None and ln.startswith('SIG '):
            cur['sig'] = ln[4:]
        elif cur is not None and ln.startswith('BINDER '):
            _, bi, sort, rest = ln.split(' ', 3)
            nm, _, ty = rest.partition(' : ')
            cur['binders'].append((bi, sort, nm, ty))
        elif cur is not None and ln.startswith('CONCL '):
            cur['concl'] = ln[6:]
    return recs


def strip_comments(text):
    """Comments blanked, line structure kept. Block comments nest; strings are not parsed (none hold `/-`)."""
    out, i, n, depth = [], 0, len(text), 0
    while i < n:
        if text.startswith('/-', i):
            depth += 1
            out.append('  ')
            i += 2
        elif depth and text.startswith('-/', i):
            depth -= 1
            out.append('  ')
            i += 2
        elif depth:
            out.append('\n' if text[i] == '\n' else ' ')
            i += 1
        elif text.startswith('--', i):
            j = text.find('\n', i)
            j = n if j < 0 else j
            out.append(' ' * (j - i))
            i = j
        else:
            out.append(text[i])
            i += 1
    return ''.join(out)


def groups(s):
    """The top-level bracket groups of `s`, in order, until a top-level ':' (returned with what follows it)."""
    out, i, n = [], 0, len(s)
    while i < n:
        ch = s[i]
        if ch in OPEN:
            depth, j = 1, i + 1
            while j < n and depth:
                if s[j] in OPEN:
                    depth += 1
                elif s[j] in CLOSE:
                    depth -= 1
                j += 1
            out.append(s[i:j])
            i = j
        elif ch == ':':
            return out, s[i + 1:]
        else:
            i += 1
    return out, ''


def binders(group):
    """[(class, name-or-None, type text, group text)] of one bracket group; [] for a binder update with no type."""
    inner = group[1:-1].strip()
    if group[0] == '[':
        nm = None
        m = re.match(r'^(\S+)\s*:\s*(.*)$', inner, re.S)
        if m and re.match(r"^[A-Za-z_𝒜][\w'₀-₉𝒜]*$", m.group(1)):
            nm, inner = m.group(1), m.group(2)
        return [('inst', nm, ' '.join(inner.split()), ' '.join(group.split()))]
    if ':' not in inner:
        return []
    names, _, ty = inner.partition(':')
    ty = ' '.join(ty.split())
    cls = 'type' if re.match(r'^(Type|Sort)\b', ty) else 'term'
    return [(cls, nm, ty, ' '.join(group.split())) for nm in names.split()]


def norm_type(t):
    t = re.sub(r"\b(?:[A-Za-z_][\w']*\.)+(?=[A-Za-z_])", '', t)
    return ' '.join(t.replace('↥', '').split())


def file_decls(path):
    """{qualified name: (own binders, in-scope variable binders, signature text)} for the file's declarations."""
    text = strip_comments(open(path, encoding='utf-8').read())
    lines = text.split('\n')
    stack = [{'ns': '', 'vars': [], 'incl': set()}]
    out, pending_omit, pending_var = {}, [], []
    i, n = 0, len(lines)

    def command_text(i):
        j = i + 1
        while j < n and (lines[j].startswith((' ', '\t')) and lines[j].strip()):
            j += 1
        return ' '.join(' '.join(lines[i:j]).split()), j

    while i < n:
        ln = lines[i]
        m = re.match(r'^namespace\s+(\S+)', ln)
        if m:
            stack.append({'ns': m.group(1), 'vars': [], 'incl': set()})
            i += 1
            continue
        if re.match(r'^(?:noncomputable\s+)?section\b', ln):
            stack.append({'ns': None, 'vars': [], 'incl': set()})
            i += 1
            continue
        if re.match(r'^end\b', ln) and len(stack) > 1:
            stack.pop()
            i += 1
            continue
        if ln.startswith('variable'):
            cmd, j = command_text(i)
            only_next = cmd.endswith(' in')
            gs, _ = groups(cmd[len('variable'):])
            bs = [b for g in gs for b in binders(g)]
            (pending_var if only_next else stack[-1]['vars']).extend(bs)
            i = j
            continue
        if ln.startswith('include'):
            cmd, j = command_text(i)
            stack[-1]['incl'].update(w for w in cmd.split()[1:] if w != 'in')
            i = j
            continue
        if ln.startswith('omit'):
            cmd, j = command_text(i)
            gs, _ = groups(cmd[len('omit'):])
            pending_omit.extend(' '.join(g.split()) for g in gs)
            pending_omit.extend(w for w in re.sub(r'\[[^\]]*\]', ' ', cmd[len('omit'):]).split() if w != 'in')
            i = j
            continue
        m = DECL.match(ln)
        if m and (m.group(1) in ('theorem', 'lemma', 'axiom') or (m.group(1) == 'instance' and m.group(2) != ':')):
            j = i + 1
            while j < n and not (lines[j].strip() == '' and (j + 1 >= n or not lines[j + 1].startswith((' ', '\t')))):
                j += 1
            body = ' '.join(' '.join(lines[i:j]).split())
            after = body[m.end():]
            # an explicit universe list `.{u}` belongs to the name
            name = m.group(2).split('.{')[0]
            gs, _ = groups(after)
            own = [b for g in gs for b in binders(g)]
            scope = [b for fr in stack for b in fr['vars']] + pending_var
            incl = set().union(*[fr['incl'] for fr in stack])
            ns = '.'.join(fr['ns'] for fr in stack if fr['ns'])
            q = (ns + '.' if ns else '') + name
            out[q] = (own, scope, incl, list(pending_omit), body.split(' :=')[0])
            pending_omit, pending_var = [], []
            i = j
            continue
        if m:
            pending_omit, pending_var = [], []
        i += 1
    return out


def module_path(mod, override=None):
    if override and mod in override:
        return override[mod]
    return os.path.join(ROOT, *mod.split('.')) + '.lean'


def read(recs, reviewed, heads=None, table=None, override=None, quiet=False):
    faults, absent_flagged, rows = [], [], []
    cache = {}
    n_incl = n_abs_type = n_abs = n_omit = 0
    for name in (heads or []):
        if name not in recs:
            faults.append(f'NO-RECORD {name}')
    generated = [n_ for n_ in recs if GENERATED.search(n_)]
    for name, r in recs.items():
        if GENERATED.search(name):
            continue
        p = module_path(r['module'], override)
        if p not in cache:
            cache[p] = file_decls(p) if os.path.isfile(p) else {}
        d = cache[p].get(name)
        if d is None:
            faults.append(f'NOT-FOUND {name} in {os.path.relpath(p, ROOT)}')
            continue
        own, scope, incl, omits, sigtext = d
        knames = {b[2] for b in r['binders'] if b[0] != 'inst'}
        kinst = [norm_type(b[3]) for b in r['binders'] if b[0] == 'inst']
        notes = []
        for cls, nm, ty, g in own:
            if cls == 'inst':
                if norm_type(ty) not in kinst:
                    notes.append(f'UNMATCHED-INST {g}')
            elif nm not in knames and nm != '_':
                faults.append(f'MISSING-BINDER {name}: `{g}` of the file\'s signature is no binder of the kernel\'s statement')
                notes.append(f'MISSING-BINDER {g}')
        for cls, nm, ty, g in scope:
            held = (norm_type(ty) in kinst) if cls == 'inst' else (nm in knames)
            if not held and (g in omits or (nm and nm in omits)):
                n_omit += 1
                notes.append(f'OMITTED {g} (the file says `omit … in` above the declaration)')
            elif held:
                n_incl += 1
                notes.append(f'INCLUDED {g}' + (' (include)' if nm in incl else ''))
            elif cls == 'type':
                n_abs_type += 1
            else:
                n_abs += 1
                key = (name, g)
                why = reviewed.get(key)
                notes.append(f'ABSENT {cls} {g}' + (f' — reviewed: {why}' if why else ' — NOT REVIEWED'))
                absent_flagged.append((name, cls, g, why))
                if not why:
                    faults.append(f'ABSENT {cls} {name}: variable `{g}` in scope, not in the kernel\'s statement, not reviewed')
        rows.append((name, r, sigtext, notes))
    if table:
        with open(table, 'w', encoding='utf-8') as f:
            for name, r, sigtext, notes in rows:
                f.write(f'## {r["kind"]} {name}  ({r["module"]})\n')
                f.write(f'kernel: {r["sig"]}\n')
                f.write(f'file:   {sigtext}\n')
                props = [f'({b[2]} : {b[3]})' for b in r['binders'] if b[1] == 'prop' and b[0] != 'inst']
                f.write(f'kernel hypotheses (prop binders, named): {len(props)}' + (': ' + '; '.join(props) if props else '') + '\n')
                for nt in notes:
                    f.write(f'  {nt}\n')
                f.write('\n')
    if not quiet:
        print(f'records read: {len(recs)} (theorems {sum(r["kind"] == "THM" for r in recs.values())}, '
              f'axioms {sum(r["kind"] == "AXIOM" for r in recs.values())}); generated by Lean, not compared: '
              f'{len(generated)}; compared with their files: {len(rows)}')
        print(f'section variables in scope: INCLUDED {n_incl}; OMITTED by the file\'s own `omit … in` {n_omit}; '
              f'ABSENT type-binders {n_abs_type}; '
              f'ABSENT inst/term {n_abs} (reviewed {sum(1 for a in absent_flagged if a[3])}, '
              f'not reviewed {sum(1 for a in absent_flagged if not a[3])})')
        for a in absent_flagged:
            print(f'  ABSENT {a[1]:4s} {a[0]}  {a[2]}  ' + (f'[{a[3]}]' if a[3] else '[NOT REVIEWED]'))
        for f_ in faults[:40]:
            print('  FAULT ' + f_)
        print('kernel-signatures: PASS' if not faults else f'kernel-signatures: FAIL ({len(faults)} fault(s))')
    return faults, rows


def load_reviewed(path):
    out = {}
    if path and os.path.isfile(path):
        for ln in open(path, encoding='utf-8').read().split('\n'):
            if ln.strip() and not ln.startswith('#'):
                parts = ln.split('\t')
                if len(parts) >= 3:
                    out[(parts[0], parts[1])] = parts[2]
    return out


def main(argv):
    def opt(flag):
        if flag in argv:
            i = argv.index(flag)
            v = argv[i + 1]
            del argv[i:i + 2]
            return v
        return None
    reviewed = load_reviewed(opt('--reviewed'))
    heads_f, table = opt('--heads'), opt('--table')
    heads = [l.strip() for l in open(heads_f, encoding='utf-8')] if heads_f else None
    heads = [h for h in heads if h and not h.startswith('#')] if heads else None
    if len(argv) == 2 and argv[0] == 'read':
        recs = parse_kernel(argv[1])
        if not recs:
            print('FAIL: no record read')
            return 2
        faults, _ = read(recs, reviewed, heads, table)
        return 1 if faults else 0
    if len(argv) == 2 and argv[0] == '--self-test':
        recs = parse_kernel(argv[1])
        faults, rows = read(recs, reviewed, heads)
        ok = not faults
        # plant 1: drop a named prop binder of the kernel's record that the file's signature names
        import copy
        victim = None
        for name, r, _, _ in rows:
            p = module_path(r['module'])
            own = file_decls(p)[name][0]
            own_names = {b[1] for b in own if b[0] != 'inst'}
            cand = [b for b in r['binders'] if b[1] == 'prop' and b[0] == 'explicit' and b[2] in own_names]
            if cand:
                victim = (name, cand[0])
                break
        if victim is None:
            print('plant 1: COULD NOT BE PLANTED')
            ok = False
        else:
            recs1 = copy.deepcopy(recs)
            recs1[victim[0]]['binders'].remove(victim[1])
            f1, _ = read(recs1, reviewed, quiet=True)
            fired = any(x.startswith('MISSING-BINDER ' + victim[0]) for x in f1)
            print(f'plant 1 (kernel record of {victim[0]} loses `({victim[1][2]} : …)`): '
                  f'{"fired (MISSING-BINDER)" if fired else "DID NOT FIRE"}')
            ok = ok and fired
        # plant 2: a hypothesis variable planted in scope of a module's theorems
        mod = 'Proofs.HadwigerNelson.Arith.NormOneTarget'
        src = open(module_path(mod), encoding='utf-8').read()
        anchor = 'namespace HadwigerNelson.StandingFive\n'
        if anchor not in src:
            print('plant 2: COULD NOT BE PLANTED')
            ok = False
        else:
            with tempfile.NamedTemporaryFile('w', suffix='.lean', delete=False, encoding='utf-8') as f:
                f.write(src.replace(anchor, anchor + '\nvariable (hplant : (1 : Nat) = 1)\n', 1))
            f2, _ = read(recs, reviewed, quiet=True, override={mod: f.name})
            in_mod = [n_ for n_, r in recs.items() if r['module'] == mod and not GENERATED.search(n_)]
            hit = [n_ for n_ in in_mod if any(x.startswith(f'ABSENT term {n_}:') and 'hplant' in x for x in f2)]
            fired = bool(in_mod) and len(hit) == len(in_mod)
            print(f'plant 2 (`variable (hplant : (1 : Nat) = 1)` in scope of {mod}): '
                  f'{"fired (ABSENT term) on " + str(len(hit)) + " of " + str(len(in_mod)) + " theorems" if fired else "DID NOT FIRE"}')
            ok = ok and fired
            os.unlink(f.name)
        # plant 3: a head with no record
        f3, _ = read(recs, reviewed, heads=['HadwigerNelson.NoSuch.head'], quiet=True)
        fired = any(x.startswith('NO-RECORD ') for x in f3)
        print(f'plant 3 (a head with no record): {"fired (NO-RECORD)" if fired else "DID NOT FIRE"}')
        ok = ok and fired
        # partner: one section variable read both ways — INCLUDED where the statement mentions it, ABSENT where not
        f128 = [nt for name, r, _, notes in rows if r['module'].endswith('.Floor128') for nt in notes]
        n_in = sum(nt.startswith('INCLUDED (t : R)') for nt in f128)
        n_ab = sum(nt.startswith('ABSENT term (t : R)') for nt in f128)
        pok = n_in > 0 and n_ab > 0
        print(f'partner (`Floor128`\'s section variable `(t : R)`: INCLUDED in {n_in} theorem(s), ABSENT in {n_ab}): '
              f'{"passed" if pok else "FAILED"}')
        ok = ok and pok
        print('self-test: PASS' if ok else 'self-test: FAIL')
        return 0 if ok else 1
    print(__doc__)
    return 2


if __name__ == '__main__':
    sys.exit(main(sys.argv[1:]))
