# M63 phase C — the joint test, the instruments the loop needs, and the audit closed

*Subplanned 2026-09-11 by de Bruijn (the phase C planner), for a fresh implementer. The milestone plan is
`plans/M63-parts-reproduction.md`; **its §S is the current state** — the goal (S.1), what planning measured
(S.2), the gap audit (S.3), the roadmap C–G (S.4) and the design-for-G decisions (S.5). This file is phase
C only. The product owner reviews it before implementation; the approval is recorded in §A at the end.*

---

## §0 — Purpose, and the shape in five lines

Phase C does two jobs, and they are one job, because every later phase stands on both.

1. **Run the cheapest experiment that can meet the record** (Poros card 1). Reduce **both halves at once**
   over his own two published accumulators, `A412 ∪ ρ·g⁻¹(A166)`. That working graph contains the
   509-vertex record. He never reduced jointly, and neither have we: every run so far froze one side.
2. **Make the instruments honest** before a loop runs on them for hours. That means exact resume, a wall on
   every ask, a freeze that works, records produced by committed code, and an audit instrument that
   turns his tables into rows that can disagree.

The shape:

| part | what | why it is in C |
|---|---|---|
| **C1** | hygiene: ask wall, exact resume, vacuity verdicts, the freeze repaired, `parts_verify` stops dirtying the tree, the committed driver `tools/parts_run.py`, committed producers for M64's two scratch artifacts | D's loop runs for hours and must resume; the joint run may exceed 15 minutes; the freeze is D's last step and it crashes today (S.2 #12) |
| **C2** | `tools/parts_audit.py`: his tables as `Comparison` rows, the three count conventions, accumulator and member checks, per-orbit ranges and the stable/unstable partition from his gray shading, edges, `Y` re-verified, Tables 5–7, involution classes, the open rungs | closes S.3's C rows; D and E report through it |
| **C3** | the M6B 375 level set on his `v403e2106` with his `S141` | decides what Table 2's "375 M6A&B" column is (S.2 #4) |
| **C4** | the joint stage (`side="LS"`) and the record-bearing run | card 1 |
| **C5** | `typem.CrossLaw`: the cross-edge law as a parameter of `Stage` | design for G at a cost of hours (S.5) |

**Not in C:** the expansion rule, the loop runner and the freeze commit (D); the companion constructors
(E); certification of a record (F); any rotation other than `ρ₁₅` (G).

---

## §1 — What the implementer must know before writing a line

Everything here is measured and has an address. Read M63 §S.2 in full first; the essentials are:

- **The L-side level set is his.** Reducing his `v451e2400` against his `v136e564` gives 375 vertices and
  3,264 raw minima, which is **282 up to `Aut(A)`** (order 12, the companion free to move). That is his
  Table 1 count. Its union **equals his `v403e2112` literally**. The convention "up to `Aut(A)`" is his on
  both sides (8 on S, M63 §R1; 282 on L).
- **Frames.** His files are stored each in its own frame (M63 §1(v)). The record is `v374e1860 ∪ ρ·v136e564`
  **in stored frames** (M63 §R1: 509 / 2,442). `v374e1860 ⊆ v412e2106` literally. The six group elements
  `g` with `g(v136e564) ⊆ v166e774` all give the same set `g⁻¹(v166e774)` ⊇ `v136e564`. **Rule: use stored
  frames whenever they work; when a group element is needed, the config names it.**
- **The subtype is a property of the pair.** His M6B `v375e1916` refuses four colours with `v141e594` in 12
  of the 24 frames, and with `v136e564` in none.
- **Ask costs on the incremental oracle.** L451: 11,942 colourable at 0.006 s and 4,741 refusing at 0.02 s,
  605 s in all. S166: 13,176 at 0.009 s and 3,076 at 0.108 s, 587 s.
- **Rung fixtures, measured in planning** (the S166 stage, companion `v374e1860`, `Aut(A)` of order 6 with
  element orders 1, 2, 2, 2, 3, 3):
  - the full order-6 rung: 31 atoms, closed at 142 vertices, 1 minimum, 39 correction sets, 17.6 s;
  - the order-3 rung: 55 atoms, closed at 142 vertices, **21 minima**, 129 correction sets, **67 s**;
  - one order-2 rung (which of the three involutions is not yet mapped to M64's rows): 86 atoms, closed
    at 138 vertices, 2 minima, 186 correction sets, 114 s.
- **Four defects the code has today** (S.2 #12):
  - `require_frozen` crashes on first use;
  - `parts_verify.py` rewrites a tracked file;
  - the checkpoint is never read back;
  - `Oracle.ask` has no wall, so `undecided` can never be nonzero.
- **The scratch probes that measured all this are not in the repository.** C2's instrument is what
  re-derives them. Do not go looking for the planner's scratch directory; the numbers above are the record.

Commands that work today, all self-tests green on 2026-09-11 (run each before believing it):

```
python3 tools/parts_report.py            # 1 s   ALL REFUSALS FIRED  (does not exercise require_frozen)
python3 tools/parts_faces.py --self-test # <1 s  18 controls, ALL FIRED
python3 tools/parts_repro.py             # 10 s  ALL CHECKS PASSED
python3 tools/parts_verify.py            # 61 s  rewrites data/m62/parts-ref11-verified.json (defect H-1)
python3 tools/parts_stage.py             # 28 s  CONTROL FIRES
```

---

## §PA — The prior-art gate (WORKFLOW step 3a), proportionate to what is new here

What is new in phase C:

- the joint reduction;
- exact resume and walls, which are engineering;
- reading his shading, which is extraction.

**The question the product owner put to this gate is whether 509 is still the record.** A record we
"beat" must be the current one.

**(a) Is 509 still the record? As far as every reachable source says, yes.**

| source | what it says | status |
|---|---|---|
| `[Haugland2026]`, arXiv:2608.04542**v3** (10 August 2026), introduction, fetched 2026-09-11 | *"the current record is 509 vertices by Parts"*; also *"Heule subsequently reduced this bound to 1441 vertices"*, about Moser-spindle-free graphs | primary sentence read at source; the rest of the paper is not re-read here |
| `[Polymath16threads]`, all eighteen threads, 14 April 2018 – 17 January 2026, held as `~/source/library/notes/polymath16-threads-1-18-text.txt`, searched 2026-09-11 for vertex counts 400–509 | the last record mentions are the 509 itself (April 2020: *"where is the 509-vertex graph published?"*); Parts, April 2020: stepping below 500 is *"either impossible, or it wi[ll]…"*; no sub-509 5-chromatic unit-distance graph is posted | searched in full |
| the Polymath16 wiki page *Hadwiger-Nelson problem* | **no longer served**: HTTP 404 at `michaelnielsen.org/polymath1/…` and `…/polymath/…`; `asone.ai` does not resolve; the Internet Archive is unreachable from this tool and rate-limited (HTTP 429) from `curl` | **negative, with its routes** — the implementer retries the Wayback availability API once, and records the result either way |
| Geombinatorics tables of contents 2020–2026 | no index reachable by search; the search surfaced `[Heule2021]` (*Odd-distance virtual edges*, Geombinatorics 31(2), 2021), which is not a record paper | **negative** — no TOC was read; recorded as not reached |
| web search, four queries (2026-09-11), in the question's words: *"smallest 5-chromatic unit distance graph fewer than 509 vertices"* and variants | every result is 2018–2020 lineage or Haugland 2026; nothing smaller | search listings only |

**Default, and its falsifier:** the record is 509 / 2,442. It is falsified by any certified smaller graph
found later. The implementer adds the Haugland v3 sentence to `BIBLIOGRAPHY.md`'s `[Haugland2026]` row: its
title is now verified at the source as *"A Moser-spindle-free 5-chromatic unit distance graph on 2131
vertices in the plane"*, and its read status becomes "introduction's record sentence read at source".

**(b) The joint reduction, in the vocabulary of the fields that own it.** "The smallest vertex subset of a
graph that keeps it non-4-colourable" is **smallest-MUS extraction** over vertex groups. That problem is
named at `[IgnatievEtAl2015]` (hitting-set dualization, the tool `forqes`) and `[LiffitonSakallah2008]`,
already in `BIBLIOGRAPHY.md` and **not read**. Heule's clausal-proof trimming (`[Heule2019]`, read) is the
heuristic joint reduction of whole type-M graphs, and it is how 529 and 510 were reached. Our
`reduce_stage` is the exact dualization. **Nothing here claims novelty for the method**; the joint run is
an experiment on his objects. The `[IgnatievEtAl2015]` row stays "not read — blocking for any claim about
FS-32's question". It does not block this phase, which claims no method.

**(c) Nothing to search for resume, walls or shading extraction.** They are engineering, and each is
controlled below.

---

## §2 — The skeleton

*Signatures and docstrings are the specification; bodies are the implementer's. Every planted control is
named with the verdict it must flip. Every new artifact names its producer and stamps
`parts_report.provenance(config=…)`.*

### C5 — `typem.CrossLaw` (do this first: it is small and every later stage takes it)

```python
# tools/typem.py
@dataclass(frozen=True)
class CrossLaw:
    """The cross-edge law between `L` and `ρS` for a rotation ρ = c + i·s whose sine leaves K.

    **Derivation, valid for every such rotation and not only ρ₁₅.** |u − ρv|² = 1 ⟺ Re(ρ·conj(u)·v) = k,
    with k = (|u|² + |v|² − 1)/2. Write conj(u)·v = p + i·q (p, q ∈ K) and s = σ√D with √D ∉ K. Then
    c·p − σ√D·q = k splits over the basis {1, √D}: **q = 0** (u and v are collinear with the centre) and
    **c·p = k**. Add the centre edges |0 − ρv| = |v| = 1, which do not depend on the rotation. ρ₁₅ is
    c = 7/8, where c·p = k is `cross_edges_rho15_fast`'s p = 4(a + b − 1)/7.

    A rotation whose sine lies in K lies in K(i), where Theorem B four-colours every union: refused, not
    supported. A cosine outside K needs a different derivation (FS-30 step 2): not implemented.

    **The law does not see the sine at all**, so ρ and its complex conjugate give the same adjacency —
    which is the adjacency face of complex conjugation being one of the base group's Galois elements
    (M62 §R19(1)). That is why `cos` is the whole datum."""
    cos: tuple                       # an element of K in typem's 4-slot form -- the law's only datum

    @property
    def name(self) -> str:
        """Derived from `cos` ("collinear(7/8)", spelled "rho15" at that value), never stored beside it:
        a stored name is a second copy of the law that drifts from it."""

    @staticmethod
    def collinear(cos: "Fraction | tuple") -> "CrossLaw":
        """Refuses (ValueError, naming Theorem B) when 1 − cos² is a square in K (`k_is_square`)."""

    @staticmethod
    def rho15() -> "CrossLaw":
        """`collinear(7/8)`, named 'rho15'."""

    def edges(self, pts, norms=None) -> list[tuple[int, int]]:
        """The (L-index, S-index) cross edges, proposed on floats by rays and disposed exactly in K,
        exactly as `cross_edges_rho15_fast` does for 7/8."""
```

```python
# tools/parts_stage.py
Half = Literal["L", "S"]

class Stage:
    def __init__(self, base, L_tuples, S_tuples, side: str = "S", rung=1, pin=True,
                 rung_maps=None, cross_law: "T.CrossLaw | None" = None, pin_triangle=PIN_TRIANGLE):
        """`side` is the SPELLING of `self.reduce`, the set of halves whose vertices may be deleted:
        "L" → {"L"}, "S" → {"S"}, "LS" → {"L","S"} (C4). The deletable set is then one expression —
        the union of the chosen halves minus the shared centre — instead of a conditional per side, and
        the joint stage stops being a third case.

        **A vertex of a stage is a pair `(half, tuple)`**, never a bare lattice tuple: on a joint stage
        the same lattice point is a different vertex in each half. Every atom label, every minimum,
        every profile and every group image carries the half.

        The shared centre is never deletable. That is the type-M construction's own constraint (the two
        halves share the rotation centre), it is what makes `|M| = weight + 1`, and a search that allows
        its deletion is a different stage and says so.

        `cross_law` defaults to `CrossLaw.rho15()`; `describe()` names it and every record's config
        carries it."""

    def identity(self) -> str:
        """**What a resume may be resumed onto, and what `stage_fingerprint` is not.** The old
        fingerprint hashes the present graph only, so an L stage and an LS stage over the same working
        graph share it, and so do two rungs of one stage — a checkpoint would be accepted onto a
        different search. `identity()` hashes the graph, the deletable set (with halves), the atom
        partition, the pin vertices and the law's `cos`. `stage_fingerprint` stays as it is, because
        the stored records carry it."""
```

Planted controls (in `typem.self_test` or a new `parts_stage` self-test section):

| control | plant | must read |
|---|---|---|
| c5.1 | none: `CrossLaw.rho15().edges` against `cross_edges_rho15_fast` on `Base(2.6)`'s points | `law-matches-rho15`, equal as sets |
| c5.2 | none: build the L451 stage with the explicit law | stage fingerprint `0700718c70107448b8658a630c5456ee` |
| c5.3 | `collinear(3/4)` (1 − 9/16 = 7/16; √7 ∉ K) | an edge set **different** from ρ₁₅'s: `law-is-not-ignored` |
| c5.4 | `collinear(1/2)` (1 − 1/4 = 3/4; √3 ∈ K) | `ValueError` naming Theorem B |
| c5.5 | none: the record stage `Stage(v374e1860, v136e564)` under the explicit law | 509 vertices, 2,442 edges |

### C1 — hygiene

**C1.1 The ask wall.** `tools/parts_reduce.py`

```python
class Oracle:
    def __init__(self, stage, wall: float | None = 600.0): ...

    def ask(self, kept: list[int], wall: float | None = None) -> tuple[str, list[int] | None]:
        """'unsat' (the selection keeps the property), 'sat' (it loses it; the model is returned) or
        'unknown' (the wall interrupted the solver). 'unknown' increments `n_unknown`, which
        `Bound.undecided` reads — so "zero undecided asks" becomes a measurement that can fail, where as
        shipped it was structurally zero.

        Implementation: `solve_limited(assumptions, expect_interrupt=True)` with a `threading.Timer`
        calling `interrupt()`, then `clear_interrupt()`. QUERY FIRST that PySAT 1.9.dev15's `cadical153`
        honours `interrupt()`; if it does not, say so in this docstring and use the next honest mechanism
        (a conflict budget, or a subprocess with a kill) — never a wall that silently does nothing."""
```

**How an 'unknown' moves through the algorithm.** The whole soundness argument is here, so it is written
into the docstrings:

- In **phase 1**, 'unknown' counts as *not critical*. That omits a degree-1 hyperedge: fewer constraints,
  so the lower bound stays a lower bound.
- In the **correction-set shrink**, 'unknown' counts as *still needed*, as today: a non-minimal correction
  set is still sound.
- In the **level loop**, an 'unknown' candidate is blocked **and recorded** in `undecided_candidates`. The
  bound then renders open, and the level's count method becomes `bounded-below`, because blocking an
  undecided candidate may remove an unrecorded minimum. The completeness invariant (M63 §O(1c)) holds only
  with that list empty, and the record says which case it is in.

**C1.2 Exact resume.**

```python
@dataclass
class ReductionState:
    """**The checkpoint and the record are one object at two times** (§M). A checkpoint is this state
    with `status = "in-progress"`; the record is `state.finish()`, which adds only derived views — `A`,
    the canonical counts, the member profiles, the bound. Two schemas would be two things to keep in
    agreement, and `blocked` was already a second copy of the minima: it is derived here, as
    `minima ∪ undecided`, and never stored.

    `problem_sha256` identifies WHAT is being searched — the stage's `identity()` and the problem half
    of the config. `config_sha256` covers the budgets too. **A resume is refused on a problem mismatch
    and permitted on a budget change**, because a wall and a cap are properties of a launch, not of the
    search: raising the wall is exactly how one continues a truncated run."""
    problem_sha256: str
    status: str                       # "in-progress" | "complete" | "truncated-at-wall" | "truncated-at-budget"
    pin: dict
    phase1: dict[int, str]            # atom -> "critical" | "droppable" | "unknown"
    corr: list[list[int]]             # correction sets, in harvest order
    minima: list[list[int]]
    undecided: list[list[int]]        # candidates an ask could not decide THIS launch
    w_star: int | None
    iteration: int
    asks: dict
    launches: list[dict]              # one entry per launch: budgets, machine, git commit, seconds

def reduce_stage(stage, *, wall_ask: float | None = 600.0, max_minima: int = 0, phase2_wall: float = 0.0,
                 checkpoint: str | None = None, config: dict | None = None, log=print,
                 _stop_after: int | None = None) -> dict:
    """Phases 1 and 2, returning the record — never a bare number.

    RESUME. If `checkpoint` names an existing file the run continues from it EXACTLY. The file is
    REFUSED when `stage.identity()` or the problem hash differs (`checkpoint-problem-mismatch`), and
    accepted when only budgets differ. On resume the `undecided` list is CLEARED back into the candidate
    pool — an ask that a 60-second wall could not decide is exactly what a longer wall should re-ask —
    and phase-1 atoms recorded `unknown` are re-asked too.
    A relaunch therefore re-asks nothing that was decided, and everything that was not.

    The checkpoint is JSON, written atomically (temp file + `os.replace`): after phase 1, after any new
    minimum or correction set once ≥ 30 s have passed since the last write, and at exit.

    What resume does NOT promise, stated so no control asserts it: the correction sets harvested AFTER
    the resume point may differ from an uninterrupted run's. A fresh incremental solver can return a
    different model for the same colourable ask, and the shrink starts from that model. The LEVEL — the
    minima as a set, w*, the method — is identical, by the completeness invariant.

    `_stop_after` (tests only): raise `PlantedInterruption` after that many level iterations, so the
    self-test can kill a run at an arbitrary point without a signal."""
```

**C1.3 Vacuity verdicts.** The record's `verdict` field takes exactly one of these values:

| verdict | when |
|---|---|
| `pin-unsound` | the pin control disagrees |
| `base-fails` | the full selection is colourable |
| `companion-suffices` | **new**: the empty selection refuses (asked before phase 1) |
| `reduced` | an optimum was found and w* < the total weight |
| `no-reduction` | w* equals the total weight (today this label sits on the wrong branch) |
| `truncated-before-optimum` | `phase2_wall` expired before the first optimum |

**C1.4 The freeze, repaired.** `tools/parts_report.py`

```python
def config_sha256(config: dict) -> str:
    """SHA-256 of the configuration's canonical JSON (sorted keys, compact separators). `provenance` and
    `require_frozen` both call this one function, so an artifact's `config_sha256` and the freeze's are
    comparable by string equality. (As shipped, the two computed different things, and `require_frozen`
    called `.hexdigest()` on a `str`.)"""

def require_frozen(config: dict, *, freeze_path: str = FREEZE_PATH, repo: str = ROOT) -> str:
    """As documented today, plus: the differing entries are reported as dotted keys over the flattened
    config (nested lists and dicts are values, compared by their canonical JSON), never by a set of
    `.items()`, which raises on unhashable values."""
```

**C1.5 `parts_verify` stops dirtying the tree.** `main()` rewrites `parts-ref11-verified.json` only when
`files` or `base_radius` differs from the stored artifact. It prints `unchanged: not rewritten` otherwise.

**C1.6 The committed driver.** `tools/parts_run.py` (new)

```
python3 tools/parts_run.py reduce --L FILE --S FILE --reduce {L,S,LS} --out PATH
        [--S-frame stored | contains:FILE | refuses-with:FILE | coset:N]
        [--rung 1 | stab | order:K] [--max-minima N] [--phase2-wall SEC] [--wall-ask SEC]
        [--checkpoint PATH]   # defaults to <out>.ckpt.json, so nobody forgets one
        [--dry-run]           # print and stop: see below
python3 tools/parts_run.py frames --L FILE --S FILE [--contains FILE | --refuses-with FILE]
python3 tools/parts_run.py --self-test
```

`--reduce`, not `--side`: "side" is not English for both halves, and the domain pass made the parameter
a set (§M). `Stage.side` survives as the spelling, for the records already on disk.

**`--dry-run` is the surface that makes the 15-minute rule mechanical.** It builds the stage, prints what
the run will be, and stops — so the text you paste into the announcement is generated rather than
composed:

```
stage      reduce {L,S}   L 412 + S 165 = 577 vertices, 2904 edges (36 connection)   576 atoms at rung 1
identity   9c1f…  (graph 1c9e…, deletable 576, atoms 576, pin 3, law cos 7/8)
frames     S frame: coset 1 of 2, element = identity (image of (2,0,4,2) is (2,0,4,2)); the other coset
           is a DIFFERENT problem (C4b)
forecast   phase 1 ~ 6 s (576 asks at the L451 mean); the level unmeasured at this size, 20-90 min
           ASSUMING the L451 ask means hold; checkpoint data/m62/ckpt/… (resumable, budgets may change)
writes     data/m62/m63-joint-A412-A166.json
```

```python
def load_side(name: str) -> list[tuple[int, int, int, int]]:
    """A `.vtx` file from `data/m62/parts-ref11/JP/Large/` by basename, through `parts_vtx.load_lattice`."""

def frames(base, S_tuples, *, contains=None, refuses_with_L=None) -> list[dict]:
    """Printed as one line per double coset, each naming a representative by its image of (2,0,4,2),
    whether the stored frame lies in it, and which requested property its members have. **The default
    `--S-frame stored` refuses rather than picks** when the stored frame does not qualify: it prints the
    qualifying cosets and the flag to choose one. A frame chosen silently is a run nobody can reproduce.

    Selection: the group elements h with h(S) ⊇ `contains`, or with `refuses_with_L ∪ ρ·h(S)` refusing four
    colours, **grouped into the double cosets that make them inequivalent** (§M): applying h to S alone
    is a new problem, applying it to both halves is the same problem, so the problems are
    `Stab(W_L) \\ G / Stab(S)`. The stored frame (the identity, index 0 — confirmed) is listed first
    whenever it qualifies.

    **A group element is named by its image of `(2, 0, 4, 2)`**, whose orbit the group acts on freely
    (24 distinct images, measured). An index into `parts_group()`'s order is an enumeration accident and
    would silently change meaning if that order ever moved; the image cannot."""

def rung_maps_for(base, stage, spec: str) -> list[dict] | None:
    """'1' → None. 'stab' → the stage's whole stabiliser. 'order:K' → the unique subgroup of that order,
    REFUSING when there are several and naming them. 'H<K>#<I>' → the I-th subgroup of order K in
    `parts_faces.subgroups` order. Always a subgroup of the STAGE's stabiliser, never of the base group
    (M64 §1)."""

def run_reduce(args) -> dict:
    """Build the stage, run `reduce_stage` with the checkpoint, and write the schema-2 record below
    atomically. The record carries its producer and is self-contained: its atom labels let a reader map
    atoms to lattice tuples without rebuilding the stage."""
```

**The schema-2 reduction record** (new fields marked `+`; the rest are as today):

```json
{
 "kind": "m63-reduction", "schema": 2,
 "producer": "tools/parts_run.py:run_reduce",
 "config": {"problem": {"L": {"source": "v451e2400.vtx", "fp": "…"},
                        "S": {"source": "v136e564.vtx", "fp": "…",
                              "frame": {"image_of": [2, 0, 4, 2], "is": [2, 0, 4, 2], "coset": 1,
                                        "found_by": "stored"}},
                        "side": "L", "rung": {"order": 1, "elements": [[2, 0, 4, 2]]},
                        "cross_law": {"cos": "7/8"}, "base_r": 2.6, "pin": true},
            "budgets": {"wall_ask": 600.0, "max_minima": 0, "phase2_wall": 0.0}},
 "+problem_sha256": "…", "config_sha256": "…", "+stage_identity": "…",
 "verdict": "reduced", "bound": {"lower": 374, "upper": 374, "rung": 1, "undecided": 0},
 "bound_render": "minimum 374 over all selections",
 "M_vertices": 375,
 "M_set": {"count": {"n": 3264, "method": "exhaustive-level", "of": null}, "up_to": "as found (companion fixed)"},
 "+M_set_canonical": [{"count": {"n": 282, "method": "symmetry-collapsed", "of": 3264}, "up_to": "Aut(A), order 12, companion moving"}],
 "+atoms": [["L", [a, b, c, d]], "…"],
 "minima": [[0, 3, "…"]], "+minima_fp": "blake2b of the sorted minima",
 "+member_profiles": {"orbits": [[2, 0, 6, 4], "…"], "rows": [[4, 6, 6, 8], "…"]},
 "A": ["…"], "+A_fp": "fp_tuples(A)", "+A_canonical_fp": "fp_tuples(min image of A)",
 "hypergraph": {"degree_1": 312, "correction_sets": 703, "sets": ["…"], "by_size": {}, "note": "…"},
 "asks": {"colourable": {}, "refusing": {}, "undecided": 0, "+wall_s": 600.0, "+phase1_unknown": []},
 "+undecided_candidates": [],
 "stage_fingerprint": "…", "base_fingerprint": "…", "seconds": 605.0, "provenance": {}
}
```

**C1.7 Committed producers for M64's two scratch artifacts.** `tools/parts_faces.py`

```python
def rung_lattice(base, stage, rec, *, verify_ask=None) -> dict:
    """For every subgroup H of Aut(A): the weight-minimum hitting set of the stored Y over the H-orbits.
    That is a LOWER bound, because Y is harvested lazily. When `verify_ask` is given, one refusal ask on
    the witness closes it to an equality whenever the witness refuses (M64 §R10(b)). Reproduces
    `data/m62/m64-rung-lattice.json`, whose producer was a scratch script."""

def orbit_closure(base, stage, rec) -> dict:
    """For every subgroup H: min over the level's members of |cl_H(M)| (M64 §R5), the solver-free upper
    bound. Its minimum over inclusion-minimal refusers is an equality (§R10(a)). Reproduces
    `data/m62/m64-orbit-closure.json`."""
```

**C1 planted controls:**

| control | plant | must read |
|---|---|---|
| c1.1 resume is exact | the S166 stage at the **order-3 rung** (55 atoms, 21 minima, 67 s uninterrupted, §1): once uninterrupted, once with `_stop_after` at half its iterations and then resumed | `resume-identical` on the minima set, w*, method, and the pre-interruption correction-set prefix; the post-resume `Y` compared and reported, never gated. Quick smoke: the order-6 rung (17.6 s) |
| c1.2 | resume from a checkpoint written by the S166 order-6 stage onto the order-3 stage | `checkpoint-stage-mismatch`, nothing asked |
| c1.3 the wall is real | a 1 ms wall on a refusing ask of the L451 full selection | `unknown`; `Bound.render()` contains "undecided"; `bound.closed` is false |
| c1.4 | a stub oracle answering `unsat` on the empty selection | verdict `companion-suffices`, no bound emitted |
| c1.5 the freeze | a scratch `git init` repository: (a) no file; (b) a committed file then edited; (c) a committed file with a config differing in a nested list; (d) committed and equal; (e) present but never committed | (a) "no freeze registered"; (b) "uncommitted edits"; (c) the dotted key named; (d) returns the sha; (e) "not in git history". **As shipped, all five crash** |
| c1.6 | `parts_verify.main()` twice into a scratch output path | the second run prints `unchanged: not rewritten`; the mtime is unchanged |
| c1.7 regeneration | `parts_run.py reduce` for S166 (`--L v374e1860.vtx --S v166e774.vtx --side S`) and L451 (`--L v451e2400.vtx --S v136e564.vtx --side L`), written **beside** the stored records as `…-reduction.v2.json` | `regenerated-identical` on stage fingerprint, minima set, bound and `A`; `Y` compared and reported (identity expected, but the harvest is solver-order-dependent, so a difference is reported with both sizes, not failed). **The stored records are never overwritten** (M64 §6.6) |
| c1.8 | `rung_lattice` and `orbit_closure` on the stored records | `reproduces-m64` rung by rung, or `differs-from-m64:<rung>` |

### C2 — the audit instrument, `tools/parts_audit.py` (new)

```python
**His tables are data, not call-site arguments** (§M). Typing `his_edges=(1920, 1930)` where an audit is
called is precisely where a number gets nudged toward agreement. So his Table 1 is transcribed once, with
his own index `graphs.txt` supplying each row's files, into `data/m62/parts-table1.json`:

```json
{"kind": "parts-table1", "source": "[Parts2020a] Table 1 (p. 767) + JP/Large/graphs.txt",
 "rows": {"L-M6A-375": {"type": "L-subgraph", "subtype": "M6A", "sym": [1, 2], "M": 375,
                        "edges": [1920, 1930], "A": 403, "set": 282,
                        "M_file": "v375e1920.vtx", "A_file": "v403e2112.vtx",
                        "columns": ["table2:375_m6ab_set"],
                        "attestation": {"M": 2, "edges": 1, "A": 2, "set": 1}}, "…": {}}}
```

A column may be attributed to **more than one row** — Table 2's "375 M6A&B" is one range column for runs
of 282 and 66 minima — and the transcription says so rather than choosing. That ambiguity is C3's whole
question, and it is now a field rather than a footnote.

```python
@dataclass(frozen=True)
class AuditSpec:
    """Which of his rows this level set is compared against, and nothing else. Everything compared comes
    from the transcription, so a call site cannot invent a target."""
    name: str                                   # "S166", "L451", "M6B403", "joint-A412-A166"
    his_row: str | None                         # a key of parts-table1.json, e.g. "L-M6A-375"
    extra_columns: tuple[str, ...] = ()         # further columns to compare, e.g. a second attribution

@dataclass(frozen=True)
class OrbitRow:
    """`status` is DERIVED from the three measurements, never stored beside them: `absent` when hi = 0,
    `stable` when the vertex set is constant, `unstable-constant-count` when lo = hi with a varying
    vertex set (L451's (2,0,2,4)), `unstable-varying-count` when lo < hi."""
    label: tuple[int, int, int, int]
    size: int
    lo: int
    hi: int
    vertex_set_constant: bool                   # the same vertices in every member
    his_range: tuple[int, int] | None
    his_shaded_stable: bool | None              # from the shading; None when not extracted or not applicable

    @property
    def status(self) -> str: ...

def canonical_counts(base, minima_vertices, stage) -> dict:
    """|{M}| under three named conventions, each a `SetSize`. **The convention that is his**, measured on
    both sides (8 on S, 282 on L), states in one sentence: *the stabiliser of the reduced part, with the
    frozen part free to move along*. For a one-sided stage that is `Stab(W_reduced)`; for the joint stage
    it is the diagonal `Stab(W_L) ∩ Stab(W_S)`. The other two are that group intersected with the
    companion's stabiliser, and the whole base group.

    Also reports `closed_under_AutA`. That held on both M63 stages but is NOT guaranteed: Aut(A) is not a
    symmetry of the stage when the companion is not invariant. A level that is not closed makes the first
    convention's count a count of orbits of a non-invariant set, and the record must say so."""

def compare_accumulator(base, A_tuples, his_path) -> dict:
    """Literal equality, both set differences with their vertices named, and every group element mapping
    ours onto his."""

def membership(base, minima_tuples, A_tuples, his_path) -> dict:
    """How many of his file's 24 group images lie in the level set, and how many lie inside A."""

def orbit_rows(base, minima_tuples, his_column=None, shading=None) -> list[OrbitRow]:
    """His definition of stable is 'the same non-empty vertex set in every minimum'. A single-valued
    range does NOT imply it: L451's (2,0,2,4) is 10 in every minimum with a varying vertex set. So that
    orbit is `unstable-constant-count` and can never be `stable`."""

def edge_decomposition(stage, selection) -> dict:
    """Always the whole decomposition, never one number: e(L), e(S), and the off-centre cross edges by
    RADIUS FAMILY (reference at |u|² = 4, auxiliary at the conjugate-ring pair, any other family the law
    produces). His Table 1 quotes e(L) for an L row, e(S) for an S row and the union for an M-type row,
    and his subtype name IS the auxiliary count — so one function serves every row and the reader can
    see which term was compared."""

def edge_profile(stage, minima_atoms) -> dict:
    """Over a level: the multiset of decompositions, the range of the compared term, and the stabiliser
    orders of the fewest-edge members (his parenthetical, e.g. "1 (2)")."""

def table_shading(pdf: str, page: int, table: str, *, dpi: int = 200, gray=(224, 224, 224)) -> dict:
    """Cell backgrounds of his Table 2 (page 25) or Table 3 (page 26), read by rasterising with
    `pdftoppm` and sampling the exact shading gray inside each cell. Cell boxes come from
    `pdftotext -bbox-layout` word positions, never from hand-typed pixel offsets. Planning measured that
    page 25 rasterises with exactly one shading value, RGB (224, 224, 224), on about 22 % of sampled
    pixels.

    Returns, per orbit row, the label cell's shading (his 'stable' marker, 'in the first column of Tables
    2 and 3') and each fill cell's shading (his 'filled' marker)."""

def shading_control(shading, table_json, base, level=None) -> dict:
    """TWO controls, because the first is necessary and not sufficient (§O7).

    (i) On HIS data: a fill cell is shaded iff its value equals its orbit's size ('Filled orbits are
    highlighted in gray'). Any disagreement lists the cells and makes the extraction
    `shading-unreliable`; no stable/unstable verdict is then emitted from it. This catches a
    misread gray and a column misalignment, but not a row misalignment in the label column alone.

    (ii) On OUR data, when `level` is given: a shaded label means stable, and stable implies a constant
    count, so a shaded label whose orbit's count VARIES in our level is a contradiction — either the
    shading refers to a different column of Table 2, or our level is not the one that column describes.
    That is the half with teeth, and it is what makes the partition a gate rather than a transcription.

    Table 2 has FOUR {M} columns and ONE first column, so its label shading refers to some column. Test
    the shading against each column's single-valued pattern and report which it is consistent with. Only
    a consistent column is gated. Table 3 has one {M} column (374) and is unambiguous."""

def check_A_column(table_json: str, table: str, vtx: str, base) -> dict:
    """His printed A column against the orbit fillings of his A file: the printed sum against the caption
    and the file, and every differing row (M63 §1(ii)'s method, for Tables 5, 6 and 7)."""

def reverify_hypergraph(stage, rec, *, sample: int = 100, seed: int = 0) -> dict:
    """An INDEPENDENT rebuild: `typem.cnf_for` on the induced graph and a fresh solver, sharing no CNF code
    with `Stage.cnf`. Every correction set C of size ≤ 2, plus a seeded sample of the rest, must satisfy:
    `A − C` colourable, and `A − (C − {x})` refusing for every x ∈ C. Plus the antichain property over
    all of Y, which needs no solver.

    Count methods: 'sampled' for the minimality half, 'exhaustive' for the antichain."""

def involution_classes(base, stage) -> dict:
    """Conjugacy classes of the stage's Aut(A), and which class each rung-live involution lies in (M64 P7,
    its unchecked half)."""

def completeness_control(profiles, predicted_classes) -> dict:
    """M64 P10: does a level set produced AFTER its exchange classes were computed span the affine hull
    those classes predict? Meaningful for C3's level and the rung levels; on the two stages the classes
    were computed from, it reports `not-applicable`."""

def audit_level(base, stage, rec, spec: AuditSpec, *, shading=None, ask=None) -> dict:
    """Composes the above into one record of `parts_report.Comparison` rows in mode 'tuning' (M63 is not
    frozen yet), each carrying its attestation. There is no aggregate verdict and no 'reproduced' field.

    Refuses every range, partition, necessary-atom and completeness claim on a level whose count method
    is not exhaustive (via `LevelSet.require_complete`)."""
```

**Artifacts:** `data/m62/m63-audit-S166.json`, `m63-audit-L451.json`, `m63-audit-M6B403.json` (C3),
`m63-audit-joint-A412-A166.json` (C4). Also `data/m62/parts-table2-3-shading.json` and
`parts-table5-7-orbit-fillings.json` (a transcription, with its checksum and the PDF page it came from).

**The open rungs.** `m64-rung-lattice.json` rows whose bound is not closed: one L subgroup (≥ 377) and, on
the S side, one involution (≥ 138). The S order-3 rung, listed there as ≥ 139, **was closed in planning at
142** (§1). Each gets `parts_run.py reduce --rung H<K>#<I>`; minutes each.

**C2 planted controls:**

| control | plant | must read |
|---|---|---|
| c2.1 | remove one group image of one minimum from the L451 level | `closed_under_AutA: false` (true as stored) |
| c2.2 | his `v403e2112` with one vertex removed | `A-differs`, naming the vertex (`A-equal` as stored) |
| c2.3 | one row of Table 2's 375 column shifted by +1 | that row's comparison `differs` (`agrees` as stored) |
| c2.4 | a synthetic two-member level whose orbit keeps the same count with different vertices | `unstable-constant-count`, never `stable` |
| c2.5 | the L451 record relabelled `truncated-at-budget` | every range, partition and necessary-atom claim refused |
| c2.6 | one fill cell whose value equals its orbit size, repainted white in the raster | `shading-unreliable`, listing the cell |
| c2.7 | a correction set with an extra atom added; a set whose removal still refuses | `not-minimal`; `not-a-correction-set` |
| c2.8 | a superset of an existing correction set appended to Y | `antichain-violated` |
| c2.9 | Table 6's A column and `v238e1131` | agree (the positive control; M63 §3(a) found only Table 6's sum correct) |

### C3 — the M6B 375 level set, and what Table 2's "M6A&B" column is

**The question.** The L451 level set is his M6A 375 set by count (282) and by union (`v403e2112`). Its
ranges leave Table 2's 375 column in two orbits only: `(2,0,6,4)` reaches 6 against his 4, and
`(10,0,2,4)` reaches down to 6 against his 8. The column is headed "M6A&B", and his M6B 375 run has 66
minima with `A = v403e2106`.

**The frame matters here more than anywhere.** `Stab(v403e2106)` has order 6 and `Stab(v141e594)` is
trivial, so the M6B problem has **four** inequivalent relative frames (four double cosets of size 6), and
his `v375e1916` refuses in **twelve** of the 24 frames — that is two of the four. So two of the four are
live, they are different problems, and the run records which one it used. If the first does not return
66, the second is run before the column is called undecided.

**The run** (after C2 exists, predictions committed first):

```
python3 tools/parts_run.py frames --L v403e2106.vtx --S v141e594.vtx --refuses-with v375e1916.vtx
python3 tools/parts_run.py reduce --L v403e2106.vtx --S v141e594.vtx --S-frame <stored if listed, else the first>
        --side L --rung 1 --checkpoint data/m62/ckpt/m63-M6B403.ckpt.json --out data/m62/m63-M6B403-reduction.json
```

Then `audit_level` with the spec `M6B403`:
- `his_A = v403e2106`;
- `his_members = (v375e1916,)`;
- `his_column = 375_m6ab_set`;
- 375 vertices, edges 1916–1926, count 66, sym (1, 2).

*Cost ≈ 10 min, one core.*

**The decision rule, registered before the run:**

| outcome | reading |
|---|---|
| the M6B ranges equal the printed column row for row | **the printed column is M6B's** |
| the M6B ranges are narrower, and M6A's profile set ∩ M6B's profile set has exactly the printed ranges | **the printed column is the profiles the two subtypes share** |
| an M6B member has `(2,0,6,4) ≥ 5` | neither reading; the column is **undecided**, and the numbers are reported |

**Why this is not a held-out run.** It reduces his own published accumulator with his own companion, and
zero parameters are free. That is the same shape as M63 §R1's S166 calibration. The M6B held-out problem
that tests the loop is 374 at rung 2 (78 minima), and it stays untouched for E. Its rows are stamped
TUNING.

### C4 — the joint stage and the record-bearing run

The joint stage is `side="LS"`, i.e. `reduce = {"L","S"}` — no third code path (§M). Under `rung_maps`
the same group element acts on both halves at once, which is sound because every element of the order-24
group preserves unit distance and both polynomial conditions of the cross-edge law over K (M62 §R19(1)).
`side_fixed` is 1 for every side: the shared centre. The pin is conditional on presence, so pin vertices
may be deleted, as they already are on the L side.

**The joint problem has more than one relative frame, and they are not equivalent.** Applying a group
element to the S half alone gives another joint problem; applying one to both halves gives the same
problem. So frames in one double coset of `Stab(W_L) \\ G / Stab(W_S)` give isomorphic problems (§O4
proves that direction; the converse is **not** claimed), and there are **at most two inequivalent
problems here** (measured: `|Stab(A412)| = 12`, `|Stab(g⁻¹A166)| = 6`, two double cosets of size 12).
One contains the record. **The other is a second joint problem of the same cost that no one has run** —
C4b below, if the product owner approves the extra run; otherwise it is F(b)'s first item.

**C4 planted controls:**

| control | plant | must read |
|---|---|---|
| c4.1 the joint search is not blind | the joint stage over the record itself, `v374e1860 ∪ ρ·v136e564` in stored frames | `Bound(508, 508, 1)`, **exactly one minimum** (everything), 508 critical atoms in phase 1. This is also the unchecked half of M63 §4's phase B control: every single deletion, on either side, is colourable. **With the S-omission bug planted** (`deletable = Lbits & ~centre` for "LS"): 373 atoms, and the control reports `joint-stage-omits-a-side` |
| c4.2 | `pin_is_sound` on the joint stage over `A412 ∪ ρ·g⁻¹(A166)` | `pin-agrees-everywhere` |
| c4.3 | the joint stage with every S atom forced kept by assumption, against the L-only stage on the same working graph, over 20 seeded random L selections | `joint-degenerates-to-L`: identical verdicts |

**The run** (predictions committed first; announced to the product owner before launch if its forecast
exceeds 15 minutes; checkpointed):

```
python3 tools/parts_run.py reduce --L v412e2106.vtx --S v166e774.vtx --S-frame contains:v136e564.vtx
        --side LS --rung 1 --max-minima 64 --wall-ask 600
        --checkpoint data/m62/ckpt/m63-joint-A412-A166.ckpt.json --out data/m62/m63-joint-A412-A166.json
```

- **What is reported:**
  - the closed bound at the first optimum, which answers card 1;
  - then up to 64 minima at w*, as `Count(k, "bounded-below")` (the joint level at 509 has at least the
    ~13k raw L-minima of `A412` against `S136`, so exhausting it is D's or F's decision, not C's);
  - for every minimum found, its split `(|L'|, |S'|)`;
  - both ask populations, and the correction-set census.
- **Stop rule.** If w* ≤ 507 atoms (**≤ 508 vertices**):
  - stop, and report to the product owner the same hour;
  - rerun with `--max-minima 0 --phase2-wall 7200` to exhaust the smaller level;
  - produce the exact-geometry re-check of one minimum and a CaDiCaL refusal with an LRAT proof for the
    report. The Lean certificate is phase F's.
- *Forecast:* phase 1 under a minute (576 asks); closing the bound 20–90 minutes on one core; ≥ 1,500
  correction sets. It is unmeasured at 576 atoms, which is why the checkpoint is mandatory.

**C4b — the second relative frame** (one more run of the same shape, `--S-frame coset:2`). It is a
different joint problem over the same two accumulators, and its minimum is unrelated to the record's by
anything proved so far. Same stop rule. *Recommended; the product owner's call, since it doubles C4's
compute.*

---

## §3 — Order of work, compute, and stop rules

1. **C5**, with its controls (an hour or two; seconds of compute).
2. **C1.1–C1.5** with their self-tests (half a day; the resume control is ~3 minutes).
3. **C1.6–C1.8**: `parts_run.py`, then the two regenerations (~20 minutes on one core, in the background as
   a process group, **announced first**), then the M64 producers.
4. **C4**: the stage and its controls; **commit §4's C4 predictions**; announce; launch the joint run in
   the background (one core).
5. **C2**, while the joint run goes, since its computations are light: the instrument, the shading,
   Tables 5–7, the re-verification, the involution classes, then the open rungs (minutes each, one core).
6. **C3**: commit its predictions, run it, audit it.
7. **Close:**
   - write M63 §R2;
   - update M63 §S.3's C rows in place, and §S.2 where a number moved;
   - commit `plans/POROS-2026-09-11-m63-phaseC.md` by path if it changed;
   - report.

**Compute rules:**
- At most 8 cores in use at any time, and one heavy job at a time.
- Every job over a minute is a process group (`setsid nohup …`, pgid to a file, stopped only by
  `kill -TERM -<pgid>`).
- Every job over 15 minutes checkpoints and resumes exactly, and is announced.
- **Any unexplained crash: halt and report**, and do not retry.

**Git rules:**
- Commit on `backlog` and stage by path only.
- Never run `git add -A`, `git checkout --`, `git reset` or `git stash`.
- End every commit with the two attribution lines.

---

## §4 — Registered predictions

*Committed with this subplan, before any run. An outcome is scored in M63 §R2 against the row as written
here.*

| # | prediction | falsifier |
|---|---|---|
| P-C1.1 | both regenerations are `regenerated-identical` on minima, bound and `A`; `Y` identical too | any difference in minima, bound or `A` |
| P-C1.2 | PySAT's `cadical153` honours `interrupt()` | the 1 ms wall returns `unsat` |
| P-C2.1 | the S166 audit agrees on every attested row: 136; 564–567; 8 up to `Aut(A)`; `A = v166e774`; `v136e564` a member; sym 1; Table 4's M6A ranges | any row differs |
| P-C2.2 | the L451 audit agrees on every attested row **except** `(2,0,6,4)`'s upper end and `(10,0,2,4)`'s lower end in Table 2's 375 column | any other row differs, or either of the two agrees |
| P-C2.3 | the shading's arithmetic control passes on Tables 2 and 3; Table 2's label shading is consistent with the 374 M6A&B column | a shaded fill cell whose value is not its orbit size, or the reverse |
| P-C2.4 | Table 6's `A` column matches `v238e1131`; Table 5's and Table 7's discrepancies (−16 and +3) are typos confined to at most three rows each, each explained by the file, as Table 3's were | a discrepancy the file does not explain |
| P-C2.5 | `Y` re-verifies: 0 failures in the sampled minimality, 0 antichain violations, on both records | any failure |
| P-C2.6 | the open L rung closes at its lower bound, 377; the open S involution closes at 138 | a closed value above the bound |
| P-C2.7 | the three live involutions of L451's `Aut(A)` form one conjugacy class | they do not |
| P-C3.1 | the M6B level: 375 vertices, **66** up to `Aut(A)`, union `v403e2106` (literally or up to the group), edges 1916–1926, fewest-edge stabiliser 2 | any of these differs |
| P-C3.2 | **no M6B member has `(2,0,6,4) ≥ 5`**, so the printed "M6A&B" column is M6B's ranges or the profiles both subtypes share, not the union of the two runs | an M6B member with `(2,0,6,4) ≥ 5` |
| P-C4.1 | **the joint minimum over `A412 ∪ ρ·g⁻¹(A166)` is exactly 509 vertices.** Planner 0.60; Poros 0.65 | a joint refusing selection of ≤ 508 vertices |
| P-C4.2 | if 509: every minimum found splits as `(374, 136)` | a minimum split `(375, 135)` or `(373, 137)` |
| P-C4.3 | cost: phase 1 < 60 s; bound closed within 90 minutes; ≥ 1,500 correction sets | outside any of these |
| P-C4.4 | **C4b**, the second relative frame, also closes at 509 vertices. Registered at 0.5 and no higher: nothing proved relates the two cosets, which is the reason to run it | a joint minimum there below or above 509 |
| P-C5.1 | the explicit law reproduces the L451 fingerprint and the record's 2,442 edges at no measurable cost | any difference |

---

## §5 — What must not be done

1. **No joint result reported as a reproduction row.** It is compared with his tables on `|M|` and edges
   only.
2. **No held-out loop problem touched.**
   - Untouched: M6B 374 at rung 2, M6C, S M6B and M6C, the 8/3 mono-pair, the √3 triple.
   - C3 uses only his published M6B 375 accumulator, with zero free parameters, and is stamped TUNING.
3. **No stored record overwritten.** Regenerations are written as `.v2.json` beside the originals.
4. **No wall-less run reported with "zero undecided asks".** After C1.1 the number is measured; before
   it, it was not.
5. **No verdict word that means "clean"; no count without its enumeration; no bound without its rung.**
6. **No frame chosen silently.** Stored frames first; any group element is written into the config.
7. **No Lean.** A ≤ 508 goes to the product owner with an exact-geometry re-check and an LRAT refusal;
   the kernel certificate is phase F's.
8. **No run over 15 minutes without a checkpoint and an announcement; never more than 8 cores.**
9. **No artifact without a committed producer** (M64 §6.9).
10. **No gray value typed by hand.** The shading's cell boxes come from `pdftotext -bbox-layout`, and the
    arithmetic control decides whether to believe the extraction.

---

## §6 — Acceptance (mirror of M63 §S.4, phase C)

- [ ] **C5:** c5.1–c5.5 fire.
- [ ] **C1:**
  - [ ] c1.1–c1.8 fire.
  - [ ] Both regenerations are written, with their verdicts.
  - [ ] `git status` is clean after a `parts_verify.py` run.
- [ ] **C2:**
  - [ ] c2.1–c2.9 fire.
  - [ ] The S166 and L451 audits are written.
  - [ ] The shading is extracted (or refused, with the reason).
  - [ ] Tables 5–7 are checked.
  - [ ] `Y` is re-verified.
  - [ ] The involution classes are reported.
  - [ ] The two open rungs are closed.
- [ ] **C3:**
  - [ ] The M6B level set is reduced and audited.
  - [ ] The column's reading is decided, or reported undecided with numbers.
- [ ] **C4:**
  - [ ] c4.1–c4.3 fire.
  - [ ] The joint run reaches a closed optimum, or reports its open interval with the checkpoint intact.
  - [ ] The verdict is recorded whichever way it comes out.
  - [ ] The stop rule is honoured.
  - [ ] **C4b** (if approved): the second relative frame, same shape, same stop rule.
- [ ] **§4:** every prediction is scored in M63 §R2.
- [ ] **Close:**
  - [ ] M63 §S.3's C rows are updated in place.
  - [ ] `BIBLIOGRAPHY.md`'s `[Haugland2026]` row is updated (§PA(a)).
  - [ ] Poros's record is committed by path.

---

## §7 — Poros's cards, and their fates

*The record is `plans/POROS-2026-09-11-m63-phaseC.md`. Every card is answered here.*

| card | question | fate |
|---|---|---|
| 1 (rank 1) | does the record survive a joint reduction on his own accumulators? | **ADOPTED as C4.** Its evidence was re-derived before adoption (M63 §S.2 #8): the frames, the six elements giving one `g⁻¹(A166)`, the 576 atoms, and the record inside. It is gated on exact resume (C1.2), because the run may exceed 15 minutes |
| 2 | is the L375 level set already his? | **ADOPTED; answered in planning.** 282 measured directly; the tails' edges sit at 1925–1926, inside his 1920–1930; P9 retired as vacuous (M63 §S.2 #1, #4, #5). What remains is C3 |
| 3 | what do "reproduce" and "beat" accept? | **DECIDED by the product owner** (M63 §S.1): a registered rule must find the expansion; E is required; beat means < 509, or 509 with < 2,442 edges, kernel-certified |
| 4 | how many admissible rotations refuse four colours at all? | **DEFERRED to G's opening gate**, with the cheap half taken in C5. The collinear law is one parameter for every rotation whose sine leaves K. Full rotation generality is declined until G's census shows more than one rotation passes (M63 §S.5) |
| 5 | can "{M} grows at fixed \|M\| in a rule-driven iteration" be met by a rung relaxation alone? | **DECIDED by the product owner:** the clause now requires a fixed rung and added vertices (M63 §S.1 2c) |
| measurements M1–M3 | state 3–4's accumulators; his stated rule on his move | M1–M2 **re-derived and adopted** (M63 §S.2 #9). M3 **recorded, not re-derived**: it bears only on D's diagnostic, which never gates |

---

## §8 — Decisions settled in planning

| choice | alternative weighed | why this one | confidence |
|---|---|---|---|
| Phase C's subplan lives in its own file; M63 carries the state, the audit and the roadmap | everything in M63 | M63 was 794 lines and §S added ~250; three modeling passes here would push it past readability, and the implementer needs one file | high |
| P9 retired without a run | run the 18-edge re-reduction | every minimum already realises 18 connection edges through one auxiliary subset; deleting atoms in no minimum cannot change the level | high |
| The tail question is decided by the M6B level set (C3) | leave M6B entirely to E | only M6B's own level set can say what the "M6A&B" column is; it reduces his published accumulator with no free parameter; the held-out M6B loop problem stays untouched | medium — if the product owner counts any M6B number as spent, C3 moves to E |
| The joint run is C's record-bearing experiment | leave it to F | it is the cheapest test that can meet the goal, and its outcome changes what D's loop expands (M63 §S.4, D's last row) | high (provisionally approved) |
| The joint level is sampled (64 minima), not exhausted, at 509 | exhaust it | at 509 it holds at least the ~13k raw L-minima of `A412` against `S136`; exhaustion is hours and answers no question C asks | high |
| The ask wall defaults to 600 s and an interrupted candidate is recorded, not guessed | keep no wall | M62 recorded a 17-minute ask; without a wall "zero undecided" cannot fail (G21) | high |
| Resume promises the level, not the post-resume harvest | promise identical `Y` | a fresh solver may return a different model for the same colourable ask; promising `Y` would make the control fail on correct code | high |
| Checkpoints are JSON, not pickle | keep the existing pickle | readable by an outside reader, and diffable when a resume is questioned | high |
| The shading is read from the raster, and trusted only through the arithmetic control | report ranges only and call the partition unattested | §3 makes the partition a hard gate, and his definition of stable is not the single-valued range; a raster read with a control that knows the answer for every fill cell is cheap | medium — if the table layout defeats the cell boxes, the partition is reported unattested |
| C2's cheap `Y` statistics (M63 §4 phase C) are proposed for dropping | compute them (~1 h) | they size his explicit enumeration, which we do not run (M63 §S.3 C-5, awaiting approval) | medium |

---

## §H — Handoff notes

- **Data addresses:**
  - his 43 files: `data/m62/parts-ref11/JP/Large/`, with his index `graphs.txt`;
  - the stored records: `data/m62/m63-S166-reduction.json` and `m63-L451-reduction.json`;
  - M64's artifacts: `data/m62/m64-*.json`;
  - Table 2: `data/m62/parts-table2-orbit-fillings.json`;
  - the paper: `~/source/library/pdf/arXiv-2010.12665-parts-509-minimization.pdf`, where Table 2 is on
    page 25, Table 3 on page 26, Tables 5–7 on pages 26–28, and `pdftotext -layout` works.
- **Group order:** `parts_faces.base_group_perms(base)` returns the order-24 group as tuple→tuple dicts,
  in `typem.parts_group()` order. Confirm which index is the identity before relying on "index 0".
- **The L451 stage** is `Stage(Base(2.6), load_lattice(v451e2400), load_lattice(v136e564), side="L",
  rung=1, pin=True)`, fingerprint `0700718c70107448b8658a630c5456ee`. **The S166 stage** is
  `Stage(Base(2.6), load_lattice(v374e1860), load_lattice(v166e774), side="S")`.
- **Applying a group element to a whole minimum set** is fastest on the tuple dicts. The first planning
  probe timed out at 300 s applying the exact-arithmetic group point by point to 3,264 minima; on the
  dicts it took seconds.
- **Talk to Poros** if a card would help. Poros is the advisor sibling, and its address arrives with the
  implementation brief. Re-derive anything it measured before relying on it.

---

## §M — The domain-modelling pass (WORKFLOW step 5, `debruijn-domain-modeling`, run fresh)

*Applied to phase C's objects: the joint stage, the reduction record and its checkpoint, the audit
instrument, and the cross-edge law. Four collapses, four corrections — two of which are bugs the skeleton
would otherwise have shipped — and two measurements the pass needed before it could choose.*

### The cut it was run on

| intrinsic to the problem | incidental, and it had crept into the skeleton |
|---|---|
| a stage is *a working graph, a frozen part, and a set of deletable vertices* | "L", "S", "LS" as three cases, with the joint stage a third code path |
| a type-M vertex is *a half and a lattice point* | a bare lattice tuple, which collapses the two halves the moment both are deletable |
| a run's state is *what has been decided so far* | a checkpoint schema and a record schema, to be kept in agreement by hand |
| a group element is *its action* | its index in `typem.parts_group()`'s enumeration order |
| his published numbers are *transcribed data with attestations* | arguments typed at the call site where the audit runs |
| the cross-edge law is *the cosine* | a cosine and a name stored beside it |

### The four collapses

1. **`side` is the set of halves that may be deleted.** `"LS"` is a spelling, not a case. The deletable
   set becomes one expression — the chosen halves minus the shared centre — and the joint stage stops
   being special. With it, **a vertex is `(half, tuple)`**: on a joint stage the same lattice point is two
   different vertices, so every atom label, minimum, profile and group image carries its half.
2. **The checkpoint and the record are one state at two times.** `finish()` adds only derived views. And
   `blocked` was a second copy of the minima — it is `minima ∪ undecided`, derived.
3. **His tables are a transcription** (`data/m62/parts-table1.json`, built from Table 1 and his own
   `graphs.txt`), and `AuditSpec` shrinks to a row id. A column may be attributed to two rows, which is
   exactly the "375 M6A&B" question, so the attribution is a field and C3 decides it with data.
4. **Derived things stop being stored:** `OrbitRow.status` from its three measurements, `CrossLaw.name`
   from `cos`.

### The four corrections, two of them bugs caught before implementation

1. **`stage_fingerprint` does not identify a search.** It hashes the present graph, so an L stage and an
   LS stage over one working graph share it — and so do two rungs. The resume control this subplan
   already specified (a checkpoint from the order-6 rung offered to the order-3 rung) would have been
   *accepted*, silently resuming one search onto another. Hence `Stage.identity()`, over the graph, the
   deletable set, the atom partition, the pin and the law.
2. **A budget is not part of the problem.** Resume is refused on a problem mismatch and permitted on a
   budget change; on resume the undecided candidates go back into the pool, because re-asking with a
   longer wall is exactly what continuing a truncated run means. Freezing the two together would have
   made a wall-truncated run unresumable.
3. **A frame is named by its action.** An index into `parts_group()`'s order is an enumeration accident.
   The orbit of `(2,0,4,2)` is free — 24 distinct images, measured — so a group element is named by its
   image of that point, and a record stays readable if the enumeration ever moves. (The identity is index
   0, confirmed.)
4. **"The frame" is not one frame.** Applying a group element to the S half alone is a different problem;
   applying it to both is the same problem. So the inequivalent relative frames are the double cosets
   `Stab(W_L) \\ G / Stab(W_S)`. **Measured: two for the joint stage** (orders 12 and 6, two cosets of
   size 12), **four for the M6B stage** (orders 6 and 1), of which his own minimum refuses in two. That
   turned a detail into C4b and into C3's frame rule.

### What the model now refuses to represent

A bare tuple as a joint-stage vertex; a `blocked` list that can disagree with the minima; a resume across
different atom partitions; a frame or a subgroup as an integer index; one of his values typed at a call
site; an orbit status stored beside the measurements it follows from; a law with a name that can drift
from its cosine. Each was reachable in the skeleton as first written.

### Seams checked

- **Adversarial member:** a checkpoint that matches the fingerprint and belongs to another search
  (correction 1); a truncated run whose continuation needs a longer wall (correction 2).
- **Unsampled member:** a level with a nonempty undecided list — its count method must be
  `bounded-below` and the completeness invariant must not be claimed; a joint stage with every S atom
  held fixed, which must reproduce the one-sided stage exactly (control c4.3).
- **Non-vacuity:** the joint stage's positive control is an instance whose answer is known in advance —
  the record itself must come back as the unique minimum (c4.1).
- **Next lemma for free:** D's expansion is `W_{n+1} = A_n ∪ Δ` over vertex sets, with no restatement; E's
  companions attach as extra structure rather than as a fourth side; G swaps the law and the base without
  touching either.

---

## §O — The obligation-modelling pass (WORKFLOW step 5, `debruijn-obligation-modeling`, run fresh)

*What phase C must prove, what it may only test, and what it assumes. The proofs are short because the
statements were chosen to make them short; each is written out so an implementer can check it rather than
trust it.*

### O0 — The partition

| prove (here, by hand) | test (a planted control) | assume (named, and named again in every record) |
|---|---|---|
| monotonicity on the joint stage (O1); resume soundness (O2); the three undecided sites (O3); the double-coset direction (O4); free-orbit naming (O5); the expected answer of the joint positive control (O9) | every control of §2; the two regenerations; the shading's two halves | CaDiCaL is a correct oracle; PySAT's `interrupt()` is honest (**c1.3 tests it**); the base and group are fixed (`fp_base`); the arena is equivariant under the order-24 group (derived, M62 §R19(1)); **his published minimality of 374 and 136**, which O9's control leans on |

### O1 — Monotonicity survives the joint stage, so everything M63 §O proved carries

`R(S) := W[S ∪ fixed] ∪ C refuses four colours` is **upward closed** in `S`, because an induced subgraph
of a 4-colourable graph is 4-colourable. *The proof never mentions which vertices are deletable.* So
making both halves deletable changes nothing in M63 §O: the MCS/MUS duality, phase 1's soundness, the
hitting-set formulation, the completeness invariant and its lexicographic measure all hold verbatim, and
`|M| = w* + 1` because the shared centre is the reduced part's only fixed vertex.

**What does not carry, and must not be quietly assumed:** the atom partition at a rung above 1 is still
unsound in the sense M63 §O(2) proved (it loses minima), and the joint level's closure under a symmetry
group is still a measured fact, not a theorem (O6).

### O2 — Exact resume, and the one line that makes it true

Split the run's state into **problem facts** and **launch facts**:

| decided fact | problem or launch? |
|---|---|
| the pin verdict; phase 1's `critical`/`droppable` verdicts; each correction set (verified by a model); each recorded minimum and `w*` | **problem** — the 4-colourability of a fixed finite graph is determined, so a verdict does not depend on when it was asked |
| a candidate the wall could not decide; a phase-1 atom the wall could not decide; the budgets themselves | **launch** |

> **Claim.** A relaunch that (i) refuses unless `stage.identity()` and `problem_sha256` match, (ii)
> restores the problem facts, (iii) **returns every launch fact to the pool** — undecided candidates
> unblocked, unknown phase-1 atoms re-asked — and (iv) continues, ends with the same `(E, w*, method)` as
> one uninterrupted run under the union of the budgets.
>
> *Proof.* By (i) the search space and the weights are the same. By (ii) and the table above, every
> restored fact is a fact about that space. The level loop rebuilds its MaxSAT instance each iteration
> from `(Y, blocked)` with `blocked = E ∪ U`; after (iii) `U = ∅`, so the instance is exactly the one an
> uninterrupted run would hold at that point, and M63 §O(1c)'s preservation argument applies unchanged.
> Termination is the same lexicographic measure with `|U|` added to the first component: each iteration
> grows `E`, `Y` or `U`, and all three are bounded. ∎

**What resume does not promise:** the correction sets harvested *after* the resume point. A fresh
incremental solver may return a different model for the same colourable ask, and the shrink starts from
that model. **The level is a problem fact; the harvest order is a launch artifact.** Any control that
demands an identical `Y` across an interruption is asserting something false about correct code.

**One residual risk, priced:** a corrupted checkpoint would restore unverified correction sets and could
make the lower bound unsound. Hence `--verify-checkpoint`, which re-asks a sample on load; off by
default, on whenever a checkpoint has been moved or edited.

### O3 — An undecided ask at each of its three sites

| site | treated as | why it is sound | what it costs |
|---|---|---|---|
| **phase 1**, `ask(All − {a})` | *not critical* | a degree-1 hyperedge is only added on `sat`; omitting a true hyperedge shrinks `Y`, and `mhs(Y) ≤ mhs(Y*)` is a lower bound either way | the atom stays deletable; the unknowns are listed in `asks.phase1_unknown` |
| **the shrink** | *still needed* | the shrink starts from a set that IS a correction set and only removes an element when the remainder is verified colourable, so the result is always a correction set — possibly not minimal | the set is flagged `minimal: unknown`, and the antichain control must tolerate it rather than fail |
| **the level loop**, candidate `h` | *neither a minimum nor a correction set* | blocking `h` may remove an unrecorded R-true set of weight `w*`, so **the completeness invariant is lost** and the count method becomes `bounded-below`; the BOUND stays sound, because the MaxSAT optimum over `Y ⊆ Y*` is a lower bound regardless | `h` is recorded in `undecided_candidates`, and `Bound.undecided = |U|` |

**`Bound.undecided` counts candidates, not asks.** A phase-1 unknown threatens no claim, so it is reported
separately; a level candidate does, and it is what must keep `Bound.closed` false.

### O4 — Frames in one double coset give the same problem; the converse is not claimed

> **Claim.** If `h' = a·h·b` with `a ∈ Stab(W_L)` and `b ∈ Stab(W_S)`, the joint problems `(W_L, h·W_S)`
> and `(W_L, h'·W_S)` are isomorphic by a weight-preserving bijection of selections, so they have the
> same minimum and corresponding level sets.
>
> *Proof.* Apply `a` diagonally to both halves. It is an automorphism of the arena (it preserves unit
> distance and both polynomial conditions of the cross-edge law over `K`, M62 §R19(1)), it fixes `W_L`,
> and it sends `h·W_S` to `a·h·W_S = h'·b⁻¹·W_S = h'·W_S`. Selections map across bijectively with their
> weights, and `R` is preserved. ∎

**The converse is false as a claim and unproven as a fact**: two different double cosets may still give
isomorphic problems. So the honest sentence is *"at most two inequivalent joint problems"*, and C4b
measures rather than assumes. Any report saying "there are two joint problems" is overclaiming.

### O5 — A group element is named by its image of a free point

> **Claim.** If `Stab(x)` is trivial then `g ↦ g·x` is injective on `G`, so `g·x` names `g`.
> *Proof.* `g·x = g'·x ⟹ g'⁻¹g ∈ Stab(x) = {1}`. ∎

Measured: `(2,0,4,2)` has 24 distinct images under the order-24 group, so its stabiliser is trivial.
**Obligation on the instrument:** assert `|{g·x : g ∈ G}| == |G|` before naming anything that way, and
refuse the naming if the base or the group ever changes so that it fails.

### O6 — What a count "up to H" means when the level may not be closed

Counting `|{M}|` up to `H` is the number of `H`-**orbits meeting** the level, and that equals the number
of orbits **contained** in it only when the level is `H`-closed. For his convention — the stabiliser of
the reduced part, with the frozen part free to move — closure is **measured** on both M63 stages and is
**not** a theorem: `g ∈ Stab(W_L)` gives `g(M) ∪ g(C)` refusing, not `g(M) ∪ C`. So `canonical_counts`
reports `closed_under_H`, and a count taken where it is false says "orbits meeting the level".

### O7 — The shading needs two controls, because the arithmetic one is necessary and not sufficient

His caption gives an independent ground truth for the **fill** cells (shaded ⟺ filled ⟺ value = orbit
size), which catches a misread gray and a column misalignment. It cannot catch a row misalignment in the
**label** column, which is the column the partition is read from. The second control uses *our* level:
**stable implies a constant count**, so a shaded label whose orbit's count varies in our level is a
contradiction — either the shading refers to another of Table 2's four `{M}` columns, or our level is not
the one that column describes. Both outcomes are findings; neither is silent.

### O8 — What the regeneration control does and does not prove

`regenerated-identical` proves that the committed driver computes the same level from the same stage. It
does **not** prove the stored record was right. And its two failure modes are not the same: a differing
`Y` with an equal level is expected (O2's launch artifact), while a differing **level** is a defect. The
control names which.

### O9 — The joint positive control's answer is a theorem, given his minimality

> **Claim.** Over `W = v374e1860 ∪ ρ·v136e564` with both halves deletable, the only refusing selection is
> the whole of it, so the minimum is 508 atoms (509 vertices) with exactly one minimum.
>
> *Proof.* Let `(L', S') ⊆ (L374, S136)` refuse. By upward closure `(L', S136)` refuses, so `|L'| ≥ 374`
> by the minimality of 374 against `S136`; and `(L374, S')` refuses, so `|S'| ≥ 136` by the minimality of
> 136 against `L374`. Hence `L' = L374` and `S' = S136`. ∎

So c4.1 is a control with a **derived** expected answer, which is what a positive control should be. If it
comes back otherwise, either one of his two minimality claims is wrong or our stage is not his object —
and both are loud findings rather than a tuning nudge. It also discharges M63 §4 phase B's unchecked
control, that every single-vertex deletion of the record is colourable.

### O10 — The column attribution is a report, not a choice

For a candidate profile set `P`, the printed column is *consistent with* `P` when, orbit by orbit, the
range over `P` equals the printed range. C3 computes consistency for four candidates — M6A's profiles,
M6B's, their union, their intersection — and **reports every consistent one**. Two may be consistent at
once; the instrument must not pick. And a range is a coarse invariant of a profile set, so consistency is
evidence about the column's source, never proof of it.

### O11 — What each control proves, and what it would still miss

| control | certifies | blind to |
|---|---|---|
| c1.1 resume | the relaunch reproduces the level | whether the level is right (c1.7, c2.\*) |
| c1.3 wall | the wall interrupts and the bound opens | whether 600 s is the right wall |
| c1.5 freeze | all five refusals fire | whether the frozen config is the one D should have frozen |
| c1.7 regeneration | the driver computes the stored level | whether the stored level was right |
| c2.9 Table 6 | the `A`-column checker agrees where his table agrees | a systematic transcription error — **which is why Tables 5 and 7, known to disagree, are run in the same pass: the three together exercise both polarities** |
| c4.1 joint positive | the joint search finds a known answer (O9) | whether a bigger joint problem is searched correctly |
| c4.3 degeneracy | the joint stage reduces to the one-sided stage | whether the joint atoms are weighted right — covered by c4.1's 508 |

---

## §E — The experience-modelling pass (WORKFLOW step 5, `debruijn-experience-modeling`, run fresh)

*The consumers are three: the phase D/E/F implementer, who inherits these instruments; the product owner,
reviewing a run they did not launch; and the person who has to kill a multi-hour job and restart it. The
pass asks one question of every surface — what does the system know here that the reader will not have?*

### E1 — Four things the system knows and no artifact currently says

1. **Whether a number was checked or merely absent.** The skeleton said an unattested field "produces no
   row rather than a guessed one". That is silent omission: a reviewer cannot tell *agrees* from *never
   compared*. **Corrected:** the audit prints a row for every field of his transcribed row, with status
   `agrees` / `differs` / `not-compared — his table does not attest it` / `not-compared — our level is
   truncated`. Absence is never a blank.
2. **Which registered prediction a run scores.** A record carries `predictions: [{"id": "P-C4.1",
   "registered": "…", "measured": "…", "relation": "agrees|differs"}]`, so the reviewer ticks §4 instead
   of reconstructing it. Still no aggregate and still no `reproduced` field.
3. **Whether a kill is safe right now.** Every progress line ends with the checkpoint's path and the age
   of its last write. A watcher who needs the machine can then stop the job knowing what a relaunch
   redoes.
4. **What a run answered, in one greppable line.** Each record carries a `headline` — a rendering, never
   a judgement: `joint minimum 509 vertices (508 atoms) over A412 ∪ ρ·g⁻¹(A166), frame coset 1 of 2,
   level bounded-below at 64 minima, 0 undecided [tuning]`.

### E2 — The progress line of a long run

M63's own incident is the specification: a phase that logged only on events was silent for five minutes
at 99.5 % CPU and was indistinguishable from a wedge. Time-gated, every 20 s:

```
joint  it 412   LB 503 -> w* ?   minima 0   Y 1174 (min size 1)   undecided 0
       asks 9331 colourable @0.004s / 388 refusing @0.11s   elapsed 21m   ETA 25-70m ASSUMING the
       remaining LB climb matches the last 10 min   ckpt m63-joint….ckpt.json written 14 s ago
```

Every element earns its place: the rising lower bound is the only evidence of progress before the first
optimum; both ask populations appear separately because they differ by 25×; the ETA carries its
assumption in the same breath; and the checkpoint's age is what makes the job killable.

### E3 — The refusal genre, with the texts pinned as golden strings

Every refusal says **what happened in the reader's vocabulary**, **in which space the judgement was
made**, and **what to do next, pasteable**. The self-tests assert the exact rendered text, because the
message is the product and not the API behind it:

```
checkpoint refused: it belongs to a different search.
  its problem   rung 6 orbits, 31 atoms, reduce {S}   identity 4b17…
  this problem  rung 3 orbits, 55 atoms, reduce {S}   identity 8ee0…
  A checkpoint may be resumed onto the same problem with different budgets, never onto another
  problem. Start a fresh run:  --checkpoint data/m62/ckpt/<new name>.ckpt.json
```

```
freeze refused: data/m62/m63-freeze.json has uncommitted edits.
  A freeze that can be edited after the fact is not a freeze.
  git add data/m62/m63-freeze.json && git commit -m "freeze the M63 configuration"
```

```
frame refused: the stored frame of v166e774 does not satisfy `contains v136e564`.
  Qualifying frames, by double coset (representative named by its image of (2,0,4,2)):
    coset 1  (0,4,2,0)   6 elements   contains v136e564
    coset 2  (2,0,4,2)   6 elements   does not
  Choose one:  --S-frame coset:1
```

```
shading unreliable: 2 fill cells contradict his caption ("Filled orbits are highlighted in gray").
  (6,2,4,0) in column 375: value 24, orbit size 24, cell NOT shaded
  (0,0,2,2) in column 374: value 6, orbit size 12, cell shaded
  The stable/unstable partition is therefore NOT gated from the shading; the ranges still are.
```

**No verdict word means clean**, and the closed list is the one in §2 C1.3 plus the audit's
`agrees` / `differs` / `not-compared…` / `shading-unreliable` / `regenerated-identical` /
`regenerated-differs:<field>` / `resume-identical` / `checkpoint-problem-mismatch` /
`joint-stage-omits-a-side` / `joint-degenerates-to-L` / `not-minimal` / `not-a-correction-set` /
`antichain-violated` / `closed_under_AutA: false`.

### E4 — The audit record reads head-first

A reviewer reads the head and stops. So the record opens with `summary` — the mode (`TUNING` until D's
freeze), the rows that differ, the rows not compared and why, the controls that fired, and the headline —
and only then the full per-orbit table. Progressive disclosure, with the detail one field away rather
than one file away.

### E5 — The escalation template, because a record below 509 is a product event

If C4 or C4b returns ≤ 508 vertices, the implementer sends this, within the hour, rather than composing
one:

```
A joint reduction returned <V> vertices (<A> atoms), below the 509 record.
  problem     <L file> ∪ ρ·<S file>, frame coset <n> of <m>, reduce {L,S}, rung 1
  identity    <stage identity>          config <config_sha256>
  bound       <Bound.render()>          undecided <n>
  level       <Count.render()>
  geometry    exact unit-distance re-check: <pass/fail, how many edges>
  refutation  CaDiCaL <version>, LRAT proof <path>, checked by <tool>: <result>
  artifact    <record path>   checkpoint <path>   commit <sha>
  NOT yet done: the Lean kernel certificate (phase F). This is not a record until that lands.
```

### E6 — Three corrections this pass made to my own skeleton

1. `--side` became `--reduce`, because the flag names a set of halves and "side" reads as one.
2. An unattested field now prints as `not-compared`, where the skeleton omitted the row.
3. `--dry-run` was added, so the 15-minute announcement is generated by the tool that knows the forecast
   rather than composed by the person who wants to start the run.

---

## §A — The product owner's approval

*Empty until the review. The implementer does not start before a line appears here naming the commit
that recorded the approval, the decisions approved, and any item the product owner redirected.*
