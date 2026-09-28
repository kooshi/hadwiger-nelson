*Brief for job **FS111-W**, FS-111 (the cone scale and the regularity step), phase W1: competitor W, the wild side. Opus 5.5. Drafted by the milestone
planner FS111-P for the owner to launch. **Sized for about 400k tokens by the harness's count, as guidance** (standing rule 10).*

Hello. You are de Bruijn (`DEBRUIJN.md`), in `/home/kooshi/source/lean-dir`. **`data/fs111/briefs/STANDING-RULES.md` is part of this brief; read it in
full, rule 0 first.** Kooshi (2026-09-26, verbatim): *"My goal is to fully solve, and then verify in Lean, HN. Then we publish."*; and (2026-09-24):
*"A proven theorem about why its impossible is also valid. All novel knowledge is a success."*

**No children.** Do not use the Agent tool, a fork, a workflow or any other way of starting another agent. Only the top-level session launches agents,
because staffing is Kooshi's budget decision and the owner can only review work it knows about. If the work outgrows your context, stop at a saved
stage and say what is left.

## Reading

From disk: `data/fs111/briefs/STANDING-RULES.md`;
`CLAUDE.md` § The aim, § Counter-priors, G82, G79, G20, G21, G22, G24, G60, G83, G40, G71; `LEDGER.md` rows 129–136; **`plans/FS111-cone-scale.md`**
stages 2, 3b, 4 and 5 — **not stage 6.3 until your stage 1 is committed**; **`data/fs111/claims.md` in full — work §3's rungs from the negative side and
§4; quote, never paraphrase**; `data/fs106/claims.md` §0–§1; `plans/FS107-derivation.md` in full; `plans/FS107-W-near-colourings.md` §2–§4 (the last
wild side: its generator image, HX-STALL, its checker); the papers `arXiv-2407.05071-cohen-mani-clustering-unit-distance-avoiding-sets.pdf` §5 and
`arXiv-2304.10163-voronov.pdf` §2 in `~/source/library/pdf/`.

**Fences** (standing rule 13): the session transcripts (everything under `~/.claude/projects/-home-kooshi-source-lean-dir/`, memory included); `chats-bak/`;
every file in the shared harness scratchpad you did not create (work in `fs111-w/` there); **competitor M's record, working directory, tools and brief —
`plans/FS111-M-regularity.md`, `data/fs111/fs111-m/`, `tools/fs111_m_*`, `data/fs111/briefs/M-111-regularity.md` — until you have handed back**; the
verifiers' records; `plans/FS111-close-inventory.md`; `data/fs111/reports/`. An accidental open is a fence touch: log it and report it.

## The question, and your side

Card 1 (stage 2 of the plan) found that "FS-114's NO plus the cone scale gives seven" needs a third statement. **Route M**: the tight limit of a
hole-vanishing sequence can be taken to be a map (then the map NOs finish). **Route R**: every near-optimal colouring of any complexity carries a
complementary pair of fat blocking junctions (then FS107-RR finishes). **You are the wild side:** find where each fails.
1. **Against route M's rungs** (claims §3), for every `k`, with real objects at `k = 7` and fragments at `k = 6`: a tight colouring whose fills never
   saturate, or lose a colour class (against C-SAT-T); a saturated colouring whose bound boundary is not a Lipschitz graph at a bichromatic point
   (against C-HULL-REG); junctions that accumulate in every modification (against REG-J); a class that cannot be given tight block structure (against
   REG-B). A wild object by formula, checked exactly, is the product; so is a proof that the rung survives every construction of a named kind (say
   which kind: G21).
2. **Against route R** (claims §4): a family given by formula with holes decreasing and no complementary pair of junctions blocking toward a common unit
   point at any scale — R's own registration, P3 (0.6), expects one. HX-STALL (`plans/FS107-derivation.md` §2) is the last family of this shape and it
   stalled at a named constraint; say where yours stalls.

**Rules of your side.**
- Every object is given by formula and checked exactly by a tool of yours with a planted fault that fires for its own reason (standing rule 7); no search
  of any kind — the ban runs to 2026-10-01, and after it Kooshi's ruling stands: *"search for a finite graph is out. It would be huge, not feasible."*
  Keep the "would have searched here" log.
- State each construction's free parameters against the configuration's before you believe a family's failure (the generator-image rule): a family that
  fails measures its image.
- A tight six-coloured object of unbounded extent would be the answer: if you think you have one, say so at once and hand it to the owner before anything
  else.

**The contest** (`plans/PROTOCOL-competitor-and-advisor.md` §1). Competitor M proves the same rungs from the other end. You see M's record only after you
hand back. A blind verifier checks you after.

## Stages

1. Quotation check; name each claim's object, complexity class and boundary class; the tight seven-colour controls written down by formula with your checker.
2. Route M's rungs attacked, lowest first.
3. Route R (A-ALL, R-P3).
4. The verdict and the obstructions met, each at its grade.

## Deliverables

Record `plans/FS111-W-wild.md` ("Theorems this phase proved"; the "would have searched here" log; the fence log); `data/fs111/fs111-w/`; exact checks in
`tools/fs111_w_*.py` with planted faults. Report per standing rule 9 to `data/fs111/reports/FS111-W.md` and to "main". Commit subjects "FS111-W: stage n".
Your final text: "FS111-W idle; report sent to the owner by SendMessage".

Thank you.
