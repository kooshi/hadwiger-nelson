*Brief for job **FS111-VMW**, the blind verifier of FS-111's round 1 (competitors M and W together). Opus 5.5. Written by the product owner, 2026-09-28,
08:00 UTC. **Sized for about 300k tokens by the harness's count, as guidance** (standing rule 10).*

Hello. You are de Bruijn (`DEBRUIJN.md`), a blind verifier, in `/home/kooshi/source/lean-dir`. **`data/fs111/briefs/STANDING-RULES.md` is part of this
brief; read it in full, rule 0 first**, then `CLAUDE.md` § The aim, § Counter-priors, G82, G21, G20, from disk. You check objects and statements you have
not seen proved: derive or rebuild first, read second. An exact checker's ACCEPT is the suspect verdict: audit it at the rate of a REJECT.

## Why

FS-111's two competitors disagree, and neither saw the other.
- M (the regularity side) holds a **saturated tight seven-colouring**, R7.
- W (the wild side) registered **"no saturated 7-colouring exists" at 0.65** (W-P1), and calls C-SAT-T a GAP at `k = 7, 8`.

Both use one definition. `data/fs111/claims.md`'s C-SAT-T conclusion: a colouring is **saturated** if, in D-NF, no `x ∈ ∂_e S_j` is `j`-free, for every
`j` (`data/fs106/claims.md` §0–§1 for D-NF and `j`-free). One of them is wrong, or the definition is read two ways. Settle it exactly.

## The objects and statements (verbatim from the two records' theorem lists; proofs withheld until your stage 1)

1. **M-R7**: "the Reuleaux seven-colouring (Reuleaux triangles of width 1 on the up triangles of the unit triangular lattice, coloured by the four cosets of
   `2Λ`; the cusped down triangles coloured by the three cosets of `M = ⟨(0, √3), (3/2, √3/2)⟩`) is a.e.-proper, tight and **saturated**".
   - **Rebuild it from this rule and check it exactly**: properness a.e., tightness, and saturation at every essential boundary point, the Reuleaux
     corners and the down triangles' cusps included.
   - Prior art: `[Polymath16threads]` thread 4, de Grey, 5 May 2018.
   - **If R7 is saturated, W-P1 is false and C-SAT-T's honest form holds at `k = 7`. If it is not, name the free point.**
2. **FS111-W-SQ9 and W-HEX9**: squares of side `1/2` coloured `(i mod 3, j mod 3)`, and hexagons of width `1/2` coloured by `Λ/3Λ`, are saturated tight
   nine-colourings. Check one exactly.
3. **FS111-W-DECO-B** against M's REG-B:
   - W: "hex7 decorated with two squares per hexagon: tight, a.e.-proper, no class with tight block structure" (REG-B's universal form FALSE at `k = 7`).
   - M: REG-B "TRUE for 7 or more colours (checked exactly)", with M-BLOCK-EQ ("block structure holds exactly when 'all cross distances < 1' is transitive
     among one colour's components").
   - Say whether these are one statement in two forms (existence against universal) or a divergence of truth. Check DECO-B exactly.
4. **C-HULL-REG, in its two corrected forms:**
   - M's **M-PINCH/M-C11**: under (H1) only two colours near the point and (H2) each colour's part near it one connected open set, a saturated interface
     is a unit arc of kind both splitting its neighbourhood, or `C^{1,1}` with curvature in `[−1, 1]`, with two-sided tangent unit discs and unit-parallel
     partners; the case (in, in) is impossible.
   - W's **FS111-W-C11 / NOBEND / NOREP**: on every saturated map without cusps, interfaces are `C^{1,1}` with curvature `≤ 1`, bends are impossible, and at
     a cone vertex no colour occupies two sectors.
   - Derive the common form. Check both on R7 (if saturated) and on SQ9.
5. **FS111-W-NEG**: every existence rung of route M (REG-A_k, REG-I_k, REG-J_k, REG-B_k) is TRUE at every `k ≥ 7` (a tight seven-colouring witnesses
   them), and a rung failing at `k ≤ 6` means `χ_m⁰ ≤ k`; A-ALL or B-RR failing means `χ_m⁰ ≤ 6`.
6. **M-REDUCE-I**: honest saturation plus a locally finite singular set Σ at five colours gives `χ_m⁰(ℝ²) ≥ 6` (so `χ(ℝ²) ≥ 6` given MR).

**Priority:** 1, 3, 4, then 2, 5, 6.

## Reading

`data/fs111/claims.md` in full; `data/fs106/claims.md` §0–§1 and §5; `plans/FS107-derivation.md` §1–§2; `plans/FS111-V0-verification.md` (open to you); the
held prior-art threads (`~/source/library/notes/polymath16-threads-1-18-text.txt`, thread 4's Reuleaux colouring).

**Fences, until your stage 1 is committed:** both competitors' records, directories and tools (`plans/FS111-M-regularity.md`, `plans/FS111-W-wild.md`,
`data/fs111/fs111-m/`, `data/fs111/fs111-w/`, `tools/fs111_m_*`, `tools/fs111_w_*`) and `data/fs111/reports/`. **Always:** the session transcripts
(everything under `~/.claude/projects/-home-kooshi-source-lean-dir/`), `chats-bak/`, every shared scratchpad file you did not create (work in
`fs111-vmw/`), `plans/FS111-close-inventory.md`, every other brief in `data/fs111/briefs/`, FS-114's files (`plans/FS114-*`, `data/fs114/`,
`tools/fs114_*`), `git log` beyond the start-up snapshot and `git log -p`. Log any touch.

## Stages

1. **Blind:** the quotation check; your verdicts on 1–6, each TRUE, FALSE, GAP at a named step, or MISSTATED; exact tools in `tools/fs111_vmw_*.py`,
   each with a planted fault beside a faithful twin, calibrated first on the tight hexagonal seven-colouring. Commit before opening any fenced file.
2. **Reconcile:** read both records and list every divergence, of truth, statement or grade, with addresses.

## Rules

- **Touch only** `plans/FS111-VMW-verification.md` (headings "Theorems this phase proved", the would-have-searched log, the fence log; SAVED stages),
  `data/fs111/fs111-vmw/` and `tools/fs111_vmw_*.py`. Neutral subjects "FS111-VMW: stage n"; push after each commit; never amend or force-push.
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the owner can
  only review work it knows about. If the work outgrows your context, stop at a SAVED stage and say what is left.
- **The ban** (standing rule 3), with its "would have searched here" log: objects by formula, checked exactly; no search.
- **Contact:** only `"main"`. Report per standing rule 9 to `data/fs111/reports/FS111-VMW.md` and to `"main"`. Final text: "FS111-VMW idle; report sent to
  the owner by SendMessage".

Thank you.
