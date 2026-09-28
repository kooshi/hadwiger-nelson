# FS112-X stage 3: plans/GROKKING-INSTANCES.md §G21 — D8's moved text verbatim and FS-112's G21 instance (§R-close 4.6), before "## G30".
import pathlib
R = pathlib.Path('/home/kooshi/source/lean-dir'); p = R/'plans/GROKKING-INSTANCES.md'
t = p.read_text()
moved = ("**FS-81's three** (rows 83–84): **a relation tree is a weak finder of isolated points** — it left Λ₂₆ over ℚ(√3) undecided at 171,657 "
         "nodes and 312 s where a small-order screen found the point in 3 ms, so the screen runs first and a high-order isolated point reads "
         "UNDECIDED, never NONEMPTY; the second and third, and the rest: `plans/GROKKING-INSTANCES.md` §G21.")
plan = (R/'plans/FS112-unit-arc-half.md').read_text()
old_claude = (R/'data/fs112/fs112-c/drafts.py').read_text()
assert (' ' + moved) in old_claude  # verbatim against the text D8 removed from CLAUDE.md
inst = ("FS-112 (§R-close 3.1): E1 registered (0.9) that NB-4 and NB-5 fail 'realised by FS-110's own fragments'; the planning advisor, A2 and NB "
        "(stage 1) read T2's truncated four-colour vertex as a counterexample to a step that reads a whole unit circle, and N caught it with the "
        "all-straight fragment BB, four-coloured at a flower of radius 1/10 — a reading radius applied to positives (C-BEYOND) and not to "
        "counterexamples.")
assert ' '.join(inst.split()) in ' '.join(plan.split())
block = ("*FS112-X, moved from G21 at FS-112's close (`plans/FS112-unit-arc-half.md` §R-close 4.2), after “…named the period 23 at once.”:*\n\n"
         + moved + "\n\n*FS112-X, FS-112's close (FS112-C, `plans/FS112-unit-arc-half.md` §R-close 3.1 and 4.6):*\n\n" + inst + "\n\n")
anchor = "## G30 — Measurement generates; derivation kills"
assert t.count(anchor) == 1
p.write_text(t.replace(anchor, block + anchor))
print('ok')
