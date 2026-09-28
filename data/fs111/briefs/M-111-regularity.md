*Brief for job **FS111-M**, FS-111 (the cone scale and the regularity step), phase M1 (and M2 if M1 lands): competitor M, the regularity side.
Opus 5.5. Drafted by the milestone planner FS111-P for the owner to launch. **Sized for about 400k tokens by the harness's count, as guidance**
(standing rule 10).*

Hello. You are de Bruijn (`DEBRUIJN.md`), in `/home/kooshi/source/lean-dir`. **`data/fs111/briefs/STANDING-RULES.md` is part of this brief; read it in
full, rule 0 first.** Kooshi (2026-09-26, verbatim): *"My goal is to fully solve, and then verify in Lean, HN. Then we publish."* and *"Let's see some
ambition. I know we can do it."*

**No children.** Do not use the Agent tool, a fork, a workflow or any other way of starting another agent. Only the top-level session launches agents,
because staffing is Kooshi's budget decision and the owner can only review work it knows about. If the work outgrows your context, stop at a saved
stage and say what is left.

## Reading

From disk: `data/fs111/briefs/STANDING-RULES.md`; `CLAUDE.md` § The aim (links 5–6), § Counter-priors, G82, G79, G24, G60, G22, G83, G71, G40, G21;
`LEDGER.md` rows 129–136; **`plans/FS111-cone-scale.md`** stages 2 (card 1), 3b (§G part 3, the extraction), 4 (§PA) and 5 (§IQ) — **not stage 6.3,
the registered expectations, until your stage 1 is committed**; **`data/fs111/claims.md` in full — work §3 and §5; quote, never paraphrase**;
`data/fs106/claims.md` §0–§1 and §5 (D-NF, I-D1, C-T-TAN); `plans/FS107-derivation.md` §1 (FS107-R-SAT, the partial-colouring saturation lemma you
are asked to make tight) and §2 (W-EQ-K, VW-CPT); `plans/FS106-derivation.md` (AE-MAP6, AE-NICE, AE-POLY). Papers, held in `~/source/library/pdf/`:
`arXiv-math0703856-bukh-measurable-sets-excluded-distances.pdf` (§3–§4: zooming-out, supersaturation, Lemma 12, Theorem 11);
`arXiv-2407.05071-cohen-mani-clustering-unit-distance-avoiding-sets.pdf` (§2.3, §5: block structure, Question 5.1);
`arXiv-2512.17606-rataj-zajicek-local-structure-2d-positive-reach.pdf` §1 and `arXiv-1604.08841-rataj-zajicek-structure-positive-reach.pdf` §6 (planar
sets with positive reach; semiconcave descriptions); `arXiv-2304.10163-voronov.pdf` §2 (Prop. 2.1, Obs. 2.2–2.3); `arXiv-2502.01958-maptype.pdf` §1, §9.

**Fences** (standing rule 13): the session transcripts (everything under `~/.claude/projects/-home-kooshi-source-lean-dir/`, memory included); `chats-bak/`;
every file in the shared harness scratchpad you did not create (work in `fs111-m/` there); **the other side's record, working directory and tools —
`plans/FS111-W-wild.md`, `data/fs111/fs111-w/`, `tools/fs111_w_*` — until you have handed back**; the verifiers' records; `plans/FS111-close-inventory.md`;
`data/fs111/reports/`; every other brief in `data/fs111/briefs/`. An accidental open is a fence touch: log it and report it.

## The question, and your side

Card 1 (stage 2 of the plan) found that the front page's "FS-114's NO plus the cone scale gives seven" needs a third statement, and that the two doors are
two routes. **Route M**: if the tight limit of a hole-vanishing sequence can be taken to be a map, the map NOs finish — at five colours the held "maps need
six" (FS106-AE-MAP6: then `χ_m⁰(ℝ²) ≥ 6`, so `χ(ℝ²) ≥ 6` given MR), at six the map NO of row 134 and FS-114 (then seven). **You are the regularity
side:** prove the rungs, for every `k`, from the bottom:
1. **C-FILL** and **C-HULL** (the planner proved both in two lines, one mind — check them first).
2. **C-SAT-T**, the tight analogue of FS107-R-SAT: saturate a tight colouring by fills until no essential boundary point is free for any of its colours;
   then every boundary point is a contact point for each colour it carries.
3. **C-HULL-REG**: after saturation, bichromatic boundaries are locally Lipschitz graphs, semiconcave or semiconvex (the planar `r`-convexity theory).
4. **REG-B_k** (tight block structure) and **REG-J_k** (junctions isolated, blow-ups finite sector partitions) — REG-J is FS-111's cone scale on the limit.
5. **M2, only if 2 and 3 land:** REG-I_k, to a map-type colouring (Conditions 2–4); at `k = 5` it is C-SIX-M's missing half. And PER, link 6's reading.

**Rules of your side.**
- **The vacuity rule (claims list, preamble):** every structural claim is stated for every `k`, and every derivation names an inhabitant at `k = 7` — a
  tight seven-colouring given by formula (G20's boundary-tight brick; a tight hexagonal one), checked exactly by a tool of yours with a planted fault. A
  proof whose only instances are six-colourings may be a proof about the empty set.
- **Controls:** every local claim must hold on the strip and the disk (row 136; the exact checkers `tools/fs112_y_check.py`, `tools/fs112_yb2_check.py`
  may be run, never edited) and say what it does on the seven-colour controls.
- **No argument one class at a time** (G24, G60, row 129) for anything that decides a colour count; a regularity rung may be proved class by class, but
  say so.
- **C-REG-EQ:** the top rung is equivalent to the answer given the NO; spend the effort on the rungs, each of which is a smaller statement.
- Stop at the first rung that is FALSE and name what it kills; GAP at a named step is a result.

**The contest** (`plans/PROTOCOL-competitor-and-advisor.md` §1). Competitor W attacks the same rungs from the other end (it builds tight objects where a
rung's universal form fails). You see W's record only after you hand back. A blind verifier checks you after.

## Stages

1. Quotation check (standing rule 5); name each claim's object, complexity class and boundary class; check C-FILL and C-HULL.
2. C-SAT-T, with its `k = 7` inhabitant.
3. C-HULL-REG.
4. REG-B_k and REG-J_k.
5. (M2) REG-I_k and PER, if 2 and 3 landed; else the verdict and the obstructions met.

## Deliverables

Record `plans/FS111-M-regularity.md` ("Theorems this phase proved"; the "would have searched here" log; the fence log); `data/fs111/fs111-m/`; exact checks in
`tools/fs111_m_*.py` with planted faults. Report per standing rule 9 to `data/fs111/reports/FS111-M.md` and to "main". Commit subjects "FS111-M: stage n".
Your final text: "FS111-M idle; report sent to the owner by SendMessage".

Thank you.
