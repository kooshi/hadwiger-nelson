# FS129-SA1 — pass 3 of the cross-application audit, lane A (the arithmetic era): merges, strengthening, vacuity, and the records that disagree

*Job FS129-SA1, brief `data/fs129/briefs/FS129-SA1-pass3.md`; a `general-purpose` agent on Opus reading Ephodos's identity
(`.claude/skills/ephodos/SKILL.md` in full, then `.claude/agents/ephodos.md` from `# Ephodos in lean-dir — the workflow` to its end). Plan:
`plans/FS129-cross-application-audit.md` § 3 Stage 4. Writes only this file, `data/fs129/sa1/`, `tools/fs129_sa1_*.py` and
`data/fs129/reports/FS129-SA1.md`. Started 2026-10-03. A successor continues from the last SAVED stage.*

## Theorems this phase proved

*(filled at the last stage)*

## Stage 1 — SAVED (readback, registered expectations, the plan of stages)

### 1.1 Readback of the brief's quotations (standing rule 3)

Checked by script, `data/fs129/sa1/readback.py` (exact substring, then whitespace normalised), 2026-10-03; with `--fault` (a word appended to
every quotation) it reports 4 of 4 missing, so it reads the claim.

| quotation | source named | found |
|---|---|---|
| "Right after this close, we'll be refining the workflow again... File that as a special case stub for after the workflow refinements." | `plans/STUB-cross-application-audit.md` § The request | verbatim |
| "1. yes, we don't want O(N^2) here. 2. Yes, keep to the cap, … so it'll pick up the latest changes." | `plans/FS129-cross-application-audit.md` § 1 | verbatim |
| "Also a note for the whole plan that not only are "hubs" important, but deep "roots", … even if it has only one offshoot" | `plans/FS129-cross-application-audit.md` § 1 | verbatim |
| "**Kooshi's reading** (2026-10-03, verbatim): "Oh... oh I see. … This is another reason for workflow 3.1 and the lean backlog."" | `plans/FS129-close-inventory.md` § Items (item 32) | verbatim, whitespace normalised (the source wraps the line) |

The brief's item references check against `plans/FS129-close-inventory.md`: items 13 (three conditional seeds), 20 (X25B-PZ, X25B-LP, the 68
ids), 33–37 (the vacuity sort and its fourth heading, the borderline list), 67 (FALC-RED reordered as Falconer p. 188), 68 and 88 (the merges),
69 (ASTRA-2026-09-14-T10), 77 (the 24 "nothing" edges), 89 (FS89-CL2). **No mismatch; no finding about the brief.**

### 1.2 What I had read when I registered

The brief; the identity in full and the lane workflow; `plans/STANDING-RULES.md`; the plan; `plans/FS129-close-inventory.md` in full. **Not yet
read:** the index files, passes 1 and 2's records, any derivation file, any grokking body.

### 1.3 Registered expectations (before reading the corpus; scored at FS129-Z1)

| # | expectation | registered |
|---|---|---|
| SA1-E1 | merges in the Falconer–slack family that earn an entry (a merged statement de Bruijn formalizes in place of two or more) | 3 (NOAFF5 at every k; FALC-T with DICHO and GAP4; the G63 rider to F(t₁, …, t_n)) |
| SA1-E2 | merge lines in total (entry or line), the whole job | 10 |
| SA1-E3 | hypotheses weakened, with the weaker form derived | 2 |
| SA1-E4 | lane-A flagged results sorted **empty** (vacuous as stated) | 2 (ASTRA-T10 over residue-𝔽₁₁ fields among them, if its statement is read as a class) |
| SA1-E5 | disagreeing records found and reconciled (beyond FS89-CL2 and ASTRA-T10, which the brief names) | 2 |
| SA1-E6 | of the 68 ids in item 20, theorems the record has lost (not duplicates, not non-theorems) | 5 |
| SA1-E7 | of item 77's 24 edges, lane A's share; and of those, false | 6 lane A; half false |
| SA1-E8 | P(pass 3 finds a held result false, beyond FS89-CL2, which is already known) | 0.12 |
| SA1-E9 | P(an attack on a one-mind composition of passes 1–2 in lane A succeeds) | 0.10 |

### 1.4 The plan of stages (each saved and committed before the next)

1. This stage.
2. **(a) the Falconer-fan and slack-plane family, merged** — read the ten entries and their sources (row 66, G9, G63, M60-T2, M61-T5,
   FS86-Cx-C11); merged entries `FS129-SA1-<NAME>` in the block format, gated.
3. **(b) the records that disagree** — FS89-CL2 and what downstream inherits; ASTRA-2026-09-14-T10 (also a vacuity case).
4. **(c) X25B-PZ, X25B-LP and the 68 ids; (d) the lane-A "nothing" edges** of item 77.
5. **The vacuity sort** — lane A's flagged results (`data/fs129/index/vacuity.md`), the borderline list, and **(e)** the older record's
   hubs, roots and Lean-order entries read for vacuity; the rest listed unsorted.
6. **The Lean order, lane A's part, swept**; the FS129-L1 list; "Theorems this phase proved"; the report.
