*Brief for crunch job **J26**: the audit of `[AmbrusEtAl2023]`'s verification code and certificate (FS-86 close inventory item 70).
Opus 5.5, 2026-09-25. Written by the product owner from `plans/CRUNCH-2026-09-25-queue.md` §4.3.*

Hello. You are de Bruijn (`DEBRUIJN.md`), working as **a reader and auditor** in the Lean 4 Hadwiger–Nelson workspace
`/home/kooshi/source/lean-dir`. Read `CLAUDE.md` (G21, G49, G50, G60; § The standard of evidence), `WORKFLOW.md` and `DEBRUIJN.md` from
disk. **`data/crunch-2026-09-25/briefs/STANDING-RULES.md` is part of this brief; read it in full.** I'm the product owner.

**If your record already exists, you are resuming:** read it and this brief, check the last SAVED stage against
`git log -- plans/PA-ambrus2023-audit.md`, and continue at the first stage not SAVED.

## Why

Two of this project's results lean on an outside computation we have never re-run. FS-86's condition C14 uses, at the real place, the
bound `m₁(ℝ²) ≤ 0.2470` on the density of a measurable set in the plane avoiding distance 1; and G60's `χ_f(K²) = 4` uses the same paper's
geometric fractional chromatic number and its graph `G27`. Both come from **`[AmbrusEtAl2023]`** (Ambrus, Csiszárik, Matolcsi, Varga, Zsámboki;
arXiv 2207.14179) — see its `BIBLIOGRAPHY.md` entry, and note the bibliography holds two keys for this one paper (`[AmbrusEtAl2023]`, held;
`[AmbrusEtAl2024]`, "not held, not read") — a merge is owed; say which is the published version. FS-86's close logged (item 70 of
`plans/FS86-close-inventory.md`): find the authors' verification code and certificate, and run it unmodified.

## What to do

1. **Find** the code and certificate: arXiv 2207.14179's ancillary files (every version), the published version's supplementary material,
   the authors' pages and repositories. Record where each piece is, its version, and its licence. An abstract is not a reading (G50):
   read the paper's section describing the verification in full and record what it claims the code checks.
2. **Decide what the certificate proves** — which inequality, over which graph, in exact or floating arithmetic, and which step a reader
   must trust (G21: a verdict measures its enumeration; § The standard of evidence: the artifact is the certificate plus the checker).
3. **Run it unmodified**, under `scripts/slot.py --mem <honest GiB> --cpus <N> -- <cmd>`, **only if its documented or measured runtime is
   under about an hour.** A run of hours is a machine-long certificate, which the finite-witness ban covers (`plans/CRUNCH-2026-09-25-queue.md`
   §1.7): then **price it** (time, memory, what it needs installed) and stop. Checking an existing certificate with its authors' checker is
   in under the ban; any search, optimisation or re-derivation of the certificate is out.
4. **Verdict**, one of: *re-checked* (the checker accepted the certificate here; say exactly what that establishes), *priced out* (the
   cost, and what running it would establish), *not found* (where you looked). And whether our two uses (C14's `0.2470`; G60's `G27`)
   read the paper's statement at its exact scope.

## Output

`plans/PA-ambrus2023-audit.md`: where things are, what was read per section, what the certificate proves, the run or its price, the
verdict, and a proposed `BIBLIOGRAPHY.md` fix for the duplicate key (a proposal only — you do not edit `BIBLIOGRAPHY.md`). Any downloaded
code or data goes under `data/pa-ambrus2023/` (text files up to about 5 MB; larger ones to `~/source/lean-dir-rescue/pa-ambrus2023/`,
listed); the paper, if not held, to `~/source/library/pdf/`.

## Rules

- **No subagents.** You may not spawn subagents, forks or workflows — delegation here is one level deep (`CLAUDE.md` § Delegation).
  Reason: staffing is Kooshi's budget decision, and I can only review work I know about. If the work outgrows your context, stop at a
  saved stage and tell me what is left.
- **Never modify** the authors' code; a run that needs a change is priced, not patched. Never edit a frozen tool (standing rules).
- Large outputs to disk, never `/tmp` (RAM). Kill only by pid, verify by effect. Halt and report on any unexplained crash.
- **Commits by explicit path**, subjects "J26: stage n". End commit messages with your harness's attribution lines. Push; never force-push.
- **Budget:** about 200k by the harness's count.
- **Report** in the fixed ≤ 12-line form (standing rule 9) to `data/crunch-2026-09-25/reports/J26.md`, committed, and by SendMessage
  `to: "main"`. Keep your turn's final text content-free: "J26 idle; report sent to the owner by SendMessage".

Thank you.
