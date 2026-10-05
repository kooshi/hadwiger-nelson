#!/usr/bin/env python3
"""FS131-K2d: every theorem this job adds has a `#print axioms` record in scripts/Axioms.lean.

Compares the theorem/lemma names in the job's files against the base commit (29082313), maps each to its fully qualified name
by the file's namespace, and checks `scripts/Axioms.lean`. `--write` appends the missing records in a block "FS131-K2d" just
before `=== PURCHASED ===`. `--plant` hides one record from the check and must FAIL (exit 1).
Usage: python3 tools/fs131_k2d_records.py [--write | --plant]
"""
import re, subprocess, sys

BASE = '29082313'
FILES = {
    'Proofs/HadwigerNelson/Plane/CoverExamples.lean': 'HadwigerNelson.Plane.',
    'Proofs/HadwigerNelson/Arith/PlaceHom.lean': 'HadwigerNelson.Arith.',
    'Proofs/HadwigerNelson/Arith/FalconerField.lean': 'HadwigerNelson.Arith.',
    'Proofs/HadwigerNelson/Instances/FalconerOrbit.lean': 'HadwigerNelson.',
}
DECL = re.compile(r'^\s*(?:@\[[^\]]*\]\s*)?(?:private |protected |noncomputable )*(?:theorem|lemma)\s+(\S+)', re.M)

def names(text):
    return DECL.findall(text)

def base_text(f):
    r = subprocess.run(['git', 'show', f'{BASE}:{f}'], capture_output=True, text=True)
    return r.stdout if r.returncode == 0 else ''

def main():
    mode = sys.argv[1] if len(sys.argv) > 1 else ''
    new = []
    for f, ns in FILES.items():
        old = set(names(base_text(f)))
        for n in names(open(f).read()):
            if n not in old:
                new.append(ns + n)
    ax = open('scripts/Axioms.lean').read()
    recorded = set(re.findall(r'#print axioms (\S+)', ax))
    if mode == '--plant' and new:
        recorded.discard(new[0])
    missing = [n for n in new if n not in recorded]
    print(f'new theorems: {len(new)}; missing records: {len(missing)}')
    for n in missing:
        print('  missing', n)
    if mode == '--write' and missing:
        block = '-- FS131-K2d: wave 2 children (sorry until the implementer closes them; the orbit and slack facts proved)\n' + \
            ''.join(f'#print axioms {n}\n' for n in missing) + '\n'
        i = ax.index('#eval IO.println "=== PURCHASED ==="')
        if '-- FS131-K2d:' in ax:
            j = ax.index('\n\n', ax.index('-- FS131-K2d:'))
            ax = ax[:j] + '\n' + ''.join(f'#print axioms {n}' + '\n' for n in missing).rstrip('\n') + ax[j:]
        else:
            ax = ax[:i] + block + ax[i:]
        open('scripts/Axioms.lean', 'w').write(ax)
        print('written')
        return 0
    return 1 if missing else 0

if __name__ == '__main__':
    sys.exit(main())
