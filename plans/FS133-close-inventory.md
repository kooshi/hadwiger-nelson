# FS-133 — the one-class transfer: close inventory

*Keryx's file (Workflow 3.1). Opened 2026-10-07 (UTC) with the milestone. One item per result, ruling, correction owed, prediction,
slip or stub, each with its source address; every line ticked done or declined with its reason by the close. Prehistory: FS-131's
inventory, items 607–625 (an outside proof of six became this project's literature; this consequence was spotted at item 613 (1)).*

## The rules that judge this milestone (written before any report)

1. **The claim list** is `data/fs133/claims.md`, fixed 2026-10-07 from the asking lane's stub `plans/STUB-one-class-transfer.md`:
   C133-DENS, C133-INV, C133-ONE, C133-HOM, each posed. A change is a dated line there.
2. **The announcement rule.** `α₁(ℝ²) = m₁(ℝ²)` (C133-ONE) is announced as "derived, one mind" only when every step of its
   derivation is in a saved stage with its grade and the deriver's gate is green; as **a result of this project's** only when the
   prior-art search of the derivation's §PA, run before the derivation and again before its report, finds no earlier statement —
   and then with the date of that search; as **held** only when its Lean module passes the gate, with the outside theorems it
   imports named. A stall at a named step is announced as that.
3. **What it rests on** is named at its grade every time: the release's rigidity theorem is [kernel, outside] (built and audited
   here, `plans/EXT-OAI1-audit.md`); this milestone's own steps are [hand] until formalized.
4. **Nothing in this milestone is blind**; the kernel is the second check.

## Registered predictions

- The asking lane's: `plans/STUB-one-class-transfer.md` § Registered expectations (before any derivation).
- The deriver's: registered in its plan before the derivation (its brief, item 1); scored at the close.

## Items

1. **Opened 2026-10-07**: the stub read (its headings and its four posed claims; minted by FS132-P1, FS-131 inventory item 625);
   the claim list fixed; the deriver's job FS133-E1 briefed (`data/fs133/briefs/FS133-E1-opening-and-derivation.md`, generator
   `data/fs131/briefs/scripts/mk-fs133-e1.py`, gate exit 0, 7 quotations) — a short opening (§G, §PA, §IQ) and the derivation of
   the four claims in order, the unchecked step first; launched into a free slot. **The order, the asking lane's and adopted**:
   FS-133 takes the deriver's first slot because its value decays with the calendar (the proof it follows from is public);
   FS-132 follows at its first hand-back at the latest. Alternative: FS-132 first, by bearing on the answer. Confidence: medium-high.

2. **FS133-E1, first message: C133-DENS — the step the reading left unchecked — is derived, as posed and at a wider class**
   (source: its message to "main", 2026-10-07; record `plans/FS133-E1-derivation.md` Stage 3, § Argument for C133-DENS; commits
   `5447beb5` (stage 1), `d0cd352a` (stage 2), `472fbaf5` (stage 3), on `main`; its gate exit 0 by its word). **[hand], one
   mind.** The step is the reverse Fatou lemma on window averages of `1_{H>0} ≥ H`: the mean over `ω` of the upper density is at
   least `α`, so a positive-measure set of `ω` has upper density at least `α`, and it meets the full-measure event on which the
   set is unit-avoiding almost everywhere. **A generalization, its own entry C133-DENS-CLASS**: the posed hypothesis "`= α` for
   every `x`" is stronger than what the transfer's field gives (its mean is `α` only at almost every `x`); the argument needs
   "`≥ α` for almost every `x`", any σ-finite space, any window sequence — and that is the form C133-ONE consumes. **Not
   claimed, each with an example**: "for almost every `ω`" (false: a half-and-half mixture); lower density (false: alternating
   annuli, with an exact control). **It was already held in words** at the same place of row 129's chain
   (`plans/FS103-F-fractional-shadow.md` § 3.4, link 1), so nothing new stands or falls on it. **Prior art, the opening pass**:
   fifteen arXiv queries newest-first, two web searches, the four printed questions read at their pages — no statement of
   `α₁(ℝ²) = m₁(ℝ²)` found, no listing in these vocabularies dated after 2026-09-28; zbMATH's interface answered 503, owed at the
   second pass. **My receipt**: the three commits are on `main`; Stage 3 read whole; the Fatou step redone by me (Fatou on
   `1 − A_n` gives `∫ D ≥ limsup ∫ A_n ≥ α`; `μ{D ≥ α} = 0` would give `∫ D < α`, `μ` a probability); its two controls re-run
   with their faults (`tools/fs133_e1_dens_control.py`: `upper` True, `lower` False; `packing 2` True, `packing 19/10` False).
   Not checked by me: stages 1 and 2; its §PA queries; the citation of the transfer's line 223–224. **Rulings.** (a) **The claim
   list gains a dated line**: C133-DENS-CLASS is the deriver's generalization and the form C133-ONE consumes; C133-DENS stays as
   posed (`data/fs133/claims.md`). Alternative: restate C133-DENS. Why not: the posed claim is true as posed, and the list's
   rule is a dated line for a later change. Confidence: high. (b) **Nothing is announced**: by this inventory's rule 2 the
   headline is C133-ONE's, and the prior-art search has one pass of two done with one source down. (c) Its scripts go under
   `data/fs133/e1/` from now on, not `tools/`: a landing will be in flight within hours, and `tools/` is not exempt during one.
