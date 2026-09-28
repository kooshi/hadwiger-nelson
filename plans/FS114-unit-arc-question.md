# FS-114 — the unit-arc question: is there a valid six-map with unit arcs? Its central statement, the global step: can such a map have a vertex of four colours or a repeated colour within 3 of every point? (the plan)

*Written by the milestone planner (job FS114-P; de Bruijn, Opus 5.5), 2026-09-27, by WORKFLOW steps 3–5, from the brief
`data/fs114/briefs/P114-planner.md` and `data/fs114/briefs/STANDING-RULES.md` (both read in full, rule 0 first). The stub is
`plans/STUB-global-step.md`; its sibling stubs `plans/STUB-stuck-ray.md` (FS-115) and `plans/STUB-reg-scale.md` (FS-111). The close inventory is
`plans/FS114-close-inventory.md` (opened empty at stage 1; the owner is its only writer). The fixed claim list is `data/fs114/claims.md`; working files
are under `data/fs114/fs114-p/`; exact checks under `tools/fs114_p_*.py`. Stages are saved and committed one at a time (standing rule 2).*

## Theorems this phase proved

None. A planner states claims and derives nothing that the milestone's jobs are to derive (the brief: "Do not derive the global step yourself; the jobs
do."). Every mathematical sentence below is a quotation with its address, a reading graded as such, or a statement of what a phase is to decide.

## Would-have-searched-here log (standing rule 3)

- Stage 1: none.

## Stage 1 — SAVED: files read from disk, and the quotation check (standing rule 5)

### 1.1 Files read from disk (this order)

1. The brief and `STANDING-RULES.md`, in full (rule 0 first).
2. `CLAUDE.md` § The aim and § Counter-priors, from disk (lines 74–140); then G82 and G83 from disk. The session's loaded copy of `CLAUDE.md` matches the
   disk at a9410925 (the programme line names "FS-114, the unit-arc question"; § Paths forward row 1 and G83 read identically), so the rest of `CLAUDE.md`
   was read from that copy; the size on disk is 298,978 bytes.
3. `LEDGER.md`: the header and the claim list; rows 1–130 by their first 420 characters (the mechanism and the headline); rows 131–136 in full.
4. `plans/STUB-global-step.md` in full; `plans/STUB-stuck-ray.md` in full; `plans/STUB-reg-scale.md` in full.
5. FS-112's close: `plans/FS112-unit-arc-half.md` §R-close stage 3 (3.0–3.6) in full; `plans/FS112-derivation.md` §§1–3 in full and §4's entries by
   headline; `data/fs112/fs112-c/reconciliation.md` §§1.5–1.11 in full; `data/fs112/claims.md` §§0–1 and §§7–11 in full (§§2–6 by heading — their
   verdicts are in §11).
6. `plans/POROS-2026-09-27-night-aim.md` in full (§3's cards 1–3; §5's hunches; §6).
7. `plans/PROTOCOL-competitor-and-advisor.md` §§0–1 in full (rules 1–14, as amended at FS-112's close) and §3's tenth and eleventh runs.
8. `plans/FS112-close-inventory.md` items 1–16 and 59–80 (the header copied into `plans/FS114-close-inventory.md`).
9. `data/fs112/fs112-pa/extracts.md` on `[16.263]`–`[17.282]` (the Sirgedas, Siamese and slack-pair comments), and `BIBLIOGRAPHY.md` on `[Oostema2020]`.
10. WORKFLOW steps 3–5 and `DEBRUIJN.md`: from the session's loaded copies (both unchanged since 2026-09-23 by `git log`; checked at stage 2).

### 1.2 The quotation check

`tools/fs114_p_quotes.py` (normalises whitespace, typographic quotes, backticks, bold and italic markers; exits 1 on any MISSING). Output
`data/fs114/fs114-p/quotes.out`: **18 of 18 FOUND** — Kooshi's three quotations in the brief (`CLAUDE.md`; `plans/FS112-close-inventory.md` items 59 and
70), the stub's head question and "Choosing the form is the milestone's first decision." (`plans/STUB-global-step.md`), card 2 and its falsifier and
hunch and §6's "A local exclusion about **one** four-colour vertex would be the whole NO, with no ray step and no density" (`plans/POROS-2026-09-27-night-aim.md`),
Sirgedas's phrase (in `data/fs112/fs112-pa/extracts.md`, `[16.317]`, and with "[sic]" in the inventory's item 16), "search for a finite graph is out.",
the name ruling (item 77), and the standing rules' four quotations of Kooshi. **Control:** `--self-test` alters one word ("within 3" → "within 2") in
the stub's head question; the altered twin reads MISSING and the faithful one FOUND (`data/fs114/fs114-p/quotes-selftest.out`: PASS). Later stages add
their quotations to the same checker (`--file`), and every quotation the claim list uses is run through it before the claim list is committed.

### 1.3 Findings of the check (none changes a statement)

1. **A precision of address, not a misquotation.** The brief places "`[16.317]`, in the Google group hadwiger-nelson-problem". `[16.317]` is a **held**
   comment — de Grey, Polymath16 thread 16, 2020-10-31 (`data/fs112/fs112-pa/extracts.md` l. 565) — which *mentions* the near-proof; the near-proof itself
   is what lives in the Google group and is unheld. The debt is recorded at §PA with that address.
2. **The held context of `[16.317]` says more than the brief quotes**, verbatim: "(This would strengthen the old result of Thomassen, wich applied only to
   scaleable tilings.)" So de Grey's own reading of Sirgedas's target is "non-Siamese", against Thomassen's "scaleable" — two different hypotheses, and
   `[14.160]` / `[15.19]` record the threads disagreeing about which one Thomassen leaves. The claim list states both and keeps them apart.
3. **`[17.282]` carries a second slack statement** the stub does not quote (verbatim): "But we can also say that no two TPs that share exactly one colour
   can be less than d^2-1 apart." It is the slack twin of a one-shared-colour pair lemma, and a candidate for §IQ's structural form (stage 3).
4. **The brief's "the night advisor's §6 form" is one mind over FS112-C-ENDS** (NIGHT-A §6: "one mind, mine, over the close's links"), and C-ENDS is itself
   one mind outside a named residue (`plans/FS112-derivation.md`). The form decision (stage 5) carries that grade.

## Stage 1 — SAVED
