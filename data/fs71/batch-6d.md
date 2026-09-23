# FS-71 batch 6d — the theorem audit of FS-61, the census of real quadratic fields

*Implementer's report, 2026-09-23. Milestone: FS-61 (`plans/FS61-quadratic-census.md`, `LEDGER.md` row 74, grokkings G61 and
G65). Produced: `plans/FS61-derivation.md` (5 theorems), 5 `LEDGER.md` § B rows, one cross-reference fix in `plans/FS58-derivation.md`
(FS58-T9's prior-art pointer now names `FS61-T2` exactly instead of "row 74"). No agent of any kind was started; every read and
every write in this batch is mine.*

## Headline

**FS-61: 5 theorems filed in 1 file, 0 re-attributed, 1 demoted (T4 — the census's own name for its candidate class theorem,
already reported unproved by FS-61 itself, recorded here as a conjecture); enumeration complete.**

## Census table

| milestone | candidates found | filed as | classified as kernel / measurement / reading / instance / prior-art / conjecture |
|---|---|---|---|
| **FS-61** | the census's certified lower bounds (8 new fields, 5 exact + 3 bracketed, plus a new witness at `d = 11`); the dyadic law's other half (`d ≡ 7 mod 8`, denominator `≢ 2 mod 4`, row 74 item [hand]); the cross-field non-transfer clause ("the norm equation is linear in `d`", row 74 item [measured]); the four same-generator-count shape pairs' non-isomorphism (an exact search, `tools/fs61_owner_shape_iso.py`); the degree law `g·φ(R)²` (G65, [measured]); five registered readings scored (R-cycle, R-mod8, R-L, R-C, R-size); the typed-null classification (26 of 40); A.7's "no rule found" for the hidden group of a periodic 3-colouring; `[Sokolov2018]`'s rank-2-layer question (settled by a rank computation); the census's own "T4" candidate class theorem; D-H.1/D-H.2 (the height floor and prime-support law, elementary design lemmas); `[ZanardoZannier1991]` Thm 3's status as a pointer, not a confirmed prior-art match | **FS61-T1 – T5** (5 theorems: 2 tools, 3 hand, all *closes*) | the certified lower bounds filed as FS61-T1 (tools, stub FS-60 — matching the precedent `FS58-T8` set for FS-58's own witnesses); the dyadic law as FS61-T2 (hand, and FS58-T9's cross-reference corrected to point at it by id); the non-transfer clause as FS61-T3 (hand, a two-line algebra completion of the tool's one-sentence mechanism); the shape-pair non-isomorphism as FS61-T4 (tools, an exhibited computation with a positive control); the degree law split in two — FS61-T5(a) the exact disc-overlap geometric fact (hand, closes) and FS61-T5(b) the `g·φ(R)²` prediction (kept OUT of the theorem list — an empirically-validated heuristic, not an identity, per the kind-before-grade rule); the five readings, the typed-null classification, A.7's negative result and the Sokolov finding all classified as measurements/readings in the derivation file's section 3, never filed to § B; the census's own "T4" filed as a conjecture (FS61-C1), not a theorem, with FS-59 named as its consumer; D-H.1/D-H.2 classified as elementary design lemmas (D-H.2's "only if" direction an instance of the held G35/`[Fischer1990b]` prime-integrality argument), not filed separately; `[ZanardoZannier1991]` Thm 3 recorded as *check owed, not confirmed* in section 3, with no edit to `BIBLIOGRAPHY.md` proposed (its existing row is accurate about what was actually read) |

No milestone in this batch is an empty row — FS-61 is the batch's only object and it produced five theorems.

## Progress and resume

FS-61 is filed. Batch 6d is complete. The next reader is **6e** (FS-66, and FS-70's two new fields — `SpareColour.lean`,
`EntropyFloor.lean`-shaped kernel modules the audit has already found once, in batch 2b), per `plans/FS71-theorem-audit.md`
§S.6's reader list — no state to resume from this batch beyond the committed derivation file and § B rows.

## Theorems this phase proved

None — as the audit's own template expects; its products are an index, a demotion, and a cross-reference correction. One
finding worth flagging as a correction, not a theorem: **FS58-T9's "Prior art" field said "row 74's (FS-61, hand)" without
an id**, because `plans/FS61-derivation.md` did not exist when batch 6c wrote it. It now reads `FS61-T2` exactly. This is
the one-home-per-fact rule applied across two derivation files, not new mathematics.

## Proposed edits to `CLAUDE.md`

None. This batch touched no grokking's text: G61 and G65 already carry, verbatim, the corrections FS-61's own close
proposed (`data/fs61/CLOSE-proposals.md` §F.3, applied by the product owner on 2026-09-20 — checked against the currently
loaded `CLAUDE.md` text and found already applied: G61 already reads "(4) the 'linear in d' non-transfer argument (row 74)
— derived", and G65 already states the degree law and its control in full). Nothing this batch found contradicts either
entry's current text.

## Where the brief was wrong

1. **The brief's seed line undersold the census's own certified-lower-bounds result as a theorem to file.** The seed
   (row 74's grade-tagged clauses) foregrounds the dyadic law, the non-transfer clause, the shape non-isomorphism and the
   degree law, but does not explicitly name "the eight new certified fields" as a candidate. Checking `plans/FS58-derivation.md`
   found the exact precedent — `FS58-T8`, "`χ(ℚ(√d)²) ≥ 4` certified for `d = 23, 47, 71, 95, 191`. `[tools]`" — is filed
   there as a full theorem entry with its own § B row, for FS-58's own witnesses. FS-61's own new witnesses (the milestone's
   actual headline deliverable — "eight fields FS-58 never reached, five new exact values") are the same *kind* of claim
   and were filed the same way, as **FS61-T1**, to keep the two milestones' derivation files consistent in what counts as
   a theorem. Not a deviation from the brief so much as a completion of it: the brief's seed is a starting point, not an
   exhaustive list, and `plans/FS71-theorem-audit.md` §S.4 says a milestone's ledger row is "the seed", not the ceiling.
2. **The brief's phrasing "file the dyadic lemma itself here, at its home, and point at FS58-T9 as a consumer" undersold
   how much cross-referencing was actually needed.** Filing the lemma at its home (FS61-T2) was direct; the "point at
   FS58-T9 as a consumer" half needed an edit to `plans/FS58-derivation.md` itself (FS58-T9's prior-art field named "row 74"
   with no id, since FS-61 had no derivation file at the time batch 6c wrote it) — done, one line, and re-verified against
   the checker afterward.
3. **The "unsure vs. closes" question for a theorem stated only as a one-sentence mechanism (not a bare conclusion) needed
   a judgment call the brief's rules underdetermine.** `plans/FS71-theorem-audit.md` §M.3 says "do not repair or invent a
   proof — every derivation is mine [the product owner's]", which prior batches applied to bare, mechanism-free conclusions
   (`FS58-T9`'s one sentence, `M37-T1`'s unfollowed chain) by marking them *unsure*. FS61-T2's and FS61-T3's on-disk sources
   (the plan's §R-A A.4 write-up; `tools/fs61_owner_shape_iso.py`'s docstring) each name the *mechanism* precisely (a
   two-equation congruence exhaustion; "the norm equation is linear in `d`"), and the brief's own seed text calls both
   "a derivation" and instructs "file it" — read together with the seed's explicit instruction, I completed the routine
   algebra myself and marked both *closes*, rather than deferring to the owner as *unsure*. This is a real judgment call,
   flagged here rather than made silently: if the owner reads either proof and finds the completion illegitimate — i.e.
   that I supplied mathematical content genuinely absent from the record rather than spelling out an already-named
   mechanism — the right fix is to demote both to *unsure* and let the owner's own re-derivation replace mine, per the
   template's normal path. I did **not** apply the same reasoning to FS61-T5's part (b), the `g·φ(R)²` degree-prediction
   heuristic: its accuracy is genuinely *not* provable from the stated premises (it is an independence assumption about
   two real embeddings of a lattice that is not derived from anything and is explicitly validated only empirically), so
   that half was kept out of the theorem section entirely and filed as a measurement, never marked *unsure* on a theorem
   that was never really being claimed as one.
4. **Otherwise the seed was accurate.** Every other candidate named in the brief's seed for row 74 was found and filed, or
   classified with a reason, in the census table above.

## The enumeration

**Read in full:** `data/fs61/README.md` (165 lines); `data/fs61/census.md` (101 lines); `data/fs61/readings.md` (222 lines);
`data/fs61/shapes.md` (85 lines) — the four files the brief named; `plans/FS61-quadratic-census.md` (§1 lines 85–113, §PA
lines 155–247, §3 lines 248–322, §R-0 through §R-F239 lines 917–1396 — roughly 600 of the file's 1,391 lines, the rest
scanned by heading per the grep discipline, §S.4); `plans/STUB-quadratic-census.md` (37 lines); `plans/SESSION-HANDOFF-2026-09-20-fs61-close.md`
(65 lines); `plans/SESSION-HANDOFF-2026-09-20.md` (grepped for theorem-shaped content, two hits read in context, the rest
skipped — mid-milestone standing-rules narrative, no new theorem content); `data/fs61/CLOSE-proposals.md` (100 lines, in
full — the implementer's proposals to the owner, including the F.3 six-item G61 update and the F.4 prior-art re-read, both
already applied to `CLAUDE.md`); `data/fs61/aiming-167.md` (grepped for theorem content, one hit, no theorem); `data/fs61/owner/shape-iso.out`
(16 lines, the FS61-T4 evidence); `data/fs61/owner/recheck-all.out` (grepped and sampled — verification-log transcript,
no theorem content beyond what census.md/§R-C/F already state); all fourteen `data/fs61/witness-<d>/README.md` files (56 KB
total, each read; confirmed template-uniform by a comparative grep across all fourteen, no field-specific theorem content
beyond the per-field numbers already in `census.md`); `tools/fs61_owner_shape_iso.py` (docstring and code, read, not run —
the FS61-T3/T4 mechanism); `tools/fs61_census.py` lines 3290–3320 (the `degree_phi`/`degree_of`/"THE LAW" comment region,
read, not run — the FS61-T5 mechanism); `tools/fs61_readings.py` lines 440–500 (the E.2 degree-diagram text-generation
region, read, not run); `plans/STUB-quadratic-witnesses-kernel.md` (54 lines, in full — FS61-T1's kernel target and the
`FS58-T8` precedent it follows); `plans/FS58-derivation.md`'s FS58-T9 entry (the cross-reference this batch corrected).

**Grepped, not read whole:** `data/fs61/controls.md` (2.2 KB, grepped for theorem/lemma/derive — none found beyond the
already-classified control table); `data/fs61/dead-quotients.md` (19 KB, grepped — none found beyond A.7's already-classified
negative result); `data/fs61/records/phase-E.md` (435 lines, grepped for "linear in", "shape", "isomorph", "Theorem",
"derivation" — one incidental hit, no theorem content; the actual E.5 shape-table findings live in `shapes.md` itself,
already read in full).

**Docstrings/comments only, per the brief (frozen tools; never run):** `tools/fs61_census.py`, `tools/fs61_readings.py`,
`tools/fs61_recount_landings.py`, `tools/fs61_owner_recheck.py`, `tools/fs61_owner_shape_iso.py`.

**Skipped, with reason:** `data/fs61/atlas.jsonl`, `census.jsonl`, `charmeans.jsonl`, `dead-quotients.jsonl`, `frame.jsonl`,
`landings.jsonl`, `witnesses.jsonl`, `witness-lattices.jsonl`, and all per-field `data/fs61/fields/<d>/*.jsonl` — raw JSONL
records, provenance rather than prose; every quantity they hold is already stated, with its population, in `census.md`,
`readings.md`, `shapes.md` or the plan's §R sections, which is what the derivation entries cite. Each witness directory's
`steps.jsonl` / `steps-ball<R>.jsonl` (gitignored, megabytes of lattice coordinates, explicitly provenance-only per
`data/fs61/README.md`'s own trust table). `data/fs61/pricing/` (explicitly "provenance for the plan's §2, not a result of
the milestone" per `README.md`) and `data/fs61/records/phase-0.md`, `phase-A.md`, `phase-B.md`, `phase-Bprime.md`
(read via the plan's §R-0 through §R-B′, which quote every gate item and finding from them; the raw phase records add
command transcripts, not additional theorem content, over what §R already narrates).

## Web lookups (prior-art gate)

zbMATH Open API queries, ten total (two per theorem, in two disciplines' words each), each run and recorded with its hit
count in the individual theorem entries (`plans/FS61-derivation.md`): `ab:"norm equation" & ab:"denominator" & ab:"2-adic"`
(0), `ab:"norm one" & ab:"real quadratic field" & ab:"denominator"` (0) — FS61-T2; `ab:"family of quadratic fields" &
ab:"same lattice" & ab:"solutions"` (0), `ab:"lattice" & ab:"unit vectors" & ab:"quadratic field" & ab:"colouring"` (0) —
FS61-T3; `ab:"Cayley graph" & ab:"isomorphism" & ab:"lattice" & ab:"odd girth"` (0), `ab:"unit distance graph" & ab:"quadratic
field" & ab:"isomorphic"` (0) — FS61-T4; `ab:"circle intersection" & ab:"lattice point" & ab:"average degree"` (0), `ti:"unit
disk graph" & ab:"expected degree"` (0) — FS61-T5; `ab:"unit distance graph" & ab:"quadratic field" & ab:"chromatic"` (0),
`ti:"chromatic number" & ab:"real quadratic"` (0) — FS61-T1 (also confirming FS-61's own §PA-R sweep, reproduced here, found
nothing new). Two positive-control queries confirmed the search mechanism itself works: `ti:"chromatic number" & ab:"additive"
& ab:"coloring" & py:1985-2000` returns exactly 1 (`[Fischer1994]`, as `plans/FS71-theorem-audit.md` §PA.1 documents), and
`ti:"random geometric graph"` returns 41. No new paper was found by any of the ten substantive queries; `BIBLIOGRAPHY.md`
was not touched — every citation used (`[Fischer1990]`, `[Moorhouse2010]`, `[ZanardoZannier1991]`, `[Johnson1987]`,
`[Sokolov2018]`) was already held and correctly attributed by FS-61's own opening prior-art gate (`plans/FS61-quadratic-census.md`
§PA-R), checked against `BIBLIOGRAPHY.md` here and found unchanged.

## Gates run

`python3 tools/fs71_ledger_b_check.py --strict` — RESULT: PASS for every `FS61-*` id (0 warnings; the only warnings printed
are the pre-existing, known `FS70-T*` and `M18-T1` ones the brief names); census: 236 theorems in 52 derivation files, 236
§ B rows, 0 placeholders. `python3 tools/claude_md_fact_audit.py --base 25879bd6` (the commit this batch started from) —
AUDIT PASSED (0 failures; every delta accounted for by the recorded allowances, none new). `python3 tools/claude_md_fact_audit.py
--dupes` — **caught one new duplicate on first draft** (FS61-T2's § B line verbatim-quoting row 74's own phrasing, "for
squarefree `d ≡ 7 (mod 8)` no primitive unit vector...", 57 bytes) — reworded before this report; re-run confirms **15
repeated runs, 1,009 bytes, identical to the pre-batch baseline** (measured directly by `git stash`-ing `LEDGER.md` alone
and re-running the check, rather than trusting a remembered number). `python3 tools/check_architecture.py` — RESULT: PASS
(the same pre-existing warnings seen in prior batches' runs, none touching this batch's files). `python3 tools/bib_audit.py`
— run as a sanity check though not required (no bibliography row was touched): 251 keyed rows, every arXiv id and bracketed
key resolves, 0 unresolved.

## Acceptance checklist (self-scored; the owner scores independently per §S.5)

- Every grade-tagged clause of row 74 accounted for: yes (census table above; the cert result, the dyadic law, the
  non-transfer clause, the shape non-isomorphism, the degree law, all five readings, the typed-null classification, and
  the `[ZanardoZannier1991]` pointer are each filed or classified with a reason).
- The dyadic lemma filed at its own home and `FS58-T9` pointed at it by id: yes (FS61-T2; `plans/FS58-derivation.md`'s
  FS58-T9 entry edited, re-verified by the checker afterward).
- `[ZanardoZannier1991]` filed as check owed, never as prior art confirmed: yes (FS61-T3's entry and the "Readings and
  measurements" section both state this explicitly, distinguishing what Thm 3 is known to compute — a class-group count
  of unit-vector heights — from what FS61-T3 itself proves — which vectors two fields' unit-vector sets share).
- Every file in the brief's enumeration appears in "The enumeration" above: yes.
- Every filed entry has all five checker-read fields (Proof, Proof verdict, Rests on it, Prior art, Kernel): yes,
  checker-verified (`tools/fs71_ledger_b_check.py --strict` prints no "lacks" warning on any `FS61-*` entry).
- Every *prior art* and *gap* verdict checked: there are no *prior art* or *gap* verdicts in this batch (all five entries
  are *ours*, all five *close*); the one *conjecture* (FS61-C1) is the census's own already-reported non-result, restated
  here in the audit's shape, not a new finding.
- One theorem re-derived by the owner, plus every *unsure*: none of this batch's five entries is *unsure* (see "Where the
  brief was wrong" item 3 for the judgment call behind that); the owner's independent re-derivation (§S.5 item 5) is
  scored at acceptance, outside this report.
- Gates green: see "Gates run" above.
- Commits by path, never `git add -A`, never push, never amend: one commit (`23b9b827`), touching exactly
  `plans/FS61-derivation.md` (new), `LEDGER.md` (5 new rows), `plans/FS58-derivation.md` (one cross-reference line).

## What was delegated

**Nothing.** No subagent, fork, or workflow was started at any point in this batch; every file above was read directly by
this agent, and the derivation file, the five `LEDGER.md` § B rows, the `FS58-T9` cross-reference fix, and this report
were all written directly by this agent.
