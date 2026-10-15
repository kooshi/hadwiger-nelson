JOB FS131-KPD1 — DONE   harness≈? (own≈240k; I cannot read the harness's count)
RESULT: Items 1–7 of § Done means are done, each a saved stage (record stages 1–6).
RESULT: item 1, the readback. All three of the brief's quotations are identical to their sources (checked by script). Every use of duality on the chain, by declaration:
- `Rigidity.isSolenoid_pieceDual`'s field `dual_embeds` reads D1 together with separation.
- Its field `connectedSpace` reads a third fact, D3: a torsion-free discrete group has a connected dual. KN8's plan had routed it through D1 and through structure theory of compact groups that the leaf list never names.
- `Rigidity.isTotallyIrreducible_pieceAction` reads D2 only in the case ruling 2 names (`Y^⊥ = 0` gives `Y = ⊤`). Its branch `N ≠ 0` reads no duality at all: only `Y ⊆ N^⊥`, and `N^⊥` finite when `M/N` is finite.
RESULT: item 2, the statements. Four new modules, with `sorry` at the leaves only:
- `Rigidity/Annihilator`: the two annihilators as one Galois connection; `finite_dualAnnihilator`.
- `Rigidity/SubgroupHaar`: the Haar measure of a compact subgroup of the dual, whose Fourier coefficients are the indicator of `Y^⊥`.
- `Rigidity/Duality`: D2 general (`dualAnnihilator_dualCoannihilator_of_isClosed`), its closure form, the case (`eq_top_of_isClosed_of_dualCoannihilator_eq_bot`, and `…'` on `Additive (AddChar G Circle)`); D1 (`evalDualHom_surjective`, `dualDualEquiv`, `additiveDualDualEquiv`).
- `Rigidity/DualConnected`: D3 (`connectedSpace_dual`) and its negative partner at `ZMod 2`.
Each statement was read aloud against its use and has a model. The textbook statement is `[Rudin1962]` §§ 1.7 and 2.1, recalled and not read; no copy is held. The general D2 costs exactly what the case costs: `Z := (Y^⊥)^⊥` has `Z^⊥ = Y^⊥` with nothing to prove, so one Haar argument serves every closed `Y`.
RESULT: Pieces is re-pointed. It imports Duality and DualConnected, and two docstrings now name the theorems they read. No stored constant changed: 74 of 74 identical before and after, and the control fires.
RESULT: every consumer step that Pieces leaves 8 and 9 read applies at `PieceDual M` by `exact` (probe 2, exit 0).
RESULT: item 3, the route. I chose route H: Haar measure on closed subgroups, with Fourier uniqueness from `Rigidity/DualGroup`. It needs no Peter–Weyl, no L² and no tori. D1 follows from D2 at `G × ℤ`.
RESULT: route T, ruling 2's tori route, contains route H. Mathlib at the pin has multivariate Fourier series on tori (`UnitAddTorus`, `mFourierSubalgebra_closure_eq_top`) and Kronecker's theorem in dimension one only (`AddCircle.denseRange_zsmul_iff`). It has no theorem on closed subgroups of `ℝⁿ` or `T^k`, no multivariate Kronecker, and no duality isomorphism for any group. So D2 on `T^k` would itself have to be proved by route H's argument. Route T was priced in words and not built.
RESULT: route H was measured from its leaves, not from a table. The proofs are written in copies of the four modules (`data/fs131/kpd1/route/`): 26 of 28 leaves, about 165 lines, elaborate at the pin under the lakefile's options, 2–4 s per file. Grade: elaborated, not landed. As compiled there, the D1, D2 and D3 headlines reach `sorryAx` only through `Rigidity/DualGroup`'s leaves (`isClosedEmbedding_coe`, `isTopologicalGroup_dual`, `compactSpace_dual`, `borelSpace_dual`, `measure_eq_of_fourier`, `exists_apply_ne_one`). `finite_dualAnnihilator` reaches none.
RESULT: item 4, the lanes. One lane, PD-I: copy the route files over the modules, prove two spec leaves (about 14 and 22 lines, each planned), build, then compare the stored terms. Lane D is unchanged and is now on PD's landing path. Lane G's leaves 8 and 9 are re-pointed and can start now. No two lanes share a file. The domain pass and the obligation pass each ran as a fresh invocation.
RESULT: item 5, the price. Lane PD-I is about two to three hours of implementer work. That is far under a week, so no fallback axiom is drafted and none is needed.
RESULT: item 6, drafts. Three dated lines for the claim list, four lines for LEAN.md, and the `[Rudin1962]` reading status with a library request (record § 5.3).
RESULT: Tate's self-duality, in words. Its "onto" half reads D2's case at `Dual F`, once `W/Λ` is compact. Its kernel `Λ = R^∨` and the cocompactness are adelic arithmetic that is not on this route. Openness comes free (record § 5.2).
RESULT: the gate at the hand-back. Build exit 0 (6 modules rebuilt, 477 warnings, every one a `sorry` warning); lint passed (14 linters); architecture PASS; no name collides on `main`, `fs131-wch` or `fs132-wi1`.
RECORD: plans/FS131-KPD1-pontryagin.md (branch fs131-wpd, tree .claude/worktrees/fs131-wq1; not pushed, per the brief)   COMMITS: 5707f9a6c, 3e270cc1b, 71f64898e, a0ad12d3f, a67308b94, c233e1ddb, and the report's commit
INVENTORY:
- result — Pontryagin duality D1 and D2 for a countable discrete abelian group is typed, with every leaf but two spec leaves elaborated in route copies. It rests on `Rigidity/DualGroup`'s leaves only. — record §§ 2–3, data/fs131/kpd1/route/
- generalization — The general D2 (every closed subgroup is its annihilator's annihilator; for any subgroup, the closure) costs what the case costs, so it is typed in place of the case alone. — record § 3.1
- generalization — D3 holds for every torsion-free abelian group and needs no countability. — Rigidity/DualConnected
- correction owed — Not a statement defect, a route defect: KN8's plan for `isSolenoid_pieceDual`'s connectedness read structure theory of compact groups that the leaf list never names. It is replaced by D3, whose proof uses Mathlib's `exist_openSubgroup_sub_clopen_nhds_of_one`. — record § 1.2, § 4.2
- result — Pieces leaves 8 and 9 no longer wait on lane PD's proofs, only on its typed statements. — record § 4.2
- slip (the brief's) — In inventory item 761, the nested quotations "Its words: …" match neither the KN8 report on disk nor the record verbatim (for example "Item 5" against "item 5"). They are presumably quoted from the hand-back text, which is not on disk. Nothing here rests on them. — record § 1.1
- prior-art debt — `[Rudin1962]` §§ 1.7 and 2.1 are cited, recalled and not read. A copy of it, or of Deitmar–Echterhoff Ch. 3, is requested for the library. — record § 2.4, § 5.3
- question for another lane — M8b's planner can take the surjectivity in Tate's self-duality from `eq_top_of_isClosed_of_dualCoannihilator_eq_bot`; only the kernel and the cocompactness are its own to price. — record § 5.2
HELD FOR THE COORDINATOR:
- Whether I fold the route copies into the four modules myself (a copy, plus one build) or lane PD-I does. The brief rules proofs beyond a few lines out of my lane, so I left them as measurements.
- Lane PD-I's brief: one implementer, two to three hours; it can run beside lanes D and G.
