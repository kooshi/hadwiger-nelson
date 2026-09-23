# FS-72 — the last lattice: decide `group:u3:2+w4` at four colours (stub)

*Minted 2026-09-22 at FS-70's close. Rank 5 (below FS-71, FS-59); a priced object, not a mechanism.*

## Mission, in plain language

FS-70 closed every lattice it built but one: `group:u3:2+w4` over ℚ(√3,√5) — rank 8, 84 generators, 324 unit vectors in its
saturation, wall-broken, 3-non-integral. It has no additive four-colouring (phase 1) and no periodic one at N = 2 or 4 (both UNSAT;
N = 3 inadmissible; N = 5 is 5⁸ classes, unrun), so the quotient instruments (G68, G69) are silent on it, and its plain four-colour
control is **undecided**: the word ball at sums of ≤ 4 (1,886,761 points, degree 15.4) is UNKNOWN after five attempts on two code
bases and four configurations (14,800 s), the blind cube pass has no operating point by fifteen orders of magnitude, and the
symmetry break's ceiling is 8 (the triangle pin already spent a factor of 288). Its ≤ 3 ball (95,389 points) colours in 14.6 s
and its 12-core (1,374,661 points, degree 16.08) was asked by the owner at the close (result: `LEDGER.md` row 76). **A refusal
here is five colours over ℚ(√3,√5) outright, no chain** — the milestone's target, on the one object where it is still possible.

## Routes, priced (phase 1f, `data/fs70/records/phase-1f.md` §9)

1. **The two-stage instrument** (§9.2): every four-colouring of the ≤ 4 ball restricts to a first-shell colouring (84 vertices in
   fourteen hexagonal wheels) that survives the ≤ 3 ball, which is 25× smaller and refutes a first-shell colouring in 1.7 s (120 of
   120 random ones). Enumerate the survivors, ask only those against the full ball. **Its cost is `|survivors|`, measured only from
   below (≥ 269 in 666 s of blocking-clause enumeration).** A projected model counter (`ganak`, `d4` — neither installed; an
   install ask) settles it before anything is spent.
2. **The 132-generator radius-4 ball** (§9.3): 11.09 M points at degree 18.72 — above G65's threshold, 2.6× smaller than the ≤ 5
   word ball (29.08 M at 19.23, ~103 GB of solver, the server's territory). Priced, not built.
3. **The 5-adic quotient as a theorem**: at 5 the lattice reduces onto the level-2 split-prime tower over 𝔽₂₅ (two primes of
   `F(i)` above the one prime of `F`, swapped by conjugation — G69's split case); FS-66's fibre-share certificate (row 75's
   instrument) can bound `α` at level 2 and prove *no period-5 four-colouring* without a 390,625-class SAT instance. It would make
   the lattice's rigidity a theorem at 5 (as de Grey's is at 5 and 7 by the residue planes), which is G69's precondition for a
   forced pair — and then the two-stage route is aimed at a pair, not only at the control.
4. **A lookahead cuber** (`march_cu`, not installed) is the only cube-and-conquer left (§9.4).

## Provisional bearings (WORKFLOW 2.0 step 2)

G68 and G69 (silent here by construction — that is the point), G65 (the shell-indexed core ceiling; degree 16–19 is past the
peak), G66's instrument lessons (ask the whole graph clique-pinned; a level-two refutation projects), row 75's certificate
instrument for route 3, G21 (every UNKNOWN is about an encoding), G27 (the group is exactly 96; the pin leaves 8).

## Bearing on χ ≥ 6

None directly. On the conjecture: this is its last cheap prediction's last object — five here, or a four-colouring of a lattice
with no periodic colouring, which would be the first such object anywhere and the falsifier G48 names.

**Provisional bearings, added 2026-09-23 (FS-73's close):** **G71** — at four colours there is no height, no slope and no `Θ`-type certificate: a refusal here is still a finite graph, and a four-colouring with no periodic colouring would also be the first instance of C3-aper failing (FS-76, `[AbrishamiEtAl2025]` Problem 4.6 at `k = 4`), which is open. **G68's addition** — a gap is sufficient for looseness, not necessary (FS-73's L3, loose at every period with no gap): where every colouring found is gap-free, compute the Kempe period groups before calling the lattice rigid. FS-73's implementer D found the rich 2-unit lattices over ℚ(√3,√5) (`twounits:14/30/42`, generator graphs) rigid-found with `P_found` of rank 8 and finite index, forcing undecided (row 78; `tools/fs73_census_check.py`, frozen) — the nearest objects to this one in the record.
