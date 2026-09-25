*Brief for crunch job **J03a**, milestone M1 (FS-91, `plans/STUB-band-rigidity-six.md`), blind verifier (the second reading of J01-7).
Opus 5.5, 2026-09-25. Written by J03 (`plans/FS91-character-local-global.md` §S) at the owner's request.*

Hello. You are de Bruijn (`DEBRUIJN.md`), acting as **a blind verifier**, in the Lean 4 Hadwiger–Nelson workspace
`/home/kooshi/source/lean-dir`. Read `CLAUDE.md`, `WORKFLOW.md` and `DEBRUIJN.md` from disk. **`data/crunch-2026-09-25/briefs/STANDING-RULES.md`
is part of this brief; read it in full.** I'm writing for the owner, who coordinates and reviews by artifact. The verdicts are yours.

**If your record already exists, you are resuming:** read it and this brief, check the last SAVED stage against `git log -- <record>`, and
continue at the first stage not SAVED. Redo nothing saved.

## The question, and why now

A **band character** at `k` colours is a homomorphism `θ` from a ring of Gaussian rationals to the circle `ℝ/ℤ` sending every rational
unit vector into the band `B_k = [1/k, 1 − 1/k]`; `x ↦ ⌊kθ(x)⌋` is then a proper `k`-colouring of the unit-distance graph. FS-89 proved
that at four and five colours every band character of `R_S = ℤ[i][1/p : p ∈ S]` with `|S| ≥ 2` is a torsion character plus an
archimedean one (`T + A`). Its route has exactly one step that reads the band: **Lemma SW**, a sweep over one `p`-adic digit, which works
while `k < 2p`. A stage-0 verifier of this crunch (job J01) verified the extension to `k ≤ 9` and then proposed a **multi-digit sweep,
Lemma SW-m**, which would make the band disappear from the proof altogether: rigidity at **every** number of colours. One reader has
checked it. You are the second, blind to that reader's proof.

**What either answer buys.** TRUE: the milestone's class theorem (a character colouring of a real field's plane is local at one prime) is
stated at every `k`, and FS-91's "band rigidity at six colours" question is closed on characters at every band. FALSE or GAP: the milestone
stays at `k ≤ 9`, and the step that fails is named.

**Every verdict counts, and none is preferred.** Kooshi: *"A proven theorem about why its impossible is also valid. All novel knowledge is a
success."* This is a result the project would like to be true — exactly where its recorded failure mode bites (`CLAUDE.md` G21: defects
that flatter the work survive). Audit it as hard as a counterexample you disliked. **FALSE** with a counterexample, or **GAP** with the
missing step named, is as valuable as **TRUE**.

## The statements (verbatim)

The objects are FS-89's (`plans/FS89-rational-band-rigidity.md` §0.1; `plans/FS89-derivation.md`, its "Notation, fixed once" paragraph):
`R_S`, `w_p = π_p/π̄_p`, `U_S = ⟨i⟩ × ⟨w_p : p ∈ S⟩`, `Q = ℤ[i][1/p : p ≡ 1 (4)]`, `B_k`, `Θ_k(R) = {θ ∈ Hom(R, ℝ/ℤ) : θ(U) ⊆ B_k}`, `T`,
`A` (`λ_e(x) = Re(ē x)`), `T_N`, `RS_k(S)`: `Θ_k(R_S) ⊆ T + A`, `RQ_k`: `Θ_k(Q) ⊆ T + A`, and `R̂_S`'s local coordinates `c̄` for
`c ∈ K_v` (the "pure local" elements).

**C1 — Lemma SW-m** (`plans/FS91-S0V-band-to-nine.md` line 242, "stated verbatim as proved here"):
> "Let `S` be a finite set of primes `≡ 1 (mod 4)`, `k ≥ 3`, `v | p ∈ S`, `x ∈ R̂_S`, `c₀ ∈ K_v`, `s ∈ ℤ`. Then not every `x + c̄` with
> `c ∈ c₀ + π_v^s O_v` lies in `Θ_k(R_S)`."

**C2 — the all-`k` consequence** (same record, "Verdict on the all-`k` candidate", its first bullet):
> "`RS_k(S)` for every `k ≥ 2` and every finite `S` with `|S| ≥ 2`; `RQ_k` for every `k`; and, by S0A-2's band-free gluing,
> `Θ_k(R_F) ⊆ T + A` for every `F ⊆ ℝ` at every `k`."

and its restatement there: "Equivalently: *for `|S| ≥ 2`, every character of `R_S` outside `T + A` takes values arbitrarily close to 0 on
`U_S`*." The record's theorem table gives the same claim as J01-7: "`RS_k(S)` for every `k` and `|S| ≥ 2`, `RQ_k` for every `k`, and
`Θ_k(R_F) ⊆ T + A` for every `F ⊆ ℝ` (with S0A-2)".

**Your deliverable** — a verdict TRUE / FALSE / GAP on each of:
- **C1**, Lemma SW-m, at every `k ≥ 3`;
- **C2a**, `RS_k(S)` at every `k` and `|S| ≥ 2` — i.e. that FS-89's point step (VB1, below) goes through at every band once SW-m replaces SW;
- **C2b**, `RQ_k` at every `k` (the layering, VB3 and VB4 below, at every band);
- **C2c**, `Θ_k(R_F) ⊆ T + A` for every `F ⊆ ℝ` at every `k` — including whether the gluing S0A-2 needs a torsion order bound `N` fixed in
  advance (it is stated with `T_N`), and where that `N` comes from at a general `k`.

For each, **name every line of each proof you write that reads the value of `k`**, and what it needs of `k` there. Note `k = 2`: C2 says
"every `k ≥ 2`" while C1 says `k ≥ 3`; say what holds at `k = 2`.

## Read first, from disk — the verified inputs

- `plans/FS89-derivation.md` **§1–§9a** (not §10), in particular, quoted verbatim:
  - FS89-S1VB-2: "Lemma SW: no ball of pure local translates lies in `Θ_k(R_S)`, `k ∈ {4, 5}` (a pure local sweep moves `θ(u)` through a
    coset of step `1/p ≤ 1/5`, which leaves the band)."
  - FS89-S1VB-4: "VB1: for `|S| ≥ 2`, a band point whose orbit closure meets `T + A` is in `T + A` (bands 1/4, 1/5)."
  - FS89-S1VB-6: "VB3: `RS_k(S)` ⟹ `Θ_k(R_S) ∩ T` is finite, for any nonempty `S` (non-effective: no order bound)."
  - FS89-S1VB-7: "VB4: `RS_k(S)` ⟹ `RS_k(S′)` for every `S′ ⊇ S`, finite or not; in particular RQ_k."
  - FS89-S0A-2: "G1, the gluing: `Θ_k(ℤ[U_ℚ]) ⊆ T_N + A` ⟹ `Θ_k(R_F) ⊆ T_N + A` for every subfield `F ⊆ ℝ`, at every band; the lift
    `lim 5^k·(small rep of Nθ(x/5^k))` is one real functional, and the gluing reads only `ℤ[1/5]` in each layer, never the band."
  - FS89-D1-L2 and D1-L3 (Berend's two cases; both band-free), and FS89-PA-B2's statement.
- **The verified input from this crunch** (J01's blind verdict, which the owner has accepted): PA-B2 — "for every finite `S` with `|S| ≥ 2`,
  every `U_S`-minimal closed `M ⊊ R̂_S` lies in `T + A`", TRUE, band-free. You may use it; you may also re-derive it.
- `plans/FS89-S1VB-verification.md` **§B1.0–§B1.1** — the proofs of Lemma SW, Lemma E, Lemma JC and VB1–VB4 at bands 1/4 and 1/5. These
  are FS-89's verified proofs; your job is to see which of their lines survive at a general band.
- `plans/FS89-S1V-verification.md` § V-A4 (the rank-`r` orbit model), for coordinates, if useful.
- Held papers: `~/source/library/pdf/Berend1984-minimal-sets-on-tori.pdf` and Berend's TAMS papers (`BIBLIOGRAPHY.md` `[Berend1983]`,
  `[Berend1984]`).

## Fenced until your verdicts (stage 3) are committed

These hold the other reader's proof, or routes derived from it:
- `plans/FS91-S0V-band-to-nine.md` beyond the two statements quoted above (read nothing else in it), `data/fs91/j01/`, `tools/crunch_j01_*`,
  `data/crunch-2026-09-25/reports/J01.md`, and `git log -p` / `git show` of any commit whose subject begins "J01";
- `plans/FS91-character-local-global.md` (the milestone's plan) and `plans/FS91-close-inventory.md`;
- `plans/FS89-derivation.md` §10, and `plans/FS89-PA-berend1984.md` §5 and §9 (the PA-B3 widening's argument);
- every other crunch brief, record and report except `STANDING-RULES.md` and this brief;
- every scratch directory but your own.

After stage 3's verdicts are committed you may open J01's record to write the divergence table (stage 5).

## Stages

1. **The quotation check and C0 (about 20k).** Check every quotation above against its source and log the result. Then write, before any
   derivation, a probability per claim (C1, C2a, C2b, C2c). Save.
2. **C1 blind (about 70k).** Derive or refute Lemma SW-m from its statement. Check the arithmetic of the sweep (the image of a ball under the
   local character, the choice of the expanding unit, the size of the coset step against `2/k`) with an exact tool
   `tools/crunch_j03a_*.py` in seconds, with a planted fault that fires for its own reason (standing rule 7). Save the verdict.
3. **C2a–C2c blind (about 100k).** Re-derive VB1 at a general band with SW-m in place of SW; then VB3, VB4 and the gluing at a general band.
   Name each `k`-reading line. **Report to the owner after this stage** (standing rule 9, marked STAGE 3 SAVED), because the milestone's
   class theorem waits on it.
4. **Fallback, only if a blind stage ended GAP (about 40k).** Open `plans/FS91-S0V-band-to-nine.md` **"Stage 3b", its numbered audit list
   only** (the statements of the steps; not §3.6.1–§3.6.2), and derive or refute each listed step from its statement. Save.
5. **The divergence table (about 30k).** Open J01's record and compare: every difference of truth, scope or route. Save and report.

## Record and paths

- **Record:** `plans/FS91-S0V2-SWm-second-reading.md`, with "Theorems this phase proved" (one line per theorem, grade, address) and the
  would-have-searched log (standing rule 3: the ban on finite-witness search runs to 2026-10-01; exact arithmetic of seconds checking a
  derived claim is in).
- **Data:** `data/fs91/j03a/`. **Tools:** `tools/crunch_j03a_*.py`.
- **Budget:** about 250k in the harness's count; hand back with the record saved by 320k. Agents' own counts run at 55–70 % of the harness's.
- **No children:** you may not spawn subagents, forks or workflows — delegation here is one level deep (`CLAUDE.md` § Delegation), because
  staffing is Kooshi's budget decision and the owner can only review work it knows about. If the work outgrows your context, stop at a saved
  stage and say what is left; that is a good report.
- **Report:** after stage 3 and at the end, standing rule 9's form, to `data/crunch-2026-09-25/reports/J03a.md` and to `"main"` by
  SendMessage.

Thank you.
