#!/usr/bin/env python3
"""FS112-C2 stage 1: every quotation used in reconciliation §1.8 (and the stage-1b edits), checked verbatim against its source.
Whitespace, typographic quotes and backticks normalised; bold markers `**` removed.  Exit 1 if any quotation is not found.
--self-test: one word altered in the first quotation must turn it MISSING while the faithful one is FOUND."""
import re, sys, pathlib
R = pathlib.Path('/home/kooshi/source/lean-dir')
Q = [
 ("what the end's unit-arc centre `N` needs, with `E`'s type `{g, c, h}`: to keep `E` stuck, `c` at `N` in the pinch `[δ, 180° − δ]` and `h` tangent to `±a` at `N` (so `h` in two sectors)",
  'plans/FS112-Y3-construction.md'),
 ("So a stuck chain cannot end at a unit arc in a terminal map while `E` has three colours", 'plans/FS112-Y3-construction.md'),
 ("No SHAVE at `E` needs `h` shadowing the horn from above: FLANK's list, re-read with unit arcs, leaves only `h`-tiles at `N` tangent to `±a` from above",
  'plans/FS112-Y3-construction.md'),
 ("or a step of 1–3 fails at a unit arc I have not seen", 'plans/FS112-Y3-construction.md'),
 ("Either `υ_0 = 1` too — both of `P_0`'s horns lie between `ω(P_{−1})` and `ω(P_1)`, `P_0` is a one-vertex chain, and the in-type `g` at `P_1` and `h` at `P_{−1}` make both neighbours unit-arc centres",
  'plans/FS112-N-proof.md'),
 ("(or is the doubly bounded one-vertex chain)", 'plans/FS112-N-proof.md'),
 ("an in-type `g` at `P_1` would force `υ_0 = 1`, N2-FLANK-Q", 'plans/FS112-N-proof.md'),
 ("a construction of R2's object by formula (a finite chain with `λ_0 = −1`) has four or more colours at `P_{−1}` and a unit arc of `ω(P_{−2})` through `P_{−1}`",
  'plans/FS112-N-proof.md'),
 ("a checked fragment with three colours at `P_{−1}`, or no arc at `P_{−2}`, refutes N3-END", 'plans/FS112-N-proof.md'),
 ("If an upper bound of `H_±` is `+1`, that arc lies on `ω(P_1)` with the horn colour `c` outside, and a stuck `P_1` would need `c` to fill its `+n` side against N112-U1 (N112-END's argument): the chain is `{P_0}`, doubly bounded.",
  'plans/FS112-NB3-verification.md'),
 ("Step 2 — \"`h` tangent to `±a` at `N`\"**: TRUE **iff `λ_E > −1`**", 'plans/FS112-YB3-verification.md'),
 ("If `E` is the upper end of a stuck chain of at least two vertices (so `λ_E > −1`), with `P_cl(E) = {g, c, h}` and `υ_E = 1`, then a terminal map needs a seventh colour at `N + n`; a single stuck vertex may end at unit arcs on both sides (`υ_E = 1`, `λ_E = −1`, shadowed by in-type tiles at both antipodes: the tactic's self in-contact), as BOWTIE realises locally.",
  'plans/FS112-YB3-verification.md'),
 ("a `g`-tile below `N`'s horn crosses `ω(E)` unless `N`'s lower arcs are `ω(E)` itself", 'plans/FS112-YB3-verification.md'),
 ("the proof side's stuck-ray question must include the one-vertex \"bowtie\" end", 'plans/FS112-YB3-verification.md'),
 ("a map with finitely many arc radii (every doubly periodic map, every map of `𝓜_K`'s periodic designs) has none", 'plans/FS112-YB3-verification.md'),
 ("at a horn bound `±1`, FS112-N3-END puts four colours at the centre one step beyond", 'plans/FS112-derivation.md'),
 ("**Y3-END-NEEDS, if YB3 confirms it, removes horn-bound-`±1` ends from terminal maps** and so narrows (b′) and (b″) to chains ending at NB4′ exceptions or row 8's configuration.",
  'data/fs112/fs112-c/reconciliation.md'),
 ("A vertex with five colours has unit arcs centred at it of total length at least 180°", 'plans/FS112-derivation.md'),
 ("In a stuck chain whose vertices all carry N4-STUCK's structure, the horn curvatures cannot reach `λ_{k+1} = −1` or `υ_{k−1} = 1`", 'plans/FS112-derivation.md'),
 ("closing it needs `H1`'s arc to end at a smaller angle than `E`'s. Named, not built.", 'plans/FS112-Y3-construction.md'),
 ("`|q2 − Y_0|² < 1` (float 0.9036)", 'plans/FS112-Y3-construction.md'),
 ("Y3-END-NEEDS FALSE as stated", 'data/fs112/briefs/C2-112-stage1b.md'),
 ("Six colours were `{g, c, h, x, x′, y}`", 'plans/FS112-Y3-construction.md'),
 ("a periodic terminal map has no stuck chain at all unless an end vertex is a four-colour vertex", 'plans/FS112-Y3-construction.md'),
 ("`E`'s `c`-horns would lie beyond arcs of `ω(E − n)` and", 'plans/FS112-YB3-verification.md'),
 ("including the directions just below `±a` where `c` sits there", 'plans/FS112-YB3-verification.md'),
 ("So `P_cl(N) = {c, h, x₁, x₂, y}` **exactly**, `y = y₁ = y₂` the sixth colour, `g ∉ P_cl(N)`", 'plans/FS112-YB3-verification.md'),
]
def norm(s):
    s = s.replace('**', '').replace('“', '"').replace('”', '"').replace('’', "'").replace('‘', "'").replace('`', '')
    return re.sub(r'\s+', ' ', s).strip()
def run(qs):
    bad = 0
    for q, src in qs:
        ok = norm(q) in norm((R/src).read_text())
        print(('FOUND  ' if ok else 'MISSING'), src, '|', q[:90])
        bad += (not ok)
    return bad
if '--self-test' in sys.argv:
    q, src = Q[0]
    planted = [(q.replace('pinch', 'wedge'), src), (q, src)]
    b = run(planted)
    print('self-test', 'PASS' if b == 1 else 'FAIL'); sys.exit(0 if b == 1 else 1)
b = run(Q); print('missing:', b); sys.exit(1 if b else 0)
