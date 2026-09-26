# J47 — record of the milestone-stub writer (FS-100)

*Crunch job J47, de Bruijn (Opus 5.5), 2026-09-25. Brief: `data/crunch-2026-09-25/briefs/J47-milestone-stub-portrait-47.md`, with
`data/crunch-2026-09-25/briefs/STANDING-RULES.md` as part of it, and the owner's launch message (relayed below where it adds to the brief).
HEAD at launch: `8a78875e`. No subagents; no finite-witness search (ban to 2026-10-01). Files I touch: the new stub, one cross-reference
line each in `plans/STUB-four-colours-167.md` and `plans/STUB-windows-five-nonmixing.md`, `plans/STUB-five-colours-47.md` (cross-reference
and moved stages only), the new rows in `plans/FRONTIER-STUBS.md` and `CLAUDE.md` § Paths forward, this record, and my report.*

## Theorems this phase proved

None. This job writes a stub; every statement in it is quoted from a record with its grade.

## Stage 1 — SAVED: quotation check (standing rule 5) and the reading list

### 1.1 The brief's and the launch message's quotations, against their sources

| # | quoted | source | verdict |
|---|---|---|---|
| B1 | Kooshi: "Write up the portrait of 4 in 47 as a full milestone …"; "hold the stub writer until after the posters in case they share identities" | the owner's relay; no file holds it | accepted as the owner's relay; not checkable here |
| B2 | the gap is "the colourings with no proper factor colouring continuous at finitely many places, which is exactly the failure of the example invariant EI-2" | J36 §4.1 (a): "**EI-2: every translation-invariant four-colouring has a factor that is itself a proper four-colouring and is continuous in probability at finitely many places.**" J37 §2.1 Q4: EI-2 is "about translation-invariant random colourings (measures), not deterministic ones". J45 §5.2 item 1: J36's "shadow relation is exact" holds "one direction only (SI-4)" | **narrower object in the source** (random colourings; continuity in probability). "Exactly the failure" is right for the class, but the spectral shadow of that failure is only one-directional (SI "⟸" is a GAP). The stub uses the source's words and J45's correction |
| B3 | "pure-point: rank one is closed by T-J37-1; rank ≥ 2 is open, and J37 names the missing lemma 'Kronecker selection' (§4.5)" | J37 §3.3 (b): "**Rank one is closed** (P5). **Rank `n ≥ 2` is open.**"; J1 in §3.3 (d); the statement in §4.5 R2 | agrees |
| B4 | "continuous: the Furstenberg-type zero-entropy remainder (J36 F5)" | J36 F5: "At type (A), T-C′'s colouring-free form is the zero-entropy Furstenberg-type rigidity problem for `U` acting on `R̂`, modulo `E`." | agrees |
| B5 | "J37 §4.6: Kronecker selection 0.4, EI-F 0.30" | J37 §4.5 R2: "medium-low (0.4) that it is true as stated"; §4.3 (b): "**Registered: EI-F true at ℚ(√47), 0.30.**" §4.6's hunch ledger carries no numbers | values agree; **address slip** (§4.5 and §4.3, not §4.6) |
| B6 | "J36: EI-2 about 0.4" | J36 §4.1 (c): "Confidence **medium-low** (about 0.4) that EI-2 is true over slack fields." | agrees in value; the brief drops "over slack fields". The stub keeps it |
| B7 | "`[AmbrusEtAl2023]`'s obligation H4, the input shared by five constraints" | J37 §4.2 KT-1: "It is P4's, P5's and P7's one external, computer-assisted input, and it is shared with row 92 and T-C." | the source lists three poster rows plus row 92 (P4's own source) and T-C (type (B), not a ℚ(√47) row). With J45's grades P8 (A⁺, "given T-C(A)") and P9 (SP-Cor's route) rest on it too, so the ℚ(√47) poster rows resting on H4 are **P4, P5, P7, P8, P9** — five, by a different list. The stub names them |
| B8 | "J37's R4, a triangle-free Dúcz–Varga-type finite `H` inside ℚ(√47)² (EI-F's route)" | J37 §4.5 R4: "a finite `H ⊂ ℚ(√47)²` with `α(H) < \|H\|/4` (Dúcz–Varga-type, triangle-free)" | agrees |
| B9 | "FS-97 to FS-99 are taken" | `plans/FRONTIER-STUBS.md` ranks 12, 7, 31; `plans/FS67-close-inventory.md` row 23: "new stubs from FS-100" | agrees; FS-100 is free |
| B10 | `CLAUDE.md` "stands near 295,300" | 295,280 bytes at `8a78875e` | agrees |
| B11 | G79 | `CLAUDE.md` l.1472, G79 | agrees |
| L1 | launch: "MR(F): every rotation-invariant measure on the dual that ignores the finitely-many-place characters is Haar" | J38 §3.5 T-J38-2 (iii): "**MR(F)** is 'every `U`-invariant finite positive measure on `R̂` with `τ(E) = 0` is a multiple of Haar measure'" | a paraphrase ("is Haar" for "is a multiple of Haar"; "ignores" for `τ(E) = 0`). The stub quotes J38 |
| L2 | launch: the posters "share every step but the last" | J39 report: "the posters share every step but the last." | agrees |
| L3 | launch: T-J39-3 "modulo MR, for every totally real F and every k, F² is k-colourable iff `UD(ℝ²) × (non-k-thick stable places)` has a stationary, continuous-in-probability k-colouring" | J39 §3.2: "**So, given MR(F): `F²` is `k`-colourable iff `Y_{F,k}` has a CP `k`-colouring.**" | agrees in substance; the stub quotes §3.2 |
| L4 | launch: instances "J45's SP-Cor …, J38's T-J38-3 … and T-J39-4/5 at ℚ(√167)" | J39 §4.7: "Its instances are J45-SP-Cor, T-J38-3 (with Iso for rigidity) and T-J39-4." | T-J39-5 is not an instance in the source; it is the six-colour consequence. Minor |
| L5 | launch: "MR gives χ ≥ 5 without FS-66, and six becomes equivalent to χ_CP(ℝ²) ≥ 6, given PL(23,43) and FS-69" | T-J39-4 (J39 §3.3 (e)): "It uses neither FS-66 nor Zhang"; T-J39-5 (ii) needs MR, "43's all-levels ratio is `< 1/5`", and PL(23, 43) | agrees, with MR a hypothesis of both directions' use; "FS-69" stands for 43's all-levels ratio `< 1/5` |
| L6 | launch: SI inequality TRUE, SI ⟹ TRUE, SI ⟸ GAP; A⁺, B⁺, R-U, SP (positive reading), control TRUE; T-J37-1 TRUE with two minds | J45 §5.1 verdict table; J46 §3.2 divergence table ("Differences of truth: none") and §2.9 (W1) | agrees |
| L7 | launch: "97/529 is level one; the all-levels ratio is 0.18523" | J39 §2.1 | agrees |
| L8 | launch: "'local at no prime' is unproved at 43 at depth ≥ 2" | J39 report and §3.1 P1 | agrees |
| L9 | launch: "FS-96's places become {∞, 23, 43}" | J39 §4.5 R3: "(i) **for existence** the places are `{∞, 23, 43}`, **modulo SP**" | **narrower in the source**: the launch drops "for existence" and "modulo SP". The stub and the FS-96 line keep both |
| L10 | launch: "FS-59's bearing: closing five at ℚ(√167) needs χ_CP(ℝ²) ≥ 6" | J39 §4.5 R4: "closing five at ℚ(√167) needs `χ_CP(ℝ²) ≥ 6` (rung D in measurable form)"; T-J39-5 (i): "`χ(ℚ(√167)²) ≥ 6 ⟹ χ_CP(ℝ²) ≥ 6`" | agrees with R4, but **an ambiguity the stub must not inherit**: "closing five" there means refusing five-colourings (χ ≥ 6, the conjecture's prediction). FS-59's own question is "does ℚ(√167)² need five colours at all?" (χ ≥ 5), and T-J39-4 reduces that to MR, not to rung D. Held for the owner |
| L11 | launch: "corrections are logged in plans/FS84-close-inventory.md rows 26–28" | the inventory, rows 26–29 (row 29 is J38's shared identity, "for J47") | agrees; row 29 also bears |

### 1.2 Read (in full or at the named sections)

J37's poster in full; J39's poster §2–§4 and its theorems table; J38's poster §3.4–§3.6, §4.7 and its theorems table; J36's F5 and §4.1;
J45's theorems table, §4.2 and §5.1–§5.2; J46's §2.7–§2.9 and §3.1–§3.3; the six reports (J36–J39, J45, J46); `plans/FS84-close-inventory.md`;
`plans/STUB-five-colours-47.md`; `plans/FS84-five-colours-47.md` §4.1–§4.3; `plans/STUB-infinite-place-spectra.md` (FS-97); the heads of FS-59's
and FS-96's stubs; `LEDGER.md` rows 84, 92, 95–98, 100, 110–115 (their heads). J43's unified map: briefed (`…/briefs/J43-unified-map-visualization.md`),
not built — no `visualizations/` directory for it exists at `8a78875e`.

### 1.3 Would-have-searched-here log

- None so far: this job writes a stub.
