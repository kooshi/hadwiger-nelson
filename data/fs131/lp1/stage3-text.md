
## Stage 3 — SAVED (FS131-LP1): the docstrings, prose only

Commit `5fab41e17`. The script that made every edit is kept (`data/fs131/lp1/doc_edits.py`: each replacement asserted
to match exactly once). What each file said of the transfer, and what it says now:
- `Outside/OAI158Collapse` (6 edits): the module docstring's apology ("Where a docstring below says a theorem 'rests on
  the standard three axioms and `proper_to_borel_weak`', it now names a theorem") replaced by the sentence it pointed
  at; the four docstrings that said "Rests on the standard three axioms and `proper_to_borel_weak`" now say the
  standard three, through the ported transfer; "holds on this import in its place" and "(which rests on the other
  import)" — written while two imports stood — now name the standard three and `no_proper_five_coloring`.
- `Outside/OAI158` (2 edits; FS131-IPD1 had rewritten the module docstring at the switch): the read-back sentence ("the
  statements of H and T are … term for term") now says "of T while it was declared here", and that T as the port's
  theorem is read back by this landing (IDENTICAL, stage 2); the models paragraph says T's model is kept as its model.
- `Plane/RadiusOutside` (7 edits): the title ("on the two outside theorems"), the bullets for `radius_down` and the join,
  and the four docstrings that said "rests on the declared outside theorem `Outside.OAI158.proper_to_borel_weak`" now
  say the standard three, through the release's transfer, its proof ported. The two `--` line comments in the proofs
  ("the half on the declared outside theorem") are left as they are: a line comment is code to the code-only check, and
  the brief says docstrings.
- `Plane/LebesgueNumber` (9 edits): "composes the result with a declared outside theorem", its bullet "**The declared
  outside theorem**", the statements' summary, the read-aloud's "given the outside theorem", the section heading
  `/-! ## On the declared outside theorem … -/` and the three docstrings of its last section.
Every "declared outside theorem" left in the four files names `no_proper_five_coloring`, the one still declared.

**Docstrings only, in text**: `data/fs131/lc1/code_only_diff.py c7122cf10 <the four>` — **SAME** four times (1534, 7312,
3329, 19754 characters of code before and after); its plant (the first `:=` made `:≡` in memory) **DIFFERS** four
times (`data/fs131/lp1/code-only.out`, `code-only-plant.out`). **From the kernel's side**: stage 4's build, then the
stage-1 dumper again.
