# FS-71 — the theorem audit: every theorem every prior milestone proved, found and filed (stub)

*Minted 2026-09-22 by Kooshi, mid-FS-70: "next milestone will be an audit of all prior milestones to find their theorems and
document them this way." Rank 1 after FS-70's close — his sequencing.*

## Mission, in plain language

Every milestone since M17 has proved things outside the kernel — by hand, by derivation from held results, at tools grade — and
most of them survive only as a clause inside a ledger row or a paragraph in a plan. The FS-38 derivation file (theorems D2-A/B,
named) and FS-66's lemmas W, E, T and links L1–L6 are the exceptions that show the shape; FS-70 had nine such theorems before
anyone counted and now has `plans/FS70-derivation.md` and `LEDGER.md` § B. The audit walks every prior milestone's plan, record,
review and owner note, extracts every theorem, and files each under the rule WORKFLOW 2.0 step 9 now states: one entry in
`plans/<milestone>-derivation.md` (statement, grade, the proof's address, what rests on it, kernel status — kernel / stub /
declined with the reason) and one line in `LEDGER.md` § B. **The goal is understanding: the theorems are the raw material of the
grokkings, and a theorem nobody can find is not held.**

## What it produces

1. A derivation file per milestone that proved anything (M17–M64, FS-24 onward; the ones already in the FS-38/FS-66 shape are
   completed, not rewritten), with stable ids `<milestone>-Tn`.
2. `LEDGER.md` § B complete: one line per theorem, ~a hundred lines.
3. **A kernel decision per theorem**, and for every *stub* decision a stub file or a line in an existing one (FS-45–48 hold GPT
   Astra's theorems already; FS-2 wants the Kempe theory; the closure theorems of FS-70 T2/T6 are two small ones). Declined
   decisions carry their reason so the next reader does not re-price them.
4. A list of theorems that turned out to be **prior art** on re-reading (G49's mechanism runs on theorems too — several of
   M53–M56's were `[Fischer1990b]`'s), each moved to its bibliography row.
5. A list of theorems whose proof is **missing or defective** on re-reading — a theorem asserted in a record with a proof that
   does not close is recorded as a conjecture, not silently kept.

## How it runs (subplan at the opening)

One planner-free audit: one Opus implementer per batch of milestones (M17–M36, M37–M52, M53–M64, FS-24–FS-66), each briefed
with the file list, the ledger rows of its batch, and the FS-70 derivation file as the template; the owner scores by reading a
sample of five entries per batch against their sources and re-deriving one theorem per batch. No solver time; no Lean beyond
`#check` of the addresses named. Budget: four implementers at ~300k tokens; two days.

## Provisional bearings (WORKFLOW 2.0 step 2; replaced by the re-grokking at the opening)

G30 (measurement generates, derivation kills — the audit is the derivations' census), G46 (recognise the classical theory: each
theorem named in its discipline's words is a prior-art query), G49/G50 (prior art of each theorem; read what was found), G67
(the form: each entry ends with what it makes you do), G21 (a theorem proved in a record measured its own hypotheses — re-read
each against its objects). Rows that already carry named theorems: 57, 63, 66, 67, 68, 70, 72, 75.

## Bearing on χ ≥ 6

None directly. High on the programme: "the derivations are an order of magnitude more important than individual objects", and
this is the derivations' ledger.
