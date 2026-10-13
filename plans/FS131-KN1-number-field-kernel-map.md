# FS131-KN1 — the results about planes over number fields: what each rests on in the Lean library, and the plan of the first module

*de Bruijn, the planner; brief `data/fs131/briefs/FS131-KN1-number-field-kernel-map.md`; branch `fs131-wnf`, cut from `main` at
`151c4a27`. Opened 2026-10-13. Working files: `data/fs131/kn1/`. The stages below are saved in order; a successor resumes at the
first stage not marked SAVED.*

## Theorems this phase proved

None. Phase 1 is a map: it reads the ledger, the gate's receipts and the modules, and proves nothing. (Phase 2, if it is run from
this record, types statements and leaves `sorry` at every leaf; it proves nothing either.)

## Stage 1 — SAVED: the readback

**The two quotations** (`W1`, `H1` in the brief's § The request) against `data/fs131/REQUEST-2026-10-13.md`, compared character
for character by script with a planted one-word change as the control: `W1 IDENTICAL` (631 characters), `H1 IDENTICAL` (259),
control `DIFFERS`. No mismatch.

**What is asked.** Kooshi is winding the project down and publishing the repository; what he wants in it first is Lean proofs of
the findings about planes over number fields. This job says, result by result, what the library holds, what it assumes, and what
stands between each result and *kernel-checked on the standard three axioms and declared theorems of the literature*; then, when
the asking lane's ranking arrives as an amendment to the brief, it plans the first module. Measure rigidity at a number field is
not to be formalized or priced here: it enters as a declared outside theorem, and the single most useful thing the map can say
about a result that leans on it is **where the printed statement ends and this project's own deduction begins**.

**The target grade, as I read it** (the brief's § The request, third paragraph): for each result, every hypothesis of kind `ours`
is discharged — proved in the kernel — and what is left is the standard three axioms plus one or more printed statements, each
declared term for term against its page with `LEAN.md` § Assumptions' four items.

**Where I draw the line around "results about planes over number fields".** Inside:

1. the chromatic number of the plane over a real field given by algebra — values, families, lower and upper bounds (rows 52, 53,
   57, 63, 72–74, 76, 82–83, 99, 103–105, 119, 121, 123, 127);
2. the finite residue planes `Γ_q`, their towers and the 2-adic tower, with what they bound (rows 53–56, 60, 66–71, 75);
3. the two theorems on residue colourings (A and B) and their consumers (rows 57, 59, 63, 72);
4. the local–global conjecture's proved range and the machinery under it: band rigidity, the class theorem for character
   colourings, the spectral chain, measure rigidity for the unit-vector group (rows 95–102, 111–113, 116–118, 120–127);
5. the four-colour rigidity results on lattices and field planes (rows 78–81, 84–94, 108–110), which are statements about
   `Cay(Λ, U)` and about planes over named fields;
6. the fractional, character, Borel and `p`-adic statements from the same machinery (rows 71, 75, 100–101, 109–110, 129);
7. the bridge between the fields and the real plane (rows 104, 107, 128, 130's field clause).

Outside, with the reason: rows 1–25 (the seam-field closures: unit-distance graphs on circles drawn over `K`, kernel-checked
already, statements about finite or two-circle objects and not about a field's plane — listed once as a group so a reader can see
they need nothing); rows 26–51 (anatomy, cell family, compulsion toolkit: graph theory of the real plane; rows 50–51, additive
colourings, are the kernel base of Theorem A and are listed under it); rows 58, 61–62, 64–65 (design targets and the Parts
reduction: witness objects, not field statements — row 64's five-chromatic object over `K(√7)` is noted under item 1); rows
114–115 (product colourings: finite graph theory, used by rows 109–110); rows 131–167 (the regularity wall: analysis in `ℝ²`).
Rows 77 (an audit) and 106 (the stripe lemma, kernel, a lattice statement) are listed for completeness only.

**How entries are grouped.** One entry per ledger row inside the line, in ledger order, except that rows held entirely by hand
within one derivation file and with no kernel form are grouped where they share every leaf (88–94; 108–110; 111–113; 116–118;
124–126). The cross-cuts follow the entries.

**Sources read at this stage, and how.** The brief, `plans/STANDING-RULES.md`, `LEAN.md`, `RUNNING.md` § Building and § Make the
gate fail, in full. `scripts/assumptions-ledger.txt` in full (129 rows). The last gate's assumptions receipt
(`data/fs124/l2/gate/receipt-assumptions-final.log`): every `ASSUMPTION`, `PRODUCES`, `SILENT`, `DERIVED` and totals line.
`ARCHITECTURE.md` § 3.6 and § 5 (Imported outside theorems; Assumed as hypotheses). `LEDGER.md` § The claim list in full; rows
52–63 and 119–123, 127 in full or near it; rows 64–118, 122, 124–126, 128–130 by head and tail
(`data/fs131/kn1/rowdigest.py`), each to be read in full where its entry needs more.
