# FS-110 — the tangency seam: does a tight six-map exist whose close complementary vertices are all tangent pairs, bowties or cusps? (the plan)

*Job FS110-P, the milestone planner (de Bruijn, Opus 5.5), 2026-09-27; brief `data/fs110/briefs/P110-planner.md` with
`data/fs110/briefs/STANDING-RULES.md`; advisor FS110-A (Poros), record `plans/POROS-2026-09-27-fs110-tangency-seam.md`. Stub:
`plans/STUB-tangency-seam.md`. WORKFLOW steps 3–4: §G (3.1), §PA (3.2), §IQ (3.3), the fixed claim list `data/fs110/claims.md`, then the plan and
the briefs. Nothing here derives a seam; the jobs do.*

## Theorems this phase proved

None. A planning phase states claims; it proves nothing (standing rule 7's heading, kept empty on purpose).

## Would-have-searched-here log (standing rule 3)

- A search for a map meeting Q-rule (a tile-ring enumeration, a local-rule SAT, a MaxSAT over vertex types) — instead the plan assigns the
  construction side maps **given by formula** and checked exactly, and the proof side a hand derivation per seam.
- A float sweep over ring junctions and directions for V-C5's killing test ("a ring junction and a direction `θ` with no forced band on either
  side") — instead the plan poses V-C5 as a statement to be derived, with the exact one-parameter families (sliver width, angular margin) written
  by formula and checked at named values only.

## Stage 1 — SAVED: quotation check (standing rule 5), files opened, one naming hazard

### 1.1 Files read from disk (this order)

`data/fs110/briefs/P110-planner.md`, `STANDING-RULES.md`, `A110-advisor.md`; `CLAUDE.md` § The aim, § Counter-priors, § Frontier (header, items
30–31, paths forward top rows), G71's FS-106 addition, G79's tail, G82 in full (the loaded copy was stale: it predates FS-106 and FS-107; the
disk copy governs); `LEDGER.md` rows 131–133 in full, rows 1–130 by headline; `plans/STUB-tangency-seam.md` in full; `plans/STUB-reg-scale.md`;
`plans/STUB-regular-half-residuals.md` item 2; `plans/STUB-hole-dial.md`; `data/fs107/claims.md` in full (§7 included); `plans/FS107-derivation.md`
in full; `plans/FS107-stability.md` §PA, §R-close 3.1–3.3; `plans/FS107-R-stability.md` §3.4–3.6; `plans/FS107-W-near-colourings.md` §2.5,
§4.2–4.4; `plans/FS107-V-verification.md` §4.3; `plans/FS107-VW-verification.md` §2b.4, §4; `plans/POROS-2026-09-27-fs107-competition.md` §5.1,
§5.4, §5.8–5.10; `plans/FS106-TS-derivation.md` (TS-U §2.2; C-T-TAN, l. 258; C-T-IND, C-T-KILL, l. 273–275; the theorem list l. 11–36);
`plans/FS106-V-verification.md` l. 368–374 (the ⅔π counterexample checked) and l. 452 (Woodall's row); `plans/FS106-derivation.md` l. 129, 172;
`plans/PROTOCOL-competitor-and-advisor.md` §1 and the ninth run.

### 1.2 Quotation check

| quotation in the brief or the stub | source | verdict |
|---|---|---|
| "My goal is to fully solve, and then verify in Lean, HN. Then we publish." | `CLAUDE.md` § The aim | matches (a prefix of the longer quotation) |
| "Let's see some ambition. I know we can do it." | `CLAUDE.md` § Counter-priors | matches (a prefix) |
| "search for a finite graph is out" | `CLAUDE.md` § Publication | matches ("… It would be huge, not feasible.") |
| Standing rules 0, 3, 4: "From here on out …", "to eliminate the crutch …", "A proven theorem about why its impossible is also valid. All novel knowledge is a success." | `CLAUDE.md` § Counter-priors, § Toolchain, Frontier item 23 | match |
| Stub, Q-rule, "is there a planar six-coloured map, tiles of diameter `≤ 1`, … survive K-KILL's second half)?" | A2 §5.1, table, bounded row | matches verbatim |
| Stub, "a YES is decisive (`χ(ℝ²) ≤ 6` with no MR, through W-EQ-K)" | A2 §5.9, the "Why the tangency-seam question first" bullet | matches |
| Stub, NO / YES clauses of Q-rule | A2 §5.1 | match |
| Stub, V-C5: "**Tangency is not an escape at positive scale** … `≳ s²·s′ sin(µ/2)`", the sketch, the killing test | FS107-V §4.3 | match |
| Stub, R's re-route "in the overlap of the two deformed annuli … so it is priced by CP" | FS107-R §3.4 | matches |
| Stub, W-TAN's paraphrase ("must form a tangent pair … or include a bowtie") | FS107-W-TAN, `plans/FS107-derivation.md` §2 | a paraphrase, unquoted; the claim list quotes the derivation file's statement |
| Brief, "Townsend's ⅔π counterexample to Woodall already lives among maps with a unit-arc seam" | FS106-V l. 368–374: "It uses a boundary that is a **unit arc**" | consistent; the check is at l. 368, after § Continuation — FS106-V3's heading (l. 276) |
| Brief, Q-full and Q-rule | the stub | paraphrased, unquoted; the claim list quotes the stub |

### 1.3 A naming hazard found in the quotation check (carried into the claim list)

**"C5" names two different objects.** (a) **TS-C5** — FS-106's *configuration C5* (`plans/FS106-TS-derivation.md` l. 200: "Configuration C5 (Prop. 5
fails at `x` without Condition 5)"), the object of FS106-AE-Q2's [G1] and of FS106-IND-X ("configuration C5 with a colour in the side cones at `y`").
(b) **V-C5** — FS107-V's fifth configuration of its CP tool (FS107-V l. 145: "C5: a full-ring junction with an interface exactly along `e_u^⊥`"),
the instance behind "tangency is not an escape at positive scale", filed as **FS107-V-C5**. The brief's "tangent pairs (C5)" is (b). The claim list
uses **V-C5** and **TS-C5** throughout, never bare "C5".

## Stage 1 — SAVED
