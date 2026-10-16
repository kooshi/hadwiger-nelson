# Brief FS131-KPA1 — the p-adic plane at the kernel: the Borel chromatic number of the anisotropic p-adic plane is unbounded in p, and its values at 7, 11, 19 and 23 — the map, the skeleton and the price

*Written 2026-10-16 13:33 UTC by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-KPA1
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow; you run on Opus
  role: the kernel lane's planner for one hand result of ours, the p-adic Borel bound (FS66-T7) and the values beside it (ledger row 75) — the map of what it rests on, the statements in Lean, the skeleton with `sorry` at every leaf, a plan per leaf, priced in lines of Lean
  launch: now, in a worktree of your own cut from `main`; beside you two other jobs (an implementer finishing another module, and a planner of an unrelated theorem), neither of which writes a file you write
  mission: § Why this job
  statements: § The result
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage at once for a statement defect (the result false or misstated as written) or a generalization; the report goes to `data/fs131/reports/FS131-KPA1.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full (never push; everything committed may be published). Also `LEAN.md` in full, and `RUNNING.md` § Building
  record: `plans/FS131-KPA1-padic-plan.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/il5`, on its branch `fs131-kpa1` (cut from `main` at `99e78e428`; `.lake/packages` a symlink to the main tree's, `.lake/build` a copy of the main tree's build): `plans/FS131-KPA1-padic-plan.md`; skeleton modules under `Proofs/HadwigerNelson/` in files you create, each named in your record, and the import lines that bring them into `Proofs.lean`; `ARCHITECTURE.md` rows for your new modules only; your scripts and outputs under `data/fs131/kpa1/`; `data/fs131/reports/FS131-KPA1.md`. Edits to the front files (`CLAUDE.md`, `LEDGER.md`, `LEAN.md`, `BIBLIOGRAPHY.md`, `CLOSED-QUESTIONS.md`, `ROADMAP.md`, `README.md`) and to existing modules are drafted in your record, not made. Commit on your branch by explicit path; never push
  budget: about 400k by the harness's count, as guidance; save a stage after each of the stages below; hand back at a saved stage before about 500k

Hello. The library has formalized the project's results about planes over number fields one by one this week; this
one is about the p-adic plane instead, and a published question asks for it by name.

## Why this job

Kooshi's rule for what this project publishes:

> W2: (2026-10-13, answering the choice between the two publishable forms) I choose the second form. Any finding of ours must be formalized. I'd prefer to formalize the entire chain, so at some point I'd like to price the EL theorem to see what it would take to formalize as well.
> — source: data/fs131/REQUEST-2026-10-13.md

The asking lane ranked the project's findings by interest to the field. Of the three ranked above this one, two are in
the kernel and the third is being finished there (all but its density form, which waits for that module); its default
order names this one next:

> **If he says nothing:** rank 2, then rank 1 with rank 6, then rank 4.
> — source: plans/POROS-2026-10-13-number-field-findings.md § 3.5 The recommendation

An earlier triage of the derivation's theorems for the kernel declined this one, before that rule existed:

> | FS66-T7 | declined — a `CLOSED-QUESTIONS.md`-shaped consequence, not a Lean theorem |
> — source: plans/FS66-derivation.md

W2 replaces that: the bound is a finding of ours, so it is formalized.

## The result

The theorem a reader would look for, as the asking lane wrote it:

> - *The theorem.* For every prime `p ≡ 3 (mod 4)` the Borel chromatic number of the graph on `ℚ_p²` joining `x`, `y`
>   with `(x₁ − y₁)² + (x₂ − y₂)² = 1` is at least `1 + (p + 1)/(2√p)`; so it is not bounded in `p`. It is 4 at
>   `p = 7`, 5 at `p = 11` and `p = 19`, and between 6 and 8 at `p = 23`.
> — source: plans/POROS-2026-10-13-number-field-findings.md § 3.3 The first ten, each as the theorem a reader would look for

The objection it must meet, from the same entry:

> - *The first objection.* "Why did the posers not see it?" — the statement must show the one new step, the bound at
>   levels two and above. And the plain chromatic number is untouched: the Lean statement must say Borel.
> — source: plans/POROS-2026-10-13-number-field-findings.md § 3.3 The first ten, each as the theorem a reader would look for

The values and the tower, as the ledger states them now (its row 75, quoted whole; the kernel already holds
`χ(UD(ℤ/121, 2)) = 5`):

> | 75 | **The residue ceiling does not drop up the tower at 7, 11, 19 or 23 — one level-one inequality governs every level** (FS-66). **[kernel]** `chromaticNumber_unitQuadrance_zmod121 : (unitQuadrance (ZMod 121)).chromaticNumber = 5` on the standard three axioms — level two at 11 needs five, like level one — from an 883-point 1-minimal witness (4.4 CPU-min, 6.14 GB); the generic layer `unitQuadrance_colorable_of_ringHom`, `chromaticNumber_unitQuadrance_zmod_le_of_dvd`, `unitPairNat`, `unitPairNat_eq_true_iff`, `unpackPt`; the pilot, `UD(ℤ/121,2)` (14,641 vertices, built by FS-38, asked only at five colours before; floor 4 by ℚ(√47)'s certified graph), refused four colours in 1.7 s, triangle pinned. **[hand]** *The fibre-share inequality:* a character of `G_k` of exact level ≥ 2 has `\|λ\| ≤ 2p^{k−1}` (the character sum over a fibre `{s(1 + p^{k−1}·i·a)}` of `S_k → S_{k−1}` vanishes off at most two residues), so the fibre shares `φ ∈ [0,1]^{𝔽_p²}` over level one of an independent set of `G_k` obey `⟨φ, A₁φ⟩ ≤ 2Σφ(1−φ)`; with `B₁(p) = max Σφ` under it, `α(G_k) ≤ B₁·p^{2(k−1)}` and **`m·B₁ < p²` refuses m colours at every level at once**. **[cert]** Exact integer sum-of-squares certificates (format `fs66-b1-cert-v2`) of the second-level moment relaxation of `B₁`, its symmetry divided out by translation-Fourier blocks, each `CERTIFIED` by a frozen standard-library checker written from the specification (exit 0 / 3 BOUND ONLY / 2 ERROR; sha256 `735b9267…`), re-run by the owner with plants refused, joined to the statement by hand links L1–L6: **`U = 14.015224` (7), `28.204320` (11), `77.511742` (19)** against 49/3, 121/4, 361/4, **`97.984637` (23)** against 529/5 (rounded from the 6,000-iteration GPU checkpoint, `res_dual 1.9e−03`, loss 0.417) — **no level at 11 or 19 is four-colourable, none at 7 three-colourable, none at 23 five-colourable**; `α(UD(ℤ/49,2)) = 686` exactly, `3,388 ≤ α(UD(ℤ/121,2)) ≤ 3,412`, `27,436 ≤ α(UD(ℤ/361,2)) ≤ 27,981`, and **`α(Γ₁₉) ∈ {76, 77}`** (was [76, 80]), and **`α(Γ₂₃) ≤ 97`** (was 105; bracket [87, 97]; `46,023 ≤ α(UD(ℤ/529,2)) ≤ 51,833`). **Consequences:** `χ_Bor(ℚ_p²) = 4, 5, 5` at 7, 11, 19 and `[BardestaniMallahiKarai2017]` Question 1 answered **no** (`χ_Bor(ℚ_p²) ≥ 1 + (p+1)/(2√p)`; `CLOSED-QUESTIONS.md` §1.8); the bracket at ℚ(√47) cannot be closed from above by residues at any depth (§1.7); `χ_Bor(ℚ₂₃²) ≥ 6` (ceiling χ(Γ₂₃) ∈ {6, 7, 8}); the prediction at ℚ(√167) survives every level of its first usable tower. **[hand, the prover's; checked by the owner]** the weighted form of *the tower never rises* is false at every p — a level-two set on one single-direction line carries `(p²−1)/(2p)` against the line's `(p−1)/2` (Lemma W); towers over a ring containing its residue field are impotent (Theorem E: the first `e` levels at a ramified place); every spectral fact and every `B₁` certificate holds for **every** twisted cover of `Γ_p` (Lemma T). **[tools]** the biclique structure of one step (between adjacent fibres, p disjoint `K_{p,p}`, lines to lines — level two is a sparse lift, 1/p of the full blow-up's edges; M59's critical cores do not lift mod p²; SAT encoding 397,972 clauses against 3.9 M) and the projection of a level-two resolution refutation onto level one. **Not claimed:** the plain `χ(ℚ_p²)`; six colours at 23 (`U < 88.17` is far off; a seven-colour search, three 10-minute arms, found nothing: `data/fs66/owner/p23-k7/`); `α(G_k) = p^{2(k−1)}α(G₁)` — **not proved** (`plans/FS66-tower-conjecture.md`); anything at 43, ℚ(√167)'s other plane below the spectral refusals (FS-69). **Prior art:** the chain `χ(F²) ≤ χ(ℚ_p²) = χ(ℤ_p²) ≤ lim_k χ(G_k) ≤ χ(G₁)` is `[Madore2015]` Prop. 3.8; the `p`-adic problem is posed by his ¶1.5 and by `[BardestaniMallahiKarai2017]`; the completely-positive exactness of measurable independence density is `[DeCorteOliveiraVallentin2022]` (statements read, proofs unread). Ours: the inequality, the certificates and their checker, every value above, the answer. | `ResidueTower.lean`, `Instances/ZMod121Four.lean`, `Instances/ZMod121Four/`, `tools/fs66_b1_cert_check.py`, `tools/fs66_b1_cert_make.py`, `tools/fs66_owner_verify.py`, `data/fs66/b1/` (`cert-p*.json`, `records.jsonl`, `level-one-sets.json`, `SOUNDNESS.md`, `README.md`), `data/fs66/witness-p11-l2-k4/`, `data/fs66/owner/`, `plans/STUB-residue-tower-drop.md`, `plans/FS66-residue-tower-drop.md`, `plans/FS66-phase2-certificate.md`, `plans/FS66-tower-conjecture.md` | FS-66 |
> — source: LEDGER.md

The derivation is `plans/FS66-derivation.md`: FS66-T7 (the Borel bound) and FS66-T8 (the tower's limit is the clopen
chromatic number of `ℤ_p²`), with the hand links L1–L6 that join the certificates to the values; the soundness note of
the certificates' checker is `data/fs66/b1/SOUNDNESS.md`, and the milestone's plan `plans/FS66-residue-tower-drop.md`
(its § PA.2 found the posers' question). The posers' paper is `[BardestaniMallahiKarai2017]` in `BIBLIOGRAPHY.md`, with
where our copy is and what of it has been read; `CLOSED-QUESTIONS.md` § 1.8 records the answer. Weil's bound is already
a declared outside theorem of this library (`StandingFive.kloosterman_bound`); whether T7 reads it in the declared form is
part of the map.

## Done means

1. **Stage 1 — the readback.** Check every quotation above against its source; restate in your record, in your own
   words, the result, each hypothesis it rests on (each printed theorem, each certificate, each hand link), and what
   the library holds; log any mismatch as a finding.
2. **Stage 2 — the map.** Each step of T7, of T8 as far as the values need it, and of L1–L6, set against what this
   library, Mathlib at our pin and the outside release under `~/source/math` hold, by declaration name and module; what is
   missing, with your estimate of each piece in lines of Lean. For each printed theorem the result reads (the posers'
   Theorem 2.5, Weil's bound): formalize it if that is about an hour of agent work, and when unsure, formalize; otherwise
   say what declaring it would take (`LEAN.md` § Assumptions, its four items). For the certificates: their size, and
   the route by which the kernel would check them with no `native_decide` (the density bound's 13,552 atoms went
   through `decide +kernel` in core-only modules; `plans/FS131-LDB1-landing.md` is that job's record), with a measured cost on
   one certificate if it is cheap to measure.
3. **Stage 3 — the skeleton and the plan.** The head statements in Lean — the Borel bound for every prime
   `p ≡ 3 (mod 4)` and its unboundedness, and the values at 7, 11, 19 and 23 that the certificates reach — read back
   aloud against the result in your record, with what is not claimed (the plain chromatic number of `ℚ_p²`); every
   missing piece as a statement with `sorry`, built through `./scripts/build.sh` under the slot; a plan per leaf; the
   price in lines of Lean in total and per module; then the experience-modeling pass on the head statements
   (`debruijn-experience-modeling`: their names and docstrings as a mathematician would cite them). Nothing with a
   `sorry` reaches `main`; the skeleton stays on your branch.
4. **The report**, in the standing rules' form, with the front-page lines your reading finds owed drafted in your
   record, each naming its slot; novelty as the ledger words it ("prior art: not found in print" where that is the
   finding), and the posers' question credited to them.

## What is yours to decide

The definitions (in particular how "Borel chromatic number" is stated over `ℚ_p²` with Mathlib's topology), the
modules' names and places, the form of every Lean statement, whether a piece is better proved as a general lemma, which
values ride in the first module, and the order of the leaves. If the result is misstated, or holds in a wider form (for
instance at every non-archimedean local field with the same anisotropy, or with a better constant), say so: a wrong
statement reported is a finding, and a better target is welcome with its price.

## The machine

This is the laptop: 12 cores, 31 GB, shared with two other jobs, one of which builds at 16 GiB. Every Lean build and
every `lake env lean` over about 2 GiB goes through the slot with this machine's settings, from inside your worktree:
`SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 6 --cpus 3 -- env MEMMAX=6G BATCH=2 ./scripts/build.sh`
(or `--mem 4 --cpus 1 -- lake env lean …` for one file); never `lake build`. When the slot waits, another job holds the
memory; on exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`)
is for iteration only, never evidence that a module is green. The worktree's `.lake/build` is its own copy; never
replace it with a symlink. `/tmp` is a tmpfs: keep anything your record cites under `data/fs131/kpa1/`.
