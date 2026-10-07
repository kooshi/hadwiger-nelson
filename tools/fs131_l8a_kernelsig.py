#!/usr/bin/env python3
"""FS131-L8A — every theorem of the landing's twelve modules as the kernel holds it, against its file: the last landing's
reader (`tools/fs131_l10b_kernelsig.py`, another job's; imported, not edited) with one class added that its modules did not
have — theorems Lean generates from a `structure` or an `inductive` of the module, which have no `theorem` text to compare.

That reader counts as generated, and does not compare, the names of one pattern (`f.eq_1`, `mk.inj`, …); any other theorem
with no text in its module's file is NOT-FOUND, a fault: nothing was compared. Wave 8 declares a `Prop`-valued structure
(`IsStar4`, ten fields — each field is a theorem to the kernel) and an enumeration (`SemiKind`), so thirteen theorems the
kernel holds have no declaration of their own. This wrapper does not exempt them by name. For each record with no text it
looks for the reason in the module's own file and exempts the record only if it finds it:

  FIELD  the name is `<S>.<f>` and the file (comments blanked) declares `structure <S> … where` with a field line `<f> :`
         inside that block. Printed with the field's line and the kernel's conclusion, to be read side by side.
  ENUM   the name is `<E>.<c>.sizeOf_spec` for a constructor line `| <c>` of an `inductive <E>` of the file, or
         `<E>.ofNat_ctorIdx` for such an inductive.

Everything else the reader does is unchanged: MISSING-BINDER, NOT-FOUND for any other name, ABSENT with `--reviewed`,
`--heads`, `--table`.

  tools/fs131_l8a_kernelsig.py read <kernel-sigs.out> [--reviewed FILE] [--heads FILE] [--table OUT]
  tools/fs131_l8a_kernelsig.py --plant <kernel-sigs.out>
      (a) the exemption: three records planted in memory, none of which may be exempted — a name `<S>.<g>` where `<g>` is
          no field of the structure; `<E>.<c>.sizeOf_spec` where `<c>` is no constructor; a plain theorem name with no
          text. Each must read NOT-FOUND from the reader; and one true field must be exempted (the partner).
      (b) the reader's own four checks, on this landing's modules. Its `--self-test` plants its second fault in
          `Arith/NormOneTarget` and reads its partner in `Arith/Floor128` — modules of the landing it was written for,
          which a listing of the ring calculus does not hold, so there it reports DID NOT FIRE and FAILED for want of
          records. Re-made here: a named hypothesis of `emptyNS` dropped from the kernel's record (MISSING-BINDER);
          `variable (hplant : (1 : Nat) = 1)` planted in a scratch copy of `Plane/RingCalculus/OuterAdj`, in scope of
          its theorems (ABSENT term on every one of them — inventory item 556's class: the file's reader sees a
          hypothesis the kernel lacks); a head with no record (NO-RECORD); and the partner, one section variable read
          both ways — `Empty`'s `{F : ArcMap k}` INCLUDED where a statement mentions it and ABSENT where none does.
      Exit 0 iff all eight behave.
"""
import os
import re
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fs131_l10b_kernelsig as base  # noqa: E402

BASE_GENERATED = base.GENERATED.pattern


def blocks(path):
    """({structure short name: {field: line text}}, {inductive short name: [constructors]}) of a file, comments blanked."""
    text = base.strip_comments(open(path, encoding='utf-8').read())
    lines = text.split('\n')
    structs, inducts = {}, {}
    i, n = 0, len(lines)
    while i < n:
        m = re.match(r'^(?:@\[[^\]]*\]\s*)?structure\s+(\S+)', lines[i])
        mi = re.match(r'^(?:@\[[^\]]*\]\s*)?inductive\s+(\S+)', lines[i])
        if m or mi:
            name = (m or mi).group(1)
            j = i + 1
            body = []
            while j < n and (lines[j].startswith((' ', '\t')) or not lines[j].strip()):
                body.append(lines[j])
                j += 1
            if m:
                fields = {}
                for b in body:
                    f = re.match(r'^\s+([^\s:(){}\[\]]+)\s*:', b)
                    if f:
                        fields[f.group(1)] = ' '.join(b.split())
                structs[name] = fields
            else:
                inducts[name] = [c.group(1) for b in body for c in [re.match(r'^\s*\|\s*([^\s:]+)', b)] if c]
            i = j
        else:
            i += 1
    return structs, inducts


def reason(name, path, cache):
    """Why a record with no text is a theorem Lean generated from a declaration of its file — or None."""
    if path not in cache:
        cache[path] = blocks(path) if os.path.isfile(path) else ({}, {})
    structs, inducts = cache[path]
    parts = name.split('.')
    if len(parts) >= 2 and parts[-2] in structs and parts[-1] in structs[parts[-2]]:
        return f'FIELD of structure {parts[-2]}: `{structs[parts[-2]][parts[-1]]}`'
    if len(parts) >= 3 and parts[-1] == 'sizeOf_spec' and parts[-3] in inducts and parts[-2] in inducts[parts[-3]]:
        return f'ENUM: sizeOf_spec of the constructor `{parts[-2]}` of inductive {parts[-3]}'
    if len(parts) >= 2 and parts[-1] == 'ofNat_ctorIdx' and parts[-2] in inducts:
        return f'ENUM: ofNat_ctorIdx of inductive {parts[-2]}'
    return None


def exempt_generated(recs, quiet=False):
    """Extend the reader's GENERATED pattern by exactly the records that have no text and a found reason."""
    old = re.compile(BASE_GENERATED)
    cache, dcache, found = {}, {}, []
    for name, r in recs.items():
        if old.search(name):
            continue
        p = base.module_path(r['module'], None)
        if p not in dcache:
            dcache[p] = base.file_decls(p) if os.path.isfile(p) else {}
        if name in dcache[p]:
            continue
        why = reason(name, p, cache)
        if why:
            found.append((name, why, r['concl']))
    if found:
        base.GENERATED = re.compile(BASE_GENERATED + '|^(?:' + '|'.join(re.escape(n) for n, _, _ in found) + ')$')
    else:
        base.GENERATED = old
    if not quiet:
        print(f'generated from a structure or an inductive of the module, no text of their own: {len(found)}')
        for name, why, concl in found:
            print(f'  EXEMPT {name}\n      {why}\n      kernel concludes: {concl}')
    return found


def main(argv):
    if argv and argv[0] == '--plant':
        recs = base.parse_kernel(argv[1])
        true_field = next((n for n in recs if n.endswith('.IsStar4.cone₁')), None)
        if true_field is None:
            print('PLANT: no record `….IsStar4.cone₁` to stand as the partner')
            return 2
        mod = recs[true_field]['module']
        ns = true_field[:-len('IsStar4.cone₁')]
        plants = {
            ns + 'IsStar4.zzNoSuchField': 'a name `<S>.<g>` where `<g>` is no field',
            ns + 'SemiKind.ZZ.sizeOf_spec': '`<E>.<c>.sizeOf_spec` where `<c>` is no constructor',
            ns + 'zz_plain_theorem_with_no_text': 'a plain theorem name with no text',
        }
        for n in plants:
            recs[n] = {'kind': 'THM', 'module': mod, 'name': n, 'sig': n + ' : True', 'binders': [], 'concl': 'True'}
        found = {n for n, _, _ in exempt_generated(recs, quiet=True)}
        faults, _ = base.read(recs, {}, quiet=True)
        ok = True
        for n, what in plants.items():
            fired = (n not in found) and any(f.startswith('NOT-FOUND ' + n) for f in faults)
            print(f'plant ({what}): {"NOT-FOUND fired, not exempted" if fired else "DID NOT FIRE"}')
            ok &= fired
        partner = true_field in found and not any(f.startswith('NOT-FOUND ' + true_field) for f in faults)
        print(f'partner (a true field, {true_field}): {"exempted with its field line" if partner else "NOT exempted"}')
        ok &= partner
        # (b) the reader's own four checks, on this landing's modules
        import copy
        import tempfile
        recs = base.parse_kernel(argv[1])
        exempt_generated(recs, quiet=True)
        faults0, rows0 = base.read(recs, {}, quiet=True)
        head = ns + 'emptyNS'
        victim = next((b for b in recs[head]['binders'] if b[2] == 'hΓ'), None) if head in recs else None
        if victim is None:
            print('plant (a named hypothesis dropped from the kernel record): COULD NOT BE PLANTED')
            ok = False
        else:
            recs1 = copy.deepcopy(recs)
            recs1[head]['binders'].remove(victim)
            f1, _ = base.read(recs1, {}, quiet=True)
            fired = any(x.startswith('MISSING-BINDER ' + head) for x in f1) and \
                not any(x.startswith('MISSING-BINDER ' + head) for x in faults0)
            print(f'plant (the kernel record of {head} loses `(hΓ : …)`): {"fired (MISSING-BINDER)" if fired else "DID NOT FIRE"}')
            ok &= fired
        mod = 'Proofs.HadwigerNelson.Plane.RingCalculus.OuterAdj'
        src = open(base.module_path(mod), encoding='utf-8').read()
        anchor = 'namespace HadwigerNelson.Plane\n'
        if src.count(anchor) != 1:
            print('plant (a hypothesis variable in scope): COULD NOT BE PLANTED')
            ok = False
        else:
            with tempfile.NamedTemporaryFile('w', suffix='.lean', delete=False, encoding='utf-8') as f:
                f.write(src.replace(anchor, anchor + '\nvariable (hplant : (1 : Nat) = 1)\n', 1))
            f2, _ = base.read(recs, {}, quiet=True, override={mod: f.name})
            os.unlink(f.name)
            in_mod = [n_ for n_, r in recs.items() if r['module'] == mod and not base.GENERATED.search(n_)]
            hit = [n_ for n_ in in_mod if any(x.startswith(f'ABSENT term {n_}:') and 'hplant' in x for x in f2)]
            before = [x for x in faults0 if 'hplant' in x]
            fired = bool(in_mod) and len(hit) == len(in_mod) and not before
            print(f'plant (`variable (hplant : (1 : Nat) = 1)` in scope of {mod}): '
                  f'{"fired (ABSENT term) on " + str(len(hit)) + " of " + str(len(in_mod)) + " theorems" if fired else "DID NOT FIRE"}')
            ok &= fired
        f3, _ = base.read(recs, {}, heads=['HadwigerNelson.NoSuch.head'], quiet=True)
        fired = any(x.startswith('NO-RECORD ') for x in f3) and not any(x.startswith('NO-RECORD ') for x in faults0)
        print(f'plant (a head with no record): {"fired (NO-RECORD)" if fired else "DID NOT FIRE"}')
        ok &= fired
        notes_e = [nt for name, r, _, notes in rows0 if r['module'].endswith('.RingCalculus.Empty') for nt in notes]
        n_in = sum(nt.startswith('INCLUDED {F : ArcMap k}') for nt in notes_e)
        n_ab = sum(nt.startswith('ABSENT term {F : ArcMap k}') for nt in notes_e)
        pok = n_in > 0 and n_ab > 0
        print(f"partner (`Empty`'s section variable `{{F : ArcMap k}}`: INCLUDED in {n_in} theorem(s), ABSENT in {n_ab}): "
              f'{"passed" if pok else "FAILED"}')
        ok &= pok
        print('plant: PASS' if ok else 'plant: FAIL')
        return 0 if ok else 1
    path = argv[1] if len(argv) >= 2 and argv[0] in ('read', '--self-test') else None
    if path is None:
        print(__doc__)
        return 2
    exempt_generated(base.parse_kernel(path))
    return base.main(list(argv))


if __name__ == '__main__':
    sys.exit(main(sys.argv[1:]))
