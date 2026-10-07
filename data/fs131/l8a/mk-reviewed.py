#!/usr/bin/env python3
"""FS131-L8A (after data/fs131/l10b/mk-reviewed.py): the reviewed list for the kernel-signature reader — written from the
reader's own ABSENT lines, but only for binders of the classes read by eye and named below, and only where the kernel's
statement does not mention the variable at all (its name is no token of the SIG line). Anything else stays unreviewed and
fails the reader.

The reading by eye, once for the class: the twelve modules declare these section variables and no other — `{k : ℕ}`,
`(F : ArcMap k)` / `{F : ArcMap k}`, and in `RingColour`'s section `GermColouring` `{p : ℂ} {κ : ℝ → Side → Fin k}`
(`grep -n '^variable'`). None is a hypothesis: no section of the wave holds a `Prop`-valued variable, so every hypothesis of
every theorem is a binder of the theorem's own signature, and inventory item 556's class (a hypothesis the file shows and the
kernel's statement lacks) has no instance to find here. What is ABSENT is bare data the statement does not speak of.

  data/fs131/l8a/mk-reviewed.py <kernel-sigs.out> > data/fs131/l8a/kernelsig-reviewed.txt
"""
import re, sys, os
sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', '..', '..', 'tools'))
import fs131_l8a_kernelsig as wrap
ks = wrap.base

K = ('k', 'the section\'s number of colours; the statement fixes its own (`F : ArcMap 6`) or speaks of no map and no colour; '
          'a bare natural number carries no hypothesis')
F = ('F', 'the section\'s map; the statement binds a map of its own (`{F : ArcMap 6}`), in which case the name is its own '
          'binder and this row is not written, or speaks of no map at all (angles, points of ℂ, sets, finite data); a bare '
          '`ArcMap k` is data and bundles no hypothesis about the statement\'s objects')
# binder text -> (the token whose absence from the statement is checked, the reading)
CLASSES = {'{k : ℕ}': K, '{F : ArcMap k}': F, '(F : ArcMap k)': F}
recs = ks.parse_kernel(sys.argv[1])
wrap.exempt_generated(recs, quiet=True)
faults, rows = ks.read(recs, {}, quiet=True)
print('# FS131-L8A: section variables in scope that the kernel\'s statement does not hold, each read by eye (class) and by')
print('# script (the statement does not mention it). <full name>\\t<binder>\\t<reading>. Written by data/fs131/l8a/mk-reviewed.py.')
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
