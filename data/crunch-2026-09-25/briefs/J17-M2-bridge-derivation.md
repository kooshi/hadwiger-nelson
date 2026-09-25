*Brief for crunch job **J17**, milestone M2 (FS-39's hand step, `plans/STUB-plane-bridge.md`), derivation. Opus 5.5, 2026-09-25. Written by J04
(`plans/M2-kernel-lane.md` §S, §IQ).*

Hello. You are de Bruijn (`DEBRUIJN.md`), deriving FS-39's bridge by hand, in `/home/kooshi/source/lean-dir`. Read `CLAUDE.md`, `WORKFLOW.md` and
`DEBRUIJN.md` from disk. **`data/crunch-2026-09-25/briefs/STANDING-RULES.md` is part of this brief; read it in full.** No children: do not use the
Agent tool, a fork or a workflow (delegation is one level deep; staffing is Kooshi's budget decision and the owner can only review work it knows
about). **If your record already exists, you are resuming: read it and the brief, check the last SAVED stage against `git log -- <record>`, and
continue at the first stage not SAVED. Redo nothing saved.** You run beside the kernel lane and write no Lean.

## The question, and why now
Every "χ(ℝ²) = …" sentence this project writes about number fields rests on `χ(ℝ²) = sup_F χ(F²)`. Fischer stated it in 1990 with a false step;
**J04 found that `[Madore2015]` ¶5.4 proves it correctly, by Tarski** (`plans/M2-kernel-lane.md` §2.3). Your job is the record: the proof written in
full, a second proof by the Artin–Lang homomorphism theorem (the route that extends route C), Fischer's step refuted by an example, and the kernel
price of each route. **Its novelty is none, and that is recorded, not hidden** (rule 4: a correct write-up with the credit right is the product).

## The statements (verbatim; your fixed claim list)
- **C1** — "For every finite graph `H` and every map `f : V(H) → ℝ²` with `‖f(x) − f(y)‖ = 1` on every edge, there is a real number field `F` and a
  map `g : V(H) → F²` with `‖g(x) − g(y)‖ = 1` on every edge." (Non-injective `g` allowed.)
- **C2** — "`χ(ℝ²) = sup { χ(F²) : F ⊂ ℝ a number field }`, the chromatic number of `F²` meaning that of the unit-distance graph on `F × F`."
- **C3** — "`[Fischer1990]` Remark 1's first sentence is false: there is a finitely generated field `E ⊂ ℝ` over `ℚ` that is not a purely
  transcendental extension of any finite algebraic extension of `ℚ`." (With an explicit `E`.)
- **C4** — "`χ(ℝ²) ≠ 6` if and only if every real number field `F` with `χ(F²) = 6` has a finite extension `F′ ⊂ ℝ` with `χ(F′²) = 7`"
  (`plans/STUB-plane-bridge.md` §5, FS62-T2), given C2.
- Fischer's Remark 1 (held PDF `~/source/library/papers/1-s2.0-0012365X9090324B-main.pdf`, p. 188): "Given a finitely generated extension E ⊂ R
  over Q, it may be realized as a purely transcendental extension of some finite algebraic extension F over Q." Madore ¶5.4 (held,
  `~/source/library/pdf/arXiv-1509.07023-…pdf`): "One consequence is that χ(R^d) = χ((Q^{r−alg})^d) where Q^{r−alg} stands for the real closure of Q".

## Read first, from disk
`plans/M2-kernel-lane.md` §2.3 and §4.1 (§IQ); `plans/STUB-plane-bridge.md` in full; `CLAUDE.md` G63, G64; `plans/FS39-derivation.md`;
`plans/FS62-derivation.md` T2; Madore ¶1.3 and ¶5.4; Fischer §2 (Thm 6 and Remarks 1–2). De Bruijn–Erdős in Mathlib: `Finset.rado_selection`,
`SimpleGraph.nonempty_hom_of_forall_finite_subgraph_hom`. Real algebra in Mathlib: `IsRealClosed` (definition only) — no Tarski, no Artin–Lang.

## Fenced
Nothing is fenced from you. **J17V (if the owner runs it) is fenced from your record until your verdicts are committed.**

## Stages
1. The quotation check; C0 (a probability per claim; P-J17a–b of §P); **the zbMATH gate J04 could not finish** (the API returned HTTP 502 after
   one query): re-run the seven queries of §2.3 with `curl -G … --data-urlencode`, plus `au:"Madore, David"` and one query in real-algebraic-geometry
   words, and record each count (~40k). Save.
2. C1–C4 by hand: C1 by Artin–Lang (cite Bochnak–Coste–Roy by theorem number, or say which source you could read), and by Tarski after Madore;
   C3 with an explicit curve of positive genus and the reason it is not purely transcendental over any number field; C2 and C4 from C1 and
   de Bruijn–Erdős (~80k). Save.
3. The kernel price of each route against Mathlib's holdings (what is missing, named by file), and the proposed edits to `CLAUDE.md` G63 and the
   FS-39 stub, **in your record only** (~40k). Save and report.

## Record and paths
Record: `plans/M2-S1D-bridge.md`, with "Theorems this phase proved" (grades: C1–C4 are [hand], resting on a cited theorem; say which). Working files:
`data/m2/j17/`. Budget 200k (harness); hand back by 280k. Stop rule: a verdict per claim saved, or GAP at a named step. Keep the "would have searched
here" log. Report (rule 9) to `data/crunch-2026-09-25/reports/J17.md`, SendMessage to `"main"`.
