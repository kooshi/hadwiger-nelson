# FS-39 — the derivation file: G63's theorems (transcendence is free), filed at the stub that is their home

*Written 2026-09-23 by the FS-71 batch-6c implementer (`plans/FS71-theorem-audit.md`, G63's row in §G.1: "target, batch 6").
FS-39 (`plans/STUB-plane-bridge.md`) is not itself a closed milestone — it is the open stub for the bridge
`χ(ℝ²) = sup_F χ(F²)` — but per the audit's own placement rule (§M.2: "the home of a theorem is where it was proved"; the
brief: "G63's `FS39-Tn` (`plans/FS39-derivation.md`, its stub being their home)") the one theorem G63 actually closes (D4,
the transcendence lemma) is filed here rather than left as a stub-internal paragraph. Enumeration: `plans/STUB-plane-bridge.md`
read in full (107 lines); `CLAUDE.md` G63 (loaded, disk-authoritative) read in full; `BIBLIOGRAPHY.md`'s `[Fischer1990]` row
read for its existing attribution of Theorem 6 and the Remark 1 gap (already correctly recorded there — see "Prior art
re-attributed" below). Grades are `CLAUDE.md` § Notation's.*

## The theorems

**FS39-T1 — Transcendence is free: `χ(F(t)²) = χ(F²)`. [hand; prior art Fischer1990 Thm 6]** For any `F ⊆ ℝ` and any `t`
transcendental over `F`, `χ(F(t)²) = χ(F²)`. *Proof:* take the place `t ↦ 0` of `F(t)/F`; its residue field is `F`, which is
formally real, so `−1` is not a square there. A unit vector `(u,v)` (`u² + v² = 1`) with a pole at this place would force
the leading terms of `u²` and `v²` to cancel, which forces `−1` to be a square in the residue field — contradiction. So
every unit vector lies in the valuation ring (`normOne_subset_valuationSubring`, which already exists in this project's
Lean development), the plane decomposes into cosets of `O_v²` with no edge between cosets, and reduction is a graph
homomorphism onto `F²` (`colorable_unitDistance_induce_of_valuationSubring`, which also already exists). Hence
`χ(F(t)²) ≤ χ(F²)`; the reverse inequality is the induced subgraph. *Proof:* `plans/STUB-plane-bridge.md` §3 D4.
*Proof verdict:* closes. *Consequence recorded alongside it:* `χ(ℚ(π)²) = χ(ℚ(e)²) = 2` — the chromatic number of a field
plane cannot see transcendence degree at all. *Rests on it:* FS-39's phase B′ (a half-day kernel theorem, the two
valuation lemmas already existing); the honesty of every "`χ(ℝ²) = …`" sentence the programme writes (§5 of the stub, high
bearing, not directly on finding a six-forcer). *Prior art:* **the theorem itself is `[Fischer1990]` Theorem 6** —
*"`F^d` can be `k`-colored (has an additive `k`-coloring) iff `F(α)^d` can"*, any dimension, proved by clearing
denominators in `F[x]` and setting `x = 0` — found 2026-09-19 at FS-61's prior-art gate and read first-hand in the held
PDF (`BIBLIOGRAPHY.md`'s `[Fischer1990]` row already carries this attribution, added at that gate: *"Thm 6 is `CLAUDE.md`
G63... his Remark 1... is the false step G63 names as the remaining gap"* — no edit to `BIBLIOGRAPHY.md` is needed at this
audit; it is already correct). **Ours:** the valuation-theoretic proof route (`normOne_subset_valuationSubring` /
`colorable_unitDistance_induce_of_valuationSubring`, a different technique from Fischer's polynomial-clearing argument),
the naming of the consequence (`χ(ℚ(π)²) = 2` etc.), and the identification of the gap in his Remark 1 (below). zbMATH:
not re-queried here — the attribution was already found and verified at FS-61's own gate (2026-09-19), and re-running the
same search would duplicate that work rather than add to it. *Kernel:* **stub** (FS-39 phase B′,
`chromaticNumber_planeOver_adjoin_transcendental_eq` — priced at half a day, the two valuation lemmas already exist; not
yet built).

## Readings and measurements that were called theorems

* **`χ(ℚ(φ)²) = 2`, the golden-ratio plane is bipartite** (G63's own parenthetical remark; no separate written derivation
  found anywhere else — searched `data/fs61/`, `data/fs62/`, `plans/*.md` for "golden ratio", "ℚ(φ)" and "φ =": no hits
  beyond the audit's own row in `plans/FS71-theorem-audit.md`). This is an **instance**, not a new theorem: `φ = (1+√5)/2`
  generates `ℚ(√5)`, and `5 ≡ 5 (mod 8)` makes the prime above 2 inert in `ℚ(√5)` (residue field `𝔽₄`) and **ramified** in
  `ℚ(√5, i)` — case (b) of `FS54-T2`'s 2-adic trichotomy (already filed, batch 6b): a ramified prime gives `χ(F²) ≤ 2`
  regardless of its norm. Combined with `χ ≥ 2` for any graph with an edge, `χ(ℚ(φ)²) = 2`. `L(ℚ(√5)) = 2` is G48's;
  `data/fplane/map.md` reads "sealed-at-4" for this field, which G63 itself notes is the coarser `|κ|` bound, not the
  sharp value — that discrepancy is in a data file outside this audit's remit to edit and is already correctly explained
  in `CLAUDE.md`'s own text, so no edit is proposed here.

## Conjectures surfaced, not claimed

* **The bridge's remaining gap** (FS-39 §3, D3/D4): descending an arbitrary finitely generated `F ⊆ ℝ` (not just one
  transcendental adjunction) still needs either (i) the model-theoretic route (Tarski–Seidenberg, real Nullstellensatz —
  not in Mathlib as checked) or (ii) the valuation-theoretic route generalised to a place with formally-real residue field
  at every step (the theory of real places, Artin–Lang — not in Mathlib as checked, and not priced against (i) as of this
  writing). Neither route is closed; FS39-T1 is the one clean special case (a single transcendental over a real base).

## Prior art re-attributed

**Fischer's own Remark 1 has a false step, already recorded in `BIBLIOGRAPHY.md`, found and checked here rather than
edited.** `[Fischer1990]`'s Remark 1 reduces a finitely generated `E ⊂ ℝ` to a number field by asserting `E` is "a purely
transcendental extension of some finite algebraic extension" of ℚ — false in general (a positive-genus function field is
a counterexample) — and then invokes de Bruijn–Erdős; so statement (ii) of the bridge (χ(ℝ²) = sup over number fields) has
been *stated* in print since 1990 and never correctly *proved* there. `BIBLIOGRAPHY.md`'s `[Fischer1990]` row already
records this exact finding, word for word, attributed to "FS-61's prior-art gate, 2026-09-19" — checked against
`plans/STUB-plane-bridge.md` §3 D4's own text at this audit and found to match precisely; no edit proposed.

## Kernel decisions, summarised

| theorem | decision |
|---|---|
| FS39-T1 | **stub** (FS-39 phase B′) — the two valuation lemmas (`normOne_subset_valuationSubring`, `colorable_unitDistance_induce_of_valuationSubring`) already exist; priced at half a day; not yet built |
