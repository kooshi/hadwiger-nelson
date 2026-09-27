# FS110-YB3 — blind verification of the construction side's round 3 (FS110-Y3)

*Job FS110-YB3, Opus 5.5, 2026-09-27. Brief: `data/fs110/briefs/YB110-verify-construction.md` with its instance block
`data/fs110/briefs/YB3-110-instance.md` and `data/fs110/briefs/STANDING-RULES.md`. Blind until stage 3 is committed: FS110-Y3's record and tools,
both earlier verifiers' records, the plan, every advisor record and the proof side's files stay unopened until then.*

## Theorems this phase proved

*(Filled at each stage; one line per theorem, its grade, its address. Stage 1 proves nothing.)*

## Stage 1 — SAVED

### 1.1 Resume check

No record, directory or tool of this job existed at start (`ls` 11:1x UTC): a fresh start.

### 1.2 Fence log

- **Touch 1 (11:20 UTC, disclosed).** Checking the tree before writing, I ran `git log --oneline -1`, which printed the **subject of the latest
  commit**, beyond the start-up snapshot: `b141228d FS-110: Cor. 1 blind-check brief; inventory`. One subject line; no content, no path, nothing
  of FS110-Y3's. Logged and not used.
- Nothing else fenced was opened, listed or grepped. Every grep of this job excludes `plans/FS110-Y-construction.md`, `data/fs110/fs110-y*`,
  `tools/fs110_y_*`, `tools/fs110_n*`, `tools/fs110_nb*`, `plans/FS110-N*`, `plans/FS110-NB*`, `plans/FS110-YB-*`, `data/fs110/fs110-n*`,
  `data/fs110/fs110-a*`, `data/fs110/fs110-yb/`, `plans/POROS-*fs110*`, `plans/FS110-tangency-seam.md`, `plans/FS110-close-inventory.md`,
  `data/fs110/reports/`, the other briefs, the transcripts and `chats-bak/`.

### 1.3 Quotation check (standing rule 5)

| quotation | source | result |
|---|---|---|
| the seven Y3 statements in the instance block | FS110-Y3's theorem list (fenced) | **deferred to stage 4**, when the record opens |
| `𝓜_K`: "periodic designs with at most `K` circular or straight arcs per tile, arc radii at least `1/K`, …" (claims §0) | `plans/FS107-derivation.md` l. 11 | **matches** |
| NB-4, NB-5, the W-3 question (claims §7) | FS110-A4's record, `plans/POROS-2026-09-27-fs110-competition.md` (fenced for this job) | not checkable; used as quoted by the owner |
| §7.1's ring, `W`, swap point, N2-TRANS, the count (claims §7.1) | `plans/FS110-N-proof.md` (fenced for this job) | not checkable; used as quoted by the owner, the list's §7.1 being "sent to both sides word for word" |
| `[SokolovVoronov2025]` Condition 5 (claims §1) | the held PDF | not re-read at stage 1; the equivalence YB3-C5 uses the quoted words only |

### 1.4 The statements against the claim list's definitions

| id | type used | covering pair | `𝓜_K` / object | verdict on the match |
|---|---|---|---|---|
| Y3-C5 | none | none | "in `𝓜_K`" — circular or straight arcs, radii `≥ 1/K` | matches |
| Y3-GP | none: a ring of §7.1 (colours in `t^c`, `t = P_cl(u)`) | none | a ring, i.e. a colouring of a circle; no map needed | matches; note the statement is purely about circle colourings satisfying N-E0 |
| Y3-RING | as Y3-GP | none | six named rings | matches (rings deferred to stage 4) |
| Y3-PROP | `|P_cl| = 3` — closure types | NB-5 (closure types) | a tight six-map in `𝓜_K`, Condition 5 | matches; "connected map" is undefined in the list — read as "the boundary `Γ` is connected" |
| Y3-FLIP | "type `{a, b_{i−1}, b_i}`" — kind unnamed; read as closure (§7.1's count) | none | a tile | matches §7.1's scope note (count defined only at such tiles) |
| Y3-BOW | "trichromatic vertices", bowtie `(a,b,a,c)` of claims §0 — kind unnamed; read as closure | none directly (NB-5 enters the proof) | a winding map | matches; "winding map" is W-3's term (§7) |
| Y3-SIX | "three essential sectors" (positive angle, `P_ess`) with degree 3; NB-5 in closure types | NB-5 | a tight six-map in `𝓜_K`, Condition 5, NB-4, NB-5 | matches |

### 1.5 Restatements and registered expectations

*Registered after one reading pass in thought and before any tool was written or run. Both outcomes named reachable.*

| id | my restatement | expected | P | the other outcome, and how it is reached |
|---|---|---|---|---|
| Y3-C5 | in `𝓜_K`, "every boundary meets every unit circle in finitely many points" ⟺ "no boundary arc is an arc of radius 1" | TRUE | 0.95 | FALSE if a non-unit arc could meet a unit circle infinitely often (it cannot: two distinct circles, or a line and a circle, share ≤ 2 points) |
| Y3-GP | a §7.1 ring with no two change points `60°`, `120°` or `180°` apart has `W ≡ 3 (mod 6)`; so `W ∈ {0,±1,±2}` needs a pair at chord 1, √3 or 2 | TRUE | 0.8 | FALSE by a GP ring with `W ≢ 3 (mod 6)`; my checker computes `W` exactly and would exhibit one |
| Y3-PROP | `W` transports along an `a|b` edge between two closure-trichromatic vertices (bowties included, through bichromatic points), and `|W|` is constant on each component of `Γ` | first clause TRUE for `c ≠ d`; second clause GAP at same-type edges | 0.7 / 0.55 | TRUE outright if the same-type edge has its own argument; FALSE if an event type the proof does not exclude can change `W` |
| Y3-FLIP | around a tile whose vertices are all `{a, b_{i−1}, b_i}`, transport returns the orientation with sign `(−1)^k` | TRUE as label algebra; its use needs same-type transport | 0.85 / 0.55 | GAP if same-type transport is unproved; FALSE (as algebra) if my simulation of the labels disagrees with `(−1)^k` on a named face |
| Y3-BOW | at a bowtie with flanks `{a,b,x}`, `{a,b,y}`: `x ≠ y ∧ c ∉ {x,y}` ⟹ `W = 0`; the bowtie then counts as one neighbour `a` of tile `b` | TRUE | 0.7 | FALSE if the three transports' orientations compose to a consistent (non-zero) `W`; GAP if the transport through the bowtie vertex needs more than N2-TRANS's argument |
| Y3-SIX | no degree-3 vertex with three positive-angle sectors has a six-arc ring | TRUE | 0.6 | FALSE by a local six-arc configuration consistent with C5, NB-4, NB-5 and the Siamese rule |

### 1.6 "Would have searched here" log

- (none yet)
