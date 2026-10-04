# FS131-E2 — the claim list: the cusp case of the both-kind four-colour clause

*Fixed 2026-10-04 by Keryx. Everything quoted below is copied by script from the file named beside it; the questions at the end are the coordinator's,
written from those quotations. Inventory item 112 holds the finding and the ruling; items 116–117 the formal repair.*

## The sources

**The hand statement** — `plans/FS116-derivation.md`, derivation FS116-V5-U1 (V5's lemma, one mind; "known (FS112-U1)"):

```
  statement: let A be an arc of Γ on ω(z), of angular extent [θ₁, θ₂] about z, θ₂ − θ₁ = ℓ > 0, with inner side colour c and outer side colour c′; a
    tile of colour c with z in its closure has its cone at z in the closed cone [θ₂ − 90°, θ₁ + 90°] facing A; one of colour c′ has it in the closed
    cone [θ₂ + 90°, θ₁ + 270°] facing away; the two open side cones (θ₁ − 90°, θ₂ − 90°) and (θ₁ + 90°, θ₂ + 90°) hold neither colour; so if z carries
    both c and c′ (A is both-kind), the side cones hold two further colours and, in a non-Siamese simple fragment, z has at least four colours
  not claimed: anything when ℓ = 0; anything about tiles at z of other colours
```

**The formal statements** — `Proofs/HadwigerNelson/Plane/RingGerm.lean` on branch `fs131-w3`. As the skeleton stated them (commit `05cb0a3e`):

```lean
/-- **FS116-V5-U1**, the four-colour clause at the class it reads: if `z` (in the domain) carries both side colours of an arc
of `Γ` on `ω(z)` (the arc is both-kind), each colour has at most one tile with `z` in its closure, and each such tile's cone
at `z` is one closed angular interval, then `z` carries at least four colours. -/
theorem four_of_bothKind (hF : F.Valid) {z : ℂ} (hz : z ∈ F.dom) {θ₁ θ₂ : ℝ} {c c' : Fin k}
    (hA : F.IsRingArc z θ₁ θ₂ c c') (hc : c ∈ F.coloursAt z) (hc' : c' ∈ F.coloursAt z)
    (hone : ∀ d T T', F.TileOf d T → F.TileOf d T' → z ∈ closure T → z ∈ closure T' → T = T')
    (hint : ∀ T, F.IsTile T → z ∈ closure T → ∃ β₁ β₂, β₁ ≤ β₂ ∧ β₂ ≤ β₁ + 2 * π ∧ coneAt T z = angleIcc β₁ β₂) :
    4 ≤ (F.coloursAt z).ncard := by

/-- **FS116-V5-U1**, the row's four-colour clause: in a non-Siamese simple map, a point `z` of the domain carrying both side
colours of an arc of `Γ` on `ω(z)` carries at least four colours. -/
theorem four_of_bothKind_simple (hF : F.Valid) (hN : F.NonSiamese) (hS : F.Simple) {z : ℂ} (hz : z ∈ F.dom)
    {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc z θ₁ θ₂ c c') (hc : c ∈ F.coloursAt z)
    (hc' : c' ∈ F.coloursAt z) : 4 ≤ (F.coloursAt z).ncard := by
```

As repaired under the coordinator's ruling (commit `4f7b949d`; `four_of_bothKind_simple`'s proof is done from `four_of_bothKind`):

```lean
/-- **FS116-V5-U1**, the four-colour clause at the class it reads: if `z` (in the domain) carries both side colours of an arc
of `Γ` on `ω(z)` (the arc is both-kind), each colour has at most one tile with `z` in its closure, and each such tile's cone
at `z` is one closed angular interval of positive length (`β₁ < β₂`: no cusp at `z`; inventory item 112), then `z` carries at
least four colours. -/
theorem four_of_bothKind (hF : F.Valid) {z : ℂ} (hz : z ∈ F.dom) {θ₁ θ₂ : ℝ} {c c' : Fin k}
    (hA : F.IsRingArc z θ₁ θ₂ c c') (hc : c ∈ F.coloursAt z) (hc' : c' ∈ F.coloursAt z)
    (hone : ∀ d T T', F.TileOf d T → F.TileOf d T' → z ∈ closure T → z ∈ closure T' → T = T')
    (hint : ∀ T, F.IsTile T → z ∈ closure T → ∃ β₁ β₂, β₁ < β₂ ∧ β₂ ≤ β₁ + 2 * π ∧ coneAt T z = angleIcc β₁ β₂) :
    4 ≤ (F.coloursAt z).ncard := by

/-- **FS116-V5-U1**, the row's four-colour clause: in a non-Siamese simple map, a point `z` of the domain carrying both side
colours of an arc of `Γ` on `ω(z)` carries at least four colours, provided no tile with `z` in its closure has a cone reduced to
one direction (`hnc`: no cusp at `z`; inventory item 112). -/
theorem four_of_bothKind_simple (hF : F.Valid) (hN : F.NonSiamese) (hS : F.Simple) {z : ℂ} (hz : z ∈ F.dom)
    {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc z θ₁ θ₂ c c') (hc : c ∈ F.coloursAt z)
    (hc' : c' ∈ F.coloursAt z) (hnc : ∀ T, F.IsTile T → z ∈ closure T → ∀ β, coneAt T z ≠ angleIcc β β) :
    4 ≤ (F.coloursAt z).ncard := by
```

**The finding and the ruling** — `plans/FS131-close-inventory.md`, verbatim:

112. **Statement defect candidate — a cusp breaks `four_of_bothKind`'s route** (FS131-I3e, message 2026-10-04; `Plane/RingGerm`, FS116-V5-U1's four-colour clause):
     `hint` allows `β₁ = β₂`, so a tile's cone at `z` may be one direction (a cusp between two tangent arcs; `Simple` allows it — a Jordan domain can have a cusp).
     A cusp `c`-tile in the facing cone, a `d`-tile whose interval cone covers both side cones and the facing cone around the cusp, and a `c′` sector meet every
     hypothesis with three colours at `z` and no contradiction found locally — a local picture, not a built fragment. The plan's route (a colour in both side
     cones overlaps `c`'s or `c′`'s tile cone in an interval) needs non-degenerate cones. **Ruling**: `four_of_bothKind`'s `hint` takes `β₁ < β₂`;
     `four_of_bothKind_simple` takes a hypothesis that no tile with `z` in its closure has a cone of one direction (no cusp at `z`; the Lean form the
     implementer's). Alternative weighed: hold wave 3's landing until a deriver settles the cusp case. Why not: the repaired forms are weaker, so they cannot be
     wrong where the originals are right, and a stronger form, if the cusp case holds, is a new theorem later, not a restatement; wave 3 is nine leaves from
     landing. Confidence: high that the repair is sound; medium that the hand clause fails with cusps. **Correction owed** (to the record job / an Ephodos
     job, queued as **FS131-E2**: prove the four-colour clause with a cusp at `z`, or build the valid fragment): FS116-V5-U1's four-colour clause is held only
     with no cusp at `z`; its hand consumers — FS116-V5-DICHO, FS116-V5-CROSS-S, V5's second derivations of FS116-N3-SEMI, -PAIR, -CROSS — inherit the question.
     **Wave 4 note**: FS112-N3-NOBOTH (`noBoth`, "four colours or a repeated colour") likely has the same cusp case — for wave 4's implementer brief.

**The other row with the same clause** — `plans/FS112-derivation.md`:

**FS112-N3-NOBOTH — The centre of a both-kind unit arc is a vertex with at least four colours or a repeated colour. [hand; two minds, one blind: N3; NB3; over FS112-U1]**
*Proof:* N3 stage N3-3; NB3-NOBOTH. *Proof verdict:* TRUE. So no both-kind arc is centred at a cubic trichromatic vertex, and a three-colour (S1) centre is
a bowtie. *Rests on it:* FS112-N3-COR3, FS112-N3-PAIRS, FS112-N3-END. *Prior art:* not found in print. *Kernel:* stub — with FS-114.

## The questions

*Common setting.* As FS116-V5-U1's: a non-Siamese simple valid fragment (FS116's definitions, `plans/FS116-derivation.md` and `data/fs116/claims.md`);
`z` a point of the domain; `A` an arc of `Γ` on `ω(z)` of extent `[θ₁, θ₂]`, `θ₂ − θ₁ = ℓ > 0`, inner side colour `c`, outer side colour `c′`; `z`
carries both `c` and `c′`. A **cusp at `z`** is a tile with `z` in its closure whose cone at `z` is a single direction (a cone of zero angle). In a
simple fragment every tile is a Jordan domain, and a Jordan domain can meet a boundary point in a cusp (between two tangent arcs).

**Q1 — the cusp case of FS116-V5-U1's four-colour clause.** Is it true, with no further hypothesis, that `z` carries at least four colours, also when
some tile with `z` in its closure has a cusp at `z`? Verdicts: **derived** (the clause holds with cusps — by an argument the formal route can follow);
**realized** (a non-Siamese simple valid fragment with all of the setting's data in which `z` carries exactly three colours, exhibited exactly, its
validity checked); or a **GAP** at a named step.

**Q2 — the same for FS112-N3-NOBOTH.** Is the centre of a both-kind unit arc a vertex with at least four colours or a repeated colour, also when a tile at
the centre has a cusp there? The same three verdicts.

**Q3 — the consumers.** For each result that rests on the four-colour clause of FS116-V5-U1 or on FS112-N3-NOBOTH — FS116-V5-DICHO, FS116-V5-CROSS-S, V5's
second derivations of FS116-N3-SEMI, -PAIR and -CROSS (FS116-V5-U1's "Rests on it" line), and FS112-N3-COR3, -PAIRS, -END (FS112-N3-NOBOTH's) — does it
read the clause at a point where a cusp can occur? If Q1 or Q2 is realized: does the consumer survive as stated, survive with a named added hypothesis,
or fail (and then, is any filed ledger row or frontier statement among what fails)?

*Not claimed by this list:* which verdict any question takes; anything about tiles at `z` of colours other than `c`, `c′` beyond what the clause says;
anything when `ℓ = 0`.
