*Brief for job **FS111-P**: open FS-111, the cone scale, by WORKFLOW steps 3–5. Opus 5.5, 2026-09-27. Written by the product owner. **Sized for
about 350k tokens by the harness's count, as guidance** (standing rule 10). No planning advisor tonight: the three slots are yours, FS-114's planner,
and a blind verifier (BASE-V) (`plans/POROS-2026-09-27-night-aim.md` §1).*

Hello. You are de Bruijn (`DEBRUIJN.md`), the milestone planner, in `/home/kooshi/source/lean-dir`. **`data/fs111/briefs/STANDING-RULES.md` is part of
this brief. Read it in full, rule 0 first.** Read from disk (a subagent sees a stale snapshot of `CLAUDE.md`; FS-112's close has just rewritten it):
- `CLAUDE.md`: **§ The aim and § Counter-priors first**, then the rest (G82 closely, and link 6 of § The aim: De Giorgi's room);
- `LEDGER.md` in full, with rows 131–136 read closely (row 133's grade clause in particular);
- `WORKFLOW.md` steps 3–5, and `DEBRUIJN.md`;
- **the stub `plans/STUB-reg-scale.md`**, all of it, and `plans/STUB-global-step.md` (FS-114), `plans/STUB-hole-dial.md` (FS-109);
- `plans/FS107-derivation.md` (FS107-RR, FS107-MEET, W-EQ-K and their grades) and FS-107's §R-close;
- the night advisor's record `plans/POROS-2026-09-27-night-aim.md` (§3's card 1 and its prior-art list, §5).

## Kooshi's words (verbatim)

> "My goal is to fully solve, and then verify in Lean, HN. Then we publish." (2026-09-26)

> "Even decompressed, this is a bit beyond me, […]. I'll defer to a Poros agent." (2026-09-27; the night advisor chose FS-111 as
> tonight's second milestone, `plans/FS112-close-inventory.md` items 70, 73)

## The question

The stub's (`plans/STUB-reg-scale.md`), door (B): do near-optimal band-proper six-colourings keep junction cone scales `≥ s₀` on a set of positive
measure? **Before anything else — the night advisor's card 1, verbatim** (`plans/POROS-2026-09-27-night-aim.md` §3): *"Does FS-114's NO at every
complexity bound plus FS-111's cone-scale bound give seven, or is a third statement needed — R's (A) at unbounded complexity, a hole bound uniform in K,
or a NO for the boundaries a limit produces?"* Its hunch: "a third statement is needed — the NO bounds holes by `δ(K)` with no uniformity in `K`, and (B)
presupposes (A)'s junctions exist"; its falsifier: "a derivation that every family with holes → 0 and cone scale ≥ s₀ has a subsequence of bounded
complexity whose limit is a segment-and-arc map". The pairing of the two doors is one mind's reading (FS107-MEET; row 133). **Answer it at §IQ, by
derivation, before any phase**, and let the answer shape the milestone: if a third statement is needed, it is named and stubbed, and the front page's
route to seven is corrected at your close.

## What to produce: `plans/FS111-cone-scale.md`

1. **§G** (WORKFLOW 3.1), saved in two stages, each *bears* extracted into a phase.
2. **§PA** (all eight questions). The object in its home discipline's words: regularity of near-minimisers or optimal partitions under a non-local
   constraint (De Giorgi, Almgren, Taylor; Morgan's planar clusters, whose boundaries are circular arcs); compactness for sets avoiding a distance
   (`[Bukh2008]`, Falconer–Marstrand 1986, Furstenberg–Katznelson–Weiss 1990); whether any regularity theorem makes limits of near-optimal colourings
   into maps of segments and arcs, the only class the map NO covers. This literature is **unheld**: fetch what you need (standing rule 11; zbMATH's API
   for discovery, WORKFLOW 3.2 item 8), put each in `~/source/library/`, and record a reading status per section. An abstract is not a reading.
3. **§IQ**: card 1 first, then the structural form of door (B).
4. **The fixed claim list** `data/fs111/claims.md`: statements only, verbatim with addresses.
5. **The plan and the registrations** (populations stated; both outcomes reachable), the staffing (at most three agents at once, all Opus 5.5), and the
   briefs drafted as `data/fs111/briefs/<id>-*.md`. The ban runs to 2026-10-01, and "search for a finite graph is out" beyond it.

## Rules

- **Touch only** `plans/FS111-cone-scale.md`, `data/fs111/` (claims, briefs, `data/fs111/fs111-p/`), `tools/fs111_p_*.py`, and new files in
  `~/source/library/`. Also create `plans/FS111-close-inventory.md` empty from `plans/FS112-close-inventory.md`'s header; from then on the owner is its
  only writer.
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the owner
  can only review work it knows about.
- BASE-V (a blind verifier) and FS-114's planner are running: do not read BASE-V's record or contact either.
- **Contact:** only `"main"`. Commit subjects "FS111-P: stage n", neutral. Push after each; never amend or force-push.
- Report per standing rule 9 to `data/fs111/reports/FS111-P.md`: card 1's answer, the claim ids, the phases, the registrations, and any paper still
  needed. Your final turn's text: "FS111-P idle; report sent to the owner by SendMessage".

Thank you.
