# FS129-MA2 — pass 2 of the cross-application audit, lane A (the arithmetic era), second part: the record

*Job FS129-MA2, brief `data/fs129/briefs/FS129-MA2-pass2.md`; a `general-purpose` agent on Opus reading Ephodos's identity
(`.claude/skills/ephodos/SKILL.md` in full, then `.claude/agents/ephodos.md` from `# Ephodos in lean-dir — the workflow` to its end). Plan:
`plans/FS129-cross-application-audit.md` § 3 Stage 3. Continues FS129-MA1 (`plans/FS129-MA1-audit.md`, its § 5.4 the starting list). Writes
only this file, `data/fs129/ma2/`, `tools/fs129_ma2_*.py` and `data/fs129/reports/FS129-MA2.md`. Started 2026-10-04 00:07 UTC. A successor,
FS129-MA3, continues from the last SAVED stage (`plans/FS129-close-inventory.md` item 52).*

## Theorems this phase proved

Each `derived`, one mind, prior art owed; handoff de Bruijn.

- **FS129-MA2-FALC-DICHO** — a Falconer fan at five colours has χ(H) ≥ 4, and when χ(H) = 4 it forces its apex and tip equal at four colours (so in
  any four-colourable host it is a four-colour forcer). [hand] — § 2.2
- **FS129-MA2-FALC-GAP4** — a Falconer fan at five colours has no homomorphism into a graph with a proper four-colouring gapped at the tip's image
  (MA1's FALC-T clause (3) at the class its argument carries). [hand, control FS129-MA2-GAPK] — § 2.2
- **FS129-MA2-FALC-HOSTS** — no Falconer fan at five colours over a real number field with a usable prime of residue field 𝔽₃ or 𝔽₇ or a dyadic place
  ramified in F(i), nor in a lattice with a gapped four-colourable quotient; in de Grey's lattice t − a ∈ 8Λ; over ℚ(√59), ℚ(√83), ℚ(√131),
  t − a ∈ R ∩ 𝔓⁴ and one fan would make every four-colouring of the plane periodic (row 88). [derived from the two above, rows 78, 88; control
  FS129-MA2-G7GAP] — § 2.2

## Stage 1 — SAVED (readback, registered expectations)

### 1.1 Readback of the brief's quotations (standing rule 3)

Checked by script, `data/fs129/ma2/readback.py` (exact substring, whitespace normalised), 2026-10-04 00:09 UTC; with `--fault` (a word
appended to every quotation) it reports 5 of 5 mismatches, so it reads the claim.

| quotation | source named | found |
|---|---|---|
| "Right after this close, we'll be refining the workflow again... File that as a special case stub for after the workflow refinements." (full text) | `plans/STUB-cross-application-audit.md` § The request | verbatim |
| "1. yes, we don't want O(N^2) here. 2. Yes, keep to the cap, … so it'll pick up the latest changes." (full text) | `plans/FS129-cross-application-audit.md` § 1 | verbatim |
| "Also a note for the whole plan that not only are "hubs" important, but deep "roots", … even if it has only one offshoot" (full text) | `plans/FS129-cross-application-audit.md` § 1 | verbatim |
| "where else can we use that identity?" | `plans/FS116-close-inventory.md` item 142 | verbatim |
| MA1's method, "take a held composition, … meets the wider hypothesis." | `plans/FS129-MA1-audit.md` § 5.4 note (3) | verbatim |

The brief's item references check: FS-116 inventory items 122 (FS116-Y4 DONE), 124 (the vacuity corrections), 127 (the G83 instance), 142
(Kooshi on V6-HUG); FS-129 inventory items 52 (successive agents) and 70 (the ownership finding: G71 split, G13 two, G54's last paragraph
separate, row 66 under four grokkings). **No mismatch; no finding about the brief.**

### 1.2 What I had read when I registered

The brief; the identity in full and the lane workflow (§ Where you sit to § What leaves your lane); `plans/STANDING-RULES.md`; the plan; the
stub's § Why now, § The question and § Bearing on the answer; `data/fs129/demand-judged.md` §§ 1–2; `plans/FS129-MA1-audit.md` in full and its
report; `plans/FS129-close-inventory.md` items 50–74. **Not yet read:** any grokking body on my list, pass 1's records beyond what MA1 quotes,
the index, any derivation file.

### 1.3 Registered expectations (before reading the corpus; scored at FS129-Z1)

My prior, from MA1's scored registration: the yield in lane A came from reading held compositions at the class their arguments carry, not from
the rarely-cited grokkings, which were mostly retired finite-witness methods. My list is MA1's remainder: by mentions it starts with G1 (the 4/5
wall's mechanism), G21 (a method), G35 (the 2-adic wall), then a long tail of entries cited one to eight times. The tail's mechanisms are
mostly field-level (residue targets, towers, characters, `Θ`-certificates, the local–global theorem's pieces); they can bear unapplied inside
the arithmetic era (a field or target a milestone did not name) more readily than across eras. The regularity era reaches the arithmetic only
through the collapse field and through finite configurations seen by a measurable colouring (pass 1, MA1).

| id | expectation | value |
|---|---|---|
| MA2-E1 | mechanisms I reach in this job (of 47) | expected 28; range 15–47 |
| MA2-E2 | of those reached, mechanisms that bear somewhere unapplied (a composition, a miss, or a near miss with its failing hypothesis named, beyond pass 1's and MA1's) | expected 6; P(≥ 3) = 0.65 |
| MA2-E3 | compositions derived (block entries) | expected 3; range 0–7 |
| MA2-E4 | misses of the FS116-Y4 kind (a milestone worked a step the mechanism would have shortened or emptied) | expected 0.7; P(≥ 1) = 0.4 |
| MA2-E5 | cross-era bearings (a lane-A mechanism on a regularity-era site) beyond pass 1's and MA1's | expected 0.6; P(≥ 1) = 0.35 |
| MA2-E6 | a composition of this pass changes the bearing on the answer (item 31's open list or the top three) | P = 0.05 |
| MA2-E7 | a held result found false on reading | P = 0.03 |
| MA2-E8 | of my mechanisms, the share that are nulls because they are retired finite-witness or search methods | expected 0.3 |
| MA2-E9 | the roots' chains (G74's `Θ₄` layers, G77's torsion local–global theorem) yield a strengthening that travels the chain | P = 0.2 |

These are instruments for G21, never caps.

## Stage 2 — SAVED (the Falconer fan one colour below: G43's plane at 7, G48's tightness, G54's slack face, G68's gapped quotients, G76's type-(B) frame)

*Read for this stage: the bodies of G1, G4, G7, G9, G12, G14, G16, G21, G23, G24, G26, G27, G29, G31, G32, G34–G38, G40–G45, G48, G52, G53,
G57–G65, G68–G70, G73–G76, G79, G80, G2, G3, and G13 and G54 (MA1's, for the two faces the brief names); `LEDGER.md` rows 34–41, 59, 78, 88, 111,
131, 133, 145; `Proofs/HadwigerNelson/Instances/PlaneFreedom.lean` (the plane at 7) and `FanGap.lean`'s `Slack`; `plans/FS89-derivation.md` §§ 2–5
(the lane-A roots); pass 1's lane-A record § 3.2–4.1; the regularity-era reframe tables (`plans/FS107-stability.md`, `FS110-tangency-seam.md`,
`FS111-cone-scale.md`, `FS112-unit-arc-half.md`, `FS114-unit-arc-question.md`) for every grokking on my list; the index's mention contexts
(`data/fs129/ma2/mention-contexts.txt`, written by `data/fs129/ma2/q.py`).*

### 2.0 Ownership received (the coordinator, 2026-10-03, during stage 2)

G2 (construction grammar) and G3 (radially crystal, angularly detuned) are added to my list: lane R's pass 2 reports them lane A's by content,
item 51's majority having come from homonyms (FS-106's `[G2]`, `[G3]` labels; FS-125's open places G1–G3). The same homonym inflates G1's and
G4's counts here: G1's six lane-R mentions are FS-106's gap label `[G1]`, FS-111's condition `(G1)` and FS-116's case list; FS-89's "G1, the
gluing" is a step name; G4's two are FS-106's `[G4]`; G27's FS-56 mentions are a graph named `G27`; G31's M49 mention a graph named `G31`. Both
are audited in stage 3's table.

### 2.1 The mechanism family, and why it comes first

FS129-MA1-FALC-T (`plans/FS129-MA1-audit.md` § 3.1) has three clauses about a Falconer fan at five colours mapped into a target `T`. MA1 drew
its consequences at five colours (Γ₁₁, Γ₁₉, by orbit computations) and two corollaries — no fan over a field with `L ≤ 3`, and the apex–tip pair
forced at four colours in any four-colourable field plane, such as K's. **What its argument uses is less than its clause (3) assumes**: clause (3)
spends two absent colours; the contradiction needs one colour absent everywhere (any four-colouring read as a five-colouring supplies it) and
one gap at the tip's image. So the class the argument carries is every target with a four-colouring gapped at `ρ(t)`, and the record holds such
targets under four of my grokkings, none of them applied to the fan: **G43's plane at 7** (four-colourable, the kernel's `circ7Table`), **G54's slack
face** ("gaps … found at 7, 11, 19"), **G68's gapped quotients** (FS70-T9's hexagonal fabric over ℚ(√3,√5), FS81-T24's 49 lattices over ℚ(√47)), and
**G48's tightness mechanism**, which is the same repaint seen from the field (a pair forced at `k` over a field sealed at `k` by a usable prime
whose plane is `k`-colourable is trivial). And clause (2), read with `T = H` itself, turns a four-colourable fan into a four-colour forcer — the
object **G69** and **G76** classify (rows 78, 88). The site is J13 (FS-104 route (b): a Falconer fan at five colours gives `χ_m(ℝ²) ≥ 6`,
FS129-OA1-FALC-RED), and the Searcher's held request for fans (`plans/SEARCH-QUEUE.md` row 3).

**Kind of input delivered** (the card's list): a modification lemma (the repaint at the tip) and a compulsion read through a target's colouring —
here used to exclude whole fields and lattices as hosts, and to place the rest inside the four-colour rigidity theory.

### 2.2 The entries

derivation: FS129-MA2-FALC-DICHO
  statement: let H be a finite graph with an apex a and a tip t, t ≠ a and t not adjacent to a, forming a Falconer fan at five colours (every
    proper five-colouring of H − a in which N(a) avoids two colours c₁, c₂ gives t one of c₁, c₂); then χ(H) ≥ 4, and if χ(H) = 4 then every
    proper four-colouring of H gives a and t one colour
  uses only: FS129-MA1-FALC-T clauses (2) and (3), with T = H and ρ the identity map
  not claimed: that any Falconer fan at five colours exists; the converse — a pair forced equal at four colours need not be a fan at five
    (Harder's 745-point graph forces its pair at distance 8/3 at four colours over K, and is no fan at five with that apex and tip, since 8/3 is a
    unit at K's primes of residue field 𝔽₁₁, FS129-OA1-FALC-11); anything about a fan with χ(H) ≥ 5 beyond that bound
  argument: § 2.3 The arguments
  verdict: derived
  grade: hand
  minds: 1
  model: no fan at five colours is known; the argument one colour down, on the unit rhombus a, b, c, t (a Falconer fan at four colours, MA1's
    model): χ = 3 and every proper three-colouring gives a and t one colour (row 58: the rhombus forces) — control FS129-MA2-GAPK
  prior art: owed — in-house inputs (FS129-MA1-FALC-T); not searched
  handoff: de Bruijn — two lines over FS129-MA1-FALC-T's lemma: `Fan H 5 t [a₁, a₂]` with `H.Colorable 4` gives `Forces H 4 a t`

derivation: FS129-MA2-FALC-GAP4
  statement: let H, a, t be a Falconer fan at five colours as in FS129-MA2-FALC-DICHO and ρ : H → T a graph homomorphism; then no proper
    four-colouring of T leaves a colour absent from the closed neighbourhood N_T[ρ(t)]
  uses only: that a proper four-colouring C of T, read as a five-colouring, leaves the fifth colour absent everywhere; that C∘ρ restricted to
    H − a is a proper five-colouring in which N(a) avoids C(ρ(a)) and the fifth colour; row 66's single-vertex repaint at t (t is not adjacent to
    a, and its neighbours map into N_T(ρ(t)))
  not claimed: the five-colour analogue (a five-colouring of T gapped at both ρ(a) and ρ(t) only confines the tip's colour to {C(ρ(a)), the gap},
    FS129-MA1-FALC-T clause (1)); anything about targets whose four-colourings are all gap-free at ρ(t) (K's dyadic targets, U₃₂, the type-(B)
    planes), where FS129-MA2-FALC-HOSTS's confinement clauses take over
  argument: § 2.3 The arguments
  verdict: derived
  grade: hand
  minds: 1
  model: no fan at five colours is known; the argument one colour down (a fan at four colours, a three-colouring gapped at ρ(t)) holds on every
    graph with at most six vertices receiving the unit rhombus — 26,979 labelled graphs, no violation; reading the gap on the open neighbourhood
    instead, 36,030 violations at five vertices (control FS129-MA2-GAPK)
  prior art: owed — FS129-MA1-FALC-T clause (3) is the case of a three-colourable T; not searched
  handoff: de Bruijn — a lemma beside `not_fan_of_fanGap` (`FanGap.lean`), for `Fan H′ 5 t [a₁, a₂]` with H′ the doubled-apex graph and a
    `T.Coloring (Fin 4)` with `FanGap C (ρ t) γ`

derivation: FS129-MA2-FALC-HOSTS
  statement: let H ⊂ F² be a finite connected unit-distance graph over a real number field F, with apex a and tip t forming a Falconer fan at five
    colours; then (i) F has no usable prime of residue field 𝔽₃ or 𝔽₇ and no place above 2 ramified in F(i); (ii) if H is drawn in a lattice Λ
    with its complete unit-vector set U and some finite quotient Cay(Λ/NΛ, U mod N) has a proper four-colouring with a colour absent from a closed
    neighbourhood, there is no such H; (iii) if H is drawn in de Grey's lattice, t − a ∈ 8Λ; (iv) if F is ℚ(√59), ℚ(√83) or ℚ(√131), then
    t − a ∈ R ∩ 𝔓⁴ (R = ℤ[U_F], 𝔓 the dyadic prime) and every four-colouring of F² is periodic
  uses only: FS129-MA2-FALC-GAP4 and FS129-MA2-FALC-DICHO; for (i), the residue map at a usable prime 𝔭 as a homomorphism of H, translated to put a
    vertex at 0, into Γ_q (FS129-MA1-FALC-19's step: −1 a non-square in 𝔽_q), the kernel's gapped proper four-colouring of Γ₇ (`circ7Table` along
    `projAlong (1, 2)`, `Instances/PlaneFreedom.lean`; control FS129-MA2-G7GAP) moved by a translation of Γ₇ to put its gap at the tip's image,
    χ(Γ₃) = 3, and a place above 2 ramified in F(i) giving χ(F²) ≤ 2 (G35); for (ii), the quotient map Λ → Λ/NΛ and the quotient's translations;
    for (iii), row 78 (`F = P = 8Λ` on de Grey's lattice); for (iv), row 88 (`F(R) ∈ {0, P(R)}`, `P(R) = R ∩ 𝔓⁴`) and that H connected puts t − a
    in R
  not claimed: that any fan exists in the planes (iii) and (iv) leave open; anything over K beyond MA1's (FS129-OA1-FALC-11 at the primes of residue
    field 𝔽₁₁, and row 59's dyadic law, already confine t − a there); the fields whose only four-colourable residue targets are dyadic inert U_Q
    with Q ∈ {4, 8, 16} — whether those targets have a gapped four-colouring is not decided (a search request); fields with L(F) ≥ 5, where H may
    be five-chromatic and nothing here applies
  argument: § 2.3 The arguments
  verdict: derived
  grade: derived from: FS129-MA2-FALC-GAP4, FS129-MA2-FALC-DICHO
  minds: 1
  model: (i) at ℚ(√11) — 11 ≡ 2² (mod 7), so 7 splits and the prime above it has residue field 𝔽₇, and the plane is four-chromatic (row 73) — so
    no finite connected unit-distance graph over ℚ(√11) is a Falconer fan at five colours; (ii) FS81-T24's 49 gapped lattices over ℚ(√47);
    (iii), (iv): hypotheses inhabited by the lattice and the fields themselves, the conclusion conditional on a fan
  prior art: owed — in-house inputs; not searched
  handoff: de Bruijn — (i) over `finitePlane7` and `PlaneRotation`'s residue homomorphism; (iii) and (iv) wait on rows 78 and 88's Lean forms

control: FS129-MA2-G7GAP
  of: FS129-MA2-FALC-HOSTS — clause (i)'s input: the kernel's four-colouring of Γ₇ is proper and gapped (14 of 49 vertices; every vertex by a translation)
  run: python3 ../tools/fs129_ma2_fangap.py gamma7 | tail -1
  expect: proper=True gapped=14/49
  fault: python3 ../tools/fs129_ma2_fangap.py gamma7 --fault | tail -1

control: FS129-MA2-GAPK
  of: FS129-MA2-FALC-GAP4 — the argument one colour down: on every labelled graph with five vertices receiving the unit rhombus, no proper three-colouring is gapped at the tip's image, and the rhombus satisfies DICHO's analogue
  run: python3 ../tools/fs129_ma2_fangap.py gapk 4 5 | tail -1
  expect: K=4 N=5 violations=0
  fault: python3 ../tools/fs129_ma2_fangap.py gapk 4 5 --fault | tail -1

### 2.3 The arguments

*FS129-MA2-FALC-DICHO.* By FS129-MA1-FALC-T clause (3) with `T = K_{χ(H)}` and `ρ` a proper `χ(H)`-colouring, `χ(H) ≥ 4` (MA1's own reading of
the clause). If `χ(H) = 4`, take `T = H`, `ρ = id`: `T` has a proper four-colouring, so by clause (2) every proper four-colouring of `H` gives `a`
and `t` one colour. ∎ *Why it matters:* in a four-colourable host a fan has `χ(H) ≤ 4`, hence `= 4`, and is itself a finite four-colour forcer of the
pair `(a, t)` — so its tip distance `|t − a|` is a four-colour forced distance, and everything the record knows about four-colour forced pairs
applies to it: row 66 (none survives a slack target), G55's chain theorem (every four-colouring of the plane periodic under `(t − a)ℤ[U_F]`), G48's
tightness mechanism, rows 59, 78, 88.

*FS129-MA2-FALC-GAP4.* Suppose `C` is a proper four-colouring of `T` and `γ′` a colour absent from `N_T[ρ(t)]`; read `C` as a five-colouring whose
fifth colour `5` is absent everywhere. `C∘ρ` restricted to `H − a` is proper, and `N(a)` maps into `N_T(ρ(a))`, which misses `C(ρ(a))` (properness)
and `5`; so it is admissible for the fan with `{c₁, c₂} = {C(ρ(a)), 5}`, and `C(ρ(t)) ∈ {C(ρ(a)), 5}`, so `C(ρ(t)) = C(ρ(a))`. Repaint `t` alone with
`γ′`: still proper (`t ∉ N(a)`, and `t`'s neighbours map into `N_T(ρ(t))`, which misses `γ′`), still admissible, so `γ′ ∈ {C(ρ(a)), 5}`, so
`γ′ = C(ρ(a)) = C(ρ(t))` — but `γ′` is absent from `N_T[ρ(t)] ∋ ρ(t)`. ∎ The three-colourable case is MA1's clause (3); the general case needs
one colour absent everywhere and one gap at the tip, which a gapped four-colouring supplies.

*FS129-MA2-FALC-HOSTS.* (i) Translate `H` to put a vertex at 0. At a usable prime `𝔭` of residue field `𝔽_q`, `q ≡ 3 (mod 4)`, every unit vector of `F`
is `𝔭`-integral (`−1` is a non-square in `𝔽_q`), so `H` (connected) lies in the `𝔭`-integral plane and reduction is a homomorphism `ρ : H → Γ_q`
(FS129-MA1-FALC-19's step). At `q = 7` the kernel's colouring `c(x, y) = circ7Table[y − 2x]` is a proper four-colouring of Γ₇ with gapped vertices
(control FS129-MA2-G7GAP: 14 of 49, gap colour 3); a translation of Γ₇ is an automorphism, so some translate is gapped at `ρ(t)`, against
FS129-MA2-FALC-GAP4. At `q = 3`, Γ₃ is three-colourable (`finitePlane3_colorable_three`), which gaps every vertex. A place above 2 ramified in `F(i)`
gives `χ(F²) ≤ 2` (G35), and with `T = F²`, `ρ` the inclusion, a two-colouring read as a four-colouring gaps every vertex. (ii) The quotient map is
a homomorphism of `H` into `Cay(Λ/NΛ, U mod N)` (`U` complete, none of it in `NΛ`), a Cayley graph, so a gap anywhere is a gap at the tip's image
after a translation. (iii) De Grey's lattice graph is four-colourable, so `χ(H) = 4` and `H` forces `(a, t)` at four colours (DICHO, and clause (2)
with `T` the lattice graph): every four-colouring of the lattice identifies `a` and `t`, and by translation every pair at difference `t − a`, so
`t − a ∈ F = 8Λ` (row 78). (iv) `F²` is four-colourable for these fields (row 88's periodic colourings), so as in (iii) `t − a`, which lies in `R`
because `H` is connected, is a difference every four-colouring of `F²` identifies: `t − a ∈ F(R)`. Since `t ≠ a`, `F(R) ≠ 0`, so by row 88's
dichotomy `F(R) = P(R) = R ∩ 𝔓⁴`: every four-colouring of the plane is periodic. ∎

**Consequences, read off the entries (not separate claims).** (1) *Where a fan can live.* By G54's list ("a stable place's target is
four-colourable iff … only 𝔽₃, 𝔽₇, dyadic inert `Q ≤ 32` and dyadic ramified"), a Falconer fan at five colours in a four-colourable field plane
needs every four-colourable residue target of its field to be a dyadic inert `U_Q` gap-free at four colours: `U₂ = K₄` and `U₃₂` (Hoffman-tight, G54)
are; `U₄`, `U₈`, `U₁₆` are undecided (search request). Elsewhere a fan is five-chromatic and lives only in a plane needing five. (2) *What it is
there.* A four-colour forcer of its apex–tip pair, with the tip at irrational-angle distance `r > 1/2` (FALC-RED's hypothesis) and FALC-11's and
FALC-19's congruences at every prime of residue field 𝔽₁₁ or 𝔽₁₉. **The search the Searcher's row 3 describes is therefore a search among four-colour
forcers in rigid fabric** (K-like, or type-(B), where one fan would answer row 88), or among five-chromatic graphs in planes needing five — never in
loose fabric. (3) *Two routes, not independent.* HOSTS (i) also follows from DICHO and row 66's `Slack.forces_iff_of_hom` at four colours (Γ₇ is slack
at four, `Slack` in `FanGap.lean`); both routes are the same repaint, so they count as one.

**A generalization for pass 3 (not an entry).** FS129-MA1-NOAFF5's argument uses five colours only through the slackness of `T` at five; at any `k`
it reads "a finite graph with a homomorphism into a target slack at `k` satisfies no affine identity on the `(k − 1)`-simplex embedding across its
proper `k`-colourings". At `k = 4` its instances are Γ₇ (the gapped table above) and every three-colourable target: so G75's four-colour annihilator
format has nothing to find over any field with a usable prime of residue field 𝔽₃ or 𝔽₇ — the affine form of row 66's "every pair free" there, and
consistent with FS86-Cx-C11 (on type-(B) planes such an identity exists iff `F(R) ≠ 0`).

### 2.4 The mechanisms this stage audits

| G | what it is (address) | used where (ids; homonyms removed) | bears unapplied |
|---|---|---|---|
| **G43** the residue plane seals fields (`.claude/skills/grokkings/SKILL.md` G43; rows 52, 53) | a usable prime's residue map is a homomorphism into Γ_q | M53-T1, M58-T2, M59-T6, M63H2-T3, R52-T4; every field listing | **yes — a composition**: Γ₇ as a target for the fan, never asked (FS129-MA2-FALC-HOSTS (i)) |
| **G48** the tightness mechanism (G48; rows 61, 66) | a pair forced at `k` over a field sealed at `k` by a `k`-colourable usable plane is trivial | ASTRA-T8, FS50-T6, FS91-J02-T3, J17-T3, M61-T1, M61-T5, M63H2-T11, MASCOT-T4 | **yes, the same composition**: at `k = 4` with Γ₇ the mechanism kills the four-colour forcer DICHO makes of a fan (§ 2.3 (3)); MA1's note (row 66's consumer) stands for `k = 5` |
| **G54**'s slack face (MA1 audited its tight face; brief: check the gap-free pullbacks) | slack permits gaps; "found at 7, 11, 19" | MA1 § 3.3's 23 ids | **yes** at 7 (above). **Gap-free pullbacks in products** (rows 114–115): null — no audit site has a product target the fan or a regularity-era step meets; FS121-D3-SWAP1D's circle is a disjoint union of five-cycles, not a product (MA1 § 3.3) |
| **G68** ask the quotient, read it for a gap (G68) | a gapped quotient colouring frees every pair on the lattice | FS73-T32, FS79-T40, FS81-T22, FS81-T24 | **yes**: the gapped lattices exclude fans (HOSTS (ii)) |
| **G69** rigidity is arithmetic, decided on the quotient (G69; row 78) | periodic colourings are residue colourings; forced pairs need Kempe-rigid targets | none by number (the index lists no mention; FS-70, FS-73 by content) | **yes**: DICHO places every four-colourable fan among four-colour forcers, so in G69's rigid fabric only (HOSTS (iii)) |
| **G76** four-colour rigidity over a field is local plus one extension question (G76; rows 88–92, 111–113) | `F(R) ∈ {0, P(R)}` on type-(B) fields | FS91-J12-MS, R88-TC | **yes**: a fan in a type-(B) plane answers row 88 (HOSTS (iv)); cross-era null — its measure half (row 124) is already FS-104's input |

## Stage 3 — SAVED (the other 44 mechanisms, G2 and G3 among them; the roots)

*Method for every row: the grokking's body read in full; its mention list from `data/fs129/index/grokking-uses.md` read in context
(`data/fs129/ma2/mention-contexts.txt`) and homonyms removed; the regularity era checked by content through the five reframe tables that walked
every grokking from inside a regularity-era question (`plans/FS107-stability.md`, `FS110-tangency-seam.md`, `FS111-cone-scale.md`,
`FS112-unit-arc-half.md`, `FS114-unit-arc-question.md` — each row says *bears* or *silent* with its follow-up), and each *bears* followed to see
whether the follow-up was done (G68's torus count: FS114-derivation's torus identity and `plans/STUB-route-t-count.md` — done; G29/row 41: named
as C-CS-1's kernel neighbour, FS106; G58: FS116-Y4-SYM uses its frame); the arithmetic era checked against the fan family of stage 2, MA1's
compositions and pass 1's. "Finite-witness method" means a method for building or reading finite unit-distance witnesses, a route Kooshi has
closed for six (`CLAUDE.md` § Publication: "search for a finite graph is out").*

### 3.1 The table

| G | what it is, in one sentence (address: the grokkings file by number) | kind of input it delivers | used where (ids; homonyms removed) | bears unapplied? (with what was read) |
|---|---|---|---|---|
| **G1** the field wall | over K and every wall-standing field, a residue colouring at a dyadic prime four-colours the plane (Theorem B) | a colouring by formula (a homomorphism to a finite target) | M53-T5, M63G-T5, TC1-DEGREE-BELOW-12, TC1-STANDING-FIVE, FS100-CX (the six lane-R and FS-89 mentions are homonyms, § 2.0) | **applied** in stage 2 (K as a fan host, HOSTS's not-claimed); cross-era null — no regularity-era step reads a number field (reframes: silent ×5) |
| **G21** a negative measures its enumeration | a refusal against a sufficient test measures the test; put the enumeration in the headline | a method | FS73-T20, -T27, FS79-T32, -T33, -T40, FS85-A3, -T0, FS100-C45, -X27D-FL, M50-T2, FS106-EQ, FS111-M2-DISCK7-AS-PLACED, -W-DECO-B, -W-HEXSAT, FS116-Y4-EMPTY | **applied** in both eras (reframes: bears ×5, each with its follow-up); this record's own control states its set (graphs ≤ 6 vertices). Null |
| **G35** the wall is 2-adic | a conjugation-fixed prime of F(i) bounds χ(F²) by its norm; ramified ⇒ 2, inert of norm Q ⇒ U_Q | a field-listing rule and a colouring by formula | ASTRA-T2, -T7, FS54-T2, M53-T5, M56-T6, M58-T3, M63G-T5, R57-T1, TC1-DEGREE-BELOW-12, -STANDING-FIVE, -STANDING-FOUR | **applied** in stage 2 (HOSTS (i): a ramified dyadic place excludes fans); cross-era null as G1 |
| **G7** detuning read arithmetically | every forcing rotation is the spindle family `cos θ = (2n−1)/(2n)`, radicand `4n − 1` | a construction screen (four gates) | ASTRA-T9, FS73-T45, M51-T1, M52-T1, M55-T6, M63G-T1, M63H2-T1, M63H3-T7, -T8 | **null** — a finite-witness method; a Falconer-fan search (J13) would use it only if Kooshi releases the Searcher's held row 3 |
| **G31** no held object carries a top-rung pair compulsion | arity-2 emptiness is a theorem on sealed objects, a measurement on 6-open ones | a measured null with a theorem half (row 66) | ASTRA-T10, FS25-T1, M49-T3, M54-T1, -T4, M60-T3, M63H4-T1 (M49-T2's "G31" is a graph) | **null** beyond MA1's row 66 section (brief's note 1) |
| **G44** Kloosterman control | Γ_p's eigenvalues are Kloosterman sums, so Hoffman refuses five from 59 and six from 103 | a spectral certificate | ASTRA-T4, FS50-T6, FS66-T7, FS67-DC3, FS89-S0A-13, FS91-J08-1, -J08-4, M58-T1 | **null** — applied wherever a prime is screened; no regularity-era graph is a residue plane (MA1 § 3.3: the plane's operator, rings and the five-cycle circle are slack everywhere) |
| **G73** four colours cell by cell | no cell-local topological certificate of non-four-colourability on a lattice graph; `KG(4, 2)`'s three matchings | a no-go on certificate formats | FS79-T18, -T21, -T22, -T24, -T29, -T39, FS85-C14 | **null** — applied as a no-go in FS-107's reframe (PIX, HIT); its `KG(4, 2)` reading at FS-124 case 5 was pass 1's (FS129-OA1 § 3.2: supplies the vocabulary, not the step) |
| **G4** one shell vocabulary | every five-forcer stands on one inventory of seam radii | a measured pattern | ASTRA-T7, -T8, -T9 (FS105/FS106 mentions are FS-106's `[G4]`) | **null** — finite-witness method |
| **G26** the 6-forcer reduction | `hexShell_plane`: a monochromatic pair at √3 or 2 in every colouring with fewer than seven colours | points and distances (a finite configuration) | ASTRA-T10, M45-T1, M54-T4, M56-T7, M57-T1, M60-T2 | **near miss**: at a four-colour vertex of a six-coloured fragment the ring carries two colours alternating under 60° (row 145), which already puts monochromatic pairs at √3 there — lane R's ring theorem is the stronger statement at the only regularity-era site, and a monochromatic pair at √3 or 2 costs a fragment nothing (only exact unit distance is forbidden). Failing hypothesis: a contradiction needs a virtual edge at √3 and at 2, which no measurable statement supplies. Its stationary form (a correlation inequality `n₃ρ(√3) + n₂ρ(2) ≥ 1` for a CP colouring) is one instance of FS-104 route (c)'s generic finite-configuration inequalities (J12), not a new kind |
| **G27** hidden arithmetic symmetry | a Galois flip of a multiquadratic field is a non-geometric automorphism of a witness | a symmetry (compulsion vocabulary) | FS100-CLS, FS100-G27 (FS56's "G27" is a graph) | **null** — a field automorphism maps a fan to a fan at the conjugate tip distance (free conjugate fans, nothing excluded); ℝ has no non-trivial automorphism, so no regularity-era site |
| **G57** the window is triangle-free where roomy | `ω = 3` over F iff `√3 ∈ F`; no window field holds a Moser spindle | a clique certificate on fields | FS100-Q47, FS103-635TF, FS103-F-TF, FS53-T2, FS54-T3, M59-T4 | **applied** — a remark on stage 2: 3 is a non-residue mod 7, so HOSTS (i)'s 𝔽₇ clause speaks only of triangle-free planes, where a four-colourable fan must be four-chromatic without triangles (DICHO); FS103-635TF applies it at the collapse field. Null beyond |
| **G61** three colours break at 1/3 | `1/3 ∈ ℤ[U_F]` and an odd cycle force four, any F ⊆ ℝ | a field-level relation | FS100-FAM, -T1, FS67-DB2, -DC2, -DC3, FS81-T5 | **null** — trivially true at ℝ; within lane A applied at every field listed |
| **G64** six may be no field's value | S (no field has χ = 6) implies W (χ(ℝ²) ≠ 6), not conversely | a wording rule and a gap locator | FS103-S, FS62-T3, -T4, FS86-A4, FS91-J07-7, J17-T9 | **applied** as wording in every regularity reframe (bears, "keep five and six apart"); null |
| **G38** the linear method's thresholds | coset colourings give 2, 3 or 4 colours, then nothing below 7; two colours decided by square classes | a colouring by formula; a field criterion | FS36-T1, M53-T5, -T7, -T8, TC1-STANDING-FOUR | **applied** in stage 2 through G35 and HOSTS (i) (bipartite and three-colourable fields host no fan); null cross-era (a measurable coset colouring of ℝ² by a closed finite-index subgroup is constant) |
| **G62** every witness is a twisted bilayer | the spindle family is the coincidence rotations; commensurate ⇒ periodic ⇒ bounded by a quotient | a structural reading | FS62-T4, FS73-T45, M63G-T1, M63H3-T7, -T8 | **null** — finite-witness frame; its periodic-quotient step is G68's, audited in stage 2 |
| **G63** pure transcendence is free | `χ(F(t)²) = χ(F²)`: at `t ↦ 0` every unit vector is integral and reduction is a homomorphism | a place (a homomorphism of planes) | FS103-F1, FS103-S, FS39-T1, FS91-J09-J4-A, J17-T5 | **bears — a rider, not entered**: composed with the residue map, G63's place carries HOSTS (i), FS129-OA1-FALC-11 and FS129-MA1-FALC-19 and -NOAFF5 from a number field F to every `F(t₁, …, t_n) ⊂ ℝ` (each a homomorphism, so each statement transfers). For pass 3's merge; it widens the class to configurations with transcendental coordinates, which FS-104's routes allow. It does not reach an arbitrary finitely generated `E ⊂ ℝ`: a place of `E` lands in an uncontrolled residue field (else every finite unit-distance graph would three-colour) |
| **G74** a field's plane one layer at a time | a three-colouring of F² has a field-level slope; one relation among layers decides three colours | an invariant of a colouring (a height) | FS86-Cx-C9, FS89-D2-L1, FS89-S0A-1, -S0A-2, FS91-J02-T3 | **null** — at ℝ the three-colour question is trivial; its curve form (rings) is lane R's (item 70); its roots are § 3.2 |
| **G12** the quadrature law | a detuned copy couples to its base only along one conic | a construction law | M31-T1, M54-T3, M59-T4, M62-T3 | **null** — finite-witness method |
| **G24** the gap law | below the window ω and relaxations fall while χ stays 7: the step to seven is integrality | a reading about relaxations | FS103-F-ROUND, FS111-M2-COV, M41-T1, M61-T3 | **applied** in every regularity reframe (bears; "no argument one class at a time") |
| **G37** the endgame's shape | a descent's unit part becomes five-chromatic only after one wall-breaking out-of-field point | a construction law | M53-T11, -T15, M58-T3, M59-T4 | **null** — finite-witness method |
| **G52** breaking the wall is necessary, not sufficient | the equal-radius family is the only escape from the residue colouring | a construction screen | M63G-T4, -T5, M63H2-T2, M63H3-T4 | **null** — finite-witness method |
| **G59** the wall at six is finite and fractional | χ(U_Q) ≠ 6 except at six targets, and α < Q²/6 there would settle it | a finite list; a fractional certificate | FS54-T5, -T8, FS75-H, FS91-J07-10 | **null** — MA1 § 4.2's reason (the collapse field is 6-thick, so no window member bounds it) |
| **G14** width without degree does not force | same-word copies joined by a matching carry no colour pressure | a construction law | FS79-T37, M32-T1, M63H2-T8 | **null** — finite-witness method |
| **G32** the two-distance dial | a pair forced at `k` is a `(k+1)`-chromatic graph with one non-unit edge; μ(d) = 1 at five is χ(ℝ²) ≥ 6 | a reformulation of a forced pair | M49-T3, M53-T13, M54-T4 | **applied by stage 2**: by FS129-MA2-FALC-DICHO a four-colourable fan with its apex–tip edge added is a five-chromatic `{1, r}`-graph with one `r`-edge (μ = 1 at four colours, at an irrational-angle `r`); HOSTS (i) is the dial's "μ = 1 impossible in a sealed field" at four colours. A consequence line, not an entry |
| **G41** additive colourings bound compulsions from one side | every additive colouring identifies the forced pairs; Fischer's ℤ/4 colouring of K² separates `(0, 2P)` | a colouring by formula | FS70-T1, FS79-T14, M53-T3 | **bears — a consequence line**: a fan in K² is a four-colour forcer (DICHO), so `t − a` lies in the kernel of every additive four-colouring of K², Fischer's among them — a congruence beyond row 59's dyadic law. On the one pair G41 names it adds nothing new: `2P` is a unit at K's primes of residue field 𝔽₁₁, which FS129-OA1-FALC-11 already bars |
| **G60** fractional colourings reach fields the residue method cannot | the Følner blow-up gives `χ(F²) ≥ ⌈χ_gf(H)⌉`, capped below 4.37 | a density lower bound | FS103-F-ROUND, FS73-T38, R88-TA | **applied** (regularity reframes: bears; demand list § 2's no-go); pass 1's J21 null stands |
| **G34** the field is the selection | every in-field descent point is a Moser-lattice step; Theorem B forbids an in-field endgame | a measured selection law | M52-T1, M53-T11 | **null** — finite-witness method |
| **G42** additive rigidity is closure | Kempe connectivity of every two-colour subgraph, measured with cheats | a gauge on finite objects | M3-J18-K0loc, M57-T3 | **null** — finite-witness method |
| **G45** a residue configuration lifts only if a shadow | lifting from a finite plane needs the defect to pair to zero with every self-stress | a closed design route | FS66-T8, M59-T6 | **null** — closes design-and-lift; nothing open reads it |
| **G53** the counting compulsion | at least `L` of `n` circle points share the centre's colour; `2L > n` refutes | a count | M63H2-T7, M63H3-T3 | **null** — pass 1 (J16, J24) and the FS-107/FS-110 reframes ("bears, weak": a shape for R's non-hitting count, no new instrument) |
| **G58** the antipodal conjecture | an optimal colouring of Γ_q can be taken symmetric under `z ↦ −z` up to a colour involution fixing a colour | a symmetry ansatz | FS116-Y4-SYM, FS53-T3 | **applied** in lane R (FS116-Y4-SYM's frame; FS-107/FS-110 reframes "bears, weak" as an ansatz); in a measurable setting symmetrising a random colouring is free. Null |
| **G65** the refusal phase diagram | a ball's average degree decides whether a solver answers | a search method | FS61-T5, FS79-T13 | **null** — a search method; it serves the Searcher (this record's one request is a 16- to 256-vertex question) |
| **G75** triangles pin the spectrum | a linear forbidden pattern on the tetrahedral embedding, read on the character torus | an identity (annihilator) | FS86-Cx-C11, -Cx-C13 | **applied by MA1** (NOAFF5) and stage 2's generalization note (NOAFF at four colours over 𝔽₃, 𝔽₇ fields); null beyond |
| **G80** infinite rank is the resource | `U_F` has polynomially many elements of bounded height; MR transfers by the product formula | a growth count for measure rigidity | FS103-F-DV, FS105-W-G | **null** — applied in rows 120, 128 (FS-105); the regularity era reaches it only through the collapse |
| **G9** rigidity lives only at the forcing level | compulsions sit one rung below the top: the 791-point core forces at four colours (distances 4, 4/√3) | a reading (where compulsions live) | M53-T14 | **applied by stage 2 under another name**: DICHO is G9's "one rung below" for a fan. The 791-core's forced pairs (4, `4/√3`), like Harder's `8/3` and row 78's `v`, are units at K's primes of residue field 𝔽₁₁, so none is a fan pair (FS129-OA1-FALC-11); a fan in K² needs a four-colour forced difference divisible by both, and K²'s forced group (an ideal containing `8/3`) holds such differences, e.g. `88/3` — so K stays a possible host |
| **G16** the distance-2 pigeonhole | Theorem B's colouring identifies every positive-valuation pair; √3-clean four-colourings of the Moser lattice are residue (MASCOT-T6) | a pigeonhole on fabric | M49-T2 | **null** beyond G41's line: over K the √3-clean colourings are the two residue colourings, which give row 59's law for a fan |
| **G23** refining is not a route down | the cell family's requirement is not monotone in scale | a measured null with kernel points | FS100-B3 | **applied** (FS-107 reframe: bears, "a W family's grid scale is not a driving parameter") |
| **G29** the cell family is a dial, closed | cell-constant colourings need 7 at every scale; row 41's limit lemma | a closed route; a compactness lemma | FS56-T6 | **applied** — row 41 is C-CS-1's kernel neighbour (FS106-derivation), FS-107 and FS-111's reframes; a Lean slot for it is owed to FS-101 (`plans/FS106-regular-half.md` l. 742) — already recorded |
| **G36** the residue colouring is the canonical separating colouring | on a K-point descent stage it separates the seed's pair and is monochromatic on every distance-2 cheat | a colouring by formula on finite stages | M53-T13 | **null** — finite-witness method |
| **G40** absorption | a vertex set whose colourings all extend carries only its induced subgraph's compulsions | a modification lemma | M55-T2 | **applied** (FS-107, FS-111 reframes: the hole is the spare colour); for a fan, absorption is why the tip must be joined thickly — the definition already demands it. Null |
| **G70** √3-clean is residue | a four-colouring of the Moser lattice with no monochromatic √3-pair is a residue colouring | a hexagon lemma | FS73-T8 | **null** — its hexagonal shell is the four-colour sibling of row 145's ring (two colours alternating under 60°, six colours), which lane R holds independently; no step reads the four-colour version |
| **G79** a wall arrives as a counterexample's invariant | flip a no-go's wanted poster to what every actual solution carries | a method | FS100-FLK | **applied** in every regularity reframe (bears, § IQ); null |
| **G2** construction grammar (added, § 2.0) | rings of vertices about a point mark a rotation centre of the construction | a reading of finite witnesses | FS89-S0A-4, -S0A-8 (a step label); the FS-106 and FS-107 mentions are FS-106's `[G2]` | **null** — finite-witness method; no audit site |
| **G3** radially crystal, angularly detuned (added) | the certified witnesses' centre radii lie in ℚ(√33); the new field lives in the angles | a reading of finite witnesses | none true (FS89's are step labels; FS105, FS106, FS116 mentions are labels `[G3]` and FS-116's case G3) | **null** — finite-witness method; no audit site |

### 3.2 The lane-A roots (the brief: weigh them when G74 comes up)

The lane-A roots in `data/fs129/index/roots.md` are FS-89's and FS-91's chains: FS89-S0B-C1 (depth 8) → S0B-T1 → D0-T1 → D1-L5 → D1-C1 → D1-C2 → D2-T1 →
CL2 → CL3, and FS91-J01-1 (depth 7) → J01-2 → J01-6 → J01-5 → {J01-7 | J08-10 | J08-9} → FS89-S0A-10 → CL2 → CL3; FS89-S0A-4 → S0A-3 → S0A-2 → D2-L1 →
D2-T1 → CL2 → CL3. They are G76's band-character rigidity at two primes (HD1, row 96), not G74's three-colour slope (G74 enters only through the
layer gluing, FS89-S0A-2). **Bears unapplied: null** — the chains' one consumer outside FS-89/FS-91 is G77's "a falsifier at `k ≤ 5` is no character"
(row 101), and MA1's G77 row holds the real place shut (a non-trivial character sends the unit circle onto a neighbourhood of 0). **A strengthening
that travels the chain: none found.** The root is an exact positive control and a rank-one orbit model whose consumers already use the rank-`r` form.
**A weakness on the chain, already known:** FS89-CL2 — two links above the end — is false as written (ℚ(√3), `k = 4`; the archimedean part must be
`Hom_ℚ(F(i), ℝ)` mod 1, not one embedding's `λ_e`), corrected on the front page by J24 (`plans/FS91-close-inventory.md` rows 61, 69, 78) and still
unapplied in `plans/FS89-derivation.md` (its header says so; the owner ruled the record corrections stay listed for later); FS89-CL3 is TRUE under the
wide `A`. Since every link of FS-89 is "Kernel: declined", the chain is not in `data/fs129/index/lean-order.md`; pass 3 reads it under "records that
disagree". MA2-E9 (P = 0.2 that a root yields a travelling strengthening): not met.

### 3.3 Cross-era, in one line

**No lane-A mechanism on my list bears on a regularity-era step where it was not applied.** Every grokking was walked from inside the
regularity-era questions by five reframes; each *bears* verdict I followed (G21, G23, G24, G29, G40, G53, G58, G60, G64, G68, G73, G75, G79) had its
follow-up done; the *silent* ones I re-read against the open steps (J1–J24) and found the same, with G26 the one near miss (above). The two
arithmetic-era doors pass 1 named (TOP₆'s coverage, FS-104's correlations) and MA1's (the Falconer fan) remain the only ones; stage 2 widened the
third. MA2-E5 (expected 0.6 new cross-era bearings): 0 new sites; one deepening of J13.
