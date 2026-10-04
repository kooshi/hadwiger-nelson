JOB FS131-IWb — STAGE 6 SAVED   harness≈435k (own≈140k)
RESULT: ArcMap.step5_lt (Woodall's step 5, strict) — PROVED, statement unchanged; read against [Woodall1973] p. 198 as repaired ("no sector of angle < π/3 between two neighbours of distinct colours, at a point of at least three sectors"), § 4.5's route; axioms: sorryAx only through cited unlanded statements (lemmaL via woodall_step4, dense_interiorPts, coneAt_region_eq_biUnion), standard three otherwise (iteration print, not gate evidence).
RESULT: ArcMap.step6 (Woodall's step 6 by Townsend's π/3 lemma) — PROVED, statement unchanged; read against [Townsend1979ms] Thm 4's Corollary in normal form ("no point of three sectors of distinct colours, each of angle ≥ π/3"); axioms as for step5_lt (lemmaL now via townsend_lemma).
RESULT: the connected piece (the brief's child) — ArcMap.exists_preconnected_of_mem_coneAt: at a point of the domain, a cone direction of a colour class, a horn's included, is a cone direction of one of its tiles (preconnected); with collarAt_shadow_inner_of_mem_coneAt / _outer_; sorryAx through wave 3's coneAt_region_eq_biUnion only.
RESULT: ArcMap.exists_sectorsAt as first stated — FALSE (statement defect, ruled items 154–155): k = 1, one segment [−1, 1], colour 0, v = 0 has no picture; fixed by replacing SectorsAt's fifth clause with v ∈ F.dom.
RESULT: exists_sectorsAt (as amended) and exists_woodallMerged — NOT ATTEMPTED (budget); the route for the first and the re-pricing of the second are in the record, Stage 6.
RECORD: plans/FS131-IW-implementation.md (branch fs131-ww)   COMMITS: d3ff957f, 6e94a30a, b289081c
INVENTORY:
statement defect — exists_sectorsAt false: SectorsAt's clause 5 (annSector … ⊆ F.region (c i)) fails for a sector merged across an arc between two same-coloured sides; counterexample k = 1, Arc.seg (−1) 1, v = 0; ruled item 154 — record Stage 4
statement defect — dropping clause 5 outright makes E1-RAY false off the domain (v = 0 ∉ dom, colour class cut into radial pieces with gaps accumulating at v); ruled item 155: clause 5 replaced by v ∈ F.dom at the same position — record Stage 5
result — SectorsAt clause 5 → v ∈ F.dom in Plane/Woodall/Basic (the one licensed definition change); const_sectorsAt adjusted; E1-RAY (inner, outer) and E1-BAD's interior case re-proved through the cone clause, statements unchanged — record Stage 5, commit 6e94a30a
correction owed — E1-RAY and E1-BAD's interior case were on the standard three axioms and now cite wave 3's coneAt_region_eq_biUnion: sorryAx until wave 3 lands (proved on fs131-w3) — record Stage 5
result — step5_lt proved — Proofs/HadwigerNelson/Plane/Woodall/Steps.lean, record Stage 6
result — step6 proved — same file, record Stage 6
correction owed — to the plan (W § 4.5, § 9.3): step5_lt needs no δ and no truncated sector (both edges are cone directions of all three colours, mod 2π); step6 needs no "at most three cut angles" (townsend_lemma takes any finite K; the six normals serve, and the second-order lemma is used only for the seed when all angles are 2π/3) — record Stage 6
generalization — SectorsAt.collarAt_opposite holds for any n ≥ 1 with no validity and no colour count — Steps.lean
stub to mint or re-aim — exists_woodallMerged (Woodall's step 3) re-priced H+, about 1500–3000 lines; needs first a derivation of the clearness lemma and the modification with every clause (none in plans/), then a planner, then an implementer; a derivation may find a route avoiding the modification — record Stage 6
tool defect — none; new iteration tools data/fs131/iwb/run.sh and olean.sh (private cp -rs olean mirror; the symlink is removed before an olean is written, so nothing writes through into .lake/build); never evidence
question for another lane — the planner: exists_sectorsAt by the route in record Stage 6 (wave 3's GoodAt.exists_wedge, exists_mem_Rgn_of_mem_coneAt, ray_mem_Rgn, exists_mem_coneAt_region; a uniform-slot pre-picture and a merge by Fin.removeNth), H, 600–800 lines; or a bridge from FS131-I3h's localSectors if that lands first
HELD FOR THE COORDINATOR:
who takes exists_sectorsAt (the next implementer by the Stage 6 route, or a bridge from I3h's localSectors) — decision
exists_woodallMerged as a derivation job before any kernel work — decision
the gate and the landing still wait for waves 3–4 and FS131-LEB (brief Done item 4); tools/fs131_qa1_dupes.py not yet run (a git grep found none of the 13 new names on main, fs131-w2, fs131-w3, fs131-w4, fs131-leb)
