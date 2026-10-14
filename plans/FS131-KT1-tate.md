# FS131-KT1 — the five-colour chain: `TateModel F` typed, and lane T (Tate's self-duality in the form the model reads) planned

*de Bruijn, the planner (the seventh on this chain). Brief: `data/fs131/briefs/FS131-KT1-tate.md` (on `main`). Branch `fs131-wkt`,
cut from `fs131-wk9` at `aee998a46`, in the worktree `.claude/worktrees/fs131-wch`. Working files: `data/fs131/kt1/`.*

## Theorems this phase proved

None yet (a planning job; see the last stage).

## Stage 1 — SAVED: the readback

### 1.1 The quotations (standing rule 3)

`data/fs131/kt1/readback.py` reads every block of the brief that begins with `> ` and ends with `> — source: <path>`, and checks
its text, character for character, as a substring of the source on `main`. **Six quotations, six matches** (`logs/readback.log`):
W2 (`data/fs131/REQUEST-2026-10-13.md`), NF2-LEAF-21 and the two dated lines (`data/fs131/claims-NF2.md`), inventory items 791
and 775 (`plans/FS131-close-inventory.md`). **The control**: `--plant` changes one character of the first quotation
("formalized" → "formalised"); the run reports exactly that quotation as `MISMATCH` and the others `MATCH`
(`logs/readback-plant.log`, exit 0 as the plant mode requires). No finding about the brief.

### 1.2 The five facts, restated from FS131-KN9 § 4.1, each with where M8b reads it

KN9's table has seven rows; its interface paragraph names five of them as the structure's fields, and the other two (finite
`U`-orbits on `L/Λ`; `φ_t` a Borel isomorphism onto its image) are consequences of fields 3 and 4 that M8b-4 proves. The five,
in KN9's words, with the steps of `plans/FS100-X01D-derivation.md` that read each (X01D § 3, ll. 203–311, read in full here):

| # | the fact (KN9 § 4.1) | where M8b reads it (X01D) |
|---|---|---|
| 1 | "`π` with continuity and equivariance": `π : W → R̂` a continuous homomorphism, `π(u a) = rot u (π a)` | everywhere: Lemma 3.1′ (ii) (`u*`-images of a cell's lifts, l. 233), Step 3 (`μ(vB) = μ(B)`, `vB = π(v(x̃ + Q))`, l. 254), Step 6 (iii) (`u·φ_t(a) = φ_t(ua)`, l. 295), Step 7 (`g^k` on the shells, l. 304) |
| 2 | "surjectivity" | the lifts `x̃` of Lemma 3.1′ ("every lift", l. 228) and of Steps 3–5 ("a fixed lift", l. 254) |
| 3 | "`Λ` with `ker π = ι '' Λ`, `R`-stability and the two-sided bound by `O′`" (`d·O′ ⊆ Λ ⊆ d⁻¹·O′`) | Lemma PF (`C_Λ < ∞`, the upper bound, l. 205); Lemma 3.1′ (ii) (`y′ ∈ Λ`, l. 234); Step 3 (`r ∈ Λ`, l. 256); Step 4 (`z ∈ Λ` since `Λ` is an `R`-module, l. 271); Step 6 (i) (`W_{v*} ∩ Λ = 0`, from `Λ ⊆ L`, l. 291) and (ii) (finite orbits, the lower bound) |
| 4 | "`W = K + ι(O′)` with `K` compact" | in lane T: the surjectivity (`π(W)` closed); in M8b: Lemma 3.1′ (i) (`π(Q(ε))` open, so finitely many translates cover `R̂`, l. 230) — openness from the open mapping theorem, `W` being σ-compact as `⋃_{x ∈ O′} (K + ι x)` |
| 5 | "`TA F = π '' (ι L + L_∞)`" | the conclusion: Step 7 ("`μ` is carried by `⋃_t π(t + L_∞) = T + A`", l. 306) |

Two observations for stage 2, both from this reading:
- **M8b reads one inclusion of fact 5**: Step 7 concludes that `μ` is carried by `π(ι L + L_∞)`, and `ZeroEntropyCarried` asks
  `ρ (TA F)ᶜ = 0`; so it needs `π '' (ι L + L_∞) ⊆ TA F` only. The other inclusion is the bridge "from the kernel's
  `Rigidity.TA` to the derivation's `T + A`" (KN8 § Stage 4) that no consumer reads.
- **Fact 3's lower bound is read twice, and its form matters to both readers.** Step 6 (ii)'s finite orbits need `O′/nO′`
  finite with either form; fact 4's use for surjectivity and openness needs `ι(O′) ⊆ ker π`, which `d·O′ ⊆ Λ` gives only through
  the finiteness of `O′/dO′`. For the standard character `ψ(ι x) = 1` for every `x ∈ O′` (X01D l. 120: `R^∨ = 𝔡⁻¹R` up to the
  choice of `ψ`, and `𝔡⁻¹ ⊇ 𝓞`), so `O′ ⊆ Λ` holds: the sharper lower bound with `d = 1`. Stage 2 decides the form.
