# Find the base — the next session's only mission

*Written 2026-09-12 at Kooshi's instruction: **"the next session will be dedicated to finding our new base,
and only that."** Self-contained on purpose. Read this file first and whole; §4 says which other files to
open and in what order. Everything here is a quote, a measurement with its address, or a decision with its
reason.*

---

## §1 — The mission, in one paragraph

Every known unit-distance graph needing five colours, including the 509-vertex record
(`[Parts2020a]`), is built from **one lattice** joined to a **rotated copy of itself**. Only one rotation
angle has ever worked. Last night established that this is a fact about **his lattice**, not about the
angle: a second rotation exists whose only defect is that his lattice lacks a single point, and that point
exists in the field. A base containing it was built, and it **defeated the four-colour argument that had
killed that rotation** — but the resulting graph is still four-colourable, and the measurement says by how
little. **Your mission is to find a base that closes that gap.** It reduces to one arithmetic quantity,
stated exactly in §2.

---

## §2 — The target, exactly

**The quantity to maximise is the number of module points lying on one fixed circle.** Verified as a
bijection on both instances that exist — one point on that circle ⟺ one usable cross edge:

| base | points on its circle | same-colour cross edges | verdict |
|---|---|---|---|
| `[Parts2020a]`'s lattice at his angle `ρ₁₅` | **30** on `\|p\|² = 4` | **30** | **refuses four colours** (the record) |
| his lattice at angle `5/16 − (3/16)√33` | 18 | 18 | four-colourable |
| **the base built last night** for the new angle | **8** on `\|p\|² = (7+√33)/3` | **8** | four-colourable |

**So the question is: can a module in ℚ(√3,√11) put ~30 points on the circle `\|p\|² = (7+√33)/3`?**

**The witness that started this** — the point his lattice lacks, at exactly that radius:

```
u = ( 1/3 − √3/2 − √11/6 ,  1/3 + √3/2 + √11/6 )     \|u\|² = 7/3 + √33/3 = (7+√33)/3
                                                      radius ≈ 2.061113
```

**Re-derive `\|u\|²` yourself before using it.** The check is the independent expansion in a formal square
root, **never** the cross-edge law that generated the census — a wrong law *invents* edges, and a refusal
built on invented edges reads as success (`CLAUDE.md`, measured/derived asymmetry).

**Why the count is the distance to a proof.** Delete from an arena every cross edge whose two endpoints
share a residue at one prime; what remains has every cross-edge residue difference nonzero, so the residue
colouring applies and **four-colours the arena**. Hence the gap between a candidate and a *proof that it
fails* is exactly `min` over the two primes of the same-colour cross-edge count. Measured on last night's
base: **32 at prime 17, 8 at prime 239**, and after deleting those 8, **zero** remain of 70,080 arena edges.

---

## §3 — Why this is the whole question, and the two traps in believing it

**Defeating the four-colour argument is necessary and nowhere near sufficient.** Measured over eleven
rotation classes: **six defeat it at both primes, and five of those six are four-colourable anyway.** The
only refusal is his own angle. **One in six.** So do not treat "the certificate no longer applies" as
progress on its own — last night's base already achieved that and is still colourable.

**Trap 1 — a heuristic already retired, so you do not re-form it.** Seam density **anti-correlates** with
refusal on the only two instances: the refusing class's seam endpoints have unit degree **11–13**, the
colourable one's **28–29**. "More connections at the seam" is not the lever.

**Trap 2 — do not go hunting an inverted monotonicity.** Growing a base makes the four-colour argument
*harder* to apply, so **once a base contains the witness, that elimination cannot be recovered by
enlarging the base.** That consequence is true, but it is **not** an inversion of the usual direction:
adding material makes a graph harder to colour, and makes a *sufficient condition for* colourability
harder to satisfy. One monotonicity seen twice. An earlier version of this brief called it an inversion
and an advisor corrected it; the cost of the wrong framing is that an agent spends its attention hunting
an inversion and misses the real anomaly, which is that **this filter can be defeated by breaking its
applicability rather than its conclusion** — and that matters most when you are *designing* the object it
judges. Enumerate the ways to make it inapplicable before the ways to make it fail.

---

## §4 — Read these, in this order

| file | what it is | why you need it |
|---|---|---|
| **this file** | the mission | read whole, first |
| `plans/M63-phaseH-a-base-for-a-rotation-RUN.md` **§H12** | the 8-edge measurement and the bijection | the target quantity's derivation and controls |
| `plans/POROS-2026-09-12-m63-phaseH.md` cards **PH-1…PH-9** | the advisor's ledger for stage 1 | three corrections to the requirement stamps, and the killed shortcut with its obstruction |
| `plans/M63-phaseH-a-base-for-a-rotation.md` | stage 1's standing brief | the requirement list, **with its stamps corrected by PH-1…PH-3** — read the corrections before the list |
| `plans/M63-phaseG-bases-and-rotations.md` | the rotation census | the `σ` criterion, the cross-edge law as a parameter, the endpoint bound |
| commit `94fdddc` message | stage 1's result in full | the shortest complete account of what was built and what it did |

**Tools you will not have to write:** the census tool with its per-class radius-sum spectrum; the exact
sign predicate `typem.ksign` (**a float may propose, never decide**); the cross-edge law as a parameter;
the residue colouring and its two primes; `typem_exact.py --self-test` (§1, §6, §6b are standing controls).

---

## §5 — PRIOR-ART GATE, BEFORE ANY COMPUTATION

**Mandatory** (WORKFLOW step 3a; `CLAUDE.md` G49, G50). This milestone's ancestors reconstructed a 2010
draft that was one search away, and the gate exists because of it. **The question you now hold is
classical, and it is the first time this project's question has had a standard name.**

Search it in **its own disciplines' vocabulary, never this project's**:

- **Quadratic forms / algebraic number theory** — "representation numbers of a quadratic form"; "theta
  series of a lattice"; "representation of a totally positive element by a norm form"; "shell counts";
  over a real quadratic or multiquadratic field, Hilbert modular forms.
- **Lattice geometry / sphere packing** — "shell structure of a lattice"; "kissing number"; "extremal
  lattices"; maximising the number of lattice vectors at a prescribed norm.

**Search for the question as well as the method:** *how large can a shell of a rank-`n` module over this
field be, at a fixed totally positive value?* If that has an answer or a bound in the literature, it may
settle the mission without a search. **Record a negative explicitly** — "searched X, Y, Z under these
names; nothing" is a finding about where the unworked ground is. Anything found goes into
`BIBLIOGRAPHY.md` the same day, and `tools/bib_audit.py` must stay green.

---

## §6 — Proved / inherited / unknown

**PROVED, and safe to build on:**
- `u` has **no unit-distance neighbour in his lattice at any radius** — exhaustive, not sampled: `\|u−λ\|² = 1`
  is an identity in the field, which bounds all four of his integer coordinates inside a searched box. The
  same search finds **30** neighbours of `(1,0)`, so the instrument finds them when they exist.
  **Consequence: a base for this rotation is his lattice plus at least one whole translate of it.**
- **The four-colour argument is per prime.** It applies at prime `p` iff **no** non-centre cross-edge kind
  is `p`-monochromatic, so it is defeated iff **some** kind is monochromatic **at each prime — not
  necessarily the same kind**. (PH-1; the earlier brief demanded one kind at all primes and was stronger
  than its own theorem.) At this angle prime **17 is already covered by inherited material**; only **239**
  needed new.
- **The endpoint bound is real geometry.** The cross-edge set is the same **104** edges at every radius, so
  radius 2.4495 adds 12,596 points of pure padding and no cross edge. **Do not pay for radius.**
- **Discreteness is not an obstacle.** The field is dense in the plane, but the all-conjugates disk cut
  always yields a **finite** set, so any finitely generated module is a legitimate base.
- **A killed shortcut, with its obstruction, worth more than the shortcut:** `λ₁ + λ₂ = 2cos θ`, and
  `2cos θ` is **not 2-integral at either prime**, so on every ray at this angle **one of the two partners
  is always bad**. That is precisely why the equal-radius (diagonal) kind is special.

**INHERITED — assumptions from how his lattice happens to be built, NOT requirements. Treating these as
necessary rules out the thing you are hunting:**
- **"Two families"** is a measurement on *one* object, not a theorem. **A one-family base must still be
  asked**, not discarded. A base whose only non-centre kind is the diagonal is the **minimal surviving
  configuration** — an earlier falsifier would have reported exactly that target as a failure (PH-2).
- **Symmetry closure is largely tooling** — it lets the census collapse four angles into one rotation. But
  it is **not purely** tooling: **negation closure pays mathematically**, since `λ = −1` gives
  `v(1−λ) = v(2) > 0`, making an antipodal cross pair monochromatic at **every** prime, free, at any angle
  (PH-3). A live kind the earlier brief did not know it had.
- **"Enough unit-distance structure"** is unquantified by anyone. Given §3's one-in-six base rate, **this is
  probably the binding constraint, not the circle count** — which is the one thing in this brief I would
  most like disproved.

**UNKNOWN:**
- Whether any module in this field achieves ~30 points on that circle.
- What count actually suffices. 30 refuses and 18 does not, on two instances. **That is two data points
  and not a threshold.**

---

## §7 — The trap most likely to end this badly

An instrument last night returned *"zero live families for the new angle, nine for the record's"* — a
decisive-looking negative — **with its positive control passing.** It was an artefact: the generator
restricted one coordinate to a sub-family that **cannot express the witness**, so the search could not
represent the object it was searching for. The control passed because the record's witness *was*
expressible in that shape.

**When you enumerate candidate modules, this same error will look exactly like "no base exists."**

> **Before believing any zero over a family, write down the generator's image and check the target is
> inside it.** A positive control only proves an instrument finds things **of the shape its generator can
> represent**. Say in your report that you did this.

The structural reason it bit: his lattice is a congruence lattice whose coordinates confine it to a
**4-dimensional rational subspace of the 8-dimensional field plane**, and the witness lies outside it in
**both** coordinates. So a generator built from his coordinates cannot reach the target at all.

---

## §8 — Cheap falsifiers, minutes each, before any construction

1. **Is ~30 even achievable in principle?** Bound the shell count of a rank-7 module at that value from
   above, by any means — a literature bound (§5), a counting argument, or exhaustive search in a small box.
   **If the ceiling is below ~18, the mission is over and that is a complete result.**
2. **Does the count actually have to be ~30?** Nobody has tested a base between 18 and 30. If one can be
   built at 20–24 cheaply, run it — a refusal there would be a much larger result than 30 and would retire
   the whole "maximise the circle" framing.
3. **Is the one-in-six base rate (§3) the real obstacle?** If so, the circle count is the wrong target and
   §6's unquantified requirement is the right one. Cheapest discriminator you can find, run first.
4. **Does negation closure alone (PH-3) move the count?** Free kind at every prime; check whether it adds
   to the circle count or is disjoint from it.
5. **Sanity, on a known answer:** rebuild his lattice with your own machinery and recover **30 points on
   `\|p\|² = 4`** and 30 edges. If that does not reproduce, stop — nothing downstream is believable.

---

## §9 — What NOT to do

- **Do not pursue sixfold symmetry.** A `ζ₆`-closed module containing `u` has **rank 8 and ~1.9 × 10⁸
  points**. Every base this route can build is `ζ₆`-asymmetric; that is a deliberate loss, stated as one.
- **Do not pay for radius** (§6, endpoint bound).
- **Do not re-open the joint-reduction route**, the small-half probe, or edge-thinning of his object. All
  closed with reasons: the joint route was proved worth at most five vertices; thinning his graph is a
  measurement and not a product (Kooshi's ruling).
- **Do not report "N candidates eliminated" as the result.** Seven defects found in this milestone were
  **every one** biased toward making the work look productive, because a dropped edge yields an easier
  graph, yields a colouring, and reads as a sound elimination. **The count of eliminations is the outcome
  to be least satisfied with.**

---

## §10 — Acceptance

- **§5's prior-art section exists**, with a recorded negative if nothing was found.
- **Every experiment's prediction and cost registered before it runs**, scored afterwards as met / not met /
  not decided. A prediction whose target region the apparatus cannot enter is not a prediction — **confirm
  both outcomes are reachable**, the informative one and the uninformative one.
- **Every control seen red before it is believed green**, and bound a plant on both sides
  (`0 < guarded − planted < threshold`) so it reports when it has stopped discriminating.
- **The known-answer sanity check (§8.5) reproduces 30** before any new number is believed.
- **Any candidate base states, with every verdict, its list of radius sums** — otherwise the criterion is
  re-run on the next base instead of inherited, and the base-free half of the result is lost in the
  artifact though it stays true in the mathematics.
- **A written judgement over the rows, and no aggregate verdict.** Six agreeing and one disagreeing is
  seven facts, not a score.

**And the two sentences to carry into every report:**
- **The new rotation is un-eliminated, not alive.** Nothing shows it produces anything; only that one
  argument against it can no longer be made. Forgetting this oversells the result.
- **Silence is not evidence.** The four-colour filter fires one way only. Forgetting this stops you at the
  first ambiguous answer.
