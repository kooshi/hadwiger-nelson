# FS-81: four colours over real quadratic fields (stub)

> **CLOSED 2026-09-24.** Record `plans/FS81-quadratic-four-colours.md` (its §R-close first); theorems `plans/FS81-derivation.md` T1–T25;
> `LEDGER.md` rows 82–84; G74 minted, G61 rewritten. **T4 proved at the field level** [hand, two independent derivations]: `χ(F²) ≥ 4`
> for every `F ⊆ ℝ` with `1/3 ∈ ℤ[U_F]` and `F²` not bipartite, so `χ(ℚ(√d)²) ≥ 4` for every squarefree `d ≡ 11 (mod 12)` and χ = L for
> every real quadratic field with L ≤ 4 — not by FS73-T41's family but by a field-level slope read layer by layer (row 82). **The census
> completed**, 40 of 40, by structural certificates independent of that argument [cert + hand] (row 83). **ℚ(√47) at four colours:**
> calibrated (`R*(X_A) ≤ 1.4` certified; the undecided band `d_ball` 8.3–14.7), 25 survivors of 127 lattices, and the price of a matched
> refusal read as a size ratio ≥ 1,284 — **five not landed** (row 84; carried to FS-84). **Not claimed new:** `[Johnson2000]` and
> `[Johnson2006]` are unread. Minted from it: FS-82, FS-83, FS-84; re-aimed: FS-48, FS-59, FS-64, FS-75.

*Minted 2026-09-24, just after FS-79's close. Kooshi chose it as the next milestone on a fresh Poros's advice
(`plans/POROS-2026-09-24-next-direction.md` §5; "prove first"), with the owner concurring. Rank 1.*

**Close inventory:** `plans/FS81-close-inventory.md`. It was opened at minting and is kept current by the coordinator (WORKFLOW step 5).

## Mission, in plain language

**Prove that every real quadratic field that can need four colours does**, for as many fields as an exact method reaches, and for an
infinite family if the known proof generalises.
- The fields are ℚ(√d), d squarefree with d ≡ 11 (mod 12). They are the only real quadratic fields whose plane can need four colours
  (`[Fischer1990]` Thms 8–9).
- The claim is **T4**, the census conjecture (G61): χ(ℚ(√d)²) ≥ 4 for every such d. It is a clause of Kooshi's local–global
  conjecture, and today it is proved field by field only.

**Where it stands.** FS-61's census (`data/fs61/census.md`, which predates FS-73) certified four colours at 14 of the 40 fields
below 500, and FS-73 added ℚ(√167) (row 79). That makes 15. **25 fields are open**, all recorded as typed nulls at the census's
ball tiers: 35, 83, 107, 131, 155, 179, 203, 215, 227, 251, 263, 287, 299, 323, 347, 371, 383, 395, 407, 419, 443, 455, 467, 479, 491.
- **215, 383 and 479** have local bound 5.
- **227** is open "by certificate": every lattice at the census's depth is three-colourable, so only deeper lattices can land it.

**Why this is the milestone now** (the advisor's case; the owner checked the arithmetic):
1. **An exact procedure exists and was aimed at one field only.** FS-73's `Θ₃` test decides three-colourability of a lattice exactly:
   a lattice is three-colourable iff some character puts every unit vector in `[1/3, 2/3]` mod 1 (row 79, G71). It proved ℚ(√167)
   with a certificate of kilobytes, where FS-61's refuting balls were priced near 10⁸ points. **No FS-73 or FS-79 file touches another
   census field.** G72's own *Do* is to point a new exact procedure at the open instances the day it lands; this milestone is that act,
   a day late.
2. **The half-page proof at ℚ(√167) may be a family.** FS73-T41: the 36 vectors `{1, v, z}·U_R` already have empty `Θ₃`, by four
   inequality cases.
   - `v = (83 + i√167)/84` is G7's type-M rotation at n = 42 (radicand 4n − 1 = 167), and every ℚ(√d) with d ≡ 3 (mod 4) has one.
   - `z = (1 + i)(15 − i√167)/28` exists because 15² + 167 = 2·14².
   - **ℚ(√47) has the same shape:** `(23 + i√47)/24` and `(1 + i)(5 − i√47)/12`, since 5² + 47 = 2·6², and it is already certified to
     need four. So it is a ready positive control.
   - The question is whether T41's four cases hold with the twist as a parameter.
3. **It answers questions posed in print**, which is the third publication category, never fired so far:
   - Moorhouse 2010 asks how much χ can grow over quadratic extensions, and asks about ℚ(√47) by name;
   - Benda–Perles, Open Problem 11.6;
   - `[Fischer1990]`'s request for an algebraic criterion.

   See `CLOSED-QUESTIONS.md` §1.7. **`[Johnson2000]` and `[Johnson2006]` are unread**, and §1.7 names them as the likeliest prior art:
   they must be read before any claim.
4. **The last phase measures what FS-59 needs:** the cost of refusing four colours on a rank-4 lattice, at ℚ(√47). There the
   conjecture predicts **exactly five** (L = 5: 3 and 7 unusable, 11 usable; the same at every tower level, FS-66), against a proven four.
   ℚ(√47)'s three-colour tree had 2,997 nodes against ℚ(√167)'s 605,203, so its lattices are much denser.

## §IQ draft (WORKFLOW 3.3; the planner rewrites it at the reframe)

1. **The existence form.** Does ℚ(√d)² need four colours, for each open d?
2. **The structural form** (Poros's wording): **for which real quadratic `d`, and which lattices over them, is `Θ₃` empty?** Here, unlike
   FS-79, the invariant is known to exist: the height and its slope (G71). So the structural question is a classification of `Θ₃`
   over a family, not a search for an invariant.
3. **The invariant it forces:** `Θ₃`, together with T41's multilayer structure (G62: a lattice's `U` factored as rotations × the
   rational pattern `U_R`).
4. **The route:** exact `Θ₃` trees and structural certificates, which are computations that certify a derived criterion, then a
   derivation of T41 with the twist as a parameter. No solver search.
5. **The open instances:** the 25 fields; ℚ(√47)'s lattices at four colours (last phase); and, as controls, ℚ(√167) and ℚ(√47)
   (positive) and three-colourable fields such as ℚ(√3) and ℚ(√7) (negative).

## Outcomes to register at the plan (each must be reachable)

- **(a) A family theorem:** T41 generalised to an explicit infinite family of d (with its congruence conditions), proving T4 there.
- **(b) Instances:** `Θ₃` certificates landing k of the 25 open fields, typed per field; the rest typed nulls at a stated depth.
- **(c) Not landed:** fewer than 5 of 25, and T41 specific to 167. Then the ℚ(√47) four-colour measurement becomes the whole milestone
  (Poros's fallback).

## The shape (the planner decides; the stage design of FS-79 applies)

- **Stage A:** a planner plus a plan-phase Poros do the reframe (§G, §PA with the Johnson papers read, §IQ) and the subplan.
  Phase 0, the `Θ₃` runs, can start early as it did in FS-79, one implementer, since the tools exist:
  - `tools/fs73_theta_*.py` (the checkers are frozen; import them);
  - E's tree and structural certificate;
  - V2's relation tree;
  - FS-79's `tools/fs79_p0*.py` and `tools/fs79_p3b_theta4.py`, generalised to any M and d.
- **The family derivation:** one derivation agent. A competition only if it stalls (G51).
- **The last phase:** FS-79's phase-0 screen re-run at d = 47 (four colours), then one refusal ask on the densest survivor, with its
  price measured.
- **Budget anchors:** the implementer about 250–350k tokens and 1–2 desktop days; the derivation about 300–400k.

## Owed at the opening (before the reframe; the close inventory holds them)

- **Stale claims in `CLAUDE.md`:**
  - Frontier item 10's "four or five for ℚ(√47) … are met": L = 5, so the prediction is exactly five;
  - the target paragraph's "one cheap exposed prediction left", which omits ℚ(√47), √143, √311, √335 and ℚ(√3,√5);
  - G48's "so next ℚ(√167)", which skips ℚ(√47);
  - FS-59's "falsification target" wording: five over ℚ(√167) is consistent with the prediction of at least six and cannot falsify it.
- **Poros's six-arena reading, to record:** ℚ(√167) is the smallest 6-open real field and every lattice over it has rank ≤ 4, so the
  conjecture predicts a six-chromatic unit-distance graph inside a Cayley graph of ℤ⁴ there.
- **P-G54** (FS-79, unscored): Γ₂₃'s sign at four colours, a character sum taking seconds.
- **The stub table's rank column** repeats below rank 1; re-rank it properly.
- **`plans/PROGRAMME-ALGEBRAIC-PROOF.md` §5's order of work** has been closed out since 2026-09-07; rewrite or retire it.
- **G72's killing test:** Poros proposes counting target-moving results separately from no-gos, since the method is one for two on
  target-moving results. G72 is Kooshi's method, so this is his call.
- **Prior art:** `[Johnson2000]`, `[Johnson2006]`; and "Circular coloring the plane" (SIAM J. Discrete Math. 21 (2007) 461–465), a
  zbMATH hit missing from `BIBLIOGRAPHY.md` that bears on FS-80 and FS-64 (every `Θ_k` point is a circular colouring).

## Provisional bearings (WORKFLOW step 2)

- **G61** (the census, T4, "no witness transfers between fields", written before `Θ₃` existed);
- **G71** (`Θ₃` and the height);
- **G72** (the method; its *Do*);
- **G62, G7** (T41's twists as coincidence rotations; the multilayer factorisation);
- **G65** (the degree law, for the ℚ(√47) phase);
- **G21** (typed nulls; calibrate a finder on known positives);
- **G48** (the conjecture's clauses);
- **G49, G50** (the Johnson papers; Moorhouse's question);
- **G73** (why the ℚ(√47) phase is a finite refusal).

## Bearing on χ ≥ 6

None directly. **High on the programme:** a class derivation, and the first proof of a clause of the conjecture over an infinite class
of fields without √3. **Possibly the publication trigger:** it answers questions posed in print. The last phase prices what five over
ℚ(√167), and so the hunt for six there, would cost.
