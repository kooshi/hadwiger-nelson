# FS-85: can four-colour rigidity exist without triangles? (stub)

*Minted 2026-09-24, just after FS-81's close, as the next milestone. Kooshi chose it from the algebra-week advisor's ranking
(`plans/POROS-2026-09-24-algebra-week.md` §6.3, rank 1), with FS-83 (character colourings at four and five colours) as its fallback.
Kooshi: "I agree with the advisor's rank 1 recommendation, with rank 2 as a fallback … Rank 1 as the next milestone." It **absorbs
FS-74** (why every four-colouring of de Grey's lattice is 8Λ-periodic) as its step 1; FS-74's stub keeps its file, with a banner.*

**Close inventory:** `plans/FS85-close-inventory.md`, opened at minting and kept current by the coordinator (WORKFLOW step 5).

**It runs in the finite-witness-free week, 2026-09-24 to 2026-10-01** (`CLAUDE.md` § Toolchain; Kooshi confirmed the advisor's
scope).
- **Out:** SAT, MaxSAT and #SAT solvers, MILP/CP and local-search colourers, Θ relation trees and float Θ₄ finders,
  quotient-colouring searches, and lattice sweeps hunting survivors.
- **In:** hand derivation, computer algebra, colourings given by formula, the Lean kernel, and existing checkers on existing
  certificates. An exact LP is in only when a derivation fixes its shape before it runs and its dual is read back as an identity.
- **Every brief carries a "would have searched here" log:** one line per move an agent would have made by search, and what it did
  instead. The week is judged partly by it (§ Outcomes).

## Mission, in plain language

**A four-colour "forced pair"** is two points of a graph that receive the same colour in every proper four-colouring. Forced pairs
are the engine of every proof that a plane needs **five** colours: the chain theorem (G55) turns a forced pair at distance δ into a
contradiction whenever 1/δ is a sum of unit vectors. **Every four-colour forced pair known anywhere uses a unit triangle.**
- de Grey's lattice over K = ℚ(√3, √11): every four-colouring repeats with period 8Λ (`LEDGER.md` row 78; FS73-T6/T7).
- Harder's pair at 8/3 and Parts's at 8/9 over K.
- Heule's T721, a forced pair at distance 2 over ℚ(√2, √3) (not held; §Reading).

A field without √3 has no unit triangles at all (G57). That covers ℚ(√47), ℚ(√167) and every real quadratic field that can need
four colours. In those fields, **no four-colour refusal or forced pair has ever been found, here or in print**:
- FS-70 over ℚ(√3, √5), FS-59/FS-79 over ℚ(√167) and FS-81 stage D over ℚ(√47) all failed;
- the smallest ℚ(√47) survivor needs about 1,284 times the calibration graph's points (`LEDGER.md` row 84).

The question was already posed in print: **Soifer's Open Problem 55.1 (2019): "Construct a triangle-free 5-chromatic unit-distance
graph"**, and 55.2 asks for the smallest one (`[Soifer2024]` ch. 55; `CLOSED-QUESTIONS.md` §3). It is open in the plane. The only
triangle-free five-chromatic unit-distance graph known lives in ℝ³ (de Grey 2026, 61 vertices).

**The milestone asks the structural question behind that wall, by algebra alone:**
- **Step 1 (FS-74's lead): why is de Grey's lattice rigid?** Prove that every four-colouring of it restricts to Hubai's 2018
  description: two-colour stripes on the Eisenstein sublattice, plus one chirality, where rotation by k·arccos(5/6) acts as ±k·120°.
  Read 8Λ off that description, and **record exactly where the unit triangles enter the proof.**
- **Step 2: can four-colour rigidity exist without triangles?** Can a Cayley graph of ℤ^r whose connection set contains no three
  vectors summing to zero (a triangle-free abelian Cayley graph) have a forced pair at four colours?
  - If yes, which lattices or classes realise it?
  - If no, in what class is it a theorem, and what exactly do triangles supply?

**Controls already in hand:**
- **triangle-free and rigid, at three colours:** ℚ(√11)'s lattice Λ₁₀, with F = 3Λ and no forcer (row 79, G71);
- **rigid at four colours, with triangles:** de Grey's lattice, F = P = 8Λ (row 78);
- **loose at four colours, without triangles:** ℚ(√167)'s L21cc6506, loose by a full-dimensional Θ₄ cell (row 81); and ℚ(√47)'s
  lattices, 102 of 127 four-colourable, with 49 of those having a gapped colouring (row 84).

## Why this milestone, and why now

1. **It is the SAT-free week's experiment in its sharpest form.** Kooshi's premise was that priced attempts never succeed outside
   the extensions of K, and that triangle-free fields make SAT infeasible. The advisor checked it (§4 of its record):
   - It holds at four colours.
   - It is false at three colours, where SAT did refuse 15 triangle-free fields.
   - The deeper cut is **finite witness versus a certificate on the infinite object**.

   This milestone asks the four-colour question as a question about every colouring of an infinite graph. The certificate it would
   replace (the 2,044-point refusal behind 8Λ) is a SAT refusal.
2. **Either answer moves a target.**
   - **No**, as a theorem in a class that contains the unit-distance lattices of triangle-free fields: the chain route (G55) is dead
     in every such field. Five over ℚ(√47) or six over ℚ(√167) would then need a refusal with no forced pair anywhere inside it.
     Kooshi's hunch becomes a theorem about the mathematics, not about the solver.
   - **Yes**, realised in a field where 1/2 is a sum of unit vectors (a wall-broken field): five colours follow by the chain theorem.
     That answers Soifer 55.1, Exoo–Ismailescu's "smallest field that needs five" and Moorhouse's "what about ℚ(√47)?" together.
3. **For six, it is the template.** Six at ℚ(√167), where the conjecture predicts at least six and there are no triangles, needs a
   five-colour forced pair. G73 says the local certificate formats are emptier at five colours than at four.

## §IQ draft (WORKFLOW 3.3; the planner rewrites it at the reframe)

1. **The existence form.** Is there a triangle-free abelian Cayley graph, or a triangle-free unit-distance lattice graph, with a
   forced pair at four colours?
2. **The structural form**, a candidate for the planner to sharpen or replace. For every proper four-colouring of a Cayley graph of
   ℤ^r, what does a triangle impose that no triangle-free relation can? Equivalently: which invariant of four-colourings is carried
   through triangles, and is it the only mechanism of rigidity?
   - FS-79 (G73) showed that no cell-local invariant certifies anything at four colours.
   - FS-74's re-aim (FS79-T23, T37) showed de Grey's rigidity is a many-layer effect, coupled across Eisenstein cosets by single
     matchings.
3. **The invariant it forces.** None known. On each Eisenstein coset, Moore–Newman's height exists (G73: the only edge-local
   four-colour height lives on sum-closed halves, which are exactly the triangles). Whether the cosets' heights glue is the step-1
   question.
4. **The route.** Derivation only. Exact computer algebra may check a derived claim; no search answers it.
5. **The open instances it would decide:**
   - de Grey's lattice (8Λ, step 1);
   - ℚ(√47)'s 25 survivors and ℚ(√167)'s 7;
   - the unit-distance lattices of every triangle-free field;
   - Soifer 55.1 in the plane;
   - the five-colour version at ℚ(√167) (FS-59).

## Outcomes to register at the plan (each must be reachable)

- **(a) Step 1 landed:** a derivation that every four-colouring of de Grey's lattice has period 8Λ, from Hubai's stripes, at two
  independent derivations, with the triangles' role stated. The 2,044-point refusal is then explained.
- **(b) Step 2 decided in a named class:** either a theorem that no triangle-free abelian Cayley graph in the class has a four-colour
  forced pair (with the class containing the triangle-free unit-distance lattices, or its gap to them named), or a triangle-free
  lattice with a forced pair, proved by derivation.
- **(c) Not landed:** the killing test below fires. Then FS-83 (character colourings) runs as the fallback.

**The advisor's predictions** (registered in its record §6.5 and scored at the close):

| id | prediction | probability |
|---|---|---|
| P-W3 | the first round proves Hubai's stripes on de Grey's lattice | 0.35 |
| P-W4 | the week proves some triangle-free field needs five colours | 0.05 |
| P-W5 | the week produces at least one four-colour result about every colouring, outside K | 0.55 |

P-W1 and P-W2 concern FS-83, the fallback.

**The experiment's verdicts**, registered before it starts, from the advisor's §6.5:
- **Paid:** at least one four-colour result about every colouring (or every character colouring), outside K, at two independent
  derivations or better.
- **Draw:** only three-colour results.
- **Null:** nothing at four colours. This is weak evidence against algebra, and no evidence for SAT.

The "would have searched here" log is read at the close: zero lines means the ban constrained nothing.

**Killing test (the wrong choice):** after the first round of the competition (about day 2), neither competitor has proved that
every four-colouring of de Grey's lattice restricts to stripes, and neither has stated with a proof what a triangle-free rigidity
would require. Then stop and run FS-83.

## The shape (the planner decides; the protocol applies)

- **Stage A:** a fresh planner and a plan-phase Poros do the reframe (§G, §PA, §IQ) and the subplan. Keep it short; the week is short.
- **Stage C:** a competition, the project's standing design (`plans/PROTOCOL-competitor-and-advisor.md` §1): two competitors (de
  Bruijn, Coxeter) and one advisor, with isolated scratch directories, content-free hand-backs, and retractions counted.
  - The competitors may be primed differently (rule 2).
  - Step 1 and step 2 are both open to both competitors. The planner decides whether they are ordered, or posed as one challenge.
- **No measurement phase.** There is nothing to search this week. An exact computer-algebra check of a derived claim is allowed.
- **Budget anchors:** about 1.0–1.6 million tokens over 3–5 days (the advisor's estimate: competitors 360–552k tokens each, advisors
  220–480k, a planner about 230k).
- **The close:** a fresh close planner, from the inventory, including the week's verdict and the search log's count.

## Reading owed before or during the reframe

- **`[Soifer2024]` ch. 55:** Open Problems 55.1–55.2. Read at FS-81's close; bibliography updated.
- **Hubai's 2018 Polymath16 comments:** the stripes and one chirality; the 9,120 colourings of the Moser ring, 380 with a triangle
  fixed. They are in the held threads, `~/source/library/notes/polymath16-threads-1-18-text.txt`, under `[Hubai2018]`.
- **de Grey 2026:** a triangle-free five-chromatic unit-distance graph in ℝ³, 61 vertices (zbMATH).
- **Haugstrup's "pseudo-edge" constructions:** ℝ⁴, Polymath16, December 2025 to February 2026. With de Grey 2026, the only known
  triangle-free five-forcing mechanisms.
- **Heule's T721:** the second known rigid instance at four colours (over ℚ(√2, √3), with triangles). Not held.
- **`[CGHO2025coh]`** (cohomology of the grid homshift; Thm 5.8's non-local cocycles) and `[MooreNewman2000]` (the triangular
  lattice's four-colour height).
- **The Kempe-invariant literature** carried from FS-79: `[Cepas2016]`, `[CepasAkhmetiev2020]`, `[MoharSalas2009]`.

## Provisional bearings (WORKFLOW step 2; replaced by the re-grokking)

- **G73**: the four no-gos by format; the edge-local height lives only on sum-closed halves, which are triangles.
- **G71**: three colours are linear and four are not; `K₄`'s square complex is `ℝP²`.
- **G74**: the layer method, and where it stops being two-sided.
- **G70**: the √3-clean colourings are exactly the residue ones.
- **G55**: the chain theorem.
- **G57**: fields without √3 are triangle-free.
- **G68, G69**: the Kempe screen; rigidity is arithmetic, and its density pulls apart from it.
- **G72**: the method.
- **G51**: the competition.
- **G21**: typed nulls.
- **G62**: lattices as multilayers.
- **G16, G9**: the distance-2 pigeonhole, and where rigidity lives on K.
- **The derivation files:** FS73-T6/T7, FS79-T21–T37 (T23: every edge-local cocycle trivial on de Grey's 9,120 colourings; T37: its
  Eisenstein cosets are coupled by single matchings), FS81-T25 (the four-colour sign table).
- **The ledger:** rows 78, 80, 81, 84.

## Bearing on χ ≥ 6

**Medium-high on the programme; speculative on six.**
- A yes realised in a wall-broken triangle-free field is five colours for that field. That answers a posed question (Soifer 55.1),
  the publication bar's third category.
- A no redirects every lower-bound route in triangle-free fields away from forced pairs.
- The five-colour version at ℚ(√167) is the six-template.
