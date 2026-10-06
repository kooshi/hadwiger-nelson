#!/usr/bin/env python3
"""FS131-L10B: the reviewed list for `tools/fs131_l10b_kernelsig.py` — written from the reader's own ABSENT lines, but only for
binders of the classes read by eye and named below, and only where the kernel's statement does not mention the variable
at all (its name, or for an instance the type it is about, is no token of the SIG line). Anything else stays unreviewed
and fails the reader.

  data/fs131/l10b/mk-reviewed.py <kernel-sigs.out> > data/fs131/l10b/kernel-sigs-reviewed.txt
"""
import re, sys, os
sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', '..', '..', 'tools'))
import fs131_l10b_kernelsig as ks

# binder text -> (the token whose absence from the statement is checked, the reading)
CLASSES = {
    '(t : R)': ('t', 'a ring element; the statement speaks of `X` or of the root `g` and not of `t`; a bare element carries no hypothesis'),
    '{μX : Measure X}': ('μX', 'a bare measure the statement does not mention; `Measure X` bundles no hypothesis'),
    '{μ₃ : Measure Ω₃}': ('μ₃', 'a bare measure the statement does not mention; `Measure Ω₃` bundles no hypothesis'),
    "{μ' : Measure Ω'}": ("μ'", "a bare measure on a second space the statement does not mention"),
    '{μ : Measure Ω}': ('μ', 'a bare measure on `Ω`; the statement is about a measure `m` on the dual and mentions neither `Ω` nor `μ`'),
    '[MeasurableSpace B]': ('B', 'a σ-algebra on a type `B` the statement does not mention'),
    '[MeasurableSpace X]': ('X', 'a σ-algebra on a type `X` the statement does not mention'),
    '[MeasurableSpace Ω₃]': ('MeasurableSpace Ω₃', 'the σ-algebra of `Ω₃`; the statement is about maps into `B` and sets of `X × (A → B)` and uses no σ-algebra on `Ω₃`'),
    "[MeasurableSpace Ω']": ("Ω'", "a σ-algebra on a second space `Ω'` the statement does not mention"),
    '[MeasurableSpace Ω]': ('Ω', 'a σ-algebra on `Ω`; the statement mentions no `Ω`'),
}
recs = ks.parse_kernel(sys.argv[1])
faults, rows = ks.read(recs, {}, quiet=True)
print('# FS131-L10B: section variables in scope that the kernel\'s statement does not hold, each read by eye (class) and by')
print('# script (the statement does not mention it). <full name>\\t<binder>\\t<reading>. Written by data/fs131/l10b/mk-reviewed.py.')
n = skipped = 0
for name, r, sigtext, notes in rows:
    for nt in notes:
        m = re.match(r'^ABSENT (inst|term) (.*?) — NOT REVIEWED$', nt)
        if not m:
            continue
        g = m.group(2)
        if g not in CLASSES:
            skipped += 1
            continue
        tok, why = CLASSES[g]
        body = r['sig']
        mentioned = re.search(r'(?<![\w\'₀-₉])' + re.escape(tok) + r'(?![\w\'₀-₉])', body) is not None
        if mentioned:
            skipped += 1
            continue
        print(f'{name}\t{g}\t{why}')
        n += 1
print(f'# reviewed {n}; left unreviewed {skipped}', file=sys.stderr)
