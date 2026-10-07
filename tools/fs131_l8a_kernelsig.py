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
`--heads`, `--table`, and its own `--self-test`.

  tools/fs131_l8a_kernelsig.py read <kernel-sigs.out> [--reviewed FILE] [--heads FILE] [--table OUT]
  tools/fs131_l8a_kernelsig.py --self-test <kernel-sigs.out> [--reviewed FILE]
  tools/fs131_l8a_kernelsig.py --plant <kernel-sigs.out>
      three records planted in memory, none of which may be exempted: a name `<S>.<g>` where `<g>` is no field of the
      structure; `<E>.<c>.sizeOf_spec` where `<c>` is no constructor; and a plain theorem name with no text. Each must read
      NOT-FOUND from the reader; and one true field must be exempted (the partner). Exit 0 iff all four behave.
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
