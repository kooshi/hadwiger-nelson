# The 2026-09-25 crunch — index and wiring audit (J30, the bookkeeper)

*Written by crunch job J30 at Kooshi's request (brief: `data/crunch-2026-09-25/briefs/J30-wiring-audit.md`). Two jobs: that nothing
from today is lost (stage 1), and that everything today produced can be found from the older things it bears on (stages 2–5).*

**This file holds results. It is fenced for every blind verifier:** a blind job does not open it. The pointer blocks this job writes
into stubs and plans carry addresses and neutral titles only.

**This file records; it does not judge.** Grades and verification statuses are copied from the records and reports that state them;
where a record and a report disagree, both are listed with addresses.

## Stage 1 — SAVED (nothing lost)

### 1.1 Git state (read 2026-09-25, about 17:00)

| item | state | owner |
|---|---|---|
| branch | `main`; before this stage's push, three commits were unpushed (J10 stage 3, J15 stage 4 and J15's report); this stage's push carries them | — |
| `data/m3/j18/completion-81-49-M40.txt`, `data/m3/j18/swaptail.txt`, `tools/crunch_j18_swaptail.py` | untracked, **in flight** | J18 (running) |
| `data/m3/j21/`, `tools/crunch_j21_dyadic_hyperbola.py`, `tools/crunch_j21_spectra.py` | untracked, **in flight** | J21 (running) |
| `ARCHITECTURE.md`, `Proofs.lean`, `Proofs/HadwigerNelson/Transcendental.lean`, `scripts/Axioms.lean`, `data/m2/j15/*` | modified or untracked at the brief's writing; **committed since by J15** (`1b5595aa`, report `6cb89847`) | J15 (done) |
| `data/fs91/j10/phase2.out`, `tools/crunch_j10_phase2.py` | untracked at the brief's writing; **committed since by J10** (`16272ed0`) | J10 (done) |

Nothing uncommitted belongs to a finished job. Nothing was committed on another job's behalf.

### 1.2 Commit hashes named in reports

Every hexadecimal token of 7–40 characters in `data/crunch-2026-09-25/reports/*.md` (15 reports, 86 distinct tokens) resolves to a
commit (`git cat-file -e <h>^{commit}`). Control: a planted fake hash `deadbeef1` is reported missing, so the check can fire.

### 1.3 Records: SAVED stages against `git log`

Every record a report names, plus the running jobs' records. "Clean" means the working copy equals `HEAD`.

| record | SAVED headings at `HEAD` | commits touching it; subjects' stages | working copy |
|---|---|---|---|
| `plans/FS91-S0F-three-colours.md` (J02) | 1–4 | 4; stages 1–4 | clean |
| `plans/FS91-S0V-band-to-nine.md` (J01) | 1, 2, the four `k` parts of 3, 3b | 7; stages 1, 2, 3, 3b | clean |
| `plans/FS91-S0V2-SWm-second-reading.md` (J03a) | 1, 2, 3, 5; stage 4 is headed "skipped" | 4; stages 1, 2, 3, 5 | clean |
| `plans/FS91-character-local-global.md` (J03, M1's plan) | 1–5 | 6; stages 1–5 | clean |
| `plans/FS91-S0FV-three-colours-blind.md` (J09) | 1–5 | 5; stages 1–5 | clean |
| `plans/FS91-S1D-character.md` (J07) | 1–5 | 6; stages 1–5 | clean |
| `plans/FS91-S1D-six.md` (J08) | 1–6 | 6; stages 1–6 | clean |
| `plans/FS91-S1V-character.md` (J10) | 1–4 | 4; stages 1–4 | clean |
| `plans/FS91-S1V-six.md` (J11) | 1–4 | 4; stages 1–4 | clean |
| `plans/M2-kernel-lane.md` (J04, M2's plan) | 1–4 | 5; stages 1–4 | clean |
| `plans/M2-S1D-bridge.md` (J17) | 1–3 | 5; stages 1–3 | clean |
| `plans/M2-S1K-chain.md` (J14) | 1–5 | 5; stages 1–5 | clean |
| `plans/M2-S2K-route-c.md` (J15) | 1–4 | 4; stages 1–4 | clean |
| `plans/M3-exotic-colourings.md` (J06, M3's plan) | 1–5 | 7; stages 1–5 | clean |
| `plans/M3-S1A-rank-one.md` (J18, running) | 1–4 | 5; stages 1–4 | clean |
| `plans/M3-S1D-windows-five.md` (J21, running) | 1–2 | 2; stages 1–2 | clean |
| `plans/M2-S3K-unit-ring.md` (J16, running) | 1 | 1; stage 1 | clean |
| J12's record (running) | not yet on disk | — | in flight |

No SAVED stage is missing from the history.

### 1.4 The scratch sweep

The session's scratch directory held 1,928 files outside `owner-*`, `locks` and this job's own `j30/`. Every one is classified in
**`data/rescued-2026-09-25/SWEEP.tsv`** (one line each: path, bytes, class, where it is now). Method: each file's git blob was matched
against `HEAD` and all history (`git hash-object`, `git rev-list --objects --all`); unmatched text was scored by the share
of its lines of 25 characters or more found verbatim in some tracked file (a *successor* at 80 % or more); papers were matched against
`~/source/library` by content hash and by text overlap with the library's extractions.

| class | files | where | note |
|---|---|---|---|
| (a) already in the repository | 362 | an identical blob at `HEAD`, in history or among a running job's untracked files, or a successor file | the matching path is in the manifest |
| (b) rescued into the repository | 598 (39 MB) | `data/rescued-2026-09-25/<same relative path>` | tools, record drafts, briefs, result tables, logs and small data from FS-73 to FS-89 and the crunch; agent-id-shaped tokens redacted on copy (none found) |
| (b) rescued to disk | 55 (1.6 GB) | `~/source/lean-dir-rescue/<same relative path>` | files over 5 MB or binary: CNFs, large JSON and JSONL runs, archives, NumPy arrays, pickles |
| (c) papers already held | 216 | `~/source/library` | 9 byte-identical PDFs; 207 text extractions of library papers (151 in `libtxt/`, the rest copies inside milestone directories — these also copied to disk) |
| (c) papers copied to the library | 7 | `~/source/library/pdf/`, `~/source/library/notes/` | see 1.5 |
| page and figure renders | 168 | `~/source/lean-dir-rescue/` | images of library papers' pages, regenerable; copied anyway |
| (d) junk by type | 281 | left | bytecode, pid and pgid files, git internals and the vendored solver sources (glucose, drat-trim) of one FS-73 verifier, three HTML error pages saved as `.pdf` |
| in flight | 4 | left | `delta.py`, `delta2.py`, `price.py`, `swaptail.py` at the scratch root: J18's (running) |
| older owner-named directories | 240 (181 MB) | **not swept** | `fs73-owner/`, `fs79-owner/`, `fs81-owner/` — held for the owner (1.7) |

Two stray files outside the scratch directory, in `/tmp/claude-1000/`: `o3-drop-imag.txt` (an FS-89 stage-0B control run whose two
siblings are committed as `data/fs89/s0b/control-k3-*.txt`) and `plant.out` (2026-09-24, a plant check printing `Theta_all`), both
rescued to `data/rescued-2026-09-25/tmp-claude-1000/`. The other session directories under `/tmp/claude-1000/-home-kooshi-source-lean-dir/`
are empty.

### 1.5 Papers copied to the library

| scratch file | library copy | `BIBLIOGRAPHY.md` entry |
|---|---|---|
| `degrey2018.pdf` (arXiv:1804.02385) | `pdf/deGrey2018-chromatic-number-plane-at-least-5.pdf` | `[deGrey2018]` exists |
| `ns.pdf` (Goel, Patil, Verma, *Nullstellensätze and Applications*, arXiv:1809.02818) | `pdf/GoelPatilVerma2022-nullstellensatze-and-applications.pdf` | **none** — proposed in stage 5 |
| `fs85-audit/cite/1808.09534.pdf` | `pdf/Hujdurovic2020-strong-cliques-vertex-transitive-graphs.pdf` | `[Hujdurovic2020]` exists |
| `fs85-audit/cite/1809.00527.pdf` | `pdf/ErskineGriggsSiran2022-clique-partitioned-graphs.pdf` | `[ErskineGriggsSiran2022]` exists |
| `fs85-audit/cite/1910.14454.pdf` | `pdf/JanssenMacKeigan2020-orthogonal-colourings-cayley-graphs.pdf` | `[JanssenMacKeigan2020]` exists |
| `fs85-audit/af2021.html`, `af2022.html` (the Polymath wiki page *Algebraic formulation of Hadwiger–Nelson problem*, 2021 and 2022 snapshots) | `notes/polymath16-algebraic-formulation-2021-snapshot.html`, `…-2022-snapshot.html` | the 2018 snapshot's entry; the two dates to be added (stage 5) |

`km.txt` is the text of Kechris–Marks, *Descriptive Graph Combinatorics* (2020 preliminary version); the library holds its PDF
(`pdf/KechrisMarks-descriptive-graph-combinatorics-2020.pdf`), and `BIBLIOGRAPHY.md` has no entry for it — proposed in stage 5.

### 1.6 Quotation check (standing rule 5)

- My brief's quotation of Kooshi ("Inject an Opus bookkeeper … easy to find from related things.") has no source on disk other than the
  brief itself; it is the owner's report of a conversation. Recorded, not checkable by me.
- The brief's correction wording, "`Hom_ℚ(F(i), ℝ) mod 1`", matches `plans/FS91-S1D-character.md` line 21 (its Q7, citing J03a's record
  §3.4, J03a-9) and `plans/FS91-S1D-six.md` line 18. Agrees.

### 1.7 Held for the owner — handled by the owner, off-repo

- `fs73-owner/`, `fs79-owner/` and `fs81-owner/` in the scratch directory are owner directories under an older naming (240 files,
  181 MB, some with agent ids); this job did not open or copy them. **Handled by the owner, off-repo:** every owner scratch directory
  (`owner-*` and the three above; 182 MB) is copied to `~/source/lean-dir-rescue/owner-scratch-2026-09-25/`, outside the repository,
  with a README saying it holds identifiers and stays out of the repository.

### 1.8 Would-have-searched-here log

Empty: nothing in this job calls for a finite-witness search.

## Stage 2 — SAVED (the index, M1)

### M1 — FS-91, character colourings and band rigidity

Plan `plans/FS91-character-local-global.md` (J03); close inventory `plans/FS91-close-inventory.md` (rows 1–94 at this stage's reading;
the clerk's last fold was J07, J08, J10's phase-1 report and J14, `bd73ff1d`). Briefs are under `data/crunch-2026-09-25/briefs/`,
reports under `data/crunch-2026-09-25/reports/`.

#### 2.1 Jobs

| job | role | brief | record | tools | data | report | commits (2026-09-25) |
|---|---|---|---|---|---|---|---|
| J01 | blind verifier, stage 0: FS-89's PA-B2 and PA-B3 | `J01-band-to-nine-verifier.md` | `plans/FS91-S0V-band-to-nine.md` | `tools/crunch_j01_sweep_check.py` | `data/fs91/j01/` | `J01.md` | 697aec81 ebaa0eb3 0edbeab3 7facf5cd 96cf9ea0 384f14f3 4894cd1f 9ebd7292 f517142b 31817d6b |
| J02 | stage 0: an advisor's three-colour sketch, derived | `J02-three-colours-stage0.md` | `plans/FS91-S0F-three-colours.md` | `tools/crunch_j02_additive_check.py`, `tools/crunch_j02_field.py` | `data/fs91/j02/` (incl. `lemma-statements.md`) | `J02.md` | 8cc081ea a8423422 e0a09454 3f147eb6 d3313cfe |
| J03 | reframe and subplan (§G, §PA, §IQ, §S, §P, §M); writes the J07–J13 briefs | `J03-M1-reframe.md` | `plans/FS91-character-local-global.md` | — | `data/fs91/j03/` (query records) | `J03.md` | 51b16ed5 3cf0c421 e23630f0 e4d5a8ed 474caf03 090f73ff dfe646ee 88f4118e 471a24c6 4c9d34ad 6610cc08 |
| J03a | blind second reading of the multi-digit sweep lemma and its all-band consequences | `J03a-SWm-blind-reading.md` | `plans/FS91-S0V2-SWm-second-reading.md` | `tools/crunch_j03a_sweep.py` | `data/fs91/j03a/` | `J03a.md` | e8a35ce6 8cd53feb 965b68e3 7f20236b 1f47d065 925ef0bc |
| J07 | derivation: the character local–global theorem | `J07-M1-character-local-global.md` | `plans/FS91-S1D-character.md` | `tools/crunch_j07_checks.py` | `data/fs91/j07/` (incl. `lemma-statements.md`) | `J07.md` | 909bce7b f31dfc43 56a78a3e 16dd80b9 2869bb92 95cd3af1 2aaa6d82 |
| J08 | derivation: character six-colourings at the exposed fields | `J08-M1-six-at-exposed-fields.md` | `plans/FS91-S1D-six.md` | `tools/crunch_j08_{sixa,kappa,threshold,crosscheck,sixf,sixf_points}.py` | `data/fs91/j08/` | `J08.md` | c999d2e1 6c8c01cf c2715066 3cb07a67 9c6eedb8 27501b4c 4592ddcc d893c2f4 |
| J09 | blind derivation beside J02 | `J09-three-colours-blind.md` | `plans/FS91-S0FV-three-colours-blind.md` | `tools/crunch_j09_lemma_k.py` | `data/fs91/j09/` | `J09.md` | 5785e634 b960146b 011e1551 7b83dbc1 b3d6bfc4 d4cc9803 c9c23750 |
| J10 (resumed as J10b) | blind verifier of J07 | `J10-M1-character-blind-verifier.md` | `plans/FS91-S1V-character.md` | `tools/crunch_j10_checks.py`, `tools/crunch_j10_phase2.py` | `data/fs91/j10/` | `J10.md` | 88b4d7c0 2b692934 e81a9d78 45177241 16272ed0 49ccbb35 3ae70beb |
| J11 | blind verifier of J08 | `J11-M1-six-blind-verifier.md` | `plans/FS91-S1V-six.md` | `tools/crunch_j11_{band,compare,targets}.py`, `tools/crunch_j11_q27.gp` | `data/fs91/j11/` | `J11.md` | 2d68d79f e449f631 c15c79b6 2fa038ef 6f812292 fc205982 |
| J12 | derivation: one prime — **running** | `J12-M1-one-prime.md` | `plans/FS91-S1D-one-prime.md` (not yet on disk) | `tools/crunch_j12_*` | `data/fs91/j12/` | — | — |
| J13 | blind verifier of J12 — **queued** | `J13-M1-one-prime-blind-verifier.md` | `plans/FS91-S1V-one-prime.md` | `tools/crunch_j13_*` | `data/fs91/j13/` | — | — |

#### 2.2 Results

Statements are shortened from the records' "Theorems this phase proved" tables (the verbatim line is at the address). "Verification"
is as the records, reports and the close inventory's owner rulings state it; "two derivations" means two agents reached it
independently, "blind-verified" that a fenced verifier derived it from the statement alone.

**J01** (`plans/FS91-S0V-band-to-nine.md`; J01 is itself the blind verifier of FS-89's PA-B2 and PA-B3)

| id | statement | grade (record) | verification | address |
|---|---|---|---|---|
| J01-1 | `(R̂_S, U_S)` is a group ℱ-flow in Berend's sense for every nonempty finite `S`; every minimal set is restricted | hand | one mind (J01) | stage 2 §2.3 |
| J01-2 | PA-B2: for `\|S\| ≥ 2` every `U_S`-minimal closed set lies in `T + A`; hence `MS_k(S)` at every `k` | hand | FS-89's claim, now blind-verified by J01; its case-1 step re-derived by a second route by J03a (J03a-4) | stage 2 §2.4 |
| J01-3 | the parity (doubling) lemma: `MS_β(S)` for every `β > 0`, `\|S\| ≥ 2`, without Berend | hand + tools exact | one reader (J03a: "outside my brief and is unverified by me"; inventory 67: a named hypothesis) | §3.6.2, stage 3 |
| J01-4 | Lemma SW as written holds exactly for `k < 2p` (sharp at `k = 10`, `p = 5`) | hand + tools exact | one mind | §3.6.1 step 2 |
| J01-5 | Lemma SW-m: the multi-digit sweep holds at every `k ≥ 3` | hand + tools exact | two blind readings (J01; J03a-1, at every `k ≥ 2`) | stage 3b |
| J01-6 | PA-B3 at `k = 6, 7, 8, 9`: `RS_k(S)` for every `\|S\| ≥ 2`, and `RQ_k` | hand + tools exact | blind-verified (J01 as FS-89's verifier); consumed as verified (inventory 18) | stage 3 |
| J01-7 | `RS_k(S)` every `k`, `\|S\| ≥ 2`; `RQ_k` every `k`; `Θ_k(R_F) ⊆ T + A` every `F ⊆ ℝ` | hand, one mind (record) | two blind readings (J01, J03a), with `A(R_F) = Hom_ℚ(F(i), ℝ) mod 1` (inventory 67) | stage 3b |
| J01-8 | VB3, VB4, D2-L1 and S0A's G1 use the band only as the same band on both sides | hand | one mind | §3.6.1 steps 3–4 |

**J02** (`plans/FS91-S0F-three-colours.md`; verbatim statements `data/fs91/j02/lemma-statements.md`)

| id | statement | grade (record) | verification | address |
|---|---|---|---|---|
| J02-L1 | torsion extraction: `Θ₃(R_F) ≠ ∅ ⟹ Θ₃(R_F) ∩ T₆ ≠ ∅`, every `F ⊆ ℝ` | hand | two derivations (J02; J09 "every statement TRUE by independent derivation") | §2.2 |
| J02-L2 | `R/pR` finite, maximal ideals stable, full residue fields at unramified stable primes | hand | two derivations (J09's J2′) | §2.3 |
| J02-L3 | Teichmüller section of `R/6R` and the joint Hilbert-90 lift | hand | two derivations (J09) | §2.4 |
| J02-L4 | norm-one functionals: three-colouring at `3^f` iff `f = 1`; none at `2^f` | hand + external (Weil) + tools exact | two derivations (J09; (b) = J09's J-L4b) | §2.5 |
| J02-T1 | torsion three-colour band characters exist iff a stable `𝔽₃` prime or a stable ramified dyadic prime | hand | two derivations (J09); reproduced as a control by J07 (J07-15) | §2.6 |
| J02-T2 | **S1**: `χ(F²) ≤ 3 ⟺ … ⟺ L(F) ≤ 3`, every real number field | hand (composition) | two derivations (J02, J09's J4-C); owner ruling inventory 68 | §2.7 |
| J02-T3 | **S2**: `χ(F²) = L(F)` whenever `L(F) ≤ 4`, every real number field | hand (composition) | two derivations (J02, J09); inventory 68 | §3.1 |
| J02-C1 | **S3**: `ℚ(α, √7)`: `Θ₃ = ∅`, `χ = L = 4` | hand + tools exact (PARI) | two derivations (J02, J09); inventory 68 | §3.2 |
| J02-C2 | additive 3-colourings iff a stable `𝔽₃` prime; additive 2-colourings iff a stable ramified dyadic prime | hand | two derivations (J09's J-L4b for the second half) | §4.1 |
| J02-A2.1′ | a second derivation of Astra Thm 2.1 ⟹ via L3 | hand | one mind | §3.1 |

**J03** (`plans/FS91-character-local-global.md`, the planner's own; "all one mind, unverified, handed to J07/J08 to re-derive")

| id | statement | grade | verification | address |
|---|---|---|---|---|
| J03-1 | the peeling lemma and its `n`-fold form | hand, one mind | re-derived by J07 (J07-2, CLG-b and CLG-b_n), which J10 verified blind (J10 §3.1 items 5–6) | §S CLG-b, §M.2 |
| J03-2 | SIX-a: the trace set of `λ_a` on `μ_{q+1}` is `V_{N(a)}` | hand, one mind | re-derived by J08 (J08-1), blind-verified by J11 (J11-T1) | §PA.1, §S |
| J03-3 | at `q = 23` no band six- or seven-character; band eight exactly at `c ∈ {11, 20, 21}` | hand, one mind | re-derived by J08 (J08-2, tools) and J11 (J11-T4) | §P.basis (fenced) |
| J03-4 | archimedean places have local `κ = 0`; density of a finite-index subgroup | hand, one mind | its complex-place half re-derived by J07 (J07-6) and J10 (J10-L4) | §M.1, §M.2 |

**J03a** (`plans/FS91-S0V2-SWm-second-reading.md`; the second blind reading of J01-5 and J01-7)

| id | statement | grade (record) | verification | address |
|---|---|---|---|---|
| J03a-1 | Lemma SW-m at every `k ≥ 2` | hand + tools exact | two blind readings (with J01-5) | §2.1 |
| J03a-2 | VB1 at every `k ≥ 2`, `\|S\| ≥ 2`; its only `k`-reading line is the call to SW-m | hand + tools exact | agrees with J01's §3.6.1 (divergence table §5) | §3.1 |
| J03a-3 | `RS_k(S)` and `MS_k(S)` for every `k ≥ 2`, `\|S\| ≥ 2` | hand, given PA-B2 | two blind readings (with J01-7) | §3.2 |
| J03a-4 | PA-B2's case-1 step by a joining and Furstenberg disjointness | hand, given Furstenberg | one mind; "hypotheses checked at sketch level" (report) | §3.2 |
| J03a-5 | `Θ_2(R) ⊆ T_2` for every `R = ℤ[U]` | hand | one mind | §3.2 |
| J03a-6 | VB3 at every band; the order transfer; `Θ_k(Q) ∩ T` finite | hand | one mind | §3.3 |
| J03a-7 | `RQ_k` for every `k ≥ 2` | hand | two blind readings (with J01-7) | §3.3 |
| J03a-8 | `Θ_k(R_F) ⊆ T_{N_k}(R_F) + A(R_F)`, `A(R_F) = Hom_ℚ(F(i), ℝ) mod 1`, every `F ⊆ ℝ` | hand | two blind readings (with J01-7); owner ruling inventory 67 | §3.4 |
| J03a-9 | with `A` read as one embedding, the field clause is false (ℚ(√3), `k = 4`) | hand | one mind; its consequence for FS89-CL2's wording agreed by J07 (J07-14) and J10 (§3.1 item 25) | §3.4 |

**J07** (`plans/FS91-S1D-character.md`; blind-verified by J10, phase 2: 24 of J07's 25 lemma statements TRUE, a GAP in item 19's
(g3) — J10 record §3.1, §4)

| id | statement | grade (record) | verification | address |
|---|---|---|---|---|
| J07-1 | CLG-a: pullbacks of band characters of any target lie in `Θ_β(R_F)` | hand | blind-verified (J10 item 4) | §2.1 |
| J07-2 | CLG-b and CLG-b_n (peeling, every band) | hand + tools exact | blind-verified (J10 items 5–6) | §2.2 |
| J07-3 | Lemma C: `R ⊗ ℤ_p = R̄_p × V_n`, `R/NR ≅ ∏ R̄_p/NR̄_p`; no Galois hypothesis | hand, one mind (record) | blind-verified (J10 item 7, J10-T6, independent route) | §2.3 |
| J07-4 | Lemma C′: `R̄_p = ∏ Ô_𝔓` except possibly at a ramified stable dyadic place | hand, one mind (record) | blind-verified (J10 item 8, J10-T6); also J09's J2 (independence caveat: J07's held item 1) | §2.4 |
| J07-5 | CLG-c, corrected: the joint image of `U` in `R/NR` × the archimedean tori | hand | blind-verified (J10 item 10) | §2.5 |
| J07-6 | CLG-d: archimedean part vanishes at complex places, an interval at real ones; torsion part band with margin | hand | blind-verified (J10 item 11, J10-L4) | §2.6 |
| J07-7 | CLG_k for every real number field and every `k ≥ 2`, given `H_k`; `χ_char(F²) = min χ_char(T_{𝔓,m})`; the `κ` form | hand | blind-verified (J10-T1, T2; items 13–14), with J10's scope note on the "Hence" clause | §2.7, §3.1 |
| J07-8 | Lemma LB and LB′ (level bound at odd stable places; sharp for level 2) | hand + tools exact | blind-verified (J10 items 15–16, J10-T7) | §3.2, §4.2 |
| J07-9 | CLG-e at odd `p` for `k ≤ 2p`, at inert dyadic places for `k = 3`; `U_Q` has no band character | hand + tools exact | blind-verified (J10 item 17) | §3.2, §4.2 |
| J07-10 | Lemma AV: a band-`β` character forces `α ≥ β\|G\|` | hand | blind-verified (J10 item 12) | §3.3 |
| J07-11 | CLG-g with (E1), (E2) explicit; no exception at `k ≤ 5`, none in degree ≤ 2, only `Q = 64` at `k = 6` | hand (tools-grade inputs) | blind-verified (J10 item 18, with J10-L8 closing (E2)'s input scope); **GAP** in corollary (g3) at `k = 7` (J10-T8, item 19) | §3.3, §4.2 |
| J07-12 | HD1 at ℚ(√59), ℚ(√83), ℚ(√131) re-proved through CLG | hand (given FS86-B1-LD) | two derivations (J07, J10-T4) | §4.4 |
| J07-13 | C-47 and C-167 re-proved through CLG; C-167 with no certificate | hand + tools exact | two derivations (J07, J10-T5; J10 items 22–23) | §4.4 |
| J07-14 | FS89-CL3, CL4, CL5 TRUE under the corrected `A`; the one-embedding reading enters only CL2's wording | hand | two derivations (J07; J10 phase 1 and item 25; inventory 92) | §4.4 |
| J07-15 | controls reproduced (`θ₂`, `[Fischer1994]` at one dyadic place, C9 at `Γ₇`, J02-T1, `κ` monotone) | hand + tools (existing checker) | blind-verified (J10 item 24) | §4.3 |

**J08** (`plans/FS91-S1D-six.md`; blind-verified by J11 on W1–W4, 146 values compared, 0 divergences — J11 stage 4)

| id | statement | grade (record) | verification | address |
|---|---|---|---|---|
| J08-1 | SIX-a: every band `k`-character of `Γ_q` is `λ_a`, value set `V_{N(a)}`; only non-square `c` can be band | hand; law checked at every `a`, `q ≤ 67` | blind-verified (J11-T1, T2) | stage 2 |
| J08-2 | `χ_char(Γ₂₃) = 8`, `κ = 3/23`; band 8 exactly at `c ∈ {11, 20, 21}`; no band 6 or 7 | tools exact (two halves) | blind-verified (J11-T4) | stage 3 |
| J08-3 | `χ_char(Γ₄₃) = 9`, `κ = 5/43`; band 9 exactly at `c = 33`; no band 6, 7, 8 | tools exact (two halves) | blind-verified (J11-T4) | stage 3 |
| J08-4 | band `k` on `Γ_q` ⟹ `q < 4(k−1)²`; `χ_char(Γ_q) > 1 + √q/2` | hand, given Weil | blind-verified (J11-T3; J11's constants `Q₆ = 97`, `Q₇ = 141` against J08's 100, 144 — "same lists") | stage 4 |
| J08-5 | band 6 and 7 characters exist exactly at `q ∈ {3, 7, 11, 19}`; `χ_char ≥ 8` from 23 | hand + tools exact | blind-verified (J11-T5) | stage 4 |
| J08-6 | level collapse at an odd stable place with `p > k/2` | hand, one mind (record) | blind-verified (J11-T7; J11 says J08's Cayley step fills an implicit step of its own); also J10-L6 | stage 5 |
| J08-7 | pullback (CLG-a) | hand | blind-verified (J11-T8); also J07-1 | stage 5 |
| J08-8 | `χ_char` = 8, 17, 22 at ℚ(√167), `K(√7)`, de Grey's field given CLG_7, CLG_16, CLG_21; `Θ₈, Θ₁₇, Θ₂₂ ≠ ∅` unconditionally | hand + tools exact; lower halves given CLG | blind-verified (J11-T10, T11 after its stage-3 gap closed); **correction owed** on its upper bound for `χ` (below) | stage 5 |
| J08-9 | `Θ₆(Q)` reduces to a sumset over places `{2, 3, 7, 11, 19}` | hand | one mind (outside J11's W1–W4; J08's held item) | stage 6 |
| J08-10 | the complete band-1/6 list for `Q`: 18 types, 173 torsion characters, `Θ₆(Q) ⊆ T_{105336} + A` | hand + tools exact | one mind + tools (not in J11's list) | stage 6 |
| J08-11 | the band-1/5 list for `Q`: 10 types, 77 characters, `N₅ = 35,112` | hand + tools exact | one mind + tools (not in J11's list) | stage 6 |
| J08-R | `χ_char(Γ₂₇) = ∞` (no band character at any `k`) | hand + cert (row 70) | two routes (J11-T6, exact count, no certificate) | stage 4 remark |

**J09** (`plans/FS91-S0FV-three-colours-blind.md`)

| id | statement | grade (record) | verification | address |
|---|---|---|---|---|
| J1 | typing on `τ₂`, `τ₃`: `τ₃(u) = 0 ⟺ τ₂(u) = 1/2`; `α = τ₂ = 0` on O-type layers | derived from FS81-T3, T4 | one mind | §2.1 |
| J2 | `ℤ[U_F]_(p) = O′_(p)` for every `p` with no ramified stable prime above it; no Galois hypothesis | hand, one mind | also J07-4 and J10-T6 (independent routes); owner ruling (inventory 68): one mind until a second reading | §2.2 |
| J3 | independence of finitely many stable places for `U_F` | hand, standard | one mind (cf. J10-L2) | §2.3 |
| J-K | Lemma K1 FALSE at `q = 27` exactly for `N(a) = 1`; true at 243; false at 3 for `N(a) = −1` | tools exact; two representations | one mind, two representations | §2.4 |
| J4 | no mixing: `Θ₃(R_F)` is exactly the `4N₃` additive characters (no ramified stable dyadic prime) | hand, one mind; Weil external | one mind (inventory 68) | §2.5 |
| J4-C | S1 for every real number field | hand, one mind | two derivations (with J02-T2) | §2.6 |
| J4-A | S1 for every algebraic subfield of ℝ and every purely transcendental extension of one | hand, one mind | one mind; report: GAP for general transcendental `F` at two named steps | §2.6 |
| J2′ | `ℤ[U_F]/p ≅ Ā_p/pĀ_p`; dimension bound; maximal ideals `R ∩ 𝔓` | hand, one mind | two derivations (= J02-L2 (a), (b)) | §4.2 |
| J-L4b | no additive `λ : 𝔽_{Q²} → (1/2)ℤ/ℤ` is `1/2` on all of `μ_{Q+1}`, `Q = 2^f` | hand, elementary | two derivations (= J02-L4 (b)) | §4.2 |
| J4-T6 | FS81-T6's open item settled: the additive 3-colourings of `ℚ(√d)`, `d ≡ 3, 7 (mod 12)`, are Fischer's up to symmetry | hand, one mind | one mind | §2.5 |

**J10** (`plans/FS91-S1V-character.md`; J10 is the blind verifier; its own lemmas are one mind unless another job reached them)

| id | statement | grade (record) | verification | address |
|---|---|---|---|---|
| J10-L1 | `R_F` = ℤ-span of `U_F`; `ℚR_F = L`; `R_F ⊆ O′`; `O_L[U_F] = O′`; `cO′ ⊆ R_F` | hand | one mind (blind) | §2.2 |
| J10-L2 | `U_F` dense in `∏_{v∈Σ} T(F_v)`, archimedean included; onto every finite product of targets | hand | one mind (cf. J09's J3, J07-5) | §2.2 |
| J10-L3 | a torsion character of order dividing `N` factors through `∏_{𝔓 \| cN} O_𝔓/𝔓^M` | hand | one mind | §2.2 |
| J10-L4 | value set contains `Σ V_𝔓 + V_∞`; archimedean part vanishes at complex places; torsion part band | hand | two derivations (with J07-6) | §2.2 |
| J10-L5 | a Minkowski sum of symmetric sets each meeting `{‖x‖ < β}` meets it | hand | one mind (J07's peeling is its contrapositive, J10 item 6) | §2.2 |
| J10-L6 | level collapse at inert stable places with `p > k/2`; the exception at `p ≤ k/2` is non-vacuous | hand + tools exact | two derivations (with J08-6, J11-T7) | §2.2 |
| J10-L7 | a band 4-character of a Cayley graph with `α ≤ \|G\|/4` takes the value `±1/4` | hand | one mind | §2.2 |
| J10-T1 | V1 (CLG_k): ⟸ unconditional, ⟹ given `H_k` | hand, blind | two derivations (with J07-7) | §2.3 |
| J10-T2 | V2 (the `κ` form) given `H_κ` | hand, blind | two derivations (with J07-7) | §2.3 |
| J10-T3 | V3 (CLG-g) given `H_k` | hand, blind | two derivations (with J07-11) | §2.3 |
| J10-T4 | HD1 at ℚ(√59), ℚ(√83), ℚ(√131) from `H₄` + S0A-8 + Lemma D | hand, blind; one mind | two derivations (with J07-12) | §2.3 V4 |
| J10-T5 | C-47 and C-167 from V1 + L6 (+ S0A-8, S0A-9) | hand; compositions | two derivations (with J07-13) | §2.3 V4 |
| J10-L8 | in every inert residue tower `λ_min` scales exactly by `Q^{j−1}`; every Hoffman floor survives every level | hand + tools exact at four towers | one mind | §3.2, §3.4 |
| J10-T6 | Lemma C and C′ re-derived blind; `R_F = O′` with no Galois hypothesis when no ramified stable dyadic place; the exception occurs at ℚ(√5), ℚ(√17), ℚ(α), not at ℚ(√2) | hand; tools | two derivations (with J07-3, J07-4, J09's J2) | §3.2, §3.4 |
| J10-T7 | LB, LB′, CLG-e re-derived; LB′ sharp at (`e = 1`, level 2) and (`e = 2`, level 3) | hand + tools exact | two derivations (with J07-8, J07-9) | §3.2, §3.4 |
| J10-T8 | (g3) at `k = 7`: exact level `2e(𝔭\|3) + 1` open at every `e` — a GAP in J07's (g3) | hand; arithmetic tool | one mind | §3.1 item 19 |
| J10-T9 | level one: no band-4 character of `Γ_q` for prime `q ≡ 3 (4)`, `11 ≤ q ≤ 59`; none of band 5 at 11, 23, 43, 59, one at 19; `λ_min(U₆₄, U₁₂₈, U₂₅₆) = −15, −19, −31` | tools exact | one mind (band-5 at 23 and 43 agrees with J08-2, J08-3) | tool (F), `data/fs91/j10/phase2.out` |

**J11** (`plans/FS91-S1V-six.md`; the blind verifier of J08)

| id | statement | grade (record) | verification | address |
|---|---|---|---|---|
| J11-T1 | W1: every band `k`-character of `Γ_q` is `λ_a` with value set `V_{N(a)}/q` | hand + tools exact (every prime `q ≤ 139`) | two derivations (with J08-1) | stage 2 §W1 |
| J11-T2 | every band character has `N(a)` a non-square; `χ_char(Γ_q) = ⌈q / max_c d(c)⌉` | hand | one mind | §W1 |
| J11-T3 | band `k` at `Γ_q` ⟹ `(q + 1)² ≤ 4(k − 1)²q`; `Q₆ = 97`, `Q₇ = 141` | hand, given Weil | two derivations (with J08-4) | §W3 |
| J11-T4 | W2's lists at 23 and 43; `χ_char(Γ₂₃) = 8`, `χ_char(Γ₄₃) = 9` | tools exact + hand | two derivations (with J08-2, J08-3; 146 values, 0 divergences) | `data/fs91/j11/band-lists.json` |
| J11-T5 | band 6 and 7 characters of prime `Γ_q` only at `q ∈ {3, 7, 11, 19}`; `χ_char` table to 199 | tools exact, given T3 | two derivations (with J08-5) | same |
| J11-T6 | `Γ₂₇` has no band character at any `k` | tools exact (PARI) | two routes (with J08-R) | `data/fs91/j11/q27.out` |
| J11-T7 | level collapse at stable inert places with `p > k/2` | hand | two derivations (with J08-6, J10-L6) | §W4 |
| J11-T8 | pullback: `χ_char(F²) ≤ min` over targets, unconditionally | hand | two derivations (with J08-7, J07-1) | §W4 |
| J11-T9 | the stable places of ℚ(√167), `K(√7)`, `K(√5,√7)`; none dyadic | tools exact + PARI to 300 | one mind | `data/fs91/j11/targets.json` |
| J11-T10 | given CLG_7, `χ_char(ℚ(√167)²) = 8`; unconditionally `6 ≤ χ_char ≤ 8` | hand + tools, given row 96 | two derivations (with J08-8) | §W4 |
| J11-T11 | given CLG_16, CLG_21 (corrected in stage 3): `χ_char(K(√7)²) = 17`, `χ_char(K(√5,√7)²) = 22`; `≤` unconditional | hand + tools | two derivations (with J08-8) | §W4, stage 3 |
| J11-T12 | `Θ_k(R_F) ⊆ Θ_{k+1}(R_F)`; `χ_char(F²) = m` from the pullback and CLG_{m−1} alone | hand | one mind (stated only in stage 3's table, not in the main table) | stage 3 |
| (report) | `χ_char(Γ₁₁) = 6 > χ(Γ₁₁) = 5`: at 11 no optimal colouring is a character colouring | tools exact | one mind; in the report and stage 2 §W3, not in a theorems table | stage 2 §W3 |

**J12, J13:** running and queued; nothing to index yet.

#### 2.3 Where a record and a report differ on grade or status (listed, not resolved)

| result | the record says | the report or another record says |
|---|---|---|
| J01-7 | "hand, one mind" (`plans/FS91-S0V-band-to-nine.md`, theorems table) | two blind readings (J03a report; inventory 67, owner ruling) — the record predates J03a |
| J02-T2, J02-T3, J02-C1 | "hand (composition)" (`plans/FS91-S0F-three-colours.md`); J02's report: "one mind until J09 lands" | J09's report: "S1–S3 now two independent derivations" (inventory 68) |
| J07-3, J07-4 | "hand, one mind" (`plans/FS91-S1D-character.md`) | J10 report and J10-T6: re-derived blind by independent routes |
| J07-11 | "hand (tools-grade inputs)"; J07's report: "CLG-g TRUE with the exception explicit" | J10-T8 and J10's report: GAP at (g3)'s "`e(𝔭\|3) = 1`, exact level 3" |
| J08-6 | "hand, one mind" | J11-T7 and J10-L6 reach it independently |
| J08-8 | "hand + tools exact; lower halves given CLG (J07, unverified)"; its line "`4 ≤ χ(ℚ(√167)²) ≤ 8`" | J11's report: the upper bound should read ≤ 7 (row 33) |
| J08-4 | the Weil threshold's constants 100, 144 | J11-T3: 97, 141 — J11 calls the resulting lists the same |
| J09's J2 | "hand, one mind" | J07-4 and J10-T6 reach the same localisation independently; the owner's ruling (inventory 68) still reads one mind |

#### 2.4 Corrections owed and held items, M1

| # | kind | item (short) | address | in `plans/FS91-close-inventory.md`? |
|---|---|---|---|---|
| 1 | correction | LEDGER row 95's "Not claimed: bands narrower than 1/5 …" and the FS-91 row, answered on characters | `plans/FS91-S0V-band-to-nine.md` stage 3b | yes, row 3 |
| 2 | correction | G55, G74, G48 and the Frontier's "L ≤ 4 for real quadratic fields or with √3" → every real number field; FS-82 needs a CLOSED banner; the sketch's `\|α\| ≤ 1/12` at band 1/3 → `α = 0` | `plans/FS91-S0F-three-colours.md` §4.5, §1.1 Q4 | yes, row 8 |
| 3 | correction | FS89-derivation "Notation": `A(R_F) = Hom_ℚ(F(i), ℝ) mod 1`; FS89-CL2 false as written | `plans/FS91-S0V2-SWm-second-reading.md` §3.4, §3.7 | yes, rows 61, 69 |
| 4 | correction | FS86-B1-LR's scope may drop "L/ℚ Galois"; FS89-CL2 and row 95 to say "archimedean at every place of F(i)" | `plans/FS91-S1D-character.md` "Proposed edits" | yes, row 78 |
| 5 | correction | the brief's control "a class at k = 8 at both" fails at 43: row 69's ceilings are line colourings, not characters; Frontier/G56/G59/G64 lines, FS-59/FS-64 re-aims | `plans/FS91-S1D-six.md` stage 3 item 4, "Proposed edits" | yes, row 83 |
| 6 | correction | a ramified stable dyadic prime restricts to a ramified one (J02 §2.10's "ramified or inert"); FS81-T6's open item settled; FS-82's "dyadic targets have χ ≥ 4" wrong | `plans/FS91-S0FV-three-colours-blind.md` §5 item 1, §2.5, §3.3 | partly, row 15 (J02 §2.10's wording not named) |
| 7 | correction | CLG-f's HD1 follows from CLG_k's proof with Lemma D, not its statement; CLG_k's "Hence" needs `H` at `χ_char(F²)` | `plans/FS91-S1V-character.md` §2.3, §4 row 6 | yes, row 89 |
| 8 | correction | J07's (g3): "`e(𝔭\|3) = 1`, exact level 3" should read "exact level `2e(𝔭\|3) + 1`" unless a further lemma kills `e ≥ 2` | `plans/FS91-S1V-character.md` §3.1 item 19, §4 row 10 | **no** — added in stage 4 |
| 9 | correction | J08-8's "`4 ≤ χ(ℚ(√167)²) ≤ 8`" should read ≤ 7 (row 33) | J11 report; `plans/FS91-S1D-six.md` stage 5 | **no** — added in stage 4 |
| 10 | correction | the planner's SIX-e ("given CLG_6 and CLG_7") under-names the hypothesis at `K(√7)` and de Grey's field: CLG_16, CLG_21 | J11 report; `plans/FS91-character-local-global.md` §S | **no** — added in stage 4 |
| 11 | held | the all-`k` extension J01-7 had one reader; `k ≤ 9` does not rest on it | J01 report | yes, rows 18, 67 (resolved by J03a) |
| 12 | held | J02's S1–S3 one mind until J09; J02's C0 was written after the route formed (low calibration value) | J02 report; `plans/FS91-S0F-three-colours.md` §1.2 | yes, rows 21, 68 (the C0 remark not carried) |
| 13 | held | J03: (1) J03a's id; (2) J08 may run beside J07; (3) J10's blind phase may start early; (4) LEDGER § B not read line by line | J03 report | (4) yes, row 28; (1)–(3) operational, acted on, not carried |
| 14 | held | row 95 and Frontier item 25 not widened to every `k` until "archimedean" over `R_F` is fixed; J01's parity route R2 unverified | J03a report | yes, rows 67, 70 |
| 15 | held | J07 read the heading (not the proof) of J09's J2 after deriving Lemma C′; C′'s independence rests on that note; J07 did not compute `χ_char(Γ₂₃)`, `χ_char(Γ₄₃)` | J07 report; `plans/FS91-S1D-character.md` Q8 | **no** — added in stage 4 |
| 16 | held | the plan's theorems-table row J03-3 repeats the fenced §P.basis answer; J08-6 and J08-9 are one mind (J08-9 replaced a wrong first idea, caught by the tool) | J08 report | first half yes, rows 84, 93; the one-mind half **no** — added in stage 4 |
| 17 | held | J09's J2 and J4 are one mind — a second reading before a ledger row rests on them alone | J09 report | yes, row 68 |
| 18 | held | J10, J11: none | reports | — |

The J10 final report (`3ae70beb`: J10-L8, J10-T6, the (g3) correction, the level-one table) and the J11 report (`fc205982`) were not
yet folded into the inventory at this stage's reading; stage 4 appends their lines.

## Stage 3 — SAVED (the index, M2, M3 and FS-89's close)

### M2 — the kernel lane

Plan `plans/M2-kernel-lane.md` (J04); close inventory `plans/M2-close-inventory.md` (rows 1–28 at this stage's reading; J15's report not
yet folded).

#### 3.1 Jobs

| job | role | brief | record | tools | data | report | commits (2026-09-25) |
|---|---|---|---|---|---|---|---|
| J04 | reframe (kernel; §IQ for FS-39's hand step); writes the J14–J17 briefs | `J04-M2-kernel-reframe.md` | `plans/M2-kernel-lane.md` | — | `data/m2/j04/` (scratch skeletons `K1Chain.lean`, `K2Transcendental.lean`, `K3PrimeInversion.lean`, `K3Stripe.lean`) | `J04.md` | 54043f0a 00cf5ebc 17dcef05 39442fd0 78e9bcae 278c9969 eb03ed3c |
| J14 | kernel: FS-45's chain theorem and its instances | `J14-M2-chain-kernel.md` | `plans/M2-S1K-chain.md` | — | `data/m2/j14/` | `J14.md` | e34fe2de e9d3551f 96e9fb22 1abef1f7 35c84d85 |
| J15 | kernel: FS-39 route C (transcendence is free) | `J15-M2-route-c-kernel.md` | `plans/M2-S2K-route-c.md` | `tools/j15_plants.py` (outside the `crunch_<job>_` naming) | `data/m2/j15/` (route pricing scratch, gate logs) | `J15.md` | 581d6335 c03b1df1 894ceeca 1b5595aa 6cb89847 |
| J16 | kernel: FS-47 prime inversion (valuation form), then the stripe lemma — **running** | `J16-M2-prime-inversion-kernel.md` | `plans/M2-S3K-unit-ring.md` | — | `data/m2/j16/` | — | 227087e0 (stage 1); `Proofs/HadwigerNelson/UnitRing.lean`, `Instances/SevenUnitRing.lean` and its `scripts/Axioms.lean` lines are uncommitted, in flight |
| J17 | derivation: FS-39's hand step (the bridge) | `J17-M2-bridge-derivation.md` | `plans/M2-S1D-bridge.md` | — | `data/m2/j17/` (26 files: excerpts, zbMATH records) | `J17.md` | ee04599d 9d223e2d c2b87aed 914a81aa 1517fb75 2c79436b |
| J17V | blind verifier of J17 — **declined** by the owner (inventory 16) | `J17V-M2-bridge-blind.md` | `plans/M2-S1V-bridge.md` (never created) | — | — | — | — |
| J17K | kernel: the bridge's B0 and B1 — **queued** | `J17K-M2-bridge-kernel.md` | `plans/M2-S4K-bridge…` (per the queue; not yet created) | — | — | — | — |

#### 3.2 Results

Kernel results were checked by the gate each job ran (J14: build green, axioms 1045 clean / 5 purchases, vacuity and architecture pass,
`35c84d85`; J15: axioms 1056 clean / 5 purchases, `1b5595aa`). J04's are kernel-elaborated in scratch modules only.

| id or declaration | statement | grade | verification | address |
|---|---|---|---|---|
| J04: `junction_succ`, `junction_last`, `chainDrawing_b`, `copyHom` | chain copies share their junctions; each copy is a hom into the induced unit-distance graph | kernel (scratch) | superseded by J14's library forms | `data/m2/j04/K1Chain.lean` |
| J04: `planeOverIso`, `unitQuadrance_colorable_of_subring` | the plane over `L ⊆ ℝ` is `unitQuadrance L`; colourability pulls back through a subring holding every unit vector | kernel (scratch) | moved into the library by J15 | `data/m2/j04/K2Transcendental.lean` |
| J04: `normOne_subset_iff_stable`, `inv_mem_iff_forall_valuationSubring` | a valuation subring holds every norm-one element iff σ-stable; invertibility via every valuation subring above | kernel (scratch) | J16 is moving them in (in flight; its `scripts/Axioms.lean` lines are uncommitted) | `data/m2/j04/K3PrimeInversion.lean` |
| J04: `wheel_all` | under properness and NT₀ at its centre, every wheel of the triangular lattice is type O or P | kernel (scratch; a complete enumeration of a derivation-fixed set) | one run; J16's second half | `data/m2/j04/K3Stripe.lean` |
| J04: route C's integrality | a unit vector lies in every valuation subring whose residue ring has no √−1 | hand | ported to the kernel by J15 (`mem_valuationSubring_of_sq_add_sq_eq_one`) | `plans/M2-kernel-lane.md` §4.4 |
| J14: `not_colorable_chain` and the three `add_one_le_chromaticNumber_*_of_chain` forms | the chain theorem: a forcer at `k` colours chained along unit vectors summing to `1/δ` refuses `k` colours | kernel | gate green; the owner read the statement against G55 (M2 inventory 27) | `Proofs/HadwigerNelson/Chain.lean` |
| J14: `spindle_of_chain` | `χ(ℝ²) ≥ 4`, the Moser spindle as the chain's `m = 2` case | kernel | gate green | same |
| J14: `four_le_chromaticNumber_planeOver_two_three` | `χ(ℚ(√2,√3)²) ≥ 4` by six chained rhombi | kernel | gate green | `Proofs/HadwigerNelson/Instances/SqrtTwoThree.lean` |
| J14: `eighteen_not_colorable_three`, `eighteen_colorable_four` | the 18-vertex, 33-edge graph refuses three colours and takes four | kernel | gate green (two oracles in the brief's sense: gadget algebra and a colouring) | same |
| J14: `sum_eightUnits`, `five_le_chromaticNumber_planeOver_seven_of_G4` | `w³ + w̄³ − 3w² − 3w̄² = 3/8`; `G4 → χ(ℚ(√3,√7,√11)²) ≥ 5` | kernel; the second conditional on G4 (a measurement) | gate green; not marked `VACUITY DECLARED` (inventory 25) | `Proofs/HadwigerNelson/Instances/SevenConditional.lean` |
| J15: `chromaticNumber_unitQuadrance_ratFunc` (and `…_of_one_add_sq_ne_zero`, `…_rat`) | `χ(F(t)²) = χ(F²)` for every formally real `F` (every `F` with `−1` not a square) | kernel | gate green; `[Fischer1990]` Thm 6 at `d = 2` — not new mathematics (J15 report) | `Proofs/HadwigerNelson/Transcendental.lean` |
| J15: `chromaticNumber_planeOver_adjoin_transcendental_eq` | for `F : Subfield ℝ` and `t` transcendental over `F`, `χ(F(t)²) = χ(F²)` | kernel | gate green; inhabited by Liouville's constant | same |
| J15: `unitQuadrance_colorable_of_valuationSubring`, `mem_valuationSubring_of_sq_add_sq_eq_one`, `evalZero_eq_zero_of_mem_maximalIdeal` | the valuation lemma; the residue hom at `t = 0` kills the maximal ideal | kernel | gate green | same |
| J17-T1 | C1: every finite unit-distance drawing in `ℝ²` descends to a real number field | hand (Tarski, or Artin–Lang) | one mind; J17V declined; kernel candidate for J17K | `plans/M2-S1D-bridge.md` §2.1 |
| J17-T2 | the real algebraic numbers form a real closed field | hand, classical | one mind; kernel candidate (J17K's B0) | §2.0 |
| J17-T3 | C2: `χ(ℝ²) = max` over real number fields of `χ(F²)` (attained) | hand; `[Madore2015]` ¶5.4's | one mind; J17K's B1 as a conditional theorem | §2.2 |
| J17-T4 | Lemma NP: no nonconstant `a ∈ ℂ(t)` has `a³ − a` a square | hand (Mason–Stothers) | one mind; J17K may kernel-check it by `Polynomial.abc` | §2.3 |
| J17-T5, T6, T7 | C3: `ℚ(π, √(π³ − π))` is not purely transcendental over any number field, nor embeds in one; a pointless-conic field besides | hand | one mind | §2.3 |
| J17-T8 | C3′: `χ(ℚ(π, √(π³ − π))²) = 2` | hand | one mind | §2.3 |
| J17-T9 | C4: `χ(ℝ²) ≠ 6` iff every real number field with `χ = 6` has a finite real extension with `χ = 7` | derived | one mind | §2.4 |
| J17-T10 | the equational existential fragment of Tarski and Artin–Lang are interderivable | hand, classical | one mind | §2.1 |

**J16** is running: nothing indexed until its record's stages are saved.

#### 3.3 The new Lean declarations (committed at `HEAD`) and the axiom audit

Every declaration in the four library files M2 added, with its line at `HEAD` and whether `scripts/Axioms.lean` (at `HEAD`) prints its
axioms. The audit covers each file's headline theorems (22 lines); helper lemmas and definitions are not printed, which is the audit's
practice ("one `#print axioms` line per public theorem on the milestone's surface"). **Theorems a record names in its theorems table that
the audit does not print:** `rhombus_unit_of`, `norm_eq_one_of_sq` (`Chain.lean`); `sum_sixUnits`, `delta_mul_one_add_omegaBar`,
`one_add_v_add_conj` (`Instances/SqrtTwoThree.lean`); `one_add_sq_ne_zero`, `inv_mem_zeroIntegral_of_not_mem`,
`chromaticNumber_eq_of_iso`, `chromaticNumber_planeOver_eq`, `chromaticNumber_unitQuadrance_eq_of_ringEquiv`,
`one_add_sq_ne_zero_of_subfield`, `le_adjoinTranscendental`, `mem_adjoinTranscendental_self` (`Transcendental.lean`). Each is used by an
audited theorem, so its axioms appear in that theorem's line; listed for the owner, not as a defect. J16's files are in flight and not
listed.

| file | line | kind | declaration (namespace `HadwigerNelson.` omitted) | audited by `scripts/Axioms.lean` |
|---|---|---|---|---|
| `Chain.lean` | 30 | def | `Chain.junction` | — |
| `Chain.lean` | 34 | def | `Chain.chainDrawing` | — |
| `Chain.lean` | 40 | def | `Chain.chainPoints` | — |
| `Chain.lean` | 43 | theorem | `Chain.junction_zero` | no |
| `Chain.lean` | 47 | theorem | `Chain.junction_succ` | no |
| `Chain.lean` | 65 | theorem | `Chain.junction_last` | no |
| `Chain.lean` | 71 | theorem | `Chain.chainDrawing_a` | no |
| `Chain.lean` | 76 | theorem | `Chain.chainDrawing_b` | no |
| `Chain.lean` | 82 | def | `Chain.copyHom` | — |
| `Chain.lean` | 101 | theorem | `Chain.not_colorable_chain` | **yes** |
| `Chain.lean` | 138 | theorem | `Chain.chainPoints_subset` | no |
| `Chain.lean` | 147 | theorem | `Chain.add_one_le_chromaticNumber_induce_of_chain` | **yes** |
| `Chain.lean` | 157 | theorem | `Chain.add_one_le_chromaticNumber_unitDistance_of_chain` | **yes** |
| `Chain.lean` | 167 | theorem | `Chain.norm_eq_one_of_sq` | no |
| `Chain.lean` | 172 | theorem | `Chain.rhombus_unit_of` | no |
| `Chain.lean` | 182 | def | `Chain.planeOverSubring` | — |
| `Chain.lean` | 191 | theorem | `Chain.coe_planeOverSubring` | no |
| `Chain.lean` | 195 | theorem | `Chain.add_one_le_chromaticNumber_planeOver_of_chain` | **yes** |
| `Chain.lean` | 222 | def | `Chain.spindleRhombus` | — |
| `Chain.lean` | 226 | def | `Chain.moserTwist` | — |
| `Chain.lean` | 231 | theorem | `Chain.spindle_of_chain` | **yes** |
| `Instances/SqrtTwoThree.lean` | 29 | def | `SqrtTwoThree.rhombusX` | — |
| `Instances/SqrtTwoThree.lean` | 33 | def | `SqrtTwoThree.omegaBar` | — |
| `Instances/SqrtTwoThree.lean` | 36 | def | `SqrtTwoThree.v` | — |
| `Instances/SqrtTwoThree.lean` | 39 | def | `SqrtTwoThree.sixUnits` | — |
| `Instances/SqrtTwoThree.lean` | 42 | theorem | `SqrtTwoThree.sqrt3_sq` | no |
| `Instances/SqrtTwoThree.lean` | 43 | theorem | `SqrtTwoThree.sqrt2_sq` | no |
| `Instances/SqrtTwoThree.lean` | 45 | theorem | `SqrtTwoThree.rhombusX_unit` | no |
| `Instances/SqrtTwoThree.lean` | 49 | theorem | `SqrtTwoThree.norm_omegaBar` | no |
| `Instances/SqrtTwoThree.lean` | 52 | theorem | `SqrtTwoThree.norm_v` | no |
| `Instances/SqrtTwoThree.lean` | 55 | theorem | `SqrtTwoThree.sixUnits_norm` | no |
| `Instances/SqrtTwoThree.lean` | 59 | theorem | `SqrtTwoThree.sum_sixUnits` | no |
| `Instances/SqrtTwoThree.lean` | 63 | theorem | `SqrtTwoThree.delta_mul_one_add_omegaBar` | no |
| `Instances/SqrtTwoThree.lean` | 69 | theorem | `SqrtTwoThree.one_add_v_add_conj` | no |
| `Instances/SqrtTwoThree.lean` | 74 | theorem | `SqrtTwoThree.sixUnits_sum` | **yes** |
| `Instances/SqrtTwoThree.lean` | 80 | abbrev | `SqrtTwoThree.F23` | — |
| `Instances/SqrtTwoThree.lean` | 82 | theorem | `SqrtTwoThree.sqrt2_mem` | no |
| `Instances/SqrtTwoThree.lean` | 85 | theorem | `SqrtTwoThree.sqrt3_mem` | no |
| `Instances/SqrtTwoThree.lean` | 88 | theorem | `SqrtTwoThree.rhombusX_mem` | no |
| `Instances/SqrtTwoThree.lean` | 95 | theorem | `SqrtTwoThree.omegaBar_mem` | no |
| `Instances/SqrtTwoThree.lean` | 98 | theorem | `SqrtTwoThree.v_mem` | no |
| `Instances/SqrtTwoThree.lean` | 102 | theorem | `SqrtTwoThree.conj_v_mem` | no |
| `Instances/SqrtTwoThree.lean` | 105 | theorem | `SqrtTwoThree.sixUnits_mem` | no |
| `Instances/SqrtTwoThree.lean` | 117 | theorem | `SqrtTwoThree.four_le_chromaticNumber_planeOver_two_three` | **yes** |
| `Instances/SqrtTwoThree.lean` | 125 | def | `SqrtTwoThree.eighteenEdges` | — |
| `Instances/SqrtTwoThree.lean` | 135 | def | `SqrtTwoThree.pullGadget` | — |
| `Instances/SqrtTwoThree.lean` | 145 | def | `SqrtTwoThree.diamond` | — |
| `Instances/SqrtTwoThree.lean` | 149 | def | `SqrtTwoThree.ports` | — |
| `Instances/SqrtTwoThree.lean` | 151 | theorem | `SqrtTwoThree.diamond_hom` | no |
| `Instances/SqrtTwoThree.lean` | 155 | def | `SqrtTwoThree.diamondGadget` | — |
| `Instances/SqrtTwoThree.lean` | 160 | def | `SqrtTwoThree.closingGadget` | — |
| `Instances/SqrtTwoThree.lean` | 164 | def | `SqrtTwoThree.eighteenGadget` | — |
| `Instances/SqrtTwoThree.lean` | 178 | theorem | `SqrtTwoThree.eighteen_not_colorable_three` | **yes** |
| `Instances/SqrtTwoThree.lean` | 182 | theorem | `SqrtTwoThree.eighteen_colorable_four` | **yes** |
| `Instances/SqrtTwoThree.lean` | 194 | def | `SqrtTwoThree.plantedEdges` | — |
| `Instances/SevenConditional.lean` | 29 | def | `SevenConditional.G4` | — |
| `Instances/SevenConditional.lean` | 35 | def | `SevenConditional.w` | — |
| `Instances/SevenConditional.lean` | 38 | def | `SevenConditional.eightUnits` | — |
| `Instances/SevenConditional.lean` | 42 | theorem | `SevenConditional.sqrt7_sq` | no |
| `Instances/SevenConditional.lean` | 44 | theorem | `SevenConditional.norm_w` | no |
| `Instances/SevenConditional.lean` | 47 | theorem | `SevenConditional.eightUnits_norm` | no |
| `Instances/SevenConditional.lean` | 51 | theorem | `SevenConditional.conj_w` | no |
| `Instances/SevenConditional.lean` | 56 | theorem | `SevenConditional.w_sq` | no |
| `Instances/SevenConditional.lean` | 63 | theorem | `SevenConditional.sum_eightUnits` | **yes** |
| `Instances/SevenConditional.lean` | 70 | abbrev | `SevenConditional.F7` | — |
| `Instances/SevenConditional.lean` | 72 | theorem | `SevenConditional.w_mem` | no |
| `Instances/SevenConditional.lean` | 76 | theorem | `SevenConditional.conj_w_mem` | no |
| `Instances/SevenConditional.lean` | 79 | theorem | `SevenConditional.eightUnits_mem` | no |
| `Instances/SevenConditional.lean` | 89 | theorem | `SevenConditional.planeOver_seam_subset` | no |
| `Instances/SevenConditional.lean` | 99 | theorem | `SevenConditional.five_le_chromaticNumber_planeOver_seven_of_G4` | **yes** |
| `Transcendental.lean` | 61 | def | `RouteC.planeOverEquiv` | — |
| `Transcendental.lean` | 68 | theorem | `RouteC.dist_eq_one_iff_quadrance` | no |
| `Transcendental.lean` | 75 | def | `RouteC.planeOverIso` | **yes** |
| `Transcendental.lean` | 91 | theorem | `RouteC.chromaticNumber_eq_of_iso` | no |
| `Transcendental.lean` | 97 | theorem | `RouteC.chromaticNumber_planeOver_eq` | no |
| `Transcendental.lean` | 107 | theorem | `RouteC.unitQuadrance_colorable_of_subring` | **yes** |
| `Transcendental.lean` | 141 | theorem | `RouteC.mem_valuationSubring_of_sq_add_sq_eq_one` | **yes** |
| `Transcendental.lean` | 169 | theorem | `RouteC.one_add_sq_ne_zero` | no |
| `Transcendental.lean` | 177 | theorem | `RouteC.unitQuadrance_colorable_of_valuationSubring` | **yes** |
| `Transcendental.lean` | 200 | theorem | `RouteC.eval_zero_ne_zero_of_dvd` | no |
| `Transcendental.lean` | 205 | def | `RouteC.zeroIntegral` | — |
| `Transcendental.lean` | 222 | theorem | `RouteC.mem_zeroIntegral` | no |
| `Transcendental.lean` | 225 | theorem | `RouteC.algebraMap_mem_zeroIntegral` | no |
| `Transcendental.lean` | 229 | theorem | `RouteC.inv_algebraMap_mem_zeroIntegral` | no |
| `Transcendental.lean` | 237 | theorem | `RouteC.inv_mem_zeroIntegral_of_not_mem` | no |
| `Transcendental.lean` | 260 | def | `RouteC.zeroPlace` | — |
| `Transcendental.lean` | 266 | theorem | `RouteC.mem_zeroPlace` | no |
| `Transcendental.lean` | 270 | def | `RouteC.evalZero` | — |
| `Transcendental.lean` | 278 | theorem | `RouteC.evalZero_apply` | no |
| `Transcendental.lean` | 282 | theorem | `RouteC.evalZero_eq_zero_of_mem_maximalIdeal` | **yes** |
| `Transcendental.lean` | 301 | theorem | `RouteC.chromaticNumber_unitQuadrance_ratFunc_of_one_add_sq_ne_zero` | **yes** |
| `Transcendental.lean` | 314 | theorem | `RouteC.chromaticNumber_unitQuadrance_ratFunc` | **yes** |
| `Transcendental.lean` | 320 | theorem | `RouteC.chromaticNumber_unitQuadrance_ratFunc_rat` | **yes** |
| `Transcendental.lean` | 328 | theorem | `RouteC.chromaticNumber_unitQuadrance_eq_of_ringEquiv` | no |
| `Transcendental.lean` | 336 | theorem | `RouteC.one_add_sq_ne_zero_of_subfield` | no |
| `Transcendental.lean` | 342 | def | `RouteC.adjoinTranscendental` | — |
| `Transcendental.lean` | 346 | theorem | `RouteC.le_adjoinTranscendental` | no |
| `Transcendental.lean` | 350 | theorem | `RouteC.mem_adjoinTranscendental_self` | no |
| `Transcendental.lean` | 355 | def | `RouteC.adjoinTranscendentalEquiv` | — |
| `Transcendental.lean` | 362 | theorem | `RouteC.chromaticNumber_planeOver_adjoin_transcendental_eq` | **yes** |
| `Transcendental.lean` | 371 | theorem | `RouteC.transcendental_liouvilleNumber_bot` | **yes** |
| `Transcendental.lean` | 385 | theorem | `RouteC.chromaticNumber_planeOver_liouville` | **yes** |

#### 3.4 Corrections owed and held items, M2

| # | kind | item (short) | address | in `plans/M2-close-inventory.md`? |
|---|---|---|---|---|
| 1 | correction | the brief's route-C tool colours by a finite residue ring; route C uses `cosetResidue` + `unitQuadrance_colorable_of_ringHom` | `plans/M2-kernel-lane.md` §2.1, §2.4 | yes, row 2 |
| 2 | correction | a comap union cannot carry the chain; the induced graph on the image set | `plans/M2-kernel-lane.md` §2.1 | yes, row 5 |
| 3 | correction | `CLAUDE.md` trust count 1034 → 1045 and the vacuity counts; LEDGER § B T5, T6, T9 stub → kernel | `plans/M2-S1K-chain.md` stage 5 | yes, row 22 |
| 4 | correction | `Gadget.transport` is same-`Fin n`; the 18-vertex pull is `SqrtTwoThree.pullGadget` | `plans/M2-S1K-chain.md` stages 1, 3 | yes, row 23 |
| 5 | correction | `RatFunc.algEquivOfTranscendental` exists (M2 plan §2.2); G63 names the wrong kernel tool and its grade can move to kernel | `plans/M2-S2K-route-c.md` §1.1, §4.3 | **no** — added in stage 4 |
| 6 | correction | the gate counts are stale since J14: `CLAUDE.md` § The gate and `scripts/vacuity-baseline.txt` header (6795 → 6908, 278 → 286, 275 → 278, 253 → 256) | `plans/M2-S2K-route-c.md` §4.1 | **no** — added in stage 4 (row 22 has J14's numbers only) |
| 7 | correction | FS-39's phase B is months, not 1–2 days (split B0, B1, B2); G63's "pure transcendence", examples, Madore's credit, Q-const | `plans/M2-S1D-bridge.md` §3.2, §3.4 | yes, row 13 |
| 8 | correction | Madore ¶5.4 was already in the bibliography (a re-finding); its lineage omits Benda–Perles; Soifer OP 11.1 asserts the bridge without proof | `plans/M2-S1D-bridge.md` §1.1 Q5–Q7 | yes, row 14 |
| 9 | held | J17V optional; J16's choice of FS-47 before the stripe lemma | J04 report | yes, rows 9, 10 |
| 10 | held | `VACUITY DECLARED:` withheld on the G4-conditional theorem | J14 report | yes, row 25 |
| 11 | held | queue J17K (B0 + B1) after J15; J17V skip | J17 report | yes, row 16 |
| 12 | stub | FS-39 (`plans/STUB-plane-bridge.md`): route C landed; left the finitely generated case and the sup statement | J15 report; `plans/M2-S2K-route-c.md` §4.3 | **no** — added in stage 4 |
| 13 | stub | FS-45: left are G4's certificate after the ban and a kernel upper bound `χ(ℚ(√2,√3)²) ≤ 4` | J14 report (SPAWN line) | **no** — added in stage 4 |

### M3 — colourings no character gives

Plan `plans/M3-exotic-colourings.md` (J06); close inventory `plans/M3-close-inventory.md` (rows 1–7 at this stage's reading: J06's report
only; J18's and J21's reports not yet folded).

#### 3.5 Jobs

| job | role | brief | record | tools | data | report | commits (2026-09-25) |
|---|---|---|---|---|---|---|---|
| J06 | reframe; writes the J18–J22 briefs | `J06-M3-reframe.md` | `plans/M3-exotic-colourings.md` | — | — | `J06.md` | 22bd1d12 92c86537 d57f4c5a 70cb13f6 98acb9cb 5b350f30 8badebd4 1a2e9808 |
| J18 | derivation: FS-76 in rank one ("every phase rigid ⟹ no wall") | `J18-M3-rank-one-derivation.md` | `plans/M3-S1A-rank-one.md` | `tools/crunch_j18_phases.py`, `tools/crunch_j18_swaptail.py` | `data/m3/j18/` | `J18.md` | c9c71393 af02c867 79cc4f2e 19d4aec8 048d487a d5e4c96b b85ec7c6 5a81e440 |
| J19 | derivation, the second mind on J18's stall (KE) — **running** | `J19-M3-rank-one-second-mind.md` (skeleton `…-SKELETON.md`) | `plans/M3-S1B-rank-one.md` | — | — | — | d70009d1 (stage 1) |
| J20 | blind verifier of J18 or J19 — **queued** | `J20-M3-rank-one-verifier.md` | `plans/M3-S1V-rank-one.md` (not yet created) | — | — | — | — |
| J21 | derivation: FS-64 at five colours over ℚ(√167) (measurable windows) | `J21-M3-windows-five-derivation.md` | `plans/M3-S1D-windows-five.md` | `tools/crunch_j21_spectra.py`, `tools/crunch_j21_dyadic_hyperbola.py` | `data/m3/j21/` | `J21.md` | 942f3f10 7c8f446c 534316c1 bd9fcf7b 765c1603 7cd27284 |
| J22 | blind verifier of J21 — **queued** | `J22-M3-windows-five-verifier.md` | `plans/M3-S1V-windows-five.md` (not yet created) | — | — | — | — |

**`plans/M3-exotic-colourings.md` has no "Theorems this phase proved" heading.** J06's one result is in its report and in the M3
inventory (row 2); listed below from the report.

#### 3.6 Results

No M3 result has a verifier yet (J20 and J22 are queued); every line below is one mind.

| id | statement | grade | verification | address |
|---|---|---|---|---|
| J06 (report) | R2 ⟺ "a countable four-colouring shift of a distance graph is finite"; A-T1 ⟸ A-K3 + T34's orbit step; FS-64 at five over any `S ∋ ∞` contains `χ_µ(ℝ²) ≤ 5`; at ℚ(√167) the place above 3 is split; Hoffman at 43 is 0.21376 > 1/5 | hand, planner, one mind | one mind | plan "The milestone in the theory's terms", §M |
| J18-F3 | one-dimensional SFT facts: some phase not a single cycle ⟹ `h > 0`; all single cycles ⟹ `h = 0`, `X` countable, wall ⟺ `X` infinite | hand (standard) | one mind | `plans/M3-S1A-rank-one.md` §2.0 |
| J18-K0loc | a periodic point of a rigid phase is gap-free, its Kempe components cross every cut; its `m`-windows carry `≥ k − 1` colours | hand | one mind | §2.1 |
| J18-K0H | the rank-one form of FS86-dB-H with two-sided gap-freeness is false (T30's rigid–rigid walls) | hand + FS-79 tools | one mind | §2.1 |
| J18-AK1 | A-K1 | hand | one mind | §2.2 |
| J18-AK2 | A-K2; a wall leaves a phase only at a left gap whose second colour survives | hand | one mind | §2.3 |
| J18-AKq | A-Kq for the labelled quotient; its rigidity clause false for the plain quotient (`D = {1}`) | hand | one mind | §2.4 |
| J18-EQ | A-T1 ⟺ A-T1′ ⟺ A-T2 ⟺ A-K3 | hand | one mind | §2.5, §3.1 |
| J18-DC | the Δ-completion theorem: A-T1 fails iff some heteroclinic four-colouring has an all-rigid `X₄(D_c(M))` | hand | one mind | §3.2 |
| J18-CTL | the control `{1,5,7,10}` reproduced; 8 of 9 BFS wall points have trivial completion to `M = 100`; all 9 satisfy KE | tools exact | one run | §3.3, `data/m3/j18/` |
| J18-DPR | `X₄({1,5,7,10,13,27,33})`: 25 phases, 24 rigid, one non-rigid; one rigid–rigid wall, satisfying KE | tools exact | one run | §3.4, `data/m3/j18/completion-81-49-M40.txt` |
| J18-KE⟹ | KE ⟹ A-T1 | hand | one mind; KE itself is J19's question | §3.5 |
| J21-D0 | a window five-colouring over `{∞₁}` is a measurable proper five-colouring of `UD(ℝ²)`; a "no" over every `S` with a real place implies `χ_µ(ℝ²) ≥ 6` | hand | one mind | `plans/M3-S1D-windows-five.md` §2.1 |
| J21-D1 | for finite `S` with no real place, every factor of ratio `< 1/5` ⟹ no window five-colouring (three formats) | hand; = C14.3 at `k = 5` | one mind | §2.2 |
| J21-D1fac | ℚ(√167)'s factor table: 23 ≤ 0.18523, 59 ≤ 0.19912, stable `p ≥ 67`, the ramified 167, odd split places 0; stable places below 59 are 23 and 43 | cert, tools (float with stated error), Weil | one mind; 59's margin is the report's held number | §2.3 |
| J21-D1-3 | the place above 3 is split in `F(i)/F`, ratio 0 | hand | one mind | §2.4 |
| J21-D1-2 | C14.2 (c) holds verbatim at `q = 2`: the dyadic place has ratio 0 | hand; tools (FFT at `ℚ₂(i)`, plant fires) | one mind | §2.5 |
| J21-D1-43p | windows reading the 43-adic places at level one are excluded; the fibre-share inequality alone gives exactly Hoffman's 0.21376 | hand + cert | one mind; D1-43 at depth is a GAP (report) | §2.6 |
| J21-SL | slicing: a measurable proper `k`-colouring of `Γ × Γ × Y` restricts to one of `Γ × Y` for a.e. `s` | hand | one mind | §3.1 |
| J21-D3 | `χ_µ(Γ_{∞₁} × Γ_{∞₂}) = χ_µ(Γ_{∞₁})`, and for `χ_B` | hand | one mind | §3.1 |
| J21-MX | mixing selection: a compact factor with `λ* < 1/(k−1)` can be deleted from a Borel `k`-colouring of a product | hand | one mind; prior-art searches owed (report) | §3.2 |
| J21-TH | every finite place of ℚ(√167) is 5-thick except twelve above 2, 3, 5, 7, 29, 61 (split) and 23, 43 (stable) | tools + hand; Weil | one mind | §3.3 |
| J21-RED | a Borel window five-colouring over `S` exists iff one over `S_red ⊆ {∞, 2, 3, 5, 7, 23, 29, 43, 61}` | hand | one mind | §3.4 |
| J21-D2p | D2(a), D2(b) hold when every factor of `B` is thick | hand | one mind; D2(a) GAP at two steps otherwise (report) | §3.5 |
| J21-NG1 | the planner's cylinder lemma is false already for `A′ = A = UD(ℝ²)` | hand | one mind | §3.6 |
| J21-D4 | both inhabitants: C9's `⌊4θ̃⌋` is a Borel window four-colouring over `{∞, 7}` of ℚ(√11), a pullback from neither factor; a periodic seven-colouring is a window colouring over `{∞₁}` | hand | one mind | §4.1 |
| J21-NG2 | ratio alone cannot carry D2: a counterexample at `k = 125` (Shitov, Zhu Thm 3.5) | hand, from `[Zhu2025]` §3 | one mind | §3.6 |

#### 3.7 Corrections owed and held items, M3

| # | kind | item (short) | address | in `plans/M3-close-inventory.md`? |
|---|---|---|---|---|
| 1 | slip | the J06 brief's "FS79 T30" is FS73-T30; "Ellenberg2018's question at k = 4 on ℤ" is inheritance, not existence | plan §Q row 2, §PA.2 row 1 | yes, row 1 |
| 2 | held | LEDGER § B read by keyword scan; J20/J22 carry verified-input lists | J06 report | second half yes, row 6; the § B scan **no** — added in stage 4 |
| 3 | correction | M3 plan §M item 1 and §S's "hold in either form": A-Kq's rigidity clause fails for the plain quotient | `plans/M3-S1A-rank-one.md` §2.4 | **no** — added in stage 4 |
| 4 | correction | "A-K2 is FS86-dB-H's rank-one form" holds only with left gap-freeness | `plans/M3-S1A-rank-one.md` §2.1 K0-H | **no** — added in stage 4 |
| 5 | held | KE is stronger than A-T1: the owner's call whether J19 takes KE or the counterexample side; J20's list carries A-K3, equivalent to A-T1 | J18 report | **no** — added in stage 4 |
| 6 | correction | FS86-CL1 and LEDGER row 92: "C14.2 at p = 2 not checked" is now checked (one mind) | `plans/M3-S1D-windows-five.md` §2.5, §4.6 | **no** — added in stage 4 |
| 7 | correction | `[KechrisMarks2020]` "§4.7" is §5.1 Example 5.1 (pp. 45–46), in the J21 brief and the M3 plan §PA.1 row 3 | `plans/M3-S1D-windows-five.md` §1.1 Q7 | **no** — added in stage 4 |
| 8 | slip | the planner's cylinder lemma is false (NG1) | `plans/M3-S1D-windows-five.md` §3.6 | **no** — added in stage 4 |
| 9 | held | J21's harness count passed 420k; 59 is 5-mixing by a margin of 1.4·10⁻³ (float spectrum) — the one close number J21-TH rests on | J21 report | **no** — added in stage 4 |
| 10 | slip | `plans/M3-exotic-colourings.md` has no "Theorems this phase proved" heading (standing rule 7) | this index §3.5 | **no** — added in stage 4 |

### FS-89's close (2026-09-25, before the crunch)

Plan `plans/FS89-rational-band-rigidity.md` (its §R-close first); derivation file `plans/FS89-derivation.md`; close inventory
`plans/FS89-close-inventory.md` (rows 1–54); ledger rows 95–97 (`LEDGER.md` lines 118–120). Records: `plans/FS89-S0A-gluing-verification.md`
(verifier G), `plans/FS89-S0B-band-set.md` (S0B), `plans/FS89-S1D-derivation.md` (D), `plans/FS89-S1V-verification.md` (verifier H),
`plans/FS89-S1VB-verification.md` (verifier I), `plans/FS89-PA-berend1984.md`, `plans/FS89-PA-furstenberg1967.md`, `plans/PA-tardif2023.md`,
`plans/PA-products-GL1974-LT2002.md`.

#### 3.8 Rows

| row | headline (shortened from `LEDGER.md`) |
|---|---|
| 95 | rational band rigidity: RQ₄ and RQ₅ — every four- and five-colour band character of `Q = ℤ[i][1/p : p ≡ 1 (4)]` is torsion plus archimedean |
| 96 | what it settles at the exposed fields: HD1 at ℚ(√59), ℚ(√83), ℚ(√131); no character four-colouring of ℚ(√47)'s plane; no character five-colouring of ℚ(√167)'s |
| 97 | one prime is not enough: over `ℤ[U₅]` the four-colour band set is not torsion plus archimedean |

#### 3.9 The derivation file's entries

Every entry of `plans/FS89-derivation.md`, with the verification its own bracket states (the file already merges duplicate ids; "line" is
the entry's line in that file). Today's crunch work that bears on an entry is in stage 4's reverse index.

| id | statement (the entry's title, shortened) | grade and verification (the entry's bracket, shortened) | line |
|---|---|---|---|
| FS89-S0A-1 | G0: `ℤ[U_ℚ] = ℤ[i][1/p : p ≡ 1 (4)]` ∋ 1/5; the layers `bℤ[U_ℚ]` (`b ∈ U_F`) lie in `R_F` and cover `U_F`; a band character of `R_F` restricts to … | hand; verifier G blind; the planner's §0.1 restates it | 40 |
| FS89-S0A-2 | G1, the gluing: `Θ_k(ℤ[U_ℚ]) ⊆ T_N + A` ⟹ `Θ_k(R_F) ⊆ T_N + A` for every subfield `F ⊆ ℝ`, at every band; the lift `lim 5^k·(small rep of …` | hand; verifier G blind; the route is the advisor's sketch, closed | 45 |
| FS89-S0A-3 | Lemma N₀: `Θ₄(Q) ∩ (T + A) ⊆ T₁₆₈ + A`; the torsion part is one of a 2-part of order dividing 8, an order-3 part (with `\|α\| ≤ 1/12`) or an … | hand; two derivations, both blind: verifier G, and verifier H before it opened S0A's record (its divergence table was written … | 51 |
| FS89-S0A-4 | Level collapse: a band character in `T + A` has level ≤ 1 at every odd stable place where the unit vectors are dense at every level, and 2-level ≤ … | hand; verifier G | 59 |
| FS89-S0A-5 | No band character of any `R_F` has layer restrictions in `T + A` of unbounded order; the 3-adic character at the split prime above 3 of ℚ(√2) is … | hand; verifier G (its adversarial attempt, which failed for a stated reason) | 63 |
| FS89-S0A-6 | C-HD1, conditional form: the four-band rational statement (RQ₄) implies HD1 (`Θ₄(R_F) ⊆ T`, dyadic torsion) for ℚ(√59), ℚ(√83), ℚ(√131) | hand, given FS86-dB-Theta's inputs; verifier G | 67 |
| FS89-S0A-7 | Archimedean averaging: over a real number field, the torsion part of a band character in `T + A` is itself a band character, non-zero, with margin `r` | hand; verifier G | 71 |
| FS89-S0A-8 | G2, general form: for `F` in Lemma R's scope with every stable place odd of prime residue field `q ≥ 11`, `Θ₄(R_F) ∩ (T + A) = ∅`; given RQ₄, … | hand, given Lemma R (FS86-B1-LR, its corrected scope) and Weil; verifier G; the owner's one-step check | 76 |
| FS89-S0A-9 | G3: under the five-band rational statement (RQ₅), `Θ₅(R_{ℚ(√167)}) = ∅`; needed at each stable place, a level-one ratio `< 1/5`: 23 (`α ≤ 97`, … | hand + cert + tools exact; verifier G | 82 |
| FS89-S0A-10 | The equivalence: `Θ_k(ℤ[U_ℚ]) ⊆ T + A` ⟺ `Θ_k(R_F) ⊆ T + A` for every subfield `F ⊆ ℝ`, every band; the rational statement is the uniform … | hand; verifier G | 87 |
| FS89-S0A-11 | Finite-type band characters of `Q` are in `T + A` at bands 1/4 and 1/5: a counterexample to RQ must read infinitely many split places (= … | hand; verifier G blind; de Bruijn at FS-86 | 91 |
| FS89-S0A-12 | A `T + A` statement about `ℤ[U₅]` cannot exclude split components at primes `p ≠ 5`: a continuous character at `p` restricts to every … | hand; verifier G; the owner's one-step check | 95 |
| FS89-S0A-13 | Weil check: `max\|λ\| ≤ 2√q`, and the middle-half coefficient `1/sin(π/2q) > 2√q` for every `q ≡ 3 (4)`, `11 ≤ q ≤ 83`; Hoffman ratios at 23 and … | tools (float, margins printed); verifier G | 99 |
| FS89-S0B-T1 | The rank-one orbit model: `Θ_β(U₅)` ≅ bi-infinite sequences `e_m ∈ Q_β = [β, 1−β]²` with `e_{m+1} − w̄e_m ∈ π⁻¹ℤ[i]` (layers `wᵐℤ[i]`); a … | hand + tools exact; S0B (two models agreeing to depth 6, and the adelic formula value for value at `\|m\| ≤ 25`); the owner … | 105 |
| FS89-S0B-T2 | Leaves: `τ + λ_d ∈ Θ_β` iff `\|d\| ≤ r_τ`; in adelic form `T + A` is exactly "the two 5-adic components are images of one Gaussian rational"; … | hand; S0B | 110 |
| FS89-S0B-T3 | The heteroclinic `θ*` (the order-3 character on forward layers, `θ₂ + λ` on backward ones, glued at `e₀ = (1+i)/3`) lies in `Θ₄(U₅)` | hand + tools exact; S0B; the owner by independent code (inventory item 16) | 115 |
| FS89-S0B-T4 | A band character reading `τ₁ + λ` forward and `τ₂ + λ` backward, `τ₁ ≠ τ₂`, is not in `T + A`; hence `Θ₄(U₅) ⊄ T + A` and `RS₄({5})` is false | hand; S0B; the owner (density, inventory item 16) | 119 |
| FS89-S0B-T5 | From `e₀ = q` the forward orbits form a perfect tree: continuum many non-`T + A` points, with a Cantor fibre of irrational 5-adic parts | hand, exact prefixes; S0B | 125 |
| FS89-S0B-T6 | Any second split prime `p ≠ 5` kills every rational heteroclinic of `Θ₄(R₅)`: no band character of `ℤ[i][1/5p]` restricts to one, whatever its … | hand + exact arithmetic; S0B (derived, one mind, for torsion difference prime to 13); verifier H blind (general), with the … | 129 |
| FS89-S0B-C1 | The positive control: FS81-T3/T8 reproduced on two exact code paths (the `L`-layer and orbit models) at depth ≤ 8, three colours, 5 pieces at … | tools exact; S0B; the owner reran it (inventory item 13) | 137 |
| FS89-S0B-L4 | The primitive band torsion characters of `ℤ[i]/N` at four colours with `5 ∤ N`, `N ≤ 130`: 145 characters of 12 orders (2, 3, 4, 7, 8, 22, 26, 31, … | tools exact, a finite list; S0B | 141 |
| FS89-P-R1 | `Θ₃(R₆₅) ⊆ T₆ + A`: FS81-T3 on each layer `w₁₃ⁿ·ℤ[i][1/5]`, glued through 5-divisibility as in S0A-2 (the three-colour control of the plan's §S.4) | derived, one mind (the planner); unverified — D's D2-L1 and verifier I's VB4 each imply it (RS₃({5}) is FS81-T3) | 148 |
| FS89-D0-T1 | The rank-`r` orbit model: `Θ_β(U_S)` ≅ arrays `(e_m)_{m∈ℤ^S}` in `Q_β` with `e_{m+ε_p} − w̄_p e_m ∈ π_p^{−1}ℤ[i]` for every `p ∈ S`; adjacent … | hand + tools exact; two derivations, independent (D; verifier H blind to D); the owner's CRT check at 200 random triples | 154 |
| FS89-S1V-10 | Theorem V6, `T + A` at rank `r`, five equivalent forms: one Gaussian rational at all `2r` local components ⟺ one leaf on the coordinate axes ⟺ one … | hand; verifier H | 159 |
| FS89-S1V-1 | Theorem V1: a character of `Q` whose restriction to every `R_S` (a directed exhausting family of finite nonempty `S`) is in `T + A` is in `T + A`, … | hand, elementary; verifier H blind; the owner's one-step check (inventory item 24) | 165 |
| FS89-S1V-2 | U1 and its sharp form: `RS₄(S)` for every finite `S ⊇ S₀` implies RQ₄; and RQ₄ ⟺ `Θ₄(Q)\|_{R_S} ⊆ T + A` for every finite `S` | hand; verifier H | 169 |
| FS89-S1V-3 | The leaf formula at `Q`: `τ + λ_d ∈ Θ₄(Q)` iff `τ(G_N) ⊆ [1/4 + \|d\|, 3/4 − \|d\|]`, `G_N` the image of the local norm-one groups (joint density … | hand; verifier H | 173 |
| FS89-S1V-5 | U2, the explicit list: `Θ₄(Q) ∩ (T + A)` is 13 discs (parity, margin 1/4; four of order 3, margin 1/12; eight of order 7, margin 1/28) and 16 … | hand + tools exact; verifier H blind; the owner reran the tool (inventory item 25) | 176 |
| FS89-S1V-6 | The rows of a band character of `R_{5,p}` over a rational heteroclinic of `R₅` are rational heteroclinics whose archimedean parts are rotated by … | hand; verifier H | 181 |
| FS89-S1V-7 | The sweep bound: a band torsion character with no `π̄_p`-part has `π_p`-level at most `v_{π_p}(w₅^o − 1)`, `o` fixed by its prime-to-`p` order | hand; verifier H (its own place slip, `π_p` against `π̄_p`, corrected before any other file was opened; the numbers are identical) | 184 |
| FS89-D1-L2 | Berend's case 2: if small differences in a closed `U_S`-invariant `M` have zero `S`-adic part, then `M` meets `T + A`; a minimal such `M` lies in … | hand; two derivations, independent (D, via `x∘(w_pⁿ − 1) = λ_v` on a recurrent point; verifier I blind, via finitely many … | 189 |
| FS89-D1-L3 | Case 1 at `\|S\| ≥ 2`: if small differences in `M` have non-zero `S`-adic parts, then `M − M = R̂_S`; the orbit closure of any non-zero pure local … | hand; two derivations, the second from the statement (D: expand at `v` by `w_p`, rotate by `⟨i, w_q⟩`, an open subgroup of … | 196 |
| FS89-D1-L4 | The parity line: `M ⊆ Θ₄` with `θ₂ ∈ M − M` contains a corner (`2x = θ₂`); `θ₂(u) = 1/2` on every rational unit vector, so `x(u), x(u) + ½ ∈ [1/4, …` | hand, two lines; D; verifier I from the statement; the owner | 203 |
| FS89-D1-T1 | `MS₄(S)` for every finite `S` with `\|S\| ≥ 2`: every `U_S`-minimal closed subset of `Θ₄(R_S)` is a finite torsion orbit or a finite union of leaf … | hand; D; verifier I (B2: TRUE from D1-L2 to L4, no finite lemma); B1's blind verdict GAP was its own route's | 208 |
| FS89-S1VB-1 | Lemma E (expansion): small differences with a non-zero local part in a closed invariant set expand to a pure local difference | hand; verifier I blind | 215 |
| FS89-S1VB-2 | Lemma SW: no ball of pure local translates lies in `Θ_k(R_S)`, `k ∈ {4, 5}` (a pure local sweep moves `θ(u)` through a coset of step `1/p ≤ 1/5`, … | hand; verifier I blind | 218 |
| FS89-S1VB-3 | Lemma JC: `⟨(w̄_{p′}, w_{p′}\|_v)⟩` is dense in `S¹ × W₀`, `W₀` open in `ℤ_p^×` | hand; verifier I blind | 221 |
| FS89-S1VB-4 | VB1: for `\|S\| ≥ 2`, a band point whose orbit closure meets `T + A` is in `T + A` (bands 1/4, 1/5) | hand; verifier I blind | 225 |
| FS89-S1VB-5 | VB2: for `\|S\| ≥ 2`, `MS_k(S)` ⟺ `RS_k(S)` ⟺ every minimal subset of `Θ_k(R_S)` meets `T + A` (bands 1/4, 1/5) | hand; verifier I blind | 229 |
| FS89-S1VB-6 | VB3: `RS_k(S)` ⟹ `Θ_k(R_S) ∩ T` is finite, for any nonempty `S` (non-effective: no order bound) | hand; verifier I blind | 233 |
| FS89-S1VB-7 | VB4: `RS_k(S)` ⟹ `RS_k(S′)` for every `S′ ⊇ S`, finite or not; in particular RQ_k | hand; verifier I blind; S0A-2's gluing with base `R_S`, the order bound from VB3 | 237 |
| FS89-S1VB-9 | VB6: a minimal set with a pure local pair and an infinite fibre group is impossible | hand; verifier I blind | 240 |
| FS89-D1-L5 | At `S = {5, 13}`: a band array within 0.13 of a corner pattern at two `m`-adjacent sites equals it there (the deviation rotates rigidly by `w̄₅` … | hand + tools exact; D; checked independently by S1VB-13 | 244 |
| FS89-D1-L6 | The corner exit lemma at `{5, 13}`, band 1/4 (`w̄₁₃ ≡ 3 (mod π₅)`, `w̄₅ ≡ 7 (mod π₁₃)`): no band array leaves a full corner plane; segment length … | hand + tools exact; two independent exact tools (D's, with three plants firing after two unreachable ones were replaced; … | 248 |
| FS89-D1-C1 | Corners are isolated in `Θ₄(R₆₅)`; a single vertical domino already isolates a corner (verifier I's strengthening of D's `3 × 2` box) (= S1VB-13, … | hand + tools exact; D; verifier I's own tool, six plants firing | 253 |
| FS89-D1-T2 | `RS₄({5, 13})`: `Θ₄(R₆₅) ⊆ T + A`; no heteroclinic or switching character at `{5, 13}` (U4, promoted from S0B's reading to a theorem) | hand + tools exact; D (case 1 forces a corner into the orbit closure; D1-C1 finishes); verifier I (B2, from the statements; … | 257 |
| FS89-D1-C2 | `Θ₄(R₆₅) ∩ T` is finite, so `Θ₄(R₆₅)` is a finite union of leaf discs | hand + tools exact; D (by corner isolation); verifier I's VB3 derives it from D1-T2 by expansion, so it is not an independent … | 263 |
| FS89-S1VB-14 | `RS₄(S)` and `MS₄(S)` for every finite `S` with `\|S\| ≥ 2`; `RS₅(S)` and `MS₅(S)` for every `S ∋ 5` with `\|S\| ≥ 2`; with VB4, RQ₄ and RQ₅; no … | hand; verifier I's assembly of D's D1-L2 to L4 and D5-L1 with its own VB1 and VB4 (the lemmas each derived twice, as their … | 267 |
| FS89-D2-L1 | Bounded-order layering: `Θ_β(R) ⊆ T_N + A` for a `p`-divisible `R = ℤ[U_R] ⊆ Q` implies `Θ_β(R′) ⊆ T_N + A` for every `R ⊆ R′ ⊆ Q` | hand; D (the archimedean parts aligned on the ideals `R ∩ uR`); verifier I from the statement (S0A-2's 5-adic real lift with … | 275 |
| FS89-D2-T1 | RQ₄: `Θ₄(ℤ[i][1/p : p ≡ 1 (4)]) ⊆ T + A`; with S1V-5, `Θ₄(Q)` is exactly the 13 discs and 16 points of U2, an explicit compact set | hand + tools exact; D (D2-L1 with `R = R₆₅`, `N` from D1-C2); verifier I (every lemma re-derived, from the statements; a … | 279 |
| FS89-D5-L1 | At band 1/5 with `5 ∈ S`: `θ₂ ∈ M − M` implies `M` meets a corner leaf disc of radius 1/20 (`x(u) ∈ [1/5, 3/10] ∪ [7/10, 4/5]`, so `2x ∈ …` | hand; two routes: D (FS81-T3 lifted through D2-L1); verifier I from the statement, by S1VB-12 with no FS-81 input | 287 |
| FS89-S1VB-12 | Narrow-band rigidity: for `5 ∈ S`, a character of `R_S` with `φ(U_S) ⊆ [−1/10, 1/10]` is `λ_e` with `\|e\| ≤ 1/10` (5-steps are exact since `0.283 …` | hand; verifier I | 291 |
| FS89-D5-L2 | Near a corner leaf a band array is on the leaf (digit spacing); its hypothesis `\|d\| ≤ 1/20` is not needed (verifier I) | hand; D; verifier I from the statement | 295 |
| FS89-D5-L3 | The corner-leaf exit lemma at `{5, 13}`, band 1/5, displacement ≤ 0.06, on all 128 exit lines; segment length 4 tight (checked independently by … | hand + tools exact; D's tool (plants: displacement 3/10 leaves 64 survivors, `w̄₁₃ → 1` leaves 8); verifier I's tool, a sound … | 298 |
| FS89-D5-T1 | `RS₅({5, 13})`: `Θ₅(R₆₅) ⊆ T + A` | hand + tools exact; D; verifier I (B2 from the statements; and by VB2 with D5-L1) | 302 |
| FS89-D5-C2 | `Θ₅(R₆₅) ∩ T` is finite | hand + tools exact; D; verifier I's VB3 at `k = 5` (not an independent input) | 305 |
| FS89-D5-T2 | RQ₅: `Θ₅(ℤ[i][1/p : p ≡ 1 (4)]) ⊆ T + A`; it implies RQ₄ (`Θ₄ ⊆ Θ₅`), by a route sharing D1-L2 and D1-L3 (not independent) | hand + tools exact; D; verifier I (every lemma re-derived from the statements; a second assembly via VB1, VB4) | 308 |
| FS89-CL1 | S0B's 29 depth-one cells and verifier H's 29 torsion characters are different lists with equal counts: parity sits in the 12-gon, order 3 in the … | tools exact; the close planner, one mind | 313 |
| FS89-CL2 | For every subfield `F ⊆ ℝ`: `Θ₄(R_F) ⊆ T₁₆₈ + A` and `Θ₅(R_F) ⊆ T + A`; every four- or five-colour character colouring of any real field's plane … | hand; a composition: S0A-10 and S0A-3 (verifier G; N₀ twice) with D2-T1 and D5-T2 — no new step | 320 |
| FS89-CL3 | HD1 for ℚ(√59), ℚ(√83), ℚ(√131): every four-colour band character of the plane is a dyadic torsion (pullback) character; so no character colouring … | hand; a composition: S0A-6 with D2-T1, at FS86-dB-Theta's grade (two derivations, given V3: FS-66's certificates at 11, and at … | 324 |
| FS89-CL4 | C-47 unconditional: `Θ₄(R_{ℚ(√47)}) = ∅`; no character four-colouring `x ↦ ⌊4θ(x)⌋` of ℚ(√47)'s plane exists. `χ(ℚ(√47)²) = 5` is not claimed | hand; a composition: S0A-8 (given Lemma R and Weil) with D2-T1 | 329 |
| FS89-CL5 | C-167 unconditional: `Θ₅(R_{ℚ(√167)}) = ∅`; no character five-colouring of ℚ(√167)'s plane exists. `χ(ℚ(√167)²) ≥ 6` is not claimed | hand + cert; a composition: S0A-9 (FS-53's and FS-66's certificates) with D5-T2 | 333 |
| FS89-PA-B1 | `(R̂_S, U_S)` in Berend's coordinates: `R̂_S = Ω_a²` (`a = ∏_{p∈S} p`) and `Q̂ = Ω_P²` (his Ch. IV); the action meets his irreducibility condition … | hand, a hypothesis check; the reader, one mind | 339 |
| FS89-PA-B2 | Band-free minimal sets: for every finite `S` with `\|S\| ≥ 2`, every `U_S`-minimal closed `M ⊊ R̂_S` lies in `T + A` (case 2 by D1-L2; case 1 … | hand; the reader, one mind, unverified; resting on D1-L2 and D1-L3, each derived twice | 343 |

#### 3.10 FS-89's inventory items still open

| # | kind | item (short) | status in the inventory |
|---|---|---|---|
| 5 | decision owed (Kooshi) | "de Grey's lattice" is this project's coinage, not de Grey's | carried (Kooshi's call) |
| 6 | carried | FS-90's two sanctioned hours | carried (Kooshi's call) |
| 7 | carried | the audit of C14's external input (`[AmbrusEtAl2023]`); reading debts (Soifer 2019, de Grey 2026, Haugstrup 2026, …) | carried; not worked |
| 17 | ruling owed (Kooshi) | the torsion list of item 16(b) was a finite exact enumeration (the ban's edge) | carried (recorded in S0B-L4's entry) |
| 54 | decision owed (owner) | M50's `S₅` consequence may be re-graded (the products reader) | carried (owner's call) |

Corrections owed **to** FS-89's closed record by today's crunch (the Notation's `A`, FS89-CL2's wording, FS86-B1-LR's Galois scope) are
carried in `plans/FS91-close-inventory.md` (rows 61, 69, 78) and bannered in stage 4.

## Stage 4 — SAVED (wiring)

### 4.1 What was wired

**Pointer blocks** — a section headed "Where the 2026-09-25 work on this lives", addresses and neutral titles only, appended at the end of:

| file | why |
|---|---|
| `plans/STUB-plane-bridge.md` (FS-39) | M2's route C and bridge (J04, J15, J17; J17K queued) |
| `plans/STUB-chain-theorem.md` (FS-45) | J14's kernel chain theorem |
| `plans/STUB-unit-vector-ring-kernel.md` (FS-47) | J04's skeleton, J16 (in progress), J07's Lemma C/C′, J09's J2, J10 |
| `plans/STUB-biquadratic-table.md` (FS-48) | J02, J09 (its three-colour half) |
| `plans/STUB-four-colours-167.md` (FS-59) | J08, J11, J07/J10 on C-167, J21 |
| `plans/STUB-adelic-window-colouring.md` (FS-64) | M3's question 2 (J06, J21; J22 queued), J08's re-aim |
| `plans/STUB-tight-product-colourings.md` (FS-67) | J21's product lemmas |
| `plans/STUB-three-colour-criterion-kernel.md` (FS-75) | J02's and J09's re-aims |
| `plans/STUB-four-colour-inheritance.md` (FS-76) | M3's question 1 (J06, J18; J19 in progress; J20 queued) |
| `plans/STUB-three-colours-residue-degree-three.md` (FS-82) | J02, J09 on its field |
| `plans/STUB-layer-method-five-colours.md` (FS-83) | J01, J03a |
| `plans/STUB-five-colours-47.md` (FS-84) | J07, J10 on C-47 |
| `plans/STUB-dyadic-rigidity-triangle-free.md` (FS-86) | J07, J10 (HD1), J09 (FS86-B1-LR), J21 (FS86-CL1) |
| `plans/STUB-de-grey-chain-kernel.md` (FS-87) | J04's stripe skeleton, J16 (in progress) |
| `plans/STUB-isometric-measure-rigidity.md` (FS-89) | J01, J03a, J07, J10 |
| `plans/STUB-band-rigidity-six.md` (FS-91) | all of M1 |
| `plans/FS91-character-local-global.md`, `plans/M2-kernel-lane.md`, `plans/M3-exotic-colourings.md` | each crunch milestone's plan: its jobs' records, tools, data, reports, inventory |
| `plans/FS89-rational-band-rigidity.md`, `plans/FS86-dyadic-rigidity.md`, `plans/FS81-quadratic-four-colours.md`, `plans/FS79-invariant-question.md` | the closed milestones whose derivation entries today's work extends or corrects |

Before this stage none of the 16 stubs and none of the four closed plans held any pointer to today's records (checked at `HEAD` = `a78991d2`,
before the edits: zero matches for the crunch records' paths); the three crunch plans held some.

**Correction-owed banners** — one line each, `> **Correction owed (2026-09-25 crunch):** see <source>; carried in <inventory> <rows>. Not
applied here; the close rewrites this entry.`, inserted at:

| file | entry | source of the correction | inventory row |
|---|---|---|---|
| `plans/FS89-derivation.md` | the Notation paragraph | `plans/FS91-S0V2-SWm-second-reading.md` §3.4, §3.7; `plans/FS91-S1D-character.md` §4.4 | FS91 61, 69, 78 |
| `plans/FS89-derivation.md` | FS89-CL2 | the same (J03a-9, J07-14) | FS91 61, 69, 78 |
| `plans/FS89-derivation.md` | FS89-S0A-10 ("finite, not computed, at five") | `plans/FS91-S1D-six.md` stage 6 (J08-11) | FS91 85 |
| `plans/FS86-derivation.md` | FS86-B1-LR (Lemma R's Galois scope) | `plans/FS91-S1D-character.md` §2.4; `plans/FS91-S0FV-three-colours-blind.md` §2.2; `plans/FS91-S1V-character.md` §3.2 | FS91 13, 73, 78 |
| `plans/FS86-derivation.md` | FS86-CL1 | `plans/M3-S1D-windows-five.md` §2.5, §4.6 | M3 18 |
| `plans/FS81-derivation.md` | T6 (its open item) | `plans/FS91-S0FV-three-colours-blind.md` §2.5 | FS91 15 |
| `plans/FS91-S0F-three-colours.md` (J02, closed) | §2.10 | `plans/FS91-S0FV-three-colours-blind.md` §5 item 1 | FS91 113 |
| `plans/FS91-S1D-six.md` (J08, closed) | stage 5, the ℚ(√167) bullet | `plans/FS91-S1V-six.md` stage 4 | FS91 109 |
| `plans/FS91-S1D-character.md` (J07, closed) | §3.3 (g3) | `plans/FS91-S1V-character.md` §3.1 item 19, §4 row 10 | FS91 105 |
| `plans/FS91-S1D-character.md` (J07, closed) | §3.1 (CLG_k's "Hence") | `plans/FS91-S1V-character.md` §2.3, §4 row 6 | FS91 89 |
| `plans/FS91-character-local-global.md` (M1 plan) | §S, SIX-e | `plans/FS91-S1V-six.md` stages 3–4 | FS91 110 |
| `plans/M2-kernel-lane.md` (M2 plan) | §2.1 | `plans/M2-S1K-chain.md` stages 1, 3 | M2 23 |
| `plans/M2-kernel-lane.md` | §2.2 | `plans/M2-S2K-route-c.md` §1.1 | M2 32 |
| `plans/M2-kernel-lane.md` | §2.3 | `plans/M2-S1D-bridge.md` §1.1 (Q5–Q7) | M2 14 |
| `plans/M3-exotic-colourings.md` (M3 plan) | §PA.1 | `plans/M3-S1D-windows-five.md` §1.1 (Q7) | M3 19 |
| `plans/M3-exotic-colourings.md` | §S | `plans/M3-S1A-rank-one.md` §2.4 | M3 9 |
| `plans/M3-exotic-colourings.md` | §M | `plans/M3-S1A-rank-one.md` §2.1, §2.4; `plans/M3-S1D-windows-five.md` §3.6 | M3 9, 10, 20 |

Control: `tools/fs71_ledger_b_check.py --strict` still reads `RESULT: PASS` (544 theorems in 59 derivation files) after the banners.
Stubs carry their corrections owed inside the pointer block, as an inventory address (FS-39 row 13 of M2; FS-82 rows 8, 15 of FS91).

### 4.2 Close inventories cross-checked; lines added (the owner's pen)

Every result under a record's "Theorems this phase proved" heading, and every correction owed and held item in a record or report, was
checked for an inventory line (by id, or by a line that states it). Missing ones were appended, each with the source suffix "added by
J30's cross-check, 2026-09-25", status `open`:

| inventory | rows added | what they cover |
|---|---|---|
| `plans/FS91-close-inventory.md` | 95–117 (23) | theorems not yet carried (J01-1; J02-L1–L4, A2.1′; J03a-6; J07-1, 2, 5, 6; J09's J1, J3, J4-C, J4-A, J2′, J-L4b; J10's phase-2 lemmas and results L2–L8, T6, T7, T9); the J10 final report's (g3) correction (105); J11's report in full (106–112); stage 2 §2.4's uncarried corrections and held items (113–116); J09's stub line (117) |
| `plans/M2-close-inventory.md` | 29–36 (8) | J15's report in full (29–34); J14's FS-45 re-aim (35); J17's theorems table by id (36) |
| `plans/M3-close-inventory.md` | 8–28 (21) | J18's report in full (8–15); J21's report in full (16–24, 26); J21's theorems not in its report lines (25); J06's held item (27); the missing theorems heading (28) |

Stage 2 §2.4 and stage 3 §3.4, §3.7 marked these "added in stage 4"; their rows: FS91 #6 → 113, #8 → 105, #9 → 109, #10 → 110, #12's C0
remark → 116, #15 → 114, #16's one-mind half → 115; M2 #5 → 32, #6 → 33, #12 → 34, #13 → 35; M3 #2's § B scan → 27, #3 → 9, #4 → 10, #5 →
15, #6 → 18, #7 → 19, #8 → 20, #9 → 26, #10 → 28.

**Duplication risk:** the clerk has not folded the reports of J10 (final), J11, J15, J18 and J21 (`FOLDED.txt`); when it does, it will
append their INVENTORY lines a second time. This job did not touch `FOLDED.txt` or the queue (the clerk's).

### 4.3 The reverse index

For every older item today's work mentions, where. Generated by a script (kept at `data/crunch-2026-09-25/j30-reverse-index.py`) from the crunch records, plans and reports (35 files;
the close inventories and this job's own report excluded). A mention is a bearing candidate, not a verdict; the pointer blocks above are
the curated subset.

**Stubs** (every mention of `FS-NN` in a crunch record, plan or report; the stub file is the one whose text names that number).

| stub | file | crunch addresses (file:lines) |
|---|---|---|
| FS-37 | `STUB-field-level-criteria.md` | `M2-kernel-lane`:329 |
| FS-39 | `STUB-plane-bridge.md` | `reports/J03`:34; `reports/J04`:5,15; `reports/J15`:11; `reports/J17`:6; `FS91-S0F-three-colours`:276; `FS91-S0FV-three-colours-blind`:186,197,338; `FS91-S1D-character`:195; `FS91-character-local-global`:114; `M2-S1D-bridge`:3,16,42,335,345…; `M2-S2K-route-c`:1,24,194,208,214…; `M2-kernel-lane`:1,5,6,9,99… |
| FS-45 | `STUB-chain-theorem.md` | `reports/J04`:14; `reports/J14`:12; `FS91-S0F-three-colours`:27,280; `M2-S1K-chain`:1,167,193,197,198; `M2-kernel-lane`:1,5,9,21,537 |
| FS-47 | `STUB-unit-vector-ring-kernel.md` | `reports/J04`:2,16,19; `reports/J07`:12; `FS91-S1D-character`:385; `M2-S1K-chain`:84; `M2-S3K-unit-ring`:1,24; `M2-kernel-lane`:1,6,11,22,28… |
| FS-48 | `STUB-biquadratic-table.md` | `reports/J09`:10; `FS91-S0FV-three-colours-blind`:258 |
| FS-49 | `STUB-distance-two-gadget.md` | `M2-kernel-lane`:61,502 |
| FS-53 | `—` | `reports/J17`:7; `FS91-S1D-character`:317; `FS91-S1V-character`:166,209,255; `FS91-S1V-six`:155; `M2-S1D-bridge`:42,389 |
| FS-54 | `STUB-sixth-colour.md`, `STUB-twenty-seven.md` | `FS91-S0FV-three-colours-blind`:198; `FS91-S1D-character`:239 |
| FS-59 | `STUB-four-colours-167.md` | `reports/J08`:7,9; `FS91-S1D-six`:331 |
| FS-64 | `STUB-adelic-window-colouring.md` | `reports/J06`:6,9; `reports/J08`:7,9; `reports/J21`:12; `FS91-S1D-six`:331; `M3-S1D-windows-five`:181,186; `M3-exotic-colourings`:1,5,49,138,232… |
| FS-66 | `STUB-residue-tower-drop.md` | `reports/J07`:2; `FS91-S1D-character`:315,317,321,371,379; `FS91-S1V-character`:166,176,177,200,209…; `FS91-S1V-six`:155; `M3-S1D-windows-five`:103,157; `M3-exotic-colourings`:61,488,583 |
| FS-68 | `STUB-tower-never-rises.md` | `FS91-character-local-global`:117 |
| FS-70 | `STUB-five-over-sqrt3-sqrt5.md` | `FS91-character-local-global`:208; `M2-kernel-lane`:190 |
| FS-73 | `STUB-rigidity-dichotomy.md` | `FS91-character-local-global`:30 |
| FS-75 | `STUB-three-colour-criterion-kernel.md` | `reports/J02`:9; `reports/J09`:10; `FS91-S0F-three-colours`:457; `FS91-S0FV-three-colours-blind`:259; `M2-kernel-lane`:193 |
| FS-76 | `STUB-four-colour-inheritance.md` | `reports/J06`:9; `reports/J18`:11; `M3-S1A-rank-one`:1,34,369; `M3-S1B-rank-one`:1; `M3-exotic-colourings`:1,5,399 |
| FS-79 | `STUB-invariant-question-four-colours.md` | `reports/J18`:6,9; `M3-S1A-rank-one`:14,34,39,142,173…; `M3-exotic-colourings`:19,35,372,373 |
| FS-80 | `STUB-window-frequency-certificate.md` | `M3-exotic-colourings`:147 |
| FS-81 | `STUB-quadratic-four-colour-classification.md` | `FS91-S0F-three-colours`:68,405; `FS91-S0FV-three-colours-blind`:18,41 |
| FS-82 | `STUB-three-colours-residue-degree-three.md` | `reports/J02`:6; `reports/J03`:16,33; `reports/J09`:8,10; `FS91-S0F-three-colours`:26,51,53,316,354…; `FS91-S0FV-three-colours-blind`:255,257; `FS91-character-local-global`:50,58,112,204,379… |
| FS-83 | `STUB-layer-method-five-colours.md` | `FS91-character-local-global`:315 |
| FS-86 | `STUB-dyadic-rigidity-triangle-free.md` | `reports/J07`:9; `FS91-S1D-character`:284; `FS91-character-local-global`:22; `M3-exotic-colourings`:21 |
| FS-87 | `STUB-de-grey-chain-kernel.md` | `reports/J04`:16; `M2-S3K-unit-ring`:1; `M2-kernel-lane`:1,5,10,22,51… |
| FS-89 | `STUB-isometric-measure-rigidity.md` | `reports/J03a`:10; `reports/J07`:8; `FS91-S0FV-three-colours-blind`:26; `FS91-S0V-band-to-nine`:5,28,279; `FS91-S0V2-SWm-second-reading`:33,34,37,91,93…; `FS91-S1D-character`:19,315; `FS91-S1D-one-prime`:48,80; `FS91-S1V-character`:23,27,45,257; `FS91-character-local-global`:29,402,430; `M3-exotic-colourings`:25 |
| FS-91 | `STUB-band-rigidity-six.md` | `reports/J01`:7,10; `reports/J02`:9; `reports/J03`:14; `FS91-S0F-three-colours`:1,459; `FS91-S0FV-three-colours-blind`:1,5; `FS91-S0V-band-to-nine`:1,12,289; `FS91-S0V2-SWm-second-reading`:1; `FS91-S1D-character`:1,3,385; `FS91-S1D-one-prime`:1; `FS91-S1D-six`:1; `FS91-S1V-character`:1; `FS91-S1V-six`:1; `FS91-character-local-global`:1,3,589 |

**Ledger rows** (mentions outside the three plans' re-grokking walks, §G.1–§G.3, which name every row by design; table-row and `§`-row references filtered out).

| row | crunch addresses |
|---|---|
| 14 | `M2-kernel-lane`:335 |
| 19 | `M3-exotic-colourings`:347 |
| 23 | `M2-kernel-lane`:282 |
| 32 | `M2-kernel-lane`:304 |
| 33 | `reports/J11`:9; `FS91-S1V-six`:251; `M2-S1D-bridge`:24,200,279; `M3-S1D-windows-five`:411; `M3-exotic-colourings`:333,335 |
| 45 | `M2-S1K-chain`:150; `M2-kernel-lane`:266; `M3-S1A-rank-one`:41,155; `M3-exotic-colourings`:331,557 |
| 50 | `FS91-S1D-six`:227; `FS91-character-local-global`:309 |
| 52 | `FS91-S0F-three-colours`:38,216,234,288,350; `FS91-S0FV-three-colours-blind`:16,167,198,206,282… |
| 53 | `reports/J08`:8; `FS91-S1D-six`:17; `FS91-S1V-six`:105 |
| 57 | `reports/J04`:7; `FS91-S0F-three-colours`:288,289; `FS91-S0FV-three-colours-blind`:180,195; `M2-S1K-chain`:150; `M2-S3K-unit-ring`:85; `M2-kernel-lane`:329,366,396,512 |
| 58 | `M2-kernel-lane`:265 |
| 63 | `FS91-S0F-three-colours`:27,291; `FS91-S1D-character`:300; `FS91-character-local-global`:306,314; `M2-S2K-route-c`:40,156; `M2-kernel-lane`:267,314 |
| 66 | `M3-exotic-colourings`:331 |
| 68 | `reports/J08`:8; `FS91-S1D-six`:17,37,152; `FS91-character-local-global`:308 |
| 69 | `reports/J03`:7; `reports/J08`:7; `reports/J11`:11; `FS91-S1D-six`:37,95,97,152,213…; `FS91-S1V-six`:22; `FS91-character-local-global`:308,309; `M3-S1D-windows-five`:23,69,215 |
| 70 | `FS91-S1D-six`:157,315; `FS91-S1V-six`:164,249 |
| 71 | `M3-exotic-colourings`:333 |
| 72 | `M3-exotic-colourings`:334 |
| 75 | `FS91-S1D-six`:17,164; `FS91-character-local-global`:23,312; `M3-S1D-windows-five`:17,70,90,169,219… |
| 78 | `M3-exotic-colourings`:372 |
| 79 | `FS91-S1V-six`:251; `FS91-character-local-global`:330 |
| 80 | `M3-exotic-colourings`:330 |
| 82 | `FS91-S0F-three-colours`:309,316,439,450; `FS91-S0FV-three-colours-blind`:17,18,212,344 |
| 86 | `M3-S1A-rank-one`:42; `M3-exotic-colourings`:332,565 |
| 88 | `FS91-S1D-character`:23; `FS91-S1V-character`:27; `FS91-character-local-global`:303,314 |
| 89 | `FS91-S1D-character`:177,301; `FS91-S1V-character`:22,153; `FS91-character-local-global`:305,452 |
| 91 | `M3-exotic-colourings`:331 |
| 92 | `reports/J21`:7; `FS91-character-local-global`:301; `M3-S1D-windows-five`:471 |
| 94 | `FS91-S1D-character`:302; `FS91-S1V-character`:22,159; `FS91-character-local-global`:306,452; `M3-exotic-colourings`:335 |
| 95 | `reports/J01`:7; `reports/J03a`:14; `reports/J07`:11; `FS91-S0F-three-colours`:25,37,68; `FS91-S0V-band-to-nine`:29,33,50,259,287…; `FS91-S0V2-SWm-second-reading`:251; `FS91-S1D-character`:19,320,378; `FS91-S1D-one-prime`:80; `FS91-S1V-character`:18,124,163,165,176; `FS91-character-local-global`:436,544; `M2-kernel-lane`:268 |
| 96 | `FS91-S0V-band-to-nine`:50; `FS91-S0V2-SWm-second-reading`:251; `FS91-S1D-character`:320,379; `FS91-S1V-character`:22,162,165,169; `FS91-S1V-six`:155,183; `FS91-character-local-global`:21,306,409,453,554 |
| 97 | `FS91-S0V-band-to-nine`:42,50,115,265; `FS91-S0V2-SWm-second-reading`:251; `FS91-character-local-global`:21,45,315 |

**Grokkings** (the same exclusion; lines naming FS-89's gluing lemmas G0–G3 filtered out).

| grokking | crunch addresses |
|---|---|
| G1 | `FS91-S0V-band-to-nine`:159,181,195,260; `FS91-S0V2-SWm-second-reading`:272; `FS91-S1D-character`:300; `FS91-character-local-global`:306 |
| G4 | `reports/J14`:2,12,13; `M2-S1K-chain`:23,35,50,131,146…; `M2-S3K-unit-ring`:83,96; `M2-kernel-lane`:386,429,469,511 |
| G13 | `M3-exotic-colourings`:42,331 |
| G21 | `FS91-character-local-global`:323; `M2-S1D-bridge`:106; `M3-S1A-rank-one`:49,61,281; `M3-S1B-rank-one`:54; `M3-S1D-windows-five`:378; `M3-exotic-colourings`:343 |
| G22 | `M3-exotic-colourings`:333,355 |
| G24 | `M3-exotic-colourings`:60,333,356 |
| G27 | `M3-exotic-colourings`:69 |
| G30 | `FS91-S1D-character`:354; `M2-kernel-lane`:265,266 |
| G35 | `FS91-S1D-six`:196 |
| G38 | `FS91-S0FV-three-colours-blind`:255; `M2-kernel-lane`:267 |
| G41 | `FS91-character-local-global`:305 |
| G42 | `M3-exotic-colourings`:331 |
| G43 | `FS91-character-local-global`:301; `M3-exotic-colourings`:60,333 |
| G44 | `FS91-S0F-three-colours`:82,166; `FS91-S1D-six`:152; `FS91-S1V-six`:96,176 |
| G46 | `M2-kernel-lane`:280; `M3-exotic-colourings`:330 |
| G48 | `reports/J02`:6; `reports/J06`:2; `FS91-S0F-three-colours`:452; `M2-kernel-lane`:419 |
| G49 | `M3-exotic-colourings`:343 |
| G50 | `FS91-character-local-global`:304 |
| G51 | `FS91-character-local-global`:426 |
| G54 | `reports/J10`:5; `FS91-S1D-character`:242,370; `FS91-S1V-character`:250,307,359; `FS91-character-local-global`:308; `M3-exotic-colourings`:63 |
| G55 | `reports/J02`:6; `FS91-S0F-three-colours`:27,291,316,450,453; `FS91-S0FV-three-colours-blind`:18,35,138,154,167…; `FS91-S1D-character`:104; `FS91-character-local-global`:37,303; `M2-S1K-chain`:31,174; `M2-S3K-unit-ring`:19,78,115; `M2-kernel-lane`:25 |
| G56 | `reports/J03`:2; `reports/J08`:7; `FS91-S0F-three-colours`:83,166,288; `FS91-S0FV-three-colours-blind`:129,138,154,165,171…; `FS91-S1D-character`:218,235,239,254,370; `FS91-S1D-six`:106,152,328; `FS91-S1V-character`:111,123,146,147,250…; `FS91-S1V-six`:22; `M2-S1D-bridge`:42,375; `M2-kernel-lane`:342 |
| G59 | `reports/J08`:7; `FS91-S0F-three-colours`:311; `FS91-S1D-six`:328; `M3-exotic-colourings`:24,60 |
| G61 | `FS91-S0FV-three-colours-blind`:255 |
| G63 | `reports/J04`:5; `reports/J15`:8; `reports/J17`:6; `FS91-S0F-three-colours`:276; `FS91-S0FV-three-colours-blind`:181,186,196,197,338…; `M2-S1D-bridge`:264,297,299,358; `M2-S2K-route-c`:24,33,154,207; `M2-kernel-lane`:347,474 |
| G64 | `reports/J08`:7; `FS91-S1D-character`:381; `FS91-S1D-six`:223,328; `FS91-character-local-global`:21,408; `M2-S1D-bridge`:286,288; `M2-kernel-lane`:418 |
| G66 | `FS91-character-local-global`:312; `M3-exotic-colourings`:61 |
| G71 | `FS91-S1D-character`:6; `FS91-S1D-six`:6; `FS91-S1V-six`:76 |
| G74 | `reports/J02`:6; `reports/J03`:2; `FS91-S0F-three-colours`:316,451,453; `FS91-S0FV-three-colours-blind`:254; `FS91-character-local-global`:508 |
| G76 | `FS91-S0V2-SWm-second-reading`:251; `FS91-S1D-character`:380; `FS91-S1D-six`:330 |

**FS-89's derivation entries and records** (`plans/FS89-derivation.md` ids; file names of FS-89's records are listed as files).

| entry | crunch addresses |
|---|---|
| `FS89-CL2` | `reports/J03a`:7; `reports/J07`:11; `FS91-S0F-three-colours`:21; `FS91-S0V2-SWm-second-reading`:216,250; `FS91-S1D-character`:311,319,378 |
| `FS89-CL3` | `FS91-S1D-character`:306,373 |
| `FS89-D1-L2` | `FS91-S0V2-SWm-second-reading`:118 |
| `FS89-D1-L4` | `FS91-S0V2-SWm-second-reading`:37 |
| `FS89-PA-B2` | `FS91-S0V2-SWm-second-reading`:29 |
| `FS89-PA-berend1984` | `reports/J01`:8; `FS91-S0V-band-to-nine`:9,24,25,26,27… |
| `FS89-S0A-1` | `M2-kernel-lane`:109,209 |
| `FS89-S0B-T3` | `FS91-S1D-one-prime`:18 |
| `FS89-S0B-band` | `reports/J01`:9; `FS91-S0V-band-to-nine`:52; `FS91-S1D-one-prime`:21 |
| `FS89-S1D-derivation` | `FS91-S1D-one-prime`:22 |
| `FS89-S1V-verification` | `reports/J01`:9; `FS91-S0V-band-to-nine`:52 |
| `FS89-S1VB-14` | `reports/J03a`:10; `FS91-S0V2-SWm-second-reading`:34 |
| `FS89-S1VB-2` | `FS91-S0V2-SWm-second-reading`:24 |
| `FS89-S1VB-4` | `FS91-S0V2-SWm-second-reading`:25 |
| `FS89-S1VB-6` | `FS91-S0V2-SWm-second-reading`:26 |
| `FS89-S1VB-7` | `FS91-S0V2-SWm-second-reading`:27 |
| `FS89-S1VB-verification` | `FS91-S0V-band-to-nine`:50,135,141; `FS91-S0V2-SWm-second-reading`:5,65,126 |
| `FS89-close-inventory` | `FS91-S0V-band-to-nine`:11 |
| `FS89-derivation` | `reports/J01`:8; `reports/J03a`:7; `FS91-S0F-three-colours`:7,21; `FS91-S0V-band-to-nine`:10,24,25,26,283; `FS91-S0V2-SWm-second-reading`:5,24,30,248; `FS91-S1V-character`:27; `FS91-character-local-global`:24 |
| `FS89-rational-band` | `FS91-S0V-band-to-nine`:6,28; `FS91-S1D-one-prime`:18; `FS91-S1V-character`:23; `M2-kernel-lane`:5,27 |

**Earlier derivation entries** (ids of `plans/FS<nn>-derivation.md` and the other milestones' records).

| entry | crunch addresses |
|---|---|
| `FS39-T1` | `M2-S1D-bridge`:174,296 |
| `FS54-T2` | `FS91-character-local-global`:28 |
| `FS54-T5` | `M3-exotic-colourings`:230 |
| `FS62-T2` | `M2-S1D-bridge`:277,279,288,342,354…; `M2-kernel-lane`:99,418,442 |
| `FS62-derivation` | `M2-S1D-bridge`:410 |
| `FS66-T8` | `M3-S1D-windows-five`:121,213 |
| `FS73-T22` | `FS91-S0F-three-colours`:24,77; `FS91-S0FV-three-colours-blind`:153,171,194; `FS91-character-local-global`:29 |
| `FS73-T24` | `M3-S1A-rank-one`:216,241; `M3-S1B-rank-one`:34 |
| `FS73-T30` | `reports/J06`:5; `M3-S1A-rank-one`:37,40,43,143,312; `M3-exotic-colourings`:20,413,545,582 |
| `FS73-T40` | `FS91-S0F-three-colours`:426 |
| `FS73-derivation` | `FS91-S0F-three-colours`:24; `M3-S1A-rank-one`:37; `M3-exotic-colourings`:20 |
| `FS79-C-deBruijn` | `M3-S1A-rank-one`:143,262 |
| `FS79-T30` | `reports/J06`:5; `M3-S1A-rank-one`:37 |
| `FS79-T34` | `M3-S1A-rank-one`:36; `M3-S1B-rank-one`:34; `M3-exotic-colourings`:469,553 |
| `FS79-T35` | `M3-S1A-rank-one`:35,39; `M3-exotic-colourings`:453,536 |
| `FS79-T6` | `M3-exotic-colourings`:31,79 |
| `FS79-derivation` | `M3-S1A-rank-one`:35,36,37; `M3-exotic-colourings`:20 |
| `FS81-T1` | `FS91-S0F-three-colours`:90; `FS91-character-local-global`:29 |
| `FS81-T2` | `reports/J02`:9; `FS91-S0F-three-colours`:24,40,77,230,251…; `FS91-S0FV-three-colours-blind`:153,166,171,194,198… |
| `FS81-T3` | `FS91-S0F-three-colours`:23,78,85,426,467; `FS91-S0FV-three-colours-blind`:63,65,153,171,194…; `FS91-S0V-band-to-nine`:170 |
| `FS81-T4` | `reports/J02`:2; `FS91-S0F-three-colours`:32,79,90,264,428; `FS91-S0FV-three-colours-blind`:39,61,68,273 |
| `FS81-T5` | `FS91-S0F-three-colours`:53 |
| `FS81-T6` | `reports/J09`:8; `FS91-S0F-three-colours`:360; `FS91-S0FV-three-colours-blind`:157,331,372 |
| `FS81-T7` | `FS91-S0FV-three-colours-blind`:60; `FS91-character-local-global`:214 |
| `FS81-derivation` | `FS91-S0FV-three-colours-blind`:158,256 |
| `FS85-dB1` | `M3-S1B-rank-one`:34; `M3-exotic-colourings`:565 |
| `FS85-dB2` | `M3-S1A-rank-one`:42; `M3-exotic-colourings`:246,300,317,414,545… |
| `FS85-derivation` | `M2-kernel-lane`:23,85 |
| `FS86-B1-LD` | `FS91-S1D-character`:371 |
| `FS86-B1-LR` | `reports/J07`:11; `FS91-S0F-three-colours`:42,64; `FS91-S0FV-three-colours-blind`:45,99,160,256,359; `FS91-S1D-character`:111,187,384; `FS91-S1V-character`:69,284; `FS91-character-local-global`:29,447 |
| `FS86-CL1` | `reports/J21`:7; `M3-S1D-windows-five`:61,205,471; `M3-exotic-colourings`:22,23,434,473 |
| `FS86-CL2` | `FS91-S0FV-three-colours-blind`:100,298; `FS91-S1D-character`:26,111,350; `FS91-S1V-character`:154; `M2-kernel-lane`:111,202 |
| `FS86-Cx-C14` | `M3-S1D-windows-five`:60; `M3-exotic-colourings`:473 |
| `FS86-Cx-C9` | `M3-S1D-windows-five`:73 |
| `FS86-LP` | `FS91-S1D-character`:255; `FS91-S1V-character`:308; `M3-S1D-windows-five`:63 |
| `FS86-dB-H` | `reports/J06`:11; `reports/J18`:7; `M3-S1A-rank-one`:14,43,142,335,368; `M3-S1B-rank-one`:34; `M3-exotic-colourings`:541 |
| `FS86-derivation` | `FS91-S1D-character`:384; `M3-S1D-windows-five`:60,471; `M3-exotic-colourings`:22 |

## Stage 5 — SAVED (proposed pointers for the front-page job; the report)

### 5.1 Proposed pointers for the front-page job

This job edits none of `CLAUDE.md`, `LEDGER.md`, `plans/FRONTIER-STUBS.md`, `BIBLIOGRAPHY.md`. Each line below is proposed verbatim;
where it is a state change rather than a pointer, it says so, and the front-page lane decides. **`CLAUDE.md` is loaded by every agent,
blind verifiers included**, so every line proposed for it is address-only.

**`CLAUDE.md`**

| # | where | proposed text | kind |
|---|---|---|---|
| C1 | § Frontier, after the `*Last updated: 2026-09-25 …*` paragraph (line 137) | `*The 2026-09-25 crunch runs three milestones — M1 (FS-91, `plans/FS91-character-local-global.md`), M2 (the kernel lane, `plans/M2-kernel-lane.md`), M3 (colourings no character gives, `plans/M3-exotic-colourings.md`) — and its work is indexed in `plans/CRUNCH-2026-09-25-INDEX.md` (results; blind verifiers do not open it); none of it is in this file until each milestone closes.*` | pointer |
| C2 | § Paths forward, "**Open milestones, in order.** **None is open.**" (line 270) | replace "**None is open.**" with "**Three are open, as the 2026-09-25 crunch** (queue `plans/CRUNCH-2026-09-25-queue.md`, index `plans/CRUNCH-2026-09-25-INDEX.md`): M1 = FS-91, M2 = the kernel lane (FS-45, FS-39, FS-47, FS-87), M3 = FS-76 in rank one and FS-64 at five colours." | state change |
| C3 | § Trust ledger, "the current audit reads 1034 clean and 5 declared purchases" | update at M2's close from the last kernel job's `axioms.log` (J15's reads 1056 clean / 5 purchases, `data/m2/j15/axioms.log`; J16 is still adding); M2 inventory rows 22, 33 | correction owed (pointer) |
| C4 | § The gate, the vacuity counts line | the same, from `data/m2/j15/vacuity.log` (M2 inventory row 33) | correction owed (pointer) |

**`LEDGER.md`**

| # | where | proposed text | kind |
|---|---|---|---|
| L1 | the header paragraph, after "…the story goes to git.*" | `*Work of the 2026-09-25 crunch not yet folded into rows is indexed in `plans/CRUNCH-2026-09-25-INDEX.md`, with its items in `plans/FS91-close-inventory.md`, `plans/M2-close-inventory.md` and `plans/M3-close-inventory.md`.*` | pointer |
| L2 | row 95, at its end | `Corrections owed: `plans/FS91-close-inventory.md` rows 3, 61, 69, 70, 78.` | pointer |
| L3 | row 92, at its end | `Correction owed: `plans/M3-close-inventory.md` row 18.` | pointer |
| L4 | rows 96 and 82 | `Re-derivations and extensions since: `plans/FS91-close-inventory.md` rows 75, 87, 92.` (row 96); `Extended to every real number field: `plans/FS91-close-inventory.md` rows 7, 8.` (row 82) | pointer |

**`plans/FRONTIER-STUBS.md`**

| # | where | proposed text | kind |
|---|---|---|---|
| F1 | § Open milestones, after "**No FS milestone is open. …**" (line 27) | `**The 2026-09-25 crunch** holds three milestones open: M1 = FS-91 (rank 2 below; `plans/FS91-character-local-global.md`), M2 = the kernel lane (FS-45, FS-39, FS-47, FS-87; `plans/M2-kernel-lane.md`), M3 = FS-76 in rank one and FS-64 at five colours (`plans/M3-exotic-colourings.md`); index `plans/CRUNCH-2026-09-25-INDEX.md`.` | pointer (and a state change to "No FS milestone is open") |
| F2 | § Ranked stubs, under the re-ranking line (line 37) | `*Stubs with unfolded 2026-09-25 crunch work carry a closing section "Where the 2026-09-25 work on this lives": FS-39, FS-45, FS-47, FS-48, FS-59, FS-64, FS-67, FS-75, FS-76, FS-82, FS-83, FS-84, FS-86, FS-87, FS-89, FS-91.*` | pointer |
| F3 | the FS-82 row (rank 12) | `A CLOSED banner and a correction to the stub's text are owed (`plans/FS91-close-inventory.md` rows 8, 15, 117).` | pointer to a state change |

**`BIBLIOGRAPHY.md`** (the rescued papers of stage 1.5, and the keys `tools/bib_audit.py` reports as cited but undefined)

| # | where | proposed text |
|---|---|---|
| B1 | `[deGrey2018]` row (line 84), copy column "not held (arXiv)" | `library/pdf/deGrey2018-chromatic-number-plane-at-least-5.pdf` (arXiv:1804.02385v3; saved 2026-09-25 from a scratch copy) — and a § B row for the file |
| B2 | `[JanssenMacKeigan2020]`, `[Hujdurovic2020]`, `[ErskineGriggsSiran2022]` rows (lines 663–665) | add "**Held:** `library/pdf/JanssenMacKeigan2020-orthogonal-colourings-cayley-graphs.pdf`" (resp. `Hujdurovic2020-strong-cliques-vertex-transitive-graphs.pdf`, `ErskineGriggsSiran2022-clique-partitioned-graphs.pdf`), saved 2026-09-25 from FS-85's scratch; § B rows for the three files |
| B3 | `[Polymath16wiki]` row (line 181) | add "Snapshots of 2021 and 2022 held: `library/notes/polymath16-algebraic-formulation-2021-snapshot.html`, `library/notes/polymath16-algebraic-formulation-2022-snapshot.html` (saved at FS-85's audit; not re-read)" |
| B4 | new row `[GoelPatilVerma2022]` | K. Goel, D. P. Patil, J. Verma, *Nullstellensätze and Applications*, arXiv:1809.02818 (v2, 23 Feb 2022) \| J17's route AL to the bridge (its Thm 3.11, after Lang 1953) \| `library/pdf/GoelPatilVerma2022-nullstellensatze-and-applications.pdf` \| read status as J17's record states it (`plans/M2-S1D-bridge.md` §2.1, §3.4) |
| B5 | new row `[KechrisMarks2020]` | A. S. Kechris, A. S. Marks, *Descriptive graph combinatorics* (preliminary version, 9 October 2020) \| M3's question 2 (`χ_µ(ℝ²)`; Problem 4.23) \| `library/pdf/KechrisMarks-descriptive-graph-combinatorics-2020.pdf` (already held) \| read: §4.6–§4.7 (J06), §5.1 Example 5.1 (J21, which corrects the "§4.7" citation) — `plans/M3-exotic-colourings.md` §PA.3, `plans/M3-S1D-windows-five.md` §1.1 |
| B6 | new rows `[BCR1998]`, `[CohenMahboubi2012]`, `[Lang1953]`, `[Marker2002]`, `[Poizat2000]`, `[WangKosheleva1998]`, `[Zapletal2022]` | as proposed in `plans/M2-S1D-bridge.md` §3.4 (J17) |
| B7 | new row `[Zhu1998]` | as proposed in `plans/M3-exotic-colourings.md` §PA.3 (J06) |
| B8 | `[EggletonErdosSkilton1985]`, cited in `plans/M3-S1B-rank-one.md` (J19, in flight) | the defined key is `[EggletonErdosSkilton1990]` (line 298); J19 or the close reconciles the year |

### 5.2 Would-have-searched-here log

Empty: no stage of this job called for a finite-witness search.
