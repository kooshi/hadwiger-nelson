# FS131-E3 — the claim list: Woodall's step 3 (merging repeated colours at a vertex), as the Lean chain states it

*Fixed 2026-10-04 by Keryx. Everything quoted is copied by script from the file and commit named; the questions at the end are the coordinator's, written
from those quotations. Inventory items 150 and 156 hold the context (FS131-IW, FS131-IWb).*

## The sources

**The definitions** — `Proofs/HadwigerNelson/Plane/Woodall/Basic.lean` on branch `fs131-ww` at `f73cb1e3`:

```lean
/-- **Woodall's picture at `v`** (region-only): `n ≥ 1` sectors in counter-clockwise order, sector `i` between the directions `d i.castSucc`
and `d i.succ`, `d` monotone with `d (last n) = d 0 + 2π` (so zero-angle sectors, horns, are allowed), of colour `c i`; adjacent sectors carry
different colours (when `n ≥ 2`); `v` is a point of the domain; and the cone of each colour class at `v` is the union of the closed sectors of
that colour. The fifth clause was "for every `δ > 0` a truncated open sector strictly inside each sector lies in its colour class" until inventory
item 155 (FS131-IWb): a sector merged across an arc between two sides of one colour holds points of that arc, so no picture existed at such a point;
its readers go through the cone clause and the domain point instead (`ArcMap.exists_preconnected_of_mem_coneAt`). -/
def SectorsAt (v : ℂ) (n : ℕ) (d : Fin (n + 1) → ℝ) (c : Fin n → Fin k) : Prop :=
  0 < n ∧ Monotone d ∧ d (Fin.last n) = d 0 + 2 * π ∧
    (2 ≤ n → ∀ i : Fin n, c i ≠ c (finRotate n i)) ∧
    v ∈ F.dom ∧
    ∀ j : Fin k, coneAt (F.region j) v = ⋃ i ∈ {i : Fin n | c i = j}, angleIcc (d i.castSucc) (d i.succ)

/-- **Woodall's step 3, its conclusion**: at every point, a colour carried by two sectors is carried by zero-angle sectors only ("if two of
the regions are in the same set, then each of them subtends angle 0 at P", `[Woodall1973]` p. 197). -/
def WoodallMerged : Prop :=
  ∀ v n d c, F.SectorsAt v n d c → ∀ i j : Fin n, i ≠ j → c i = c j →
    d i.castSucc = d i.succ ∧ d j.castSucc = d j.succ
```

**The statement** — `Proofs/HadwigerNelson/Plane/Woodall/Steps.lean`, same commit (its only open leaf besides `exists_sectorsAt`):

```lean
/-- **Woodall's step 3** (`[Woodall1973]` p. 197): a valid map of the plane can be recoloured near its vertices — two sectors of one colour at
`P` are joined across a run of sectors of angle `< π` between them (every unit circle through a point of the run near `P`, except those through
`P`, passes through one of the two; the run is clear for their colour), and two horns in Woodall's cone fill it — into a valid map of the plane
whose repeated colours sit on zero-angle sectors only. The new boundary arcs are circles of small radius about the vertices, so Condition 5 is
kept. -/
theorem exists_woodallMerged (hF : F.Valid) (hP : F.IsPlaneMap) :
    ∃ F' : ArcMap k, F'.Valid ∧ F'.IsPlaneMap ∧ F'.WoodallMerged ∧ (F.Condition5 → F'.Condition5) := by
  sorry
```

**Its consumer** — the chain's theorem, same file:

```lean
/-- **FS106-AE-MAP6** (arc maps): no map of the plane bounded by a locally finite family of segments and circular arcs, coloured with at most
five colours, is almost-everywhere proper (no two interior points of one colour at distance exactly `1`; boundary points carry no colour).
"Boundaries of measure 0" is not used (the row's last clause). The chain: steps 1–3, strict step 5, step 6, E1-NO45, E1-NOBRANCH (FS131-E1's
E1-MAPS6); no step reads an angle equal to `π/3`, and nothing of Woodall's steps 7–8 is used. -/
theorem aeMap6 (F : ArcMap k) (hk : k ≤ 5) (hF : F.Valid) (hP : F.IsPlaneMap) : False := by
  obtain ⟨F', hv, hp, hM, -⟩ := exists_woodallMerged hF hP
  exact aeMap6_merged hk hv hp hM
```

**What the record holds already** — `plans/FS110-derivation.md`:

**FS110-W-MERGE — Woodall's step 3 almost everywhere for curved arcs: if `int D_c(v)` is nonempty, two non-adjacent `c`-sectors at `v` are joined by recolouring the gap inside `D_c(v)` near `v`; validity and Condition 5 kept, types only shrink. [hand; two minds, one blind: N3; NB3]**
*Proof:* N § Continuation — FS110-N3 §2.2; NB3 §2.2 (NB3-MERGE). *Proof verdict:* TRUE with two one-line repairs (NB3): choose `ρ` off finitely many
values (the step "`cl R ∩ ω(v′) ⊆ {v}`" fails at `|v′ − v| = 1 ± ρ`); fill the hole a merge of two sectors of one tile encloses (Woodall's step 1). Inputs
N3-CONF, N3-CLEAR, N3-UP (FS110-N3-CONF). *Rests on it:* N3-RED; the N4 chain. *Prior art:* `[Woodall1973]` step 3 (everywhere-proper, read by NB3 and
Y4); S–V Props. 7–8 for polygons. *Kernel:* with FS110-CLOSURE.

## The questions

*Setting.* `ArcMap k`: a map of an open set `dom ⊆ ℂ` by finitely-many-per-bounded-set segments and circular arcs, coloured on the complement of the arcs;
`Valid`: almost-everywhere proper (no colour class holds a unit pair of interior points); `IsPlaneMap`: the domain is the plane; `Condition5`: no arc is an
arc of a unit circle (Sokolov–Voronov). The definitions are on `fs131-ww`'s `Plane/ArcMap`, `Plane/LocalMap` and `Plane/Woodall/Basic`.

**Q1 — Woodall's step 3, as stated.** Is `exists_woodallMerged` true: does every valid plane arc map have a valid plane arc map, Condition 5 kept, in which
every colour carried by two sectors at a point is carried by zero-angle sectors only? Verdicts: **derived** (the modification with every clause — which
vertices, which recolouring, why it stays valid, why it stays an arc map locally finite, why it is a plane map, why Condition 5 is kept, why no new
repeated colour appears — written so a planner can state its children); **refuted** (a valid plane arc map no modification of this kind can merge,
exhibited); or a **GAP** at a named step. FS110-W-MERGE (above) is the local step at one vertex; the global modification, the clearness of the run between
two same-coloured sectors, and the horn fill are what the record does not yet hold.

**Q2 — a route around it.** Does the chain's conclusion (`aeMap6`: no valid five-coloured plane arc map) follow without the modification — for instance by
proving E1-NO45 and step 6 (no point of three, four or five sectors) for maps not in normal form, reading only the cone clause of `SectorsAt` — and if so,
at what cost in new lemmas? A route that avoids `exists_woodallMerged` entirely is as good an answer as a derivation of it.

*Not claimed by this list:* which verdict either question takes; anything about Jordan-arc boundaries (the chain is for arc maps); anything about six colours.
