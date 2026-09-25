# FS-86 — four-colour rigidity over ℚ(√59) and ℚ(√83): does the tight dyadic `K₄` force pairs in a triangle-free field? (stub)

> **CLOSED 2026-09-25 (FS-86).** Record `plans/FS86-dyadic-rigidity.md` (§R-close first); theorems `plans/FS86-derivation.md`; `LEDGER.md` rows 88–94; G76. The field-level question is one pair, `(0, 4)`, and it is **undecided**; the plane over `ℚ₂(√3)` is rigid; every natural construction of a non-periodic four-colouring is impossible; ℚ(√2,√3), the class's member with triangles, is rigid given Heule's T721. The stub's "yes, `P₄ ≠ 0`" was free at the field level. What is left: FS-89 (the missing theorem) and FS-90 (sanctioned search). Carried here from the close's sweep: the colouring-level Hasse principle at L = 4 (de Bruijn §3: in S2 with `4 ∈ F_tf`, `F(R) ≠ 0`; killing test a non-periodic four-colouring of ℚ(√59)'s plane) and the local question "is `4 ∈ F_tf`?".

**Chosen 2026-09-25 as the next milestone** (Kooshi: "I agree with FS-86"). Close inventory: `plans/FS86-close-inventory.md`, opened at the choice and kept by the coordinator (WORKFLOW step 5). It opens in the finite-witness-free week (to 2026-10-01; `CLAUDE.md` § Toolchain): routes 1–3 are in scope, route 4 waits for the week's end.

*Minted 2026-09-24 at FS-85's close, from the plan-phase advisor's held item H5 and its frame item H6 (public since the competition's
fence lifted: `data/fs85/held/HELD-plan-advisor.md`), FS85-dB4's calibration, and Coxeter's R2.6 reading (`plans/FS85-derivation.md` §7).
It was the owner's option C during FS-85's round 3; Kooshi did not choose it for that week. Rank 2. Written for a session with zero
conversation memory.*

## The question, in plain words

The plane over the real quadratic field ℚ(√59) needs exactly four colours: at least four because 59 ≡ 11 (mod 12) (`LEDGER.md` row 82),
at most four because 59 ≡ 3 (mod 8) makes the prime above 2 inert in ℚ(√59, i), and its residue target is `U₂ = Cay(𝔽₄, μ₃) = K₄`
(`[Fischer1990]` Thm 10(i); the dyadic bound). Its unit-distance graph has **no triangles** (√3 ∉ F; G57). And that `K₄` is the field's
**only** four-colour residue target: 7 is not usable (59 ≡ 3 (mod 7) is a non-residue), and every other usable target (11, 19, 23, …) is
at least five-chromatic, so it has no four-colouring to offer a gap. `K₄` is Hoffman-tight at four colours (`λ_min = −1 = −3/(4−1)`), and
tightness propagates up an inert tower (G54).
*[Correction, FS-86 (FS86-A2, owner-verified): ℚ(√59)'s stable odd places are 11, 23, 31, 43, 47, … and the ramified 59 — 19 is inert in ℚ(√59); for ℚ(√83): 19, 43, 47, …, ramified 83 (11 not stable); for ℚ(√131): 19, 23, 31, 47, …, ramified 131. For 83 and 131 the place 19 needs FS-66's certificate, not Hoffman (B1's D4).]*

**So: does some rich lattice over ℚ(√59) carry a non-zero four-colour forced group, `F₄ ≠ 0`?** Weaker, and first: does every periodic
four-colouring identify a pair, `P₄ ≠ 0`? Same questions over ℚ(√83) (83 ≡ 6 (mod 7)) and ℚ(√131) — the fields `d ≡ 11 (mod 24)` with 7
not usable.

"Rich" matters (H5): a lattice built from too few unit vectors stays integral at a non-stable prime and inherits that prime's gapped
target. FS-73's one inert-dyadic row, `K|Q(sqrt11,i)|D36`, is loose by a gap at `N = 5` (`data/fs73/table/TABLE.md`). So the candidate
contains `1/p` for every non-stable prime `p` whose target four-colours with a gap (3, 5, 7, 13, …) — the saturated chain `Λ_M` with `M`
divisible by those primes; such lattices exist by prime inversion (G55).

## What is already known

- **H6, derived:** row 66 frees every pair over any field with a usable 3, a usable 7 or a ramified dyadic prime. So in the class of
  triangle-free unit-distance lattices (`𝒰^tf`) only two arithmetic types stay open: **(A)** wall-broken with no small gapped plane
  (ℚ(√47), ℚ(√167): FS-84, FS-59), and **(B)** wall-standing with the inert dyadic `K₄` and 7 not usable — this stub.
- **The record never asked a type-(B) field.** Every triangle-free four-colour screen ran either in a wall-broken field (no dyadic target)
  or with a usable 7 (H5's frame part, checked against FS-73's table).
- **Over K the mechanism is known** (row 85, G75): a tight dyadic quotient (`Λ/8Λ`, `K₄ × K₄` at the two primes above 2) plus triangles.
  The triangles do the pinning — NT_k is a linear identity whose zero sets meet in finitely many torsion characters — and the tight quotient
  kills what the spectrum leaves, pointwise. Tightness alone did not give the period: the infinite lattice is not Hoffman-tight (dB5), and
  a slack quotient can still force (row 87, L16). ℚ(√59) has one dyadic prime and no triangles.
- **The calibration (FS85-dB4, row 86): a yes here is Soifer-strength.** A four-colour forced pair in any triangle-free unit-distance graph
  gives, by chaining `m ≥ 4` isometric copies at generic angles and one closing edge, a finite triangle-free five-chromatic unit-distance
  graph — `[Soifer2024]`'s Open Problem 55.1 (`CLOSED-QUESTIONS.md` §3). Inside ℚ(√59) the forced pair is never chainable (its difference has
  positive 2-adic valuation at the stable dyadic prime; FS79-T2), but the generic chain leaves the field. **This corrects H5's "does not
  touch Soifer 55.1".** Price the yes accordingly: a strong prior against, and any claimed yes gets two independent derivations and a blind
  verifier before a row.
- **Coxeter's R2.6 reading predicts no:** in a triangle-free lattice the analogues of the hexagon circles are generically non-torsion, so
  the spectral mechanism has nothing to pin (G75's reading and its killing test).

## Routes, solver-free first

1. **H5's falsifier, an exact Smith-form derivation on the dyadic tower** (in scope in the finite-witness-free week: exact computer algebra,
   shape fixed by the derivation). For a rich lattice, reduce its unit vectors along the tower `O/𝔭^j` and ask whether the tower forces
   anything at each depth — the row-67-style certificate, four units whose `t − 1` span has 2-adic elementary divisors, says it forces
   nothing there. PARI/GAP; hours.
2. **Tightness up the tower, read with row 87.** Compute the sign of `λ_min + d/3` on `Cay(Λ/2^jΛ, U)` level by level. Where it stays
   tight, G54's theorem gives balanced, gap-free, periodic colourings; where it turns slack, compute the pull-back to the nearest tight
   level before calling the level free (L16).
3. **The structural question (G72):** classify every four-colouring of a rich lattice's graph by an invariant every colouring carries.
   With no triangles there is no NT identity; what local linear identity on the tetrahedral embedding, if any, pins the spectrum? That is
   G75's killing test.
4. **The composite quotients `N = 2^a·q`, `q` stable (11, 23, …)**, which H5 does not rule out, may supply a gapped four-colouring (H5's
   second falsifier). Deciding one is a quotient-colouring search: **banned until 2026-10-01**; after that, G68's quotient screen.

## Outcomes, registered before any run

- **No** — the tower forces nothing on some rich lattice (route 1), or some target supplies a gapped four-colouring (route 4; then
  `F = P = 0` there by row 66): kills H5 on that lattice, confirms R2.6, and leaves step 2 of FS-85 open in type (B).
- **Yes, `P₄ ≠ 0`** with `F₄` unknown: the inheritance question at four colours on a triangle-free lattice (FS-76).
- **Yes, `F₄ ≠ 0`** proved at `F`: Soifer 55.1 answered (dB4) — extraordinary; see the calibration.

## Bearing on χ ≥ 6

None directly: ℚ(√59)'s plane is four-chromatic, `L = χ = 4`. **High on the literature:** a yes answers a question posed in print
(§ Publication's third bar). And it tests G54's reading (tight ⟹ forcing) in the one field type the record never asked, and G75's.

**Provisional bearings** (WORKFLOW 3.1 item 5; replaced by the re-grokking at the opening): G54 (the tight dyadic target; the middle case,
row 87), G75 (triangles pin the spectrum; its killing test is this stub's yes), G68 (the gap screen), G69 (rigidity prime by prime), G55
and FS79-T2 (never chainable in `F`), G57 (triangle-free iff √3 ∉ F), G61/G74 (four colours, row 82), G71/G73 (no height at four colours;
the open certificate formats), G21 (a triangle-free null so far measured only the fields enumerated); rows 66, 67, 78, 82, 85, 86, 87.

**Reading owed at the opening** (FS-85 close inventory items 6 and 25, carried): Soifer ch. 55's posing citation "[Soi46]" and
its citation graph; `[deGrey2026]` (ℝ³, triangle-free, five-chromatic) and `[Haugstrup2026]`, both read by the author's summary only.

**Solver:** none for routes 1–3; route 4 needs a solver (after the week). **Cost:** route 1 hours; route 3 days.

## Where the 2026-09-25 work on this lives

*Addresses and titles only, added by the 2026-09-25 crunch's bookkeeper (job J30). The index of that day's work, with its results, is `plans/CRUNCH-2026-09-25-INDEX.md`; a blind verifier does not open it.*

- `plans/FS91-S1D-character.md` §4.4 and `plans/FS91-S1V-character.md` §2.3 (V4) — jobs J07 and J10 on HD1
- `plans/FS91-S0FV-three-colours-blind.md` §2.2, `plans/FS91-S1D-character.md` §2.4, `plans/FS91-S1V-character.md` §3.2 — on FS86-B1-LR's scope
- `plans/M3-S1D-windows-five.md` §2.5, §4.6 — job J21's record, on FS86-CL1
- `plans/FS91-close-inventory.md` rows 13, 75, 78, 87, 92 and `plans/M3-close-inventory.md` row 18 — the related items
