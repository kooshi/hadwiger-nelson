import Proofs.HadwigerNelson.Instances.DeGrey

/-!
# De Grey's graph admits a balanced 5-colouring (M19)

The χ = 5 lens's first exact answer, kernel-certified. The M19 §0 pools suggested every
5-colouring of de Grey's graph is forced off balance (largest colour class ≥ 21.1% of the
1,581 vertices across 1,292 solver-produced colourings); a cardinality-constrained SAT call
answered that this was **the solver's taste, not the graph's law**: a proper 5-colouring
exists with class sizes `[317, 316, 316, 316, 316]` — the exact pigeonhole optimum. No
density obstruction exists at witness scale, and pool statistics measure the sampler, not
the space (`plans/M19-coverage-driven-construction.md` §0(b), §0(c)).

## Layout

The witness travels as **one `Nat` literal, one hex nibble per vertex** (M04's `PtTable`
pattern): nibble `v` is vertex `v`'s colour. Extraction is `/ 2^(4v) % 16` — power,
division, and mod are exactly the operations the kernel does through GMP (M05's measured
list; a bit-shift would recurse per bit and an `Array (Fin 5)` layout would pay O(index)
list-walking per access — both cost minutes where this costs seconds). Two layers, as in
M06: decidable data facts over the literal, then the `Prop`-shaped headline derived by hand.
The witness is emitted from the cadical model, never hand-copied; the solver only proposed
it, the kernel checks it. Zero trust purchases.
-/

set_option maxHeartbeats 4000000

namespace HadwigerNelson

open SimpleGraph

/-- The balanced colouring of de Grey's 1,581 vertices, packed one hex nibble per vertex
(nibble `v` = colour of vertex `v`, values `0..4`). Emitted from the cadical model of the
cardinality-constrained instance (`tools/balance.py`, M19 §0(c)); provenance:
degrey_cert, n = 1581, edges_sha 379ff6cc4afb920b, k = 5, s = 317. -/
def balancedWitnessPacked : Nat :=
  0x442004442204321440002202304212441121422042204420212421133130133104321304342301004311112003303202302241331302201041144410103213231301301221123034444134202423222422404020421023104230214021434430204134244424442004433122230230044222102442301304200444314444242403120030331034140230021412313031202101423011300301132102432124433100132130341301023220131112211122013044211313230244301141422233301301323434410414033444102333420312211312222303333312342323023001121101410411012410203203223104120104123413211012032011413212340333120130310210310210121222344242323422001243024040240422124341244022301104321040013042403334333332324041434112334442443333101101423013444102331244001304401244440434303210012031103114213442323300400010102444404313440310120010302211241033144220411404332201340041011442310134234444201320123414100243114203141123314243133204431324341101412031403041142014210320011113200440431334104204120224212242233220423424320413334033444233403430322414234400230412004431034213300304220430042140041024111201003210112330203003243332032010032222342023220212233211000320411142341134234034043244300223313102122224141402331234230344111000111134031202112142142312324034114001212213300004234240403332130200113333441130030410110234043030303321243101303302343314211100113242340010124132110004444411230023443232043344341102423240242042020022140212111124242341000401124033010011014143200413321020032300113311231142411000143342333011120232424430042311121240242343044034121211324333401242040323240442440144213400442303230021140244240211111103330312321220321400130144242420043311031234014343423233431

/-- Vertex `v`'s colour: nibble `v` of the packed witness. Extracted as
`/ 2^(4v) % 16` — division, power, and mod are the kernel's GMP-accelerated operations
(M05's measured list); a `>>>` here would recurse once per bit and cost minutes. -/
def balancedColorRaw (v : ℕ) : ℕ := balancedWitnessPacked / 2 ^ (4 * v) % 16

/-- Every nibble is a real colour. -/
theorem balancedColorRaw_lt : ∀ v : Fin 1581, balancedColorRaw v.val < 5 := by
  decide +kernel

-- Stated in `List.all` form deliberately: the `∀ e ∈ list` decidable-instance reduces as a
-- nested per-cons tree the kernel re-reduces per layer — measured quadratic (> 10 min at
-- 7,877 edges), while this form is one linear fold (5 s). The pointwise `∀` is recovered in
-- `deGrey_balanced` by an elaborator-level bridge, which costs nothing.
/-- Properness on the committed edge list, decided by the kernel. -/
theorem balancedColorRaw_proper :
    (deGrey.edges.all fun e =>
      balancedColorRaw e.1.val != balancedColorRaw e.2.val) = true := by
  decide +kernel

/-- The witness as a typed colouring: the nibble, with its range fact. -/
def balancedColoring (v : Fin 1581) : Fin 5 := ⟨balancedColorRaw v.val, balancedColorRaw_lt v⟩

/-- Every colour class has at most 317 vertices — with 1,581 = 5 · 316 + 1 points this is
the pigeonhole optimum: no 5-partition of the vertices does better. Stated over the same
`Finset` the headline consumes, so no list-to-finset bridge intervenes. -/
theorem balancedColoring_counts :
    ∀ c : Fin 5, (Finset.univ.filter fun v => balancedColoring v = c).card ≤ 317 := by
  decide +kernel

/-- **De Grey's graph admits a balanced proper 5-colouring**: some proper colouring keeps
every colour class at the pigeonhole optimum of at most 317 vertices. -/
theorem deGrey_balanced :
    ∃ C : (edgeGraph 1581 deGrey.edges).Coloring (Fin 5),
      ∀ i : Fin 5, (Finset.univ.filter fun v => C v = i).card ≤ 317 := by
  have hproper : ∀ e ∈ deGrey.edges,
      balancedColorRaw e.1.val ≠ balancedColorRaw e.2.val := by
    have h := balancedColorRaw_proper
    rw [List.all_eq_true] at h
    exact fun e he => bne_iff_ne.mp (h e he)
  refine ⟨SimpleGraph.Coloring.mk balancedColoring ?_, ?_⟩
  · intro a b hab
    obtain ⟨hne, hmem | hmem⟩ := hab
    · intro hEq
      exact hproper _ hmem (by simpa [balancedColoring, Fin.ext_iff] using hEq)
    · intro hEq
      have h2 : balancedColorRaw a.val = balancedColorRaw b.val := by
        simpa [balancedColoring, Fin.ext_iff] using hEq
      exact hproper _ hmem h2.symm
  · exact balancedColoring_counts

/-! ## Negative controls

Each check shown discriminating, kernel-proven: the witness could not satisfy a tighter
bound, and a misread witness is improper. -/

/-- Pigeonhole is tight: no colour bound of 316 is achievable by this witness — some class
really does carry 317 vertices, so the counts check can fail and does not. -/
example : ¬ ∀ c : Fin 5, (Finset.univ.filter fun v => balancedColoring v = c).card ≤ 316 := by
  decide +kernel

/-- Colour 4 is genuinely used: the range check binds at 5, not below. -/
example : ¬ ∀ v : Fin 1581, balancedColorRaw v.val < 4 := by
  decide +kernel

end HadwigerNelson
