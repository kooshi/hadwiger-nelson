*Brief for job **FS114-P**: open FS-114, the unit-arc question (its central statement, the global step), by WORKFLOW steps 3–5. Opus 5.5, 2026-09-27. Written by the product
owner. **Sized for about 350k tokens by the harness's count, as guidance** (standing rule 10). No planning advisor tonight: the three slots are yours,
FS-111's planner, and a blind verifier (BASE-V) on the base's printed steps (`plans/POROS-2026-09-27-night-aim.md` §1).*

Hello. You are de Bruijn (`DEBRUIJN.md`), the milestone planner, in `/home/kooshi/source/lean-dir`. **`data/fs114/briefs/STANDING-RULES.md` is part of
this brief. Read it in full, rule 0 first.** Read from disk (a subagent sees a stale snapshot of `CLAUDE.md`; FS-112's close has just rewritten it):
- `CLAUDE.md`: **§ The aim and § Counter-priors first**, then the rest (G82 and G83 closely);
- `LEDGER.md` in full, with rows 131–136 read closely;
- `WORKFLOW.md` steps 3–5, and `DEBRUIJN.md`;
- **the stub `plans/STUB-global-step.md`**, all of it, and its sibling `plans/STUB-stuck-ray.md` (FS-115) and `plans/STUB-reg-scale.md` (FS-111);
- FS-112's close: `plans/FS112-unit-arc-half.md` §R-close, `plans/FS112-derivation.md`, `data/fs112/fs112-c/reconciliation.md` §§1.5–1.11,
  `data/fs112/claims.md` (with its §11 corrections);
- the night advisor's record `plans/POROS-2026-09-27-night-aim.md` (§3's cards 2 and 3, §6);
- `plans/PROTOCOL-competitor-and-advisor.md`, as amended at FS-112's close.

## Kooshi's words (verbatim)

> "My goal is to fully solve, and then verify in Lean, HN. Then we publish." (2026-09-26)

> "When round 3 finishes, let's close this milestone, and point two milestones at the two gaps, so we can focus on them specifically. They seem to
> require more research and careful exploration, and may be more complicated than they appear." (2026-09-27, `plans/FS112-close-inventory.md` item 59)

> "Even decompressed, this is a bit beyond me, […]. I'll defer to a Poros agent." (2026-09-27, on which milestones run tonight;
> item 70 — the night advisor chose FS-114 first)

## The question

The stub's, verbatim at its head: *"can a six-map with unit arcs have a vertex of four colours or a repeated colour within 3 of every point?"* By
FS112-N3-DENSE3 every valid map has that property, so in that form **the global step is the NO itself** (FS112-C-COMPOSE, one mind). **Choosing the
form is your first decision** (the stub: *"Choosing the form is the milestone's first decision."*): DENSE3's form; the four-colour form (enough alone for
doubly periodic maps; for aperiodic maps it needs FS-115's two steps); or the night advisor's §6 form, one four-colour vertex (one mind, over C-ENDS: a
local exclusion about one four-colour vertex would be the whole NO). State it as a decision in four parts. **If you choose the four-colour form for
aperiodic maps, say so at once in a message to `"main"`**: FS-115 then takes the next free slot.

**The first question, the night advisor's card 2, verbatim** (`plans/POROS-2026-09-27-night-aim.md` §3): *"Is the unit-arc NO local — an explicit radius
past which no valid fragment survives around a four-colour vertex — or visible only to a count over the whole plane, as Euler's formula and discharging
give?"* Its hunch is "global" (G17); its falsifier "an explicit radius R with a derived exclusion of every valid fragment on the disc of radius R about a
four-colour vertex". Put it to the re-grokking and the prior-art gate before any route.

## What to produce: `plans/FS114-unit-arc-question.md`

1. **§G** (WORKFLOW 3.1): one short line per grokking, row mechanism and method rule, each *bears* extracted into a phase. Save it in two stages.
2. **§PA** (all eight questions), in the planar-map vocabulary as well as the unit-distance one: "discharging" with "unit distance", "tiling" or
   "exclusion zone"; upper bounds on the radius of a six-tile-colourable disc or the width of such a strip (`[Polymath2021]`'s strips and discs and the
   works citing it); Euler-characteristic and angle-budget arguments for tilings with prescribed vertex types. **Sirgedas's near-proof "that the plane
   cannot be 6-tlled [sic] with a non-Siamese tiling"** (`[16.317]`, in the Google group hadwiger-nelson-problem) is unheld: **do not fetch from the
   Google group — that is Kooshi's call**; record it as the first prior-art debt.
3. **§IQ** (WORKFLOW 3.3): G83 says the question lives at four-colour vertices; what must every valid map carry there — the invariant a NO reads?
4. **The fixed claim list** `data/fs114/claims.md`: statements only, each quoted verbatim from its source.
5. **The plan and the registrations** (each with its population; both outcomes reachable), the staffing (at most three agents at once, all Opus 5.5;
   FS-112's shape was a proof side against a construction side, a competition advisor, and a blind verifier per side — choose what this question needs),
   and the briefs drafted as `data/fs114/briefs/<id>-*.md` for the owner to launch. **The ban runs to 2026-10-01, and Kooshi's ruling stands beyond
   it: "search for a finite graph is out."** Candidate maps are given by formula and checked exactly; the frozen checkers stay frozen, and any new one
   accepts the strip before any of its refusals is believed.
6. **BASE-V is running** (a blind re-derivation of S–V Lemma 5, Prop. 18, Lemma 6's `< 9` branch and the cusp items, in FS-112's setting; brief
   `data/night-2026-09-27/brief-BASE-V.md`). Its record is its own until it reports; do not read it or contact it. Plan so that a failing step becomes
   your first phase (the repair), and say so.

## Rules

- **Touch only** `plans/FS114-unit-arc-question.md`, `data/fs114/` (claims, briefs, `data/fs114/fs114-p/`) and `tools/fs114_p_*.py`. Also create
  `plans/FS114-close-inventory.md` empty from `plans/FS112-close-inventory.md`'s header; from then on the owner is its only writer.
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the owner
  can only review work it knows about.
- Do not derive the global step yourself; the jobs do. State the claims exactly.
- **Contact:** only `"main"`. Commit subjects "FS114-P: stage n", neutral. Push after each; never amend or force-push.
- Report per standing rule 9 to `data/fs114/reports/FS114-P.md`: the form chosen, the claim ids, the phases, the registrations, and any paper still
  needed. Your final turn's text: "FS114-P idle; report sent to the owner by SendMessage".

Thank you.
