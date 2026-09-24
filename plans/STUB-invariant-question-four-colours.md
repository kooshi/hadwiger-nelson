# FS-79 — the invariant question at four colours (stub)

> **CLOSED 2026-09-24.** Record `plans/FS79-invariant-question.md` (its §R-close first); theorems `plans/FS79-derivation.md` T1–T43;
> `LEDGER.md` rows 80–81; G73. **Outcome (b) in a narrow form, and (c):** four no-gos, each for its named format — edge-local heights
> (empty on every graph of the class at four colours; from five colours up on every presentation with two generator classes), the loop
> winding (the relation's parity), parity-free face fluxes, coindex topological bounds — **not a no-go for a kind of invariant**;
> plain density of periodic four-colourings false in rank 1; (Q-obs) and (Q-rig) not landed, typed. **The open instances (§IQ item 5):**
> `L21cc6506` decided — four-colourable and loose, `F = P = 0` (row 81); phase 0's seven minimal survivors carried to FS-59 ⟨P3B-STUB79⟩;
> KR6 (FS-77), FS-72's rank-8 lattice and the rich ℚ(√3,√5) lattices **not reached**; FS-76's rank-1 walls — the exact rank-1 criterion
> and a scan to `max D = 14` (row 80); de Grey's lattice, the known positive — its rigidity is not an edge-local height (row 80). Kooshi's
> certificate question goes on in FS-80 (averaged, one-sided) and FS-76 (decidability). **Correction:** the bearing below said
> "high-rank lattices"; every lattice over ℚ(√167) has rank ≤ 4 (close-inventory items 13–14).

*Minted 2026-09-23, just after FS-73's close. Kooshi asked for it as "its own standalone milestone", after asking how the four-colour
proof over ℚ(√167) was found and what the next step up could be — "specifically not an extension to what we found, but an abstraction
of the reframing that allowed us to see it". It is **the first milestone planned under G72 and WORKFLOW 3.3 from the start**. Rank 1.*

**Close inventory:** `plans/FS79-close-inventory.md`, opened at minting and kept current by the coordinator (WORKFLOW step 5).

## Mission, in plain language

**The target is five colours over ℚ(√167).**
- FS-73 proved χ(ℚ(√167)²) ≥ 4 (row 79). Kooshi's local–global conjecture predicts at least six there.
- The next step up is a lattice over ℚ(√167) that cannot be four-coloured. That is FS-59's question now.

**What a direct attack would cost is not yet measured.** Every lattice over ℚ(√167) has rank at most 4, because ℚ(√167)² is a
four-dimensional space over ℚ. The price of refuting four colours on the richest of them with a finite patch has never been measured;
phase 0 measures it. The precedent is at three colours: FS-61 priced ℚ(√167)'s refuting patches near 10⁸ points, and the `Θ₃`
certificate that decided the question is 5.7 KB. A certificate at the level of the lattice's symmetry is the kind that scales.

**How four was found, and why this milestone is not "Θ at four colours".**
- The proof did not come from aiming at ℚ(√167). Two attacks did aim at it: FS-61 searched for a refuting finite patch, and FS-73's
  P2b screen searched for colourings. Both stalled.
- It fell out of a question about something else. FS-73's competition asked "does every colouring look like a periodic one?", for every
  lattice at once, with the arithmetic removed and search forbidden.
- Answering that needed a handle on an arbitrary colouring. The prior-art gate had named the object in its home discipline's words (a
  hom-shift). That discipline's handle on three-colourings is the height function, and the height's slope turned out to decide everything.
- G72 states the three moves that outlive the tool: ask about the whole solution space; take integers from the target's topology; average
  over the symmetry and certify on the group, not the graph.
- The three-colour tool itself stops at four (G71). **So this milestone reruns the reframing, not the tool**: it poses the four-colour
  structural question and lets the answer choose its own invariant.

## §IQ draft (WORKFLOW 3.3; the planner rewrites it at the reframe)

1. **The existence form.** Is some lattice over ℚ(√167), or the plane, not four-colourable?
2. **The structural form.** **What does every four-colouring of a Cayley graph of a finitely generated torsion-free abelian group carry?**
   That is, an invariant defined for every proper four-colouring, which periodic four-colourings realise. And is it complete: does it
   decide four-colourability?
   - The class is FS-73's abstract class, with no field and no arithmetic.
   - Its two sharp forms are:
     - **decidability**: is four-colourability of these graphs decidable?
     - **certificates**: does a two-sided certificate scheme exist? This is Kooshi's question, and it is equivalent to decidability
       (FS73-T29).
3. **The invariant it forces: none known.** G71 excludes the one-dimensional kind: K₄'s square complex has only a ℤ/2 loop invariant,
   so there is no height and no slope. Finding an invariant, or proving that none of a stated kind exists, is the milestone.
4. **Route.** Derivation only. Exact computation may check a derived claim, but no search answers the structural form.
5. **The open instances it would decide:**
   - the ℚ(√167) lattices at four colours (the survivors of phase 0 below);
   - KR6's four-colourability (FS-77);
   - FS-72's rank-8 lattice over ℚ(√3,√5);
   - FS-76's rank-1 walls.

   And a **known positive to test against**: de Grey's lattice is rigid at four colours (F = 8Λ, row 78; FS-74). A complete invariant
   must see why.

## Outcomes to register at the plan (each must be reachable)

- **(a) An invariant with local bounds, and a certificate scheme**, one-sided or two-sided. Aimed at §IQ item 5 the same day.
- **(b) A theorem that no invariant of a stated kind exists, or that four-colourability is undecidable.** Kooshi's certificate question
  is then answered negatively. That does not by itself send five over ℚ(√167) to the field's arithmetic: the target needs only a
  one-sided obstruction, which a no-go on complete invariants leaves open. What (b) redirects is the certificate question; if no
  one-sided obstruction of the admitted kind exists either, five comes from arithmetic (FS-59's residue-set route; FS-64's mixed
  places).
- **(c) Not landed.** Report it as not landed, with fallbacks:
  - a sharpened reduction;
  - a subclass where an invariant exists (candidates: triangle-free lattices, the ℚ(√167) case by G57; hexagonal fabric, where Baxter's
    height is the one known four-colour height);
  - a candidate family and what deciding it would take.

## Design: the reframing engine

- **Staffing:** two competitors (de Bruijn and Coxeter) and the advisor (Poros), under `plans/PROTOCOL-competitor-and-advisor.md` as
  amended at FS-73's close:
  - working files and the advisor's record live in the agents' scratch directories until hand-back;
  - identical briefs;
  - teasing hints only between competitors;
  - the advisor writes its expectation first;
  - retractions are counted;
  - each theorem's key step is re-derived by the other side or the advisor, plus one step by the owner.
- **The brief** carries the structural question, the class, G71's no-go, and the §PA the planner writes. It does **not** carry the
  owner's candidate invariants.
- **Held items.** The owner holds two candidate invariants for the advisor. The advisor offers them to both competitors at once, only
  after each has written its own first route (FS-73's ruling R1). They are deliberately outside this repository, because the
  competitors read it: `~/source/lean-dir-owner/FS79-held-items.md`. **Competitors do not open that directory.** The planner does not
  read it either, so the plan's own framing stays independent. It is the owner's to hand to the advisor at launch.
- **Phase 0, a measurement run before the competition,** because the cap is three agents:
  - one implementer runs a periodic four-colour screen of ℚ(√167) lattices, by rank;
  - plus implementer C's residue-set rule (FS-73 P2b) re-run at four colours;
  - it lists which lattices *could* need five colours. That fills §IQ item 5 and feeds FS-59;
  - it must not shape the competition's question: the brief is written from §IQ, not from the screen.
- **Budget:** the planner prices it at the reframe. As an anchor, FS-73's competition phase took about 1.5 hours of wall time and about
  400k tokens per competitor.

## What is known (pointers, not retellings)

- **Four colours:** G71; row 79; `plans/FS73-derivation.md` T29–T30 (the ℤ/2 obstruction; `G(ℤ, {1,3,4,5})` is four-colourable with no
  linear colouring).
- **Four-colour colourings:** `plans/FS73-C3-Coxeter.md` §6 (the one-sided certificates; a counterexample needs chiral phases).
  `data/fs73/records/phase-P4.md` (chiral non-additive colourings are common on loose lattices).
- **Heights:** FS-74's leads (Hubai's stripes-and-chirality description of the Moser ring's colourings; Baxter's height).
- **The ℚ(√167) proof's structure:** U = {1, v, v̄, z, z̄} × the 12 rational unit vectors; v is G7's type-M rotation at n = 42 (T45,
  G62); a half-page proof on 36 vectors.

## Relation to the other stubs

- **FS-76** asks the *extension* question: is C3-inherit true at four colours? It adds a rank-1 wall scan. FS-79 asks the *structural*
  question G72 prescribes, with derivation only. FS-79's outcomes (a) and (b) answer FS-76's questions 2–3 (certificates and
  decidability); FS-76 keeps question 1 and its scan.
- **FS-59** (five over ℚ(√167)) consumes FS-79's result; its phase 0 is shared.
- **FS-74** (the algebraic explanation) supplies the known positive.

## Provisional bearings (WORKFLOW step 2)

- **G72:** the method; this is its first planned instance, and the close counts it.
- **G71:** the no-go to get around.
- **G51** and the protocol: the design.
- **G49:** naming in the discipline's words is what imported the three-colour tool.
- **G67:** the grokkings' form.
- **G65, G69:** why search is priced out at five.
- **G57:** ℚ(√167)'s graphs are triangle-free.
- **G62, G7:** the multilayer structure that made the four-colour proof readable.
- **G21:** a search measures its enumeration.
- **G54, G38:** linear instruments are blind at five to seven. A useful invariant is integral, not a relaxation.

## Bearing on χ ≥ 6

Medium-high on the programme, and speculative.
- **Up side:** a four-colour invariant with a certificate would be the first solver-free route to five colours on lattices whose refuting patches are out of a solver's reach.
  The same move one dimension further up (five colours make the colour complex a 3-sphere) is the shape a six-colour certificate
  would take.
- **Down side:** the outcome may be (b), a no-go. That redirects the certificate question, and the hunt goes to arithmetic only if no
  one-sided obstruction survives either. It is still a
  finding.
