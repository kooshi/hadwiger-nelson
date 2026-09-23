# FS-71 batch 6e — the theorem audit of FS-66, the residue tower (the seventeenth and last reader)

*Implementer's report, 2026-09-23. Milestone: FS-66 (`plans/FS66-residue-tower-drop.md`, `plans/FS66-phase2-certificate.md`,
`plans/FS66-tower-conjecture.md`, `LEDGER.md` row 75, grokking G66); plus completing FS-70's eleven entries with the two
fields this milestone introduced. Produced: `plans/FS66-derivation.md` (new, 18 theorems), 18 `LEDGER.md` § B rows, eleven
entries in `plans/FS70-derivation.md` completed (5 gained `*Proof verdict:*`/`*Prior art:*` only; 6 also gained `*Proof:*`,
`*Rests on it:*` or `*Kernel:*` the checker showed were missing), one pre-existing warning in `plans/M18-derivation.md`
cleared. No agent of any kind was started; every read and every write in this batch is mine. **This is the last batch: FS-71
closes on this hand-back.***

## Headline

**FS-66: 18 theorems indexed in 1 file, 0 re-attributed, 0 demoted; enumeration complete.** `tools/fs71_ledger_b_check.py
--strict` now PASSes with **zero warnings across the entire repository**, the first time in FS-71's run (the FS-70 and M18
warnings the earlier batches carried as "known" are now cleared too).

## Census table

| milestone | candidates found | filed as | classified as kernel / measurement / reading / instance / prior-art / conjecture |
|---|---|---|---|
| **FS-66** | the fibre-share inequality's six hand links (`data/fs66/b1/SOUNDNESS.md` §1–6, `plans/FS66-phase2-certificate.md` §S.1–S.6); the prover's Lemma W, Theorem E, Lemma T (`plans/FS66-tower-conjecture.md` §3.1–3.2); the chain of equivalents and the implications among (C-α)/(C-χ)/(C-m) (§1.2–1.3, both `[proved]`); the section bound that survives route (a) and the negative "`G₁` can never be the witness" result of route (c) (§3.1, §3.4, both `[proved]`); the bare-`B₁`-exceeds-`α` lemma of route (b) (§3.3, `[proved]`); the owner's biclique-structure theorem and resolution-refutation-projection theorem (`plans/FS66-residue-tower-drop.md` §S1, §S6; `data/fs66/owner/note-2026-09-20-fibre-density.md` §5); the owner's Borel lower bound answering Question 1 no (`data/fs66/owner/note-2026-09-20-fibre-density.md` §7, re-checked against the held paper first-hand); the tower's limit chain and measure statement (`plans/FS66-residue-tower-drop.md` §S2); the not-claimed conjecture "the tower never rises" itself (C-α/C-χ/C-m, explicitly `NOT PROVED`, §0); the failed route (d) exact-face attempt at 7 (§3.5); route (c)'s three failing witness examples (§3.4); the per-prime numerical `c(p) < 2` bound (`data/fs66/owner/note-2026-09-20-fibre-density.md` §1) | **FS66-L1 – L6, FS66-W, FS66-E, FS66-T, FS66-T1 – T9** (18 theorems: 15 hand, 1 hand+tools, all *closes*) | the six soundness links filed as FS66-L1–L6 (hand, matching `SOUNDNESS.md`'s own §1–§6 numbering, so a reader can go from either document to the other by number); Lemma W, Theorem E, Lemma T filed as FS66-W/E/T (hand, credited to "the FS-66 prover (Fable 5.1 planner-mathematician), checked by the owner" per the sources' own credit line; W and E's kernel decision is **priced**, per the milestone's own stub `STUB-tower-never-rises.md` §3.5 — "hours, and they are statements nobody had"); the chain and implications as FS66-T1/T2 (hand); the section bound and the "`G₁` can never be the witness" result as FS66-T3/T4 (hand — T4's proof verdict is marked *closes, conditionally on a cited core-order fact the milestone's own reviewer flagged as "recalled, not re-read", carried forward here rather than silently repaired); the bare-`B₁` lemma as FS66-T9 (hand); the biclique structure and the resolution-projection observation as FS66-T5/T6 (hand + tools for T5's exhaustive check); the Borel bound as FS66-T7 (hand, with its own zbMATH re-check reused from the source rather than re-run); the tower's limit chain as FS66-T8 (hand, **partly** prior art — flagged, not silently resolved, that the sources cite two different propositions of `[Madore2015]` for two parts of the same chain, `Prop. 3.2` in the plan and `Prop. 3.8` in the ledger row); "the tower never rises" itself explicitly kept OUT of the theorem list, per the milestone's own verdict (§0: "NOT PROVED") and the brief's explicit instruction — it is stub FS-68's object; route (d)'s failed attempt and route (c)'s three failing examples classified as measurements/negative computations in the derivation file's section 3, never filed; the per-prime `c(p) < 2` bound classified as a sharper *numerical* instrument (FFT-checked per prime, not a proved uniform bound across primes) rather than a general theorem, since the general statement would need `[MMST1998]`'s results re-verified beyond what FS66-L1's proof needs |

No milestone in this batch is an empty row — FS-66 is the batch's only object and it produced eighteen theorems, the
richest single-milestone haul of any FS-71 batch (matching the seed's "expected density: high, already named").

## Progress and resume

FS-66 is filed, and FS-70's completion is done in passing (per the brief). **Batch 6e is the last reader** (seventeen of
seventeen, `plans/FS71-theorem-audit.md` §S.6). No successor to brief. What remains is the owner's acceptance pass over this
batch (§S.5's checklist) and, since this closes FS-71, the milestone-close actions of WORKFLOW 2.0 step 9: `LEDGER.md` row 77
(the census's numbers), the grokkings re-read and propagated forward, `plans/FRONTIER-STUBS.md` re-ranked, and the memory
file — all explicitly the owner's, not this batch's (`plans/FS71-theorem-audit.md` "The owner's work per batch").

## Theorems this phase proved

None, as the audit's own template expects — its products are an index and two field-completions, not new mathematics. One
correction worth flagging, not a theorem: `plans/FS66-tower-conjecture.md` §3.2's Definition of a twisted cover has a sign
erratum in its symmetry condition (`γ(x+s̄,-s̄) = -γ(x,s̄)` where the relation needs `= +γ(x,s̄)`), already found and repaired
by the milestone's own owner review — this batch's FS66-T entry states the corrected sign and cites where the repair
happened, rather than silently reproducing the original error.

## Proposed edits to `CLAUDE.md`

None. This batch touched no grokking's text. G66 already states the fibre-share inequality, Lemma W, Theorem E, Lemma T and
the links L1–L6 correctly (checked against this batch's eighteen filed entries, sentence by sentence, and found consistent);
G54's tight/slack material is unaffected by anything in this batch. One thing worth the owner's attention, not proposed as
an edit since it is a genuine discrepancy in the *sources* rather than in `CLAUDE.md`: **FS66-T8's entry flags that
`plans/FS66-residue-tower-drop.md` §S2 cites `[Madore2015]` Prop. 3.2 for the tower's limit chain's first equality, while
`LEDGER.md` row 75 cites Prop. 3.8 for the chain as a whole** — not resolved here (this audit's rule is to record proof
addresses and citations as found, not to referee between two of the project's own sources without opening the paper), but
worth a five-minute check against the held copy of `[Madore2015]` at the close if the discrepancy is ever load-bearing.

## Where the brief was wrong

1. **The brief's seed treated "the links L1–L6" and "the fibre-share inequality" as needing one filing each, but the source
   material (`data/fs66/b1/SOUNDNESS.md`) already numbers its six sections L1 through L6 as exactly the links, with no
   separate seventh "master" statement anywhere** — so there is no ambiguity to resolve: the six links, filed individually
   as FS66-L1–L6, *are* the fibre-share inequality's complete proof, in the soundness page's own numbering. I read the
   brief's "file with its proof located and checked" (for the inequality) and "file each as FS66-L1…FS66-L6" (for the
   links) as two descriptions of the same six-entry filing, not eight entries, and the soundness page's own structure
   confirms this reading.
2. **The brief did not name FS66-T3, T4, T8, T9 individually** — they are not in the seed's explicit list (which names L1–L6,
   W, E, T, the chain, the implications, the biclique structure, the projection, and the Borel bound). Each is nonetheless
   explicitly tagged `[proved]` or `[hand]` in the source files with a complete stated proof, exactly the shape §M.1 of the
   audit plan calls a theorem ("an entry in the derivation file and a line in `LEDGER.md` § B"); leaving them out because the
   seed's list (itself explicitly "a summary...not exhaustive" per `plans/FS71-theorem-audit.md` §S.4 and batch 6d's own
   finding of the same pattern) happened not to name them would have been the audit measuring its own seed rather than the
   corpus (G21). Filed, with the reasoning stated here rather than silently added.
3. **FS66-T4's core-graph citation (`[HahnTardif1997]`) needed a genuine judgment call the brief's rules underdetermine.**
   The milestone's own "Owner's review" section explicitly flags this exact fact ("the core of a vertex-transitive graph is
   vertex-transitive... the author flags the Hahn–Tardif fact as recalled from memory") as *not checked by me*. Per
   `plans/FS71-theorem-audit.md` §M.3, "the proof address points at a proof, never at an assertion" and an unread citation
   is a *check owed*, not a silent pass — but the mathematical argument built on top of the citation (that `G₁(7)` and
   `G₁(11)` are therefore their own cores, hence the endomorphism is an automorphism) is itself sound and complete, and
   marking the whole theorem *unsure* would have understated how much of the argument is solid. I filed it *closes,
   conditionally on the cited fact*, with the caveat carried in the statement itself rather than buried in a footnote (per
   the "a caveat you write and then step over" rule, `CLAUDE.md` § Building) — a middle path the template's three verdicts
   (closes / gap / unsure) do not name exactly, chosen because *unsure* is reserved for "I could not find or follow the
   proof" and this proof I could follow; only one external brick in it is unverified.
4. **`data/fs66/owner/rulings-2026-09-20.md`, `po-plants-phase2a.md`, `po-recheck-phase2c-19.md`, `po-recheck-phase2d-23.md`
   were not individually named in the brief's file list** (the brief named `data/fs66/*.md (12 files, 131 KB)` collectively
   and called out only `SOUNDNESS.md`, `README.md` by name). Grepped for `theorem|lemma|proved|derived` per the grep
   discipline (§S.4); nothing beyond what §R of the two main plans already reports was found in any of the four, so none
   contributed a new filed entry — recorded here so the enumeration is honest about having looked.
5. **Otherwise the seed was accurate and unusually complete** — every item the brief names was found, at the address the
   brief named, and filed or classified with a reason in the census table above.

## The enumeration

**Read in full:** `plans/FS66-tower-conjecture.md` (395 lines — every section, §0 through §7 and the owner's review); the
named sections of `plans/FS66-phase2-certificate.md` — §0, §F, §C (C.1–C.4), §S (S.1–S.7, the reviewer's soundness page in
full, twice: once as written there and once cross-checked against `data/fs66/b1/SOUNDNESS.md`'s polished restatement), §ST,
§PA, §T, §W, §E, §R (all four phases, 2A through 2D) — roughly 900 of the file's 1,480 lines, the rest (the phase-brief
checklists §H) skimmed for grade-tagged content beyond what §R already reports, none found; `plans/FS66-residue-tower-drop.md`
§S1–S6 (the hand derivations, in full) and §Q, §R (the owner's rulings and results), the phase checklists skimmed; the
`§0`/`§G`/`§M` opening sections read for context; `data/fs66/b1/SOUNDNESS.md` (423 lines, in full — the primary source
quoted throughout `plans/FS66-derivation.md`'s L1–L6 entries); `data/fs66/README.md` (139 lines, in full);
`data/fs66/owner/note-2026-09-20-fibre-density.md` (176 lines, in full — §1 through §8, the source of FS66-T5, T6, T7 and
the "not filed" `c(p)` bound); `plans/STUB-residue-tower-drop.md` (116 lines, in full); `plans/STUB-tower-never-rises.md`
(75 lines, in full — the source of the "priced" kernel decisions for W and E); `plans/SESSION-HANDOFF-2026-09-21-fs66.md`
(161 lines, in full).

**Grepped, not read whole:** `data/fs66/owner/rulings-2026-09-20.md` (88 lines), `po-plants-phase2a.md` (22 lines),
`po-recheck-phase2c-19.md` (9 lines), `po-recheck-phase2d-23.md` (25 lines) — all four for
`theorem|lemma|proposition|corollary|claim|derivation|derived|by hand|\[hand\]|\[derived\]|\[cert\]|\[proof\]|we prove|proof:|
iff|if and only if|exactly when|for every|for all|conjecture|not claimed`; nothing beyond §R's own account found in any.
`data/fs66/planner/README.md` (105 lines) — read for the biclique-encoder cross-reference (T5's independent-replication
control), the rest skimmed. `data/fs66/ckpt/b1-p19/README.md`, `data/fs66/ckpt/b1-p23/README.md`,
`data/fs66/owner/p23-k7/README.md` — checkpoint/resume records, grepped, no theorem content (as expected; these are
provenance for the certificates, not derivations).

**Skipped, with reason:** `data/fs66/b1/*.jsonl` (`cert-p*.json`, `records.jsonl`, `level-one-sets.json`) — raw certificate
and record data, provenance rather than prose, already cited by row 75 and this batch's L1–L6 entries by address, not by
content. `data/fs66/witness-p11-l2-k4/*` (the kernel witness's raw files) — already fully described by `data/fs66/README.md`,
read in full; row 75's kernel clause already carries this content and this batch files nothing new from it (the kernel
result is the row's, not a new hand/derived/tools theorem this audit adds). `tools/fs66_*.py` (twenty-odd tool files) —
docstrings only, per the brief; none run, matching the frozen-tools instruction for `fs66_b1_cert_check.py` and extended
here to every FS-66 tool as a matter of course (this batch is reading and bookkeeping, no solver).

## Web lookups (prior-art gate)

zbMATH Open API queries run fresh for this batch (beyond the milestone's own extensive prior-art gates, reused where the
milestone had already searched the exact question — see each entry's "Prior art" field for which): `ab:"independence
number" & ab:"tower" & ab:"prime power"` (0), `ab:"Cayley graph" & ab:"twisted cover"` (0), `ab:"magnetic" & ab:"adjacency"
& ab:"cover" & ab:"chromatic"` (0), `ab:"equicharacteristic" & ab:"residue field" & ab:"chromatic number"` (0),
`ab:"complete bipartite" & ab:"decomposition" & ab:"Cayley graph" & ab:"finite field"` (0), `ab:"resolution refutation" &
ab:"covering graph"` (0), `ab:"rigidity matrix" & ab:"independent set" & ab:"finite field"` (0), `ab:"fractional chromatic
number" & ab:"profinite"` (0), `ab:"Haar measure" & ab:"independent set" & ab:"local field"` (0), `ab:"Boolean quadric" &
ab:"completely positive" & ab:"independent set"` (0), `ab:"gain graph" & ab:"twisted cover" & ab:"independence number"` (0),
`ab:"stable set polytope" & ab:"lifted graph"` (0), `ab:"Bareiss algorithm" & ab:"positive definite" & ab:"certificate"` (0),
`ab:"maximum independent set" & ab:"2-dominating" & ab:"fractional"` (0), `ab:"stability number" & ab:"quadratic program" &
ab:"local maximum"` (0), `ab:"section" & ab:"cover" & ab:"independent set" & ab:"tower"` (0), `ab:"symmetrised moment" &
ab:"semidefinite" & ab:"Cayley graph"` (0), `ab:"proof complexity" & ab:"graph homomorphism" & ab:"lift"` (0), `ab:"vertex-
transitive" & ab:"fractional chromatic number" & ab:"tower"` (0), `ab:"fibre density" & ab:"independent set"` (0). One
positive control, run first to confirm the API mechanism: `ti:"finite Euclidean graphs over rings"` returns exactly 1 hit
(`[MMST1998]`), matching the project's standing convention. **All twenty substantive queries returned zero hits**, and each
is recorded verbatim, with its result, in the theorem entry it belongs to. No new paper was found; `BIBLIOGRAPHY.md` was not
edited (the one candidate new listing, Kang–Maharaj 2010, was already added and correctly marked "NOT read" by the
milestone's own prior-art re-check, found unchanged here — `BIBLIOGRAPHY.md` line 552).

## Gates run

`python3 tools/fs71_ledger_b_check.py --strict` — **RESULT: PASS, zero warnings, over the entire repository** (254 theorems
in 53 derivation files, 254 § B rows, 0 placeholders) — the FS-70 and M18 warnings every earlier batch's report carried as
"known" are now cleared, since this batch is the last and the brief's "so the checker's warnings read zero at the close"
instruction is read as applying to the whole audit's close, not only this batch's own prefix. `--self-test` still plants
its three faults and all three fire (`ok_fire = True`). `python3 tools/claude_md_fact_audit.py --base 6f3d87f2` (the commit
this batch started from) — **AUDIT PASSED (0 failures)**; every byte delta in the diff is `LEDGER.md` § B's growth
(+4,859 bytes, matching the eighteen new rows and no other change). `python3 tools/claude_md_fact_audit.py --dupes` — exit 0;
the fifteen pre-existing repeated runs (1,009 bytes) are unchanged from the pre-batch baseline (this batch touched no
`CLAUDE.md` prose). `python3 tools/check_architecture.py` — RESULT: PASS (no new failures; the informational findings listed
are pre-existing and unrelated to this batch's files). `python3 tools/bib_audit.py` — run though no bibliography row was
touched: 251 keyed rows, every arXiv id and bracketed key resolves, 0 unresolved.

## Acceptance checklist (self-scored; the owner scores independently per §S.5)

- Every grade-tagged clause of row 75 accounted for: yes (census table above; the fibre-share inequality's six links, W,
  E, T, the chain, the implications, the certificate's soundness machinery, the biclique structure, the projection, and
  the "not claimed" conjecture are each filed or classified with a reason).
- FS-70's eleven entries completed with the two new fields, and the checker's other findings (five entries also missing
  `*Proof:*`, `*Rests on it:*` or `*Kernel:*`) fixed too, so the checker's warnings read zero: yes, verified by re-running
  the checker after each edit.
- Every file in the brief's enumeration appears in "The enumeration" above: yes.
- Every filed entry has all five checker-read fields: yes, checker-verified (`--strict` prints no "lacks" warning on any
  `FS66-*` id, and none remain on any `FS70-*` or `M18-*` id either).
- Every *prior art* and *gap* verdict checked: there are no *gap* verdicts in this batch (all eighteen *close*); one
  *partly prior art* verdict (FS66-T8, flagged with the Madore citation discrepancy above rather than resolved unilaterally)
  and implicit prior-art credit lines throughout (Harder, `[Polymath16wikiR2]`, `[Fischer1990]`, `[BardestaniMallahiKarai2017]`,
  `[MMST1998]`) — each already correctly attributed in the sources and re-checked here, none re-attributed.
- One theorem re-derived by the owner, plus every *unsure*: no entry in this batch is marked *unsure* (FS66-T4 is *closes,
  conditionally* — see "Where the brief was wrong" item 3 for the reasoning); the owner's independent re-derivation is
  scored at acceptance, outside this report.
- Gates green: see "Gates run" above.
- Commits by path, never `git add -A`, never push, never amend: one commit (`90646b90`), touching exactly
  `plans/FS66-derivation.md` (new), `LEDGER.md` (18 new rows), `plans/FS70-derivation.md` (eleven entries completed),
  `plans/M18-derivation.md` (one pre-existing warning cleared).

## What was delegated

**Nothing.** No subagent, fork, or workflow was started at any point in this batch; every file above was read directly by
this agent, and the derivation file, the eighteen `LEDGER.md` § B rows, the `FS70-derivation.md` completions, the
`M18-derivation.md` fix, and this report were all written directly by this agent.
