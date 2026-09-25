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
