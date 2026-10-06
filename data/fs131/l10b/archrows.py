#!/usr/bin/env python3
"""FS131-L10B: the five rows of ARCHITECTURE.md this landing rewrote — each exists once, none says "skeleton", and every
backticked token of its description shaped like a declaration name is declared in the row's module, in another module of
`Arith/`, or elsewhere under `Proofs/` (MISSING otherwise). --self-test: a cited name misspelt must read MISSING, and a row
saying "skeleton" must fail on that word."""
import re, subprocess, sys
MODS = ['NormOneTarget', 'FloorPlanes', 'ProductFactor', 'MajorityVote', 'NegCircleModel']
SKIP = {'sorry', 'Prop', 'axiom'}
def declared(name, path):
    last = name.split('.')[-1]
    pat = r'^(?:@\[[^\]]*\]\s*)*(?:private |protected |noncomputable |scoped |local )*(?:theorem|lemma|def|abbrev|structure|instance|inductive|class|axiom)\s+(?:\S+\.)?' + re.escape(last) + r'(?:\.\{[^}]*\})?[\s:({\[]'
    r = subprocess.run(['grep', '-rlP', pat, path], capture_output=True, text=True)
    return bool(r.stdout.strip())
def run(text, quiet=False):
    bad, n = [], 0
    for m in MODS:
        rows = [l for l in text.split('\n') if l.startswith(f'| `Arith/{m}` |')]
        if len(rows) != 1:
            bad.append(f'ROWS Arith/{m}: {len(rows)}'); continue
        desc = rows[0].split(' | ')[1]
        if 'skeleton' in desc:
            bad.append(f'SKELETON Arith/{m}')
        for tok in re.findall(r'`([^`]+)`', desc):
            if not re.match(r"^[A-Za-z_][\w'.₀-₉]*$", tok) or tok in SKIP or '/' in tok:
                continue
            n += 1
            if not (declared(tok, f'Proofs/HadwigerNelson/Arith/{m}.lean') or declared(tok, 'Proofs/HadwigerNelson/Arith') or declared(tok, 'Proofs')):
                bad.append(f'MISSING Arith/{m}: `{tok}`')
    if not quiet:
        for b in bad: print('  ' + b)
        print(f'rows 5; names looked up {n}; ' + ('arch rows: PASS' if not bad else f'arch rows: FAIL ({len(bad)})'))
    return bad
t = open('ARCHITECTURE.md', encoding='utf-8').read()
bad = run(t)
if '--self-test' in sys.argv:
    b1 = run(t.replace('`card_filter_pow_eq_one`', '`card_filter_pow_eq_onee`', 1), quiet=True)
    b2 = run(t.replace('| `Arith/MajorityVote` | **FS-131 wave 10 (FS131-K10b; proved', '| `Arith/MajorityVote` | **FS-131 wave 10 (FS131-K10b), skeleton; proved', 1), quiet=True)
    f1, f2 = any(x.startswith('MISSING') for x in b1), any(x.startswith('SKELETON') for x in b2)
    print(f'plant (a cited name misspelt): {"fired (MISSING)" if f1 else "DID NOT FIRE"}'); print(f'plant (a row saying "skeleton"): {"fired (SKELETON)" if f2 else "DID NOT FIRE"}')
    sys.exit(0 if (not bad and f1 and f2) else 1)
sys.exit(1 if bad else 0)
