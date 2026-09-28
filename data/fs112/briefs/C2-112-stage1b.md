*Brief for job **FS112-C2**: FS-112's close, stage 1b — the construction side's round 3 (FS112-Y3) against its blind verifier (FS112-YB3), folded into
the close's files. Opus 5.5, 2026-09-27. Written by the product owner. FS112-C did stages 1a–4 and is replaced (≈ 799k), not resumed. **Sized for about
200k tokens by the harness's count, as guidance** (standing rule 10).*

Hello. You are de Bruijn (`DEBRUIJN.md`), in `/home/kooshi/source/lean-dir`. **Your brief is FS112-C's brief, `data/fs112/briefs/C112-close-math.md`,
plus this file**; where they differ, this file wins. `data/fs112/briefs/STANDING-RULES.md` is part of both; read rule 0 first. Read C's report
`data/fs112/reports/FS112-C.md` and its reconciliation `data/fs112/fs112-c/reconciliation.md` (§1.5 and §1.7 first) before anything else.

## What changed since C stopped

- **FS112-YB3 reported** (`plans/FS112-close-inventory.md` items 67–69; record `plans/FS112-YB3-verification.md`; report `data/fs112/reports/FS112-YB3.md`):
  eight of Y3's nine claims TRUE; **Y3-END-NEEDS FALSE as stated** — TRUE for chains of `≥ 2` vertices, refuted for a one-vertex chain by an exact valid
  fragment, BOWTIE (`tools/fs112_yb3_frags.py`). Its record and directory are now open to you.
- The owner applied C's ticks for items 1–63 and ruled on C's held items (items 65–66): **G83 is applied**; §R-close 4.8's two FS-110 corrections go to
  the front-page job; FS-115's bearing is with Kooshi.

## What to do (C's stage 1b, then the knock-on edits)

1. **Stage 1b:** Y3 against YB3 — every claim, verdict, minds and blindness, every divergence and how it settles — as a new section of the
   reconciliation. Include C's two scope points on Y3-END-NEEDS (§1.5) against what YB3 found.
2. **Fold it in:** the Y3 entries of `plans/FS112-derivation.md` (grades from the minds that derived; Y3-END-NEEDS restated with its scope and BOWTIE as
   its own entry); row 136's `FORM-1B` placeholder and the § B lines in §R-close's drafts (`data/fs112/fs112-c/ledger-b-draft.md` too); the E-scores and
   N3-P5 that waited on YB3; **FS112-C-COMPOSE item 5**, which leaned on Y3-END-NEEDS — correct it for the bowtie, and say whether any other link of the
   composition used END-NEEDS; the errata list (items 68–69).
3. **FS-115's stub** (`plans/STUB-stuck-ray.md`): its question must include the one-vertex bowtie end, and its candidate route (END-NEEDS with N3-END)
   restated with the corrected scope. Check FS-114's stub for any line that relied on END-NEEDS.
4. **Ticks** for items 64–69 in `data/fs112/fs112-c/ticks.md`. Re-run `tools/fs71_ledger_b_check.py --strict` on your § B draft.

## Rules

- **Touch only:** `data/fs112/fs112-c/`, `plans/FS112-derivation.md`, `plans/FS112-unit-arc-half.md` (§R-close only), `plans/STUB-stuck-ray.md`,
  `plans/STUB-global-step.md`, and `data/fs112/claims.md` (its appended §11). Never the front files, the inventory, the protocols or the instances file.
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the owner can
  only review work it knows about.
- **Contact:** only `"main"`. Commits by explicit path, subjects "FS112-C2: stage n"; push after each; never amend or force-push.
- **Report** (standing rule 9) to `data/fs112/reports/FS112-C2.md`, committed, and by SendMessage to `"main"`. Your final turn's text: "FS112-C2 idle;
  report sent to the owner by SendMessage".

Thank you.
