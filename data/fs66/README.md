# data/fs66 — the residue tower at 11, and what each file licenses

FS-66 asks whether the upper bounds this project holds on the number of colours a plane over a number field
needs — every one of which comes from colouring a **first-level** residue plane — get better at higher levels.
The pilot is the prime 11: level one, `UD(𝔽₁₁, 2)`, needs five colours (kernel, row 53). **Level two,
`UD(ℤ/121, 2)`, needs five as well: the ceiling does not drop.** The plan is
`plans/FS66-residue-tower-drop.md`; this file is the map of what is on disk, written at the close of phase 1a.

**Nothing in this directory is kernel-checked.** The strongest word here is `CERTIFIED`, which is
`tools/fs66_check_witness.py`'s — a standard-library program that re-derives every claim from the definition,
not the Lean kernel. **The kernel theorem exists, and it is not here**: phase 1b put this witness into Lean as
`HadwigerNelson.chromaticNumber_unitQuadrance_zmod121` (`Proofs/HadwigerNelson/Instances/ZMod121Four.lean`),
`(unitQuadrance (ZMod 121)).chromaticNumber = 5` on the standard three axioms with no `native_decide`. What the
kernel re-derives from the files below is every claim they make: that each listed pair really has unit
quadrance modulo 121, that the clause table holds the formula those pairs generate, and that every step of the
LRAT proof propagates.

## The directories

| path | what it is | whose |
|---|---|---|
| `witness-p11-l2-k4/` | **the phase-1a product**: an 883-point subgraph of `UD(ℤ/121, 2)` that cannot be four-coloured, its LRAT refutation, and the outputs of every check run on it | the implementer's |
| `witness-p11-l2-k4/stages/` | the same object two steps earlier in the pipeline (2,974 and 996 points), in the same format and each `CERTIFIED`, so phase 1b can measure the kernel's cost on a large instance before deciding how small it needs one | " |
| `ckpt/` | the checkpoints and console logs of every run that could outlive a crash — **never under `build/`**, which is scratch that agents clean | " |
| `planner/` | the planner's first measurements of 2026-09-20 (`§M` of the plan), frozen as a record | the planner's |
| `owner/` | the product owner's notes, encoder, verifier outputs and rulings | the owner's |

## `witness-p11-l2-k4/` — the files, and what each one licenses

| file | what it licenses |
|---|---|
| `witness.json` | 883 points of `(ℤ/121)²`, 3,441 pairs of them (indices, sorted), and a pinned triangle. **A claim, not a certificate** — the checker is what makes it one |
| `witness.lrat.gz` | CaDiCaL's refutation of the four-colouring formula of that edge list, as LRAT text, gzipped (`*.lrat` is gitignored repository-wide; `*.lrat.gz` is the committed form here, as in `data/fs58/` and `data/fs61/`) |
| `check.out` | the run of the checker that ends `CERTIFIED`. It carries three digests — the witness's, the proof's and **the checker's own** — so a reader can tell which program said it |
| `controls.out` | 23 rows: one per fault planted in the witness or the proof, each refused **for its named reason**, plus a faithful twin that must pass, a second CNF builder that must agree, an all-pairs test that must match the circle walk, and a final row proving the committed files came back byte-identical |
| `mutation-audit.out` | the controls' own controls: nine tests removed from a **copy of the checker**, one at a time, each with the control rows that must go red named in advance. A control row whose failure mode is unreachable passes exactly like one that works, so this is what makes `controls.out` mean something |
| `records.jsonl` | one flat, typed line per ask — the plan's §D shape, with the mandatory trust word. `cat data/fs66/*/records.jsonl` is the milestone |

## What the certificate says, in words

The checker reads the file, checks that every listed point is a pair of integers in `[0, 121)` and that none
is listed twice; **re-derives from the definition** that each of the 3,441 listed pairs really does satisfy
`(a − c)² + (b − e)² ≡ 1 (mod 121)`, in integer arithmetic, and reports beside it that those 883 points span
8,597 such pairs in all (the listed edges are a *subset*, which is sound — a subgraph that refuses to be
coloured refutes every graph containing it — and cheaper for the kernel); checks that the pinned triangle is
three points that are pairwise **listed** edges, which is what makes fixing their colours a legitimate
symmetry reduction; **builds the colouring formula itself**, in the clause order of `Sat/Encoding.lean`, so
the one LRAT file serves both this checker and the Lean pipeline; and replays the LRAT with its own
reverse-unit-propagation checker. Then: *the listed graph has no proper 4-colouring; it is a subgraph of
`UD(ℤ/121, 2)`, so `UD(ℤ/121, 2)` has none.* With the pulled-back five-colouring of level one,
`χ(UD(ℤ/121, 2)) = 5`.

Independently of all of that, **four other solver codebases refuse the bare edge list with no pin and no
symmetry breaking at all** (glucose4, minisat22, cadical153, maplechrono: 0.9–5.2 s), and **the same list is
five-colourable**, with the model verified on every listed edge — the positive control, without which a row of
refusals would only show that the instrument can say no. Those eight asks are in `records.jsonl`.

## Regenerating the witness from the definition

Five commands. CaDiCaL is deterministic at a fixed seed, and **the seed is 2 throughout**; the minimiser is
deterministic given its state, so an interrupted-and-resumed run lands on the same graph as an uninterrupted
one. `$S` is any scratch directory (the CNF is 60 MB and the LRAT 1.5 MB; neither is committed).

```bash
python3 tools/fs66_tower.py build 11 4 --level 2 --out $S/g2-p11-k4.cnf          # 14,641 vertices, 966,306 edges
python3 tools/fs66_tower.py ask   $S/g2-p11-k4.cnf --lrat $S/g2.lrat --seed 2    # UNSAT, 1.5 s, 1,412 conflicts
python3 tools/fs66_tower.py core  $S/g2-p11-k4.cnf $S/g2.lrat 4 --out $S/r0.json # 2,974 vertices / 14,190 edges
python3 tools/fs66_minimise.py $S/r0.json --n 121 --k 4 --seed 2 --mode vertices \
    --ckpt data/fs66/ckpt/minimise-p11-l2.jsonl --out $S/final.json              # 883 / 3,441, 1-minimal, 16 s
python3 tools/fs66_tower.py witness $S/final.json --n 121 --k 4 --seed 2 --out data/fs66/witness-p11-l2-k4
```

The two stage witnesses come from the same `$S/r0.json`: `round0` is `witness` run on it directly, and
`fixpoint` is `witness` run on `fs66_tower.py shrink $S/r0.json 4 --seed 2` (996 points / 4,283 edges).

Then, to check what was just built — these are also the commands that score the phase:

```bash
python3 tools/fs66_check_witness.py            data/fs66/witness-p11-l2-k4/witness.json ; echo $?   # CERTIFIED, 0
python3 tools/fs66_check_witness.py --controls data/fs66/witness-p11-l2-k4/witness.json ; echo $?   # ALL CONTROLS BEHAVED, 0
python3 tools/fs66_mutation_audit.py           data/fs66/witness-p11-l2-k4/witness.json ; echo $?   # ALL MUTATIONS SEEN RED, 0
python3 tools/fs66_recheck.py                  data/fs66/witness-p11-l2-k4/witness.json             # four solvers, no pin
```

## `ckpt/` — the checkpoints, and the resume that was exercised on purpose

`minimise-p11-l2.{jsonl,current.json,log}` are the production minimisation: one line per accepted deletion,
the resumable state rewritten atomically after **every wave**, and the console log. The audit question — *if
this process dies right now, what does the relaunch redo?* — is answered in the log's first lines, before the
run: **at most the one wave of sixteen probes in flight.**

That run finishes in 15.7 seconds, which is too fast to interrupt by hand, and the log records that a kill
aimed at it arrived after it had already exited normally — *verified by effect*, from the run's own `stop:`
and `final:` lines, rather than assumed from the kill's exit status. So the checkpoint discipline of the same
tool is exercised in `minimise-resume-exercise.log`, on a run long enough to interrupt: a SIGKILL to the
process **group by its numeric pgid** (never by a command-line pattern, which matches the killing shell), the
death verified by effect — the pid gone from `ps` at +3 s and +15 s, no `cadical` left alive, the checkpoint's
digest identical across ten seconds — and then a resume that lost none of its 88 accepted deletions and
re-probed only the wave in flight.

**That run's product is deliberately not the witness.** It deletes *edges*, and edge deletion is measured to
be counterproductive for the thing phase 1a is for: shrinking 3,441 edges to 3,090 (a 10% smaller clause
table) made CaDiCaL's refutation 100× harder — 1,503 conflicts to 148,524 — and its **LRAT proof 71× larger,
55.9 MB against 784 KB.** The kernel pays for the proof — phase 1b measured how much, and at this size it is
**88 %** of the whole check (next section). The committed witness is the vertex-1-minimal graph, with the
small proof.

## What phase 1b measured on these files, and the rule it gives

The two `stages/` witnesses exist so the kernel's cost could be measured on a large instance and a small one
with **the same proof length**, and that is what they settled:

| instance | points | edges | clause-table slots | proof hints | `Cnf/Table.lean` | one of 8 `Cnf/SegNNN.lean` |
|---|---|---|---|---|---|---|
| the witness | 883 | 3,441 | 16,262 | 96,820 | **31.6 CPU s / 6.14 GB** | 29.3 CPU s / 5.18 GB |
| `stages/round0` | 2,974 | 14,190 | 61,484 | 95,653 | **616.6 CPU s / 20.84 GB** | 23.7 CPU s / 5.16 GB |

**The kernel has two charges, and they are paid on different things: the clause table is the graph's bill, the
segments are the proof's.** The two proofs are the same length (1.2 % apart) and the segments cost the same,
although one graph is 3.8× the other — so the graph does not enter the segment charge. The clause tables differ
3.8× and the table check differs **19.5× in time and 3.4× in memory**, super-linearly (3.8² = 14.3 is nearer
than 3.8). **Which charge dominates depends on the size, and these two objects straddle the crossover**: on the
883-point witness the segments are 88 % of the 4.4 CPU-minutes, on the 2,974-point stage the table is 76 % of
13.4. Read with this directory's other finding — that deleting edges past vertex-1-minimality makes the proof
71× larger, i.e. multiplies the charge that dominates at this size — the rule for any later witness is:
**minimise vertices while the refutation stays easy, then stop.**

## The numbers, in one table

| | vertices | edges | CNF clauses | LRAT lines | conflicts | proof, gzipped |
|---|---|---|---|---|---|---|
| all of `UD(ℤ/121, 2)` | 14,641 | 966,306 | 3,879,868 | — | 1,412 | (not committed, 1.5 MB text) |
| `stages/round0` | 2,974 | 14,190 | 59,737 | 2,990 | 1,679 | 267 KB |
| `stages/fixpoint` | 996 | 4,283 | 18,131 | 3,023 | 1,727 | 269 KB |
| **the witness** | **883** | **3,441** | **14,650** | **2,642** | **1,503** | **219 KB** |

The witness is **1-minimal in vertices**: every one of its 880 deletable points was probed against this exact
graph, under a budget of 300,000 conflicts, and every single deletion made the rest four-colourable — 2,656
probes, **no probe undecided**, on sixteen cores. Its average degree is 7.8.
