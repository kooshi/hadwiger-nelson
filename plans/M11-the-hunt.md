# M11 — The hunt (stub)

*Not subplanned. This is the carry-forward record required by `WORKFLOW.md` step 3, opened
2026-08-01 when M09 pushed scope here. Everything below is a **note**, not a decision.*

M11 is the composition search for a 6-chromatic unit-distance witness, on M09's gadget algebra. It is
the project's one genuine gamble (`ARCHITECTURE.md` § 7): the witness may not exist, or may be
astronomically large.

---

## Carried forward from M09

Ranked by what would bite first. **None of it is built, and none of it is measured on a search** —
M09's algebra was exercised only on constructions that already existed.

### 1. Restrict the terminal check to canonical patterns — worth up to 24×

The composition's last step enumerates all `4^m` colourings of the `m` interface vertices. Measured at
**~0.2 ms per (colouring × gadget)**: three interface vertices is free, **eight with ten gadgets is
~2 minutes**, twelve is days.

Every gadget's admitted set is closed under permuting the four colours — that is why one certificate
covers up to 24 patterns in the first place — so the enumeration only ever needs one representative
per colour-partition. `Gadget` would gain a closure field, every constructor would have to supply it
(all seven are three-liners), and `Gadget.survivors` would range over partitions.

**Trigger:** when the terminal check exceeds the certificate cost. **Not before** — M09 deliberately
left it out, and the reason it is safe to leave out is the next section.

### 2. `Motion` cannot express a translation or a reflection

`Motion.Maps` is `M·(image − centre) = [[a, −b], [b, a]]·(point − centre)`. That matrix has
determinant `a² + b² = M² > 0`, so **every motion it can express is a rotation about a point**:

* a **pure translation** would need `M·t = 0`, i.e. `t = 0`;
* a **reflection** would need determinant `< 0`.

For de Grey that was enough — his construction is rotations about points, and M09 needed exactly one.
A search will not be: the sub-copy scan in § "What was measured" below found its best matches using
reflections. Adding them means a `det : Int` field (or the `[[a, b], [b, −a]]` sibling) and one extra
case in `distSq_eq`, which is the same `ring` identity.

### 3. `Motion.comp` — motions compose, and de Grey's was a composite

The rotation M09 exploits was *derived* as `rot_b ∘ rot_a⁻¹` — by hand, in Python, outside Lean. A
hierarchical construction (de Grey's own `H → J → K → L`) composes motions constantly. The structure
was chosen so that `comp` is a field-wise definition plus one `ring` identity, but it is not written.

### 4. Placement should be definitional, not checked

de Grey's copy costs 791 coordinate identities because his vertex table is **frozen data** upstream of
1,222 certificate modules. A *new* construction can define a placed copy's coordinates **as** the
motion applied to the original, at which point `Motion.Maps` holds by `rfl` and placing a gadget costs
nothing at all. This is the version a search wants and it has never been tried.

### 5. A gadget *library*

Spindles, the layers of de Grey's own hierarchy, Exoo–Ismailescu's and Parts' gadgets. M09 built the
algebra and demonstrated it on what was already in the repository; there is no catalogue.

---

## Why none of this was done in M09

**Measured, 2026-08-01:** `Gadget.lean` and `Motion.lean` sit upstream of **5 modules and zero
generated certificate modules**. Editing them costs seconds, not hours. The freeze pressure that
justified front-loading work in M06–M08 — where touching a byte upstream of a certificate costs
27.8 hours — simply does not exist here, so there is no reason to add anything before a use demands
it, and `DEBRUIJN.md`'s injunction against speculative structure applies at full strength.

---

## What was measured, 2026-08-01, and what it means

**The search primitive M11 needs already has a prototype.** "Find the largest isometric sub-copy" —
map a reference unit pair onto every other unit pair, both orientations, and count how many points
land back in the set — recovers de Grey's structure exactly: **791 of 1581 points, 50%**, which is his
two-copy split. That is the check that would have found M09's saving without knowing de Grey's paper.

Run on the two smaller witnesses:

| | points | largest non-trivial isometric sub-copy landing in the graph |
|---|---|---|
| Heule 510 | 510 | **482 (95%)** |
| Heule 553 | 553 | **451 (82%)** |
| de Grey | 1581 | **791 (50%)** |

**Do not read those as savings.** Three caveats, all of them load-bearing:

* the scan matches **points, not edges** — whether the induced subgraphs correspond was not checked;
* a 95% overlap is a **near-automorphism, not a decomposition**. de Grey's split was useful precisely
  because the two copies *partition* the edges and meet in exactly one vertex; a copy that overlaps
  itself almost entirely splits nothing;
* the payoff would be small anyway — Heule's two certificates cost **~1 hour together** against de
  Grey's 15.

So this is not a lead to chase for the existing witnesses. It is evidence that the primitive works,
and it should be a tool in `tools/` before the hunt starts.

Also measured: **none of the three witnesses has a non-trivial rotational automorphism.** Searching
for automorphisms is the wrong search — de Grey's rotation carries one *subgraph* onto another and
carries the graph itself off into a third copy that is not in it.
