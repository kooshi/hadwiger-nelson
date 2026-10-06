# FS131-QA4 — impossible assumptions, third pass: every theorem landed or about to land since FS131-QA3, read against the inhabitant rule's letter (de Bruijn, Opus)

*Brief: `data/fs131/briefs/FS131-QA4-inhabitants.md`. An audit: read-only toward every `Proofs/` file, every worktree and every branch; every
finding is a recommendation routed through Keryx. Started 2026-10-06 03:55 UTC.*

## Theorems this phase proved

None in the library. An audit proves nothing there; its scratch Lean (`data/fs131/qa4/`) and exact checks (`tools/fs131_qa4_*.py`) are
evidence for verdicts, listed where used, each at its grade.

## Stage 1 — SAVED (FS131-QA4)

### 1.1 The brief's quotations (standing rule 3)

Checked by script (each quotation's text counted with `str.count` in the file its source line names), then the items read in their place:

| # | quotation (opening words) | source | result |
|---|---|---|---|
| 1 | "inhabitant** in the same file, or a one-line note naming the theorem that supplies one. **The inhabitant exercises every clause**: a" | `LEAN.md` § The gate, l. 187 | verbatim, once |
| 2 | "real instance and the gate stays green. **The inhabitant satisfies every hypothesis the theorem does not refute, at once, at a parameter the refutation leaves alive** — for a" | `LEAN.md` § The gate, l. 190 | verbatim, once |
| 3 | item 158's first line | `plans/FS131-close-inventory.md` l. 1045 | verbatim, once |
| 4 | item 172's first line | same, l. 1194 | verbatim, once |
| 5 | item 268's first line | same, l. 1949 | verbatim, once |
| 6 | item 273's first line | same, l. 2002 | verbatim, once |
| 7 | item 408's first line | same, l. 3683 | verbatim, once |
| 8 | item 414's first line | same, l. 3726 | verbatim, once |
| 9 | item 416's first line | same, l. 3762 | verbatim, once |
| 10 | item 419's first line | same, l. 3812 | verbatim, once |
| 11 | "**Inhabitant** (`LEAN.md` § The gate): none in Lean yet. FS131-E6's model (`plans/FS131-E6-derivation.md` § 3.1–3.3: a valid plane map" | `Proofs/HadwigerNelson/Plane/ValidMap/OpenMove.lean` (`main`) | verbatim, once |
| 12 | `theorem exists_open (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₂ : ℝ} {c : Fin k}` | same | verbatim, once |
| 13 | `theorem exists_merge (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {c : Fin k} {n : ℕ} (hn1 : 1 ≤ n)` | `Proofs/HadwigerNelson/Plane/ValidMap/Contact.lean` (`main`) | verbatim, once |
| 14 | `theorem bend_toward_collar (hF : F.Valid) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c')` | `.claude/worktrees/fs131-w5k/…/BendCollar.lean` (`3b120cd3`) | verbatim, once |

No mismatch. One note, not a mismatch: the brief's header is dated 2026-10-06, which is the UTC date (`date -u` at my start: 2026-10-06 03:55);
the harness's date is 2026-10-05.

Read in full: `plans/STANDING-RULES.md`; `LEAN.md` (§ The gate whole, l. 160–201); `plans/FS131-QA2-audit.md` and `plans/FS131-QA3-audit.md`
(both records whole); inventory items 408–419 (l. 3683–3831).

### 1.2 The rule, as I read it (its letter, `LEAN.md` l. 186–193)

Four requirements, each of which a theorem "whose hypothesis is a structure" can fail separately:

- **(R1) named**: the file ships a named inhabitant, or a one-line note naming the theorem that supplies one.
- **(R2) every clause exercised**: the inhabitant is not degenerate for any clause of any hypothesis.
- **(R3) at once**: one object satisfies every hypothesis the theorem does not refute, at a parameter the refutation leaves alive — a model
  of one hypothesis on an object where another fails is not a model of the theorem.
- **(R4) or declared**: where none is expected (a step inside a proof by contradiction), the docstring says so with the theorem that refutes
  the configuration.

A reading I flag, since the rule is Keryx's to sharpen: "whose hypothesis is a structure (a colouring, an embedding, a certificate, a
homomorphism)" I read as *any hypothesis set that constrains a carried object* — here an `ArcMap k` under `Valid`, `Covers`, `IsPlaneMap`, and
the named predicates on its points and arcs — because that is the class both earlier findings (items 158, 268) fell in, and QA2 § 2.1 read it so.
A theorem all of whose hypotheses are parameters and plain (in)equalities on reals (a frame identity, a lens inequality) is outside the rule and
is tabled as *parametric*.

### 1.3 The bodies, at fixed commits

| body | commit | what is read there |
|---|---|---|
| `main` | `d4403f09` (its head at my start) | everything `git diff --name-only 7abff9b9 d4403f09 -- Proofs` names: 18 files, 36,405 lines added — `Plane/SVMap`, `Plane/StuckChain`, `Plane/LocalStructure` (27 lines changed), `Plane/ValidMap/{Basic, Sectors, UnitArc, BaseSteps, Contact, Cone, Moves, Surgery, MergeMove, OpenMove}`, `Plane/Woodall/{Basic, Collar, Merge, NoFourFive, Steps}` |
| wave 5 | `fs131-w5` at `3b120cd3` (the branch has since moved to `158bfadd`; not read) | `Plane/{CurveGraph, PlaneTopology}`, `Thomassen`, `Plane/ValidMap/{MapTopology, MapGraph, BrickMap, Chain, Cor3, Dense, FlankUA, HexRing, BaseWalk, BaseDense, RadialPush, CollarMap, Pushforward, BendCollar}` |
| wave 5c | `fs131-w5c` at `87e95385` (the branch has since moved to `a300d495`; not read) | `Plane/ValidMap/{Terminal, HornShadow, Limit, Procedure}`; `exists_vertexStep` and `exists_arcStep` read in `plans/FS131-E6-derivation.md` § 4.5's drafts instead |

Read with `git show <commit>:<path>` only. Scratch Lean runs with `lake env lean` from the idle trees `.claude/worktrees/fs131-wop` (`main`'s
line, at `4b68d47d`) and `.claude/worktrees/fs131-w5k` (`3b120cd3`), reading their oleans, building and writing nothing there.

### 1.4 What I may and may not change

Mine: this record, `data/fs131/qa4/`, `tools/fs131_qa4_*.py`, `data/fs131/reports/FS131-QA4.md`, on `main`, committed by explicit path. Not mine:
any `Proofs/` file, any worktree, any other branch, any statement, any file Keryx alone writes (`LEAN.md`, the inventory) — edits to those are
drafted here with their slot. I prove nothing in `Proofs/`. I start no agent and run no search.

## Stage 2 — SAVED (FS131-QA4): the census instrument, and where the boundary is drawn

### 2.1 The instrument

`tools/fs131_qa4_census.py` (imports FS131-QA1's parser read-only; reads each module with `git show <commit>:<path>`): for every theorem of
the 39 audited modules — its head reasons (a backlog row named in its docstring; its name used in another audited module; the brief's list of
construction heads), whether its statement concludes `False`, whether its body holds `sorry`, the named predicates in its signature, and the
sentence of its docstring that speaks of an inhabitant or model; for every definition — NEW, CHANGED or SAME against every body the nine
commits of QA2 and QA3 hold under that name, and the number of audited theorems whose signature takes it.

`--self-test`: 15 controls, 4 of them planted faults inside the test (a citing module emptied, a module missing, a definition changed, a
definition new), exit 0. **Two faults planted in the tool itself and watched to fire** (on a copy in the session's scratch): with the arrow
chain's last target not taken, "arrow-form refutation missed", exit 1; with a theorem's own module counted as a citation, "a child read as a
head" and "citation still reported after the citing module was emptied", exit 1.

Outputs (committed): `data/fs131/qa4/theorems.tsv` (2,590 theorems), `heads.tsv` (963), `defs.tsv` (319 definitions).

### 2.2 The census in numbers

| body | modules | theorems | row or construction heads | cited from another module only | refutation-shaped | with `sorry` | docstring speaks of an inhabitant |
|---|---|---|---|---|---|---|---|
| `main` (`d4403f09`) | 18 | 1,563 | 139 | 468 | 32 | 0 | 26 |
| wave 5 (`3b120cd3`) | 17 | 775 | 111 | 172 | 23 | 5 | 48 |
| wave 5c (`87e95385`) | 4 | 252 | 68 | 5 | 7 | 4 | 50 |
| total | 39 | 2,590 | 318 | 645 | 62 | 9 | 124 |

Definitions: 319, of which 108 are Prop-valued (predicates and structures); **28 Prop-valued definitions are new or changed since the commits QA2
and QA3 read** (27 NEW, 1 CHANGED: `IsHoleOf`, item 242's repair); they are tabled in Stage 5.

### 2.3 The boundary (brief, Done means 2: "say where you drew that boundary")

- **A head** is a theorem whose docstring names a backlog row or a derivation's entry (318 by the script: 315 by a row, 3 more from the brief's
  list of construction heads). These are read one by one, by family (Stage 4).
- **A theorem cited from another module and not a row** (645) is an internal child in the brief's sense unless its signature takes a named
  predicate no head of its family takes. The script lists each one's predicates; a child whose predicate set is a subset of its head's
  **inherits its head's line** (its hypotheses are among the head's, so the head's inhabitant is its inhabitant). The ones that take a
  predicate set no head takes are read with the family.
- **Everything else** (1,627 theorems used only in their own module) inherits its module's heads.
- **Parametric theorems** — every hypothesis a parameter or an (in)equality on reals and complex numbers, no carried object (`n4_fin`,
  `curvUp_curvDown`, the lens and lune inequalities, `PlaneTopology`'s lemmas about sets of the plane) — are outside the rule (§ 1.2) and are
  counted, not read.

The census is textual. Its two known blind spots, both in the safe direction for a head count and not for an inhabitant verdict, so every
verdict below is from reading the statement itself: a hypothesis that is not a named predicate (an inline `∀ᶠ`, a cone's interior) is invisible
to the predicate column; and "the docstring speaks of an inhabitant" matches the words, not the claim.
