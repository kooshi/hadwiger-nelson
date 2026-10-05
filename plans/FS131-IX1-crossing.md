# FS131-IX1 — the crossing lemma `inter_nonempty_of_interleaved`

*de Bruijn, the implementer (FS131-IX1), 2026-10-05. Brief: `data/fs131/briefs/FS131-IX1-crossing.md` (main tree). Branch `fs131-w5x`, worktree
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5x`, cut from `fs131-w5p` at `01011037`.*

## Theorems this phase proved

None yet (stage 1).

## Stage 1 — SAVED: the readback

### 1.1 The brief's quotations against their sources (standing rule 3)

Checked by `grep -F` of each quotation's full text (the leaf by a Python substring test of the whole docstring and signature). Control: a fresh
string (`IX1-ctl-<nanoseconds>`) reported `MISS`; and the leaf's text with `K ∩ K'` changed to `K ∪ K'` reported `MISS`, while the true text reported
`FOUND`. (IP1's control string `ABSENT-CONTROL-STRING-xyzzy` is no longer a control in its own record: IP1 wrote it there, so `grep` finds it. Noted
so nobody reuses it.)

| quotation in the brief | source | result |
|---|---|---|
| inventory item 293 (truncated at "a binder name is not part") | `plans/FS131-close-inventory.md` (main tree) | verbatim |
| Kooshi on pricing ("Do not consider Lean formalization a cost. …") | `CLAUDE.md` § Counter-priors | verbatim |
| the leaf `inter_nonempty_of_interleaved`, docstring and signature | `Proofs/HadwigerNelson/Plane/PlaneTopology.lean` (branch, `01011037`) | verbatim |
| `noncomputable def ringPt (p : ℂ) (θ : ℝ) : ℂ := p + e θ` | `Proofs/HadwigerNelson/Plane/Basic.lean` l. 46 | verbatim |
| IP1's § 2.3 opening ("`inter_nonempty_of_interleaved` (KP's H) is left for step 5. …") | `plans/FS131-planar-implementation.md` § 2.3 | verbatim |

No mismatch. Read in full: the brief; `plans/STANDING-RULES.md`; `LEAN.md`; `RUNNING.md` § Building and § Make the gate fail, and watch it fail;
IP1's record §§ 2.1–2.3 and its "Theorems this phase proved"; KP's plan §§ 3.1–3.3 and every line naming this leaf (§ 4.1's row, § 4.3's model
"two crossing diameters", § 5.1 step 5); inventory item 293 in full.

### 1.2 What I may and may not change

**May:** prove `inter_nonempty_of_interleaved` in `Proofs/HadwigerNelson/Plane/PlaneTopology.lean`, adding children beside it, each with a spec
example; add new modules of my own under `Plane/` or `Topology/` that `PlaneTopology` imports and that import nothing under `Plane/ValidMap/`
(each into `ARCHITECTURE.md`'s module map and `Proofs.lean` in the same commit); my own block in `scripts/Axioms.lean`, headed "FS131-IX1", above the
`=== PURCHASED ===` banner; this record; `tools/fs131_ix_*.py`; `data/fs131/ix/`; `data/fs131/reports/FS131-IX1.md`.

**May not:** change the leaf's statement (not a hypothesis, not the conclusion, not `ringPt`, `e`, `closedBall`) or any other statement in the
file; touch anything under `Plane/ValidMap/` (FS131-IP2's); add an `axiom` or `native_decide`; merge into `fs131-w5p` or `fs131-w5`; run the gate;
touch `main`; edit a file while a build of it runs. A statement that looks false or short of a hypothesis goes to Keryx at once.

### 1.3 The as-given build (`01011037`, before any edit)

Under the slot (40 GiB, 8 cpus, `BATCH=4`), from inside the worktree: **OK — all 1753 modules already up to date, nothing built, 11 modules with
warnings, every warning `declaration uses 'sorry'` (98 lines), exit 0** (`build/gate/build/20261005T011928Z-104505.log`; driver log
`data/fs131/ix/build-asgiven.log`).
