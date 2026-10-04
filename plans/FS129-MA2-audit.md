# FS129-MA2 — pass 2 of the cross-application audit, lane A (the arithmetic era), second part: the record

*Job FS129-MA2, brief `data/fs129/briefs/FS129-MA2-pass2.md`; a `general-purpose` agent on Opus reading Ephodos's identity
(`.claude/skills/ephodos/SKILL.md` in full, then `.claude/agents/ephodos.md` from `# Ephodos in lean-dir — the workflow` to its end). Plan:
`plans/FS129-cross-application-audit.md` § 3 Stage 3. Continues FS129-MA1 (`plans/FS129-MA1-audit.md`, its § 5.4 the starting list). Writes
only this file, `data/fs129/ma2/`, `tools/fs129_ma2_*.py` and `data/fs129/reports/FS129-MA2.md`. Started 2026-10-04 00:07 UTC. A successor,
FS129-MA3, continues from the last SAVED stage (`plans/FS129-close-inventory.md` item 52).*

## Theorems this phase proved

*(filled at each stage)*

## Stage 1 — SAVED (readback, registered expectations)

### 1.1 Readback of the brief's quotations (standing rule 3)

Checked by script, `data/fs129/ma2/readback.py` (exact substring, whitespace normalised), 2026-10-04 00:09 UTC; with `--fault` (a word
appended to every quotation) it reports 5 of 5 mismatches, so it reads the claim.

| quotation | source named | found |
|---|---|---|
| "Right after this close, we'll be refining the workflow again... File that as a special case stub for after the workflow refinements." (full text) | `plans/STUB-cross-application-audit.md` § The request | verbatim |
| "1. yes, we don't want O(N^2) here. 2. Yes, keep to the cap, … so it'll pick up the latest changes." (full text) | `plans/FS129-cross-application-audit.md` § 1 | verbatim |
| "Also a note for the whole plan that not only are "hubs" important, but deep "roots", … even if it has only one offshoot" (full text) | `plans/FS129-cross-application-audit.md` § 1 | verbatim |
| "where else can we use that identity?" | `plans/FS116-close-inventory.md` item 142 | verbatim |
| MA1's method, "take a held composition, … meets the wider hypothesis." | `plans/FS129-MA1-audit.md` § 5.4 note (3) | verbatim |

The brief's item references check: FS-116 inventory items 122 (FS116-Y4 DONE), 124 (the vacuity corrections), 127 (the G83 instance), 142
(Kooshi on V6-HUG); FS-129 inventory items 52 (successive agents) and 70 (the ownership finding: G71 split, G13 two, G54's last paragraph
separate, row 66 under four grokkings). **No mismatch; no finding about the brief.**

### 1.2 What I had read when I registered

The brief; the identity in full and the lane workflow (§ Where you sit to § What leaves your lane); `plans/STANDING-RULES.md`; the plan; the
stub's § Why now, § The question and § Bearing on the answer; `data/fs129/demand-judged.md` §§ 1–2; `plans/FS129-MA1-audit.md` in full and its
report; `plans/FS129-close-inventory.md` items 50–74. **Not yet read:** any grokking body on my list, pass 1's records beyond what MA1 quotes,
the index, any derivation file.

### 1.3 Registered expectations (before reading the corpus; scored at FS129-Z1)

My prior, from MA1's scored registration: the yield in lane A came from reading held compositions at the class their arguments carry, not from
the rarely-cited grokkings, which were mostly retired finite-witness methods. My list is MA1's remainder: by mentions it starts with G1 (the 4/5
wall's mechanism), G21 (a method), G35 (the 2-adic wall), then a long tail of entries cited one to eight times. The tail's mechanisms are
mostly field-level (residue targets, towers, characters, `Θ`-certificates, the local–global theorem's pieces); they can bear unapplied inside
the arithmetic era (a field or target a milestone did not name) more readily than across eras. The regularity era reaches the arithmetic only
through the collapse field and through finite configurations seen by a measurable colouring (pass 1, MA1).

| id | expectation | value |
|---|---|---|
| MA2-E1 | mechanisms I reach in this job (of 47) | expected 28; range 15–47 |
| MA2-E2 | of those reached, mechanisms that bear somewhere unapplied (a composition, a miss, or a near miss with its failing hypothesis named, beyond pass 1's and MA1's) | expected 6; P(≥ 3) = 0.65 |
| MA2-E3 | compositions derived (block entries) | expected 3; range 0–7 |
| MA2-E4 | misses of the FS116-Y4 kind (a milestone worked a step the mechanism would have shortened or emptied) | expected 0.7; P(≥ 1) = 0.4 |
| MA2-E5 | cross-era bearings (a lane-A mechanism on a regularity-era site) beyond pass 1's and MA1's | expected 0.6; P(≥ 1) = 0.35 |
| MA2-E6 | a composition of this pass changes the bearing on the answer (item 31's open list or the top three) | P = 0.05 |
| MA2-E7 | a held result found false on reading | P = 0.03 |
| MA2-E8 | of my mechanisms, the share that are nulls because they are retired finite-witness or search methods | expected 0.3 |
| MA2-E9 | the roots' chains (G74's `Θ₄` layers, G77's torsion local–global theorem) yield a strengthening that travels the chain | P = 0.2 |

These are instruments for G21, never caps.
