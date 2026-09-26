# FS-100 stage 5, wave 3 — X26B: a blind second derivation of CLS, SPC's archimedean step, and row 100's exception

*Job X26B (Coxeter, Opus 5.5), 2026-09-26, from 11:44 UTC; brief `data/crunch-2026-09-26-x2x3/briefs/X26B-cls-every-field-blind-derivation.md`
with `STANDING-RULES.md`. Stop 12:50 UTC. Working files `data/fs100/x26b/`, checks `tools/x26b_*.py`.*

## Theorems this phase proved

*(filled at stage 3)*

## Fences (the blind)

Not opened, at any point: `plans/FS100-X23D-derivation.md`, `plans/FS100-X23V-verification.md`, `data/fs100/x23d/`, `data/fs100/x23v/`,
`tools/x23d_*.py`, `tools/x23v_*.py`, reports `X23*.md`, `X29C.md`, briefs `X23*.md`, `plans/POROS-2026-09-26-x2x3-crunch.md`,
`plans/FS100-X25B-derivation.md`, `data/fs100/x25b/`, and the bodies of commits "X23D…", "X23V…", "X25B…", "X23 advisor…". **Touches: none.**
(The directory listing of `briefs/` shows the file names `X23D-…md`, `X23V-…md`, `X25B-…md`; names only, no content opened. `git status` at
launch listed the untracked paths `data/fs100/x22d/`, `data/fs100/x22v/`, `tools/x22d_checks.py`, `tools/x22v_c0.py` — X22's, not fenced, not opened.)
What I read: `CLAUDE.md`, `WORKFLOW.md`, `DEBRUIJN.md` (loaded), the brief, `STANDING-RULES.md`, the queue plan's §2 and §7
(`plans/CRUNCH-2026-09-26-x2x3-queue.md` lines 1–110, 246–345), `LEDGER.md` rows 52, 57, 66, 67, 75, 94, 99, 100, 105, 112, 113, 117,
`plans/R88-derivation.md` lines 1–100 (notation, T-A, R88-TC's scope paragraph), and the outline of `plans/FS84-SI-D-derivation.md`.

## Stage 1 — SAVED (quotation check; C0 sealed before any derivation)

### 1.1 Quotation check (standing rule 5), against `plans/CRUNCH-2026-09-26-x2x3-queue.md` §7, list X23 (lines 316–323)

| brief's quotation | source | result |
|---|---|---|
| CLS: "For every real number field `F` outside row 100's exception: T-C(A) holds at `S = ∅` iff `L(F) ≥ 5`." | line 320–321 | **verbatim** |
| CLS named risks: "`q = 27`; the dyadic `U_Q` for `Q ≥ 64`; ramified stable places; the archimedean part at `n` places." | line 321–322 | **verbatim** |
| The gloss "every stable place of `L = F(i)` has all-levels four-colour ratio `< 1/4`" | SPC, line 316–317 | **verbatim** (the parenthesis inside SPC) |
| SPC: "For every real number field `F` outside row 100's exception: if T-C(A) holds at `S = ∅` (…), then J45's A⁺ and SP-Cor hold with J45's proofs" | line 316–317 | **verbatim but truncated**: the source continues ", and, given MR, `χ(F²) ≥ 5`." The brief restricts me to the archimedean step, so the truncation narrows the task and widens nothing. Logged, not a defect. |
| "the step where `F` has `n > 2` real places **and** where `F` has a complex place" | brief only | the source's named risk is "A⁺'s archimedean step when `F` has `n = [F:ℚ] > 2` real places" (line 318); "a complex place" is the brief's addition — a widening of the task, harmless. Note: "`n = [F:ℚ] > 2` real places" in the source conflates degree and real places; a field with a complex place has `n_real < [F:ℚ]`. |
| Exception: "row 100's exception (a ramified stable dyadic place)" | `LEDGER.md` row 100: "Lemma C′: `R_F = O′` … with **no Galois hypothesis**, except possibly at a ramified stable dyadic place" | agrees in substance; the ledger says "possibly" — the exception is a gap in the proof of `R = O′`, not a proved failure. |

### 1.2 Notation used below (from the sources, fixed once)

`F ⊆ ℝ` a number field, `L = F(i)`, `c` the non-trivial automorphism of `L/F` (complex conjugation on every embedding fixing `F`), `U` the
norm-one elements of `L/F`, `R = ℤ[U]`. A place `w` of `L` is **stable** if `c(w) = w`. For a stable finite `w` over `v` of `F`: `O_w`,
`π` a uniformiser of `F_v`, `𝔽_q` the residue field of `F_v`, `U_w = {x ∈ O_w : x x^c = 1}`; the **local plane** is `Cay(O_w, U_w)` and its
**level k** is `Cay(O_w/𝔭_w^k, image of U_w)`; its **all-levels (four-colour) ratio** `ρ(w)` is `sup_k α(level k)/|level k|` (non-decreasing
in `k` by pullback, so a limit), the measurable independence density of the compact local plane. At a stable archimedean `w` (over a real place
of `F`) the local plane is `UD(ℝ²)` and `ρ(w) = m₁(ℝ²)`. `L(F)` = least chromatic number of a level-one residue target at a stable finite
place (Notation, `CLAUDE.md`).

### 1.3 C0 — probabilities per claim, sealed before any derivation

*Honest timing: sealed at 06:50, after reading the inputs above and before writing any derivation. While reading I had noticed one fact
(every unit vector is `≡ 1` at a ramified dyadic place), which moved the exception's number.*

| claim | TRUE | FALSE | GAP | where I expect a failure, if any |
|---|---|---|---|---|
| CLS(F), per-place reading | 0.70 | 0.08 | 0.22 | `q = 27` (no FS-66 certificate there; must be Hoffman or nothing); the dyadic inert tower over a ramified base (level structure); ramified odd towers at 11, 19 (FS-66's certificates are for `UD(ℤ/p^k,2)`) |
| SPC, archimedean step at `n > 2` real places | 0.45 | 0.10 | 0.45 | a product `(ℝ²)^n` with connection set `(S¹)^n`: its measurable independence ratio is not obviously `m₁(ℝ²)` |
| SPC, archimedean step with a complex place of `F` | 0.65 | 0.05 | 0.30 | a complex place of `F` splits in `L`, so it is not stable; the risk is only in how J45's proof uses `A(R_F)` |
| Exception excluded by the ratio condition (never inside the class) | 0.92 | 0.03 | 0.05 | the ratio at a ramified dyadic place read on the closure of `R` rather than `O_w` |

### 1.4 Would-have-searched-here log (running)

- (none yet)
