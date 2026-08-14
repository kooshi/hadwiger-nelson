#!/usr/bin/env python3
"""The arity instrument: at what order does a colour compulsion first become visible?

UNTRUSTED, like everything in `tools/`. A compulsion this tool reports becomes mathematics only
when a later milestone re-derives it in Lean; a bug here can cost a theorem and never buy one.

## The object (mirrors `Proofs/HadwigerNelson/Arity.lean`)

Fix a graph, `k` colours, `m` DISTINCT vertices `S`, and a *pattern* `p` — which of the `m`
positions share a colour. Two facts make the notion well posed, and both are load-bearing rather
than decorative:

* the vertices must be distinct — otherwise `S = (v, v)` with `p = (0, 1)` is unrealizable for a
  reason that has nothing to do with the graph, and every graph would have arity floor 2;
* the pattern must be **locally proper** — no two positions in the same block joined by an edge —
  otherwise every graph with an edge would have arity floor 2.

Together those two say exactly: `S` lists `m` distinct vertices and `p` properly colours the
subgraph they induce. So

    a COMPULSION is a partial colouring that does not extend,
    and the ARITY FLOOR is the least number of vertices you must look at
    before local properness stops implying global extendability.

At `m = 2` that is precisely the existing vocabulary: an unrealizable "same" pattern is a **virtual
edge**, an unrealizable "distinct" pattern is a **forced pair**. Four campaigns (M31, M32, M35,
M41) measured this repository at `m = 2` and read exactly zero; this instrument asks `m ≥ 3`.

## Reading rules — three ways to misread a row, two of which have happened

1. **An `unsat` at arity 3 is NOT an arity-3 finding until every 2-subset of the tuple has been
   swept on the SAME stage and found realizable in both directions.** This confusion occurred
   during M45 subplanning: the triple (56, 102, 134) presented as an arity-3 compulsion and was a
   virtual edge at offset norm 13 wearing a disguise. `minimal_arity` is therefore ABSENT from a
   row until that check has run, and `explained_by_subtuple` names the culprit when it fails.
2. **`unknown` is never `clean`.** There is no verdict called "clean" in this file. The enum is
   `compelled | realizable | undecided`, and `undecided` always carries its `cap_seconds`.
3. **Rows from different stages are about different graphs.** Every row carries a `stage` whose
   `fingerprint` hashes the sorted edge list, so "is this the same object?" is a comparison and not
   a judgement. `aggregate` refuses to merge rows across fingerprints. This matters because a
   published conclusion has already turned out to be stage-dependent once: pair meters read zero on
   one stage of an object and nonzero on another.

## The vacuity guard, which is the first thing every entry point checks

A graph with no proper `k`-colouring at all makes every pattern unrealizable, so every tuple is
"compelled" and none of it means anything. `base_row` is the guard: it must be `sat` before any
compulsion claim is computed, and `arity_verdict` structurally refuses to produce a verdict without
it.

    python3 tools/arity.py --self-test
"""

from __future__ import annotations

import argparse
import hashlib
import itertools
import json
import sys
import time
from concurrent.futures import ProcessPoolExecutor
from pathlib import Path
from typing import NamedTuple

sys.path.insert(0, str(Path(__file__).resolve().parent))

from coloring import base_clauses, var  # noqa: E402
from forcer import _solve  # noqa: E402
from rigidity import amo_clauses, decode  # noqa: E402

SCHEMA = (
    "m45-arity v1 (plans/M45-arity-floor.md). Unit of claim: one (stage, tuple, pattern). "
    "`outcome` is the raw solver answer; `verdict` is computed ONLY by `arity_verdict` and is one "
    "of compelled|realizable|undecided|vacuous|undetermined-subtuples -- there is deliberately no "
    "verdict called 'clean', because `unknown at cap` is not a negative result. `minimal_arity` is "
    "ABSENT until every 2-subset of the tuple has been swept on the same stage; a compulsion whose "
    "sub-pair is itself compelled is reported with `explained_by_subtuple` and is NOT an arity-m "
    "finding (this exact confusion occurred during subplanning: triple (56,102,134) presented as "
    "arity 3 and was a virtual edge at offset norm 13). `stage.fingerprint` hashes the sorted edge "
    "list: rows with different fingerprints are about DIFFERENT GRAPHS and must never be "
    "aggregated -- a published conclusion has already turned out to be stage-dependent once. "
    "`encodings` is a list of (name, outcome, seconds), never a boolean, so 'double-encoded' is "
    "data a reader checks rather than a claim the writer makes. M48 adds the SCREEN, whose "
    "output is a `Candidate` -- a pattern no harvested colouring wore, i.e. a question NOT YET "
    "ASKED. A candidate is not a finding and not a negative; it carries its own `harvest` "
    "denominator, has no verdict or outcome field, and `check_recordable` refuses to "
    "serialize one. Artifacts key them under `unsolved_candidates`. `jackpot_eligible` marks "
    "the few rows that could be chi(R^2) >= 6 (arity 2, same-colour pattern, class sqrt3 or 2, "
    "k = 5, genuine unit-distance stage) rather than warning on the many that cannot -- an "
    "arity-3 compulsion is never eligible, by the counting bound of M48 §0a D2."
)


# ------------------------------------------------------------------ stages

def make_stage(kind: str, n: int, edges, **meta) -> dict:
    """A stage is the graph a question is asked ON, carried with its identity.

    `fingerprint` is a hash of the sorted edge list, so two rows are about the same object exactly
    when their fingerprints agree — a comparison rather than a judgement."""
    es = sorted(tuple(sorted(e)) for e in edges)
    fp = hashlib.sha256(repr((n, es)).encode()).hexdigest()[:16]
    return {"kind": kind, "n": n, "m_edges": len(es), "fingerprint": fp,
            "edges": es, **meta}


def _brk(n: int, k: int, order, limit: int = 400) -> list[list[int]]:
    """First-occurrence palette breaking over an arbitrary vertex ORDER.

    Sound for any order and for any palette-invariant property: the canonical relabeling of a
    witness, by order of first occurrence along `order`, satisfies every clause. Two different
    orders give two genuinely different formulas with the same models up to renaming — which is
    what makes `free-rev` a real second encoding rather than a restatement.

    Measured (M45 subplanning, desktop): on the 23-vertex certified core at six colours the
    refutation takes >162 s with no breaking and 0.02 s with it."""
    return [[-var(order[t], c, k)] + [var(order[e], c - 1, k) for e in range(t)]
            for t in range(1, min(n, limit)) for c in range(1, k)]


def _eq(u: int, w: int, k: int) -> list[list[int]]:
    """`u` and `w` wear the same colour — WITHOUT naming which. This is what keeps the whole query
    palette-invariant, hence what makes `_brk` sound on top of it."""
    return ([[-var(u, c, k), var(w, c, k)] for c in range(k)] +
            [[-var(w, c, k), var(u, c, k)] for c in range(k)])


def _ne(u: int, w: int, k: int) -> list[list[int]]:
    """`u` and `w` wear different colours, again without naming them."""
    return [[-var(u, c, k), -var(w, c, k)] for c in range(k)]


# ------------------------------------------------------------------ patterns

def partitions(m: int, k: int) -> list[list[list[int]]]:
    """One representative per partition of `m` positions into at most `k` blocks, as block lists of
    positions. The count is the Bell-like number `S(m,1)+…+S(m,k)`: 2 at m=2, 5 at m=3, 15 at m=4.

    This is the Python twin of `Pattern.canonPatterns` in Lean — same enumeration, and the Lean side
    carries `exists_mem_canonPatterns`, the proof that it misses nothing."""
    out: list[list[list[int]]] = []

    def go(i: int, blocks: list[list[int]]) -> None:
        if i == m:
            out.append([list(b) for b in blocks])
            return
        for b in blocks:
            b.append(i)
            go(i + 1, blocks)
            b.pop()
        if len(blocks) < k:
            blocks.append([i])
            go(i + 1, blocks)
            blocks.pop()

    go(0, [])
    return out


def pattern_clauses(tup, blocks, k: int) -> list[list[int]]:
    """Pin the pattern colour-FREELY: equality inside each block, disequality between blocks."""
    cl: list[list[int]] = []
    for blk in blocks:
        for a, b in zip(blk, blk[1:]):
            cl += _eq(tup[a], tup[b], k)
    for x, y in itertools.combinations(range(len(blocks)), 2):
        cl += _ne(tup[blocks[x][0]], tup[blocks[y][0]], k)
    return cl


def pattern_pins(tup, blocks, k: int) -> list[list[int]]:
    """The decorrelated encoding: NAME the colours, block `j` to colour `j`.

    Sound as a WLOG because properness and the pattern are both palette-invariant, and equivalent to
    `pattern_clauses` by `Arity.realizes_iff_extends` — a theorem rather than an assumption. It
    carries no breaking clauses (they would be unsound once colours are named), so it is much slower
    and is used to confirm hits, never to sweep."""
    if len(blocks) > k:
        raise SystemExit(f"PATTERN REJECTED: {len(blocks)} blocks exceeds k = {k}")
    return [[var(tup[i], j, k)] for j, blk in enumerate(blocks) for i in blk]


def locally_proper(stage: dict, tup, blocks) -> bool:
    """Distinct vertices, and no edge inside a block — the two conditions without which
    unrealizability would be an artifact of the question rather than a fact about the graph."""
    if len(set(tup)) != len(tup):
        return False
    adj = {tuple(sorted(e)) for e in stage["edges"]}
    return not any(tuple(sorted((tup[a], tup[b]))) in adj
                   for blk in blocks for a, b in itertools.combinations(blk, 2))


# ------------------------------------------------------------------ the queries

def base_row(stage: dict, k: int, cap: float | None = None) -> dict:
    """THE VACUITY GUARD. Every compulsion claim on this stage is void unless this reads `sat`."""
    n, es = stage["n"], stage["edges"]
    t0 = time.time()
    st, _ = _solve(base_clauses(n, es, k) + amo_clauses(n, k) + _brk(n, k, list(range(n))),
                   n * k, cap)
    return {"kind": "base", "stage": _stage_ref(stage), "k": k, "outcome": st,
            "seconds": round(time.time() - t0, 2), "cap": cap}


def _stage_ref(stage: dict) -> dict:
    return {kk: stage[kk] for kk in ("kind", "n", "m_edges", "fingerprint") if kk in stage}


ENCODINGS = ("free-fwd", "free-rev", "pinned")


def realize(stage: dict, k: int, tup, blocks, cap: float | None = None,
            enc: str = "free-fwd") -> dict:
    """Can a proper `k`-colouring wear this pattern on this tuple?

    `unsat` = the pattern is COMPELLED against (given the stage is colourable, and given the
    sub-tuple check for arity > 2). `sat` models are re-validated in process — proper AND wearing
    exactly the claimed pattern, both the equalities and the disequalities — so an encoding bug
    surfaces as a crash rather than as a finding."""
    n, es = stage["n"], stage["edges"]
    order = list(range(n)) if enc == "free-fwd" else list(range(n))[::-1]
    clauses = base_clauses(n, es, k) + amo_clauses(n, k)
    if enc == "pinned":
        clauses += pattern_pins(tup, blocks, k)
    elif enc in ("free-fwd", "free-rev"):
        clauses += _brk(n, k, order) + pattern_clauses(tup, blocks, k)
    else:
        raise SystemExit(f"ENCODING REJECTED: {enc!r} (one of {ENCODINGS})")
    t0 = time.time()
    st, model = _solve(clauses, n * k, cap)
    row = {"tuple": list(tup), "blocks": [list(b) for b in blocks], "enc": enc,
           "outcome": st, "seconds": round(time.time() - t0, 2), "cap_seconds": cap}
    if st == "sat":
        _validate(decode(model, n, k), es, tup, blocks)
    return row


def _validate(colours, edges, tup, blocks) -> None:
    for a, b in edges:
        if colours[a] == colours[b]:
            raise SystemExit("ARITY MODEL INVALID: monochromatic edge — solver or decode is wrong")
    lab = {tup[i]: j for j, blk in enumerate(blocks) for i in blk}
    for u, ju in lab.items():
        for w, jw in lab.items():
            if (colours[u] == colours[w]) != (ju == jw):
                raise SystemExit("ARITY MODEL INVALID: the model does not wear the claimed "
                                 "pattern — the pattern clauses are wrong")


# ------------------------------------------------------------------ the ONE verdict function

def arity_verdict(base_outcome: str, outcome: str, proper: bool,
                  subtuple_compulsions=None) -> tuple[str, dict]:
    """The ONE place a verdict is computed. Returns `(verdict, extra_fields)`.

    Structurally refuses the three misreadings this file exists to prevent:
      * no verdict at all unless the stage is colourable (`vacuous` otherwise);
      * `undecided` for a cap, never anything that sounds negative;
      * for arity > 2, `undetermined-subtuples` unless the caller supplies the 2-subset evidence,
        and `explained_by_subtuple` — with `minimal_arity` withheld — when a sub-pair is itself
        compelled.
    """
    if base_outcome == "unsat":
        return "vacuous", {}
    if base_outcome != "sat":
        return "undetermined-base", {}
    if not proper:
        return "not-locally-proper", {}
    if outcome == "unknown":
        return "undecided", {}
    if outcome == "sat":
        return "realizable", {}
    if subtuple_compulsions is None:
        return "undetermined-subtuples", {}
    if subtuple_compulsions:
        return "compelled", {"explained_by_subtuple": [list(x) for x in subtuple_compulsions]}
    return "compelled", {"minimal_arity": True}


# ------------------------------------------------------------------ the screen (M48)
#
# Every earlier meter in this repository SOLVED every question it asked, so every row had an
# outcome. The screen does not: it reports "never observed in H colourings, not yet given to a
# solver". That is neither a finding nor a negative, and an unnamed intermediate state is exactly
# what a summary sentence turns into a false grokking. So it gets its own TYPE, it carries its own
# denominator, it has no `verdict` and no `outcome` field, and `record` refuses to serialize it.


class Candidate(NamedTuple):
    """A pattern NO harvested colouring wore — a question still to ask, never an answer.

    `harvest` is part of the object on purpose: "never observed" is meaningless without the number
    of colourings it survived (surviving 64 is noise; surviving 8,192 is worth a solver call), so
    the denominator cannot be separated from the claim. There is deliberately no `verdict` field and
    `arity_verdict` is never called on one of these."""

    tup: tuple
    blocks: tuple
    fingerprint: str
    harvest: int

    def __repr__(self) -> str:  # so a stray print cannot read as a result
        return (f"Candidate(UNSOLVED tuple={list(self.tup)} blocks={[list(b) for b in self.blocks]} "
                f"never-observed-in={self.harvest} stage={self.fingerprint})")


def agreement_masks(cols, n: int):
    """`M[u, v]` = the bitmask of harvested colourings in which `u` and `v` share a colour.

    Every pattern's observed-set is a boolean combination of these, so all `C(n, m)` tuples are
    screened with bit operations and no solver. `len(cols)` must be a multiple of 64: otherwise the
    padding bits above `H` are zero in every mask and read as 1 under negation, manufacturing false
    *observed* readings on every pattern that has a disequality."""
    import numpy as np
    H = len(cols)
    if H % 64:
        raise SystemExit(f"HARVEST SIZE {H} IS NOT A MULTIPLE OF 64 — padding bits would read as "
                         f"spurious observations under negation")
    M = np.zeros((n, n, H // 64), dtype=np.uint64)
    for h, c in enumerate(cols):
        a = np.asarray(c, dtype=np.int16)
        M[:, :, h // 64] |= ((a[:, None] == a[None, :]).astype(np.uint64) << np.uint64(h % 64))
    return M


def pattern_mask(M, tup, blocks):
    """The reference (slow, generic) observed-mask of one pattern: agreement inside blocks,
    disagreement across them. This is the CONTROL for the vectorized `screen3` — it is the same
    claim computed by different code, and `self_test` cross-checks them."""
    import numpy as np
    lab = {i: j for j, b in enumerate(blocks) for i in b}
    out = None
    for a, b in itertools.combinations(range(len(tup)), 2):
        w = M[tup[a], tup[b]]
        w = w if lab[a] == lab[b] else ~w
        out = w if out is None else (out & w)
    return out if out is not None else np.array([], dtype='uint64')


def observed_by_mask(M, tup, blocks) -> bool:
    """Did any harvested colouring wear this pattern? Absence is a CANDIDATE, never a finding."""
    return bool(pattern_mask(M, tup, blocks).any())


def screen3(M, stage: dict, us=None, adj_rows=None):
    """The exhaustive arity-3 screen: every triple, every one of the five patterns, bit operations
    only. Yields `Candidate`s — questions still to ask.

    Vectorized over the third vertex, which is what makes `C(1581,3) = 657,385,070` tractable
    (measured: ~8 s on 28 cores at `H = 1024`). `pattern_mask` is the slow generic control for
    exactly this computation and `self_test` cross-checks them, because a screen bug would present
    as a silent wall of candidates or, worse, as a silently empty one."""
    import numpy as np
    n, H = stage["n"], M.shape[2] * 64
    fp = stage["fingerprint"]
    if adj_rows is None:
        adj_rows = np.zeros((n, n), dtype=bool)
        for a, b in stage["edges"]:
            adj_rows[a, b] = adj_rows[b, a] = True
    out = []
    for u in (range(n) if us is None else us):
        for v in range(u + 1, n):
            a = M[u, v]
            B, C = M[u, v + 1:], M[v, v + 1:]
            nA, nB, nC = ~a, ~B, ~C
            fu, fv = adj_rows[u, v + 1:], adj_rows[v, v + 1:]
            uv_free = not adj_rows[u, v]
            # (blocks, never-observed mask, locally-proper mask over w)
            cases = [
                ((( 0, 1, 2),), ~(a & B & C).any(1), (uv_free & ~fu & ~fv) if uv_free else None),
                (((0, 1), (2,)), ~(a & nB & nC).any(1), np.full(B.shape[0], uv_free)),
                (((0, 2), (1,)), ~(B & nA & nC).any(1), ~fu),
                (((1, 2), (0,)), ~(C & nA & nB).any(1), ~fv),
                (((0,), (1,), (2,)), ~(nA & nB & nC).any(1), np.full(B.shape[0], True)),
            ]
            for blocks, never, proper in cases:
                if proper is None:
                    continue
                for off in np.flatnonzero(never & proper):
                    out.append(Candidate((u, v, v + 1 + int(off)), blocks, fp, H))
    return out


def screen_neighbourhoods(M, stage: dict, k: int, m: int = 4):
    """The complete arity-`m` screen restricted to vertex NEIGHBOURHOODS — the home of the one
    compulsion `Arity.arityFloor_le_of_degree` guarantees exists.

    Generic in `m` and in the pattern, so it runs off `pattern_mask` rather than a hand-rolled case
    table. Affordable exactly because the enumeration is `Σ_v C(deg v, m)` and not `C(n, m)`: on de
    Grey's 1581 that is 1,718,839 rather than 259,338,410,115."""
    n, H = stage["n"], M.shape[2] * 64
    nbr = [[] for _ in range(n)]
    for a, b in stage["edges"]:
        nbr[a].append(b)
        nbr[b].append(a)
    pats = [tuple(tuple(b) for b in bl) for bl in partitions(m, k)]
    out, seen = [], set()
    for v in range(n):
        for tup in itertools.combinations(sorted(nbr[v]), m):
            if tup in seen:
                continue
            seen.add(tup)
            for blocks in pats:
                if not locally_proper(stage, tup, [list(b) for b in blocks]):
                    continue
                if not observed_by_mask(M, tup, [list(b) for b in blocks]):
                    out.append(Candidate(tup, blocks, stage["fingerprint"], H))
    return out


# ------------------------------------------------------------------ the marked few, not the many


def jackpot_eligible(stage: dict, k: int, arity: int, blocks, dist_class: str | None) -> bool:
    """Could THIS row, if compelled, be `chi(R^2) >= 6`? Computed in one place, like the verdict.

    Marking the few rows that can be a rung beats warning on the many that cannot: a reader asking
    "is this the big one?" then reads a single field that is `True` only where it could be true, and
    the campaign's halt-and-verify clause becomes mechanical rather than a judgement call.

    It takes all five: arity two, the same-colour pattern (a virtual edge, not a forced pair), a
    class of `sqrt3` or `2`, five colours, and a stage that is a genuine unit-distance graph. An
    arity-3 compulsion is NOT eligible and cannot be — forcing a monochromatic TRIPLE at five
    colours needs 11 points, and a set whose mutual distances all lie in `{1, sqrt3, 2}` has at most
    10 (Jung's theorem plus a packing bound; plans/M48-from-below-arity.md §0a D2)."""
    return (arity == 2 and k == 5 and dist_class in ("sqrt3", "two")
            and len(blocks) == 1 and stage.get("unit_distance") is True)


def negative_headline(kind: str, asked: int, undecided: int, stage: dict, harvest: int,
                      compelled: int = 0) -> str:
    """The enumeration belongs IN the headline, not in a scope line further down.

    M43 wrote "zero virtual edges at k = 6" for a sweep of six questions; re-asked completely on the
    identical stage at M45 the same object had seven. The artifact's scope line had been honest and
    the summary sentence was not, and the summary is what became a grokking."""
    return (f"{kind}: {compelled} compulsions in {asked:,} questions asked on stage "
            f"{stage.get('kind', '?')} ({stage.get('n', '?'):,} vertices, "
            f"{stage.get('m_edges', '?'):,} edges, fingerprint {stage.get('fingerprint', '?')}); "
            f"{undecided:,} undecided at cap and EXCLUDED from that count; "
            f"screened against {harvest:,} harvested colourings.")


def check_recordable(obj) -> None:
    """The boundary that refuses. A screen candidate is not a result, and a summary without its
    enumeration is the failure mode this whole file exists to prevent."""
    if isinstance(obj, Candidate) or (isinstance(obj, (list, tuple))
                                      and any(isinstance(x, Candidate) for x in obj)):
        raise SystemExit("REFUSED: a screen candidate is not a result — it is a question that has "
                         "not been asked yet. Call confirm() and record the resulting row.")
    if isinstance(obj, dict) and obj.get("kind") == "summary" and not obj.get("headline"):
        raise SystemExit("REFUSED: a summary must carry `headline`, which states the enumeration "
                         "its verdict is about (see negative_headline).")


# ------------------------------------------------------------------ observe, then confirm

def _harvest_one(spec):
    stage, k, seed, cap = spec
    import random
    n, es = stage["n"], stage["edges"]
    rnd = random.Random(seed)
    base = base_clauses(n, es, k) + amo_clauses(n, k) + _brk(n, k, list(range(n)))
    extra = [[var(rnd.randrange(n), rnd.randrange(k), k)] for _ in range(6)]
    st, model = _solve(base + extra, n * k, cap)
    if st != "sat":
        st, model = _solve(base, n * k, cap)
        if st != "sat":
            return None
    col = decode(model, n, k)
    for a, b in es:
        if col[a] == col[b]:
            raise SystemExit("HARVEST INVALID: improper colouring returned")
    return col


def harvest(stage: dict, k: int, count: int, workers: int = 28,
            cap: float = 60.0) -> list[list[int]]:
    """Proper colourings, validated. Each one exhibits a realized pattern for EVERY tuple at once,
    which is what makes the confirm pass small: only never-observed patterns need a solver."""
    with ProcessPoolExecutor(max_workers=workers) as ex:
        return [c for c in ex.map(_harvest_one,
                                  [(stage, k, s, cap) for s in range(count)]) if c]


def observed(cols, tup, blocks) -> bool:
    """Did any harvested colouring wear this pattern? Absence is a CANDIDATE, never a finding."""
    want = {(a, b): (blocks_of(blocks, a) == blocks_of(blocks, b))
            for a, b in itertools.combinations(range(len(tup)), 2)}
    return any(all((c[tup[a]] == c[tup[b]]) == v for (a, b), v in want.items()) for c in cols)


def blocks_of(blocks, i: int) -> int:
    return next(j for j, b in enumerate(blocks) if i in b)


# ------------------------------------------------------------------ self-test

def self_test() -> None:
    """Three planted controls. A control that has not been seen to fail is not a control.

    P1 the planted POSITIVE — the smallest graph whose first compulsion is at arity 3 (found by
       exhaustion at M45 subplanning): a 4-cycle 0–1–2–4–0 with a pendant 3 on 2, at three colours.
       Every pair is free; the triple (1,3,4) can never be rainbow, because vertex 2 is adjacent to
       all three and would have no colour left. This is the fan mechanism at its minimum.
    P2 the planted NEGATIVE — a triangle at three colours has no compulsion at any arity.
    P3 the planted EXPLAINED case — the failure mode that actually occurred: a triple containing a
       genuine virtual edge must be reported as `explained_by_subtuple`, NOT as an arity-3 find.
    """
    fails = []

    def expect(got, want, what):
        if got != want:
            fails.append(f"{what}: got {got!r}, want {want!r}")
        print(f"  [{'ok ' if got == want else 'FAIL'}] {what}: {got!r}")

    # P1 -- the planted positive
    p5 = make_stage("planted-p5", 5, [(0, 1), (0, 4), (1, 2), (2, 3), (2, 4)])
    b = base_row(p5, 3, 30.0)
    expect(b["outcome"], "sat", "P1 base is colourable (the vacuity guard)")
    hits2 = [(t, bl) for t in itertools.combinations(range(5), 2)
             for bl in partitions(2, 3)
             if locally_proper(p5, t, bl)
             and realize(p5, 3, t, bl, 30.0)["outcome"] == "unsat"]
    expect(hits2, [], "P1 has NO arity-2 compulsion")
    r = realize(p5, 3, (1, 3, 4), [[0], [1], [2]], 30.0)
    expect(r["outcome"], "unsat", "P1 triple (1,3,4) can never be rainbow")
    expect(arity_verdict("sat", "unsat", True, [])[0], "compelled", "P1 verdict with clean subtuples")
    expect(arity_verdict("sat", "unsat", True, [])[1], {"minimal_arity": True}, "P1 marked minimal")
    expect(realize(p5, 3, (1, 3, 4), [[0], [1], [2]], 30.0, enc="pinned")["outcome"], "unsat",
           "P1 agrees in the decorrelated pinned encoding")
    expect(realize(p5, 3, (1, 3, 4), [[0], [1], [2]], 30.0, enc="free-rev")["outcome"], "unsat",
           "P1 agrees under the reversed breaking order")

    # P2 -- the planted negative
    tri = make_stage("planted-k3", 3, [(0, 1), (0, 2), (1, 2)])
    expect(base_row(tri, 3, 30.0)["outcome"], "sat", "P2 base is colourable")
    bad = [(t, bl) for m in (2, 3) for t in itertools.combinations(range(3), m)
           for bl in partitions(m, 3)
           if locally_proper(tri, t, bl)
           and realize(tri, 3, t, bl, 30.0)["outcome"] != "sat"]
    expect(bad, [], "P2 triangle has NO compulsion at any arity")

    # P3 -- the planted EXPLAINED case: a path a-x-b at two colours forces a = b
    path = make_stage("planted-path", 4, [(0, 1), (1, 2), (2, 3)])
    expect(realize(path, 2, (0, 2), [[0], [1]], 30.0)["outcome"], "unsat",
           "P3 the sub-pair (0,2) IS compelled at k=2 (a forced pair)")
    v, extra = arity_verdict("sat", "unsat", True, [(0, 2)])
    expect(v, "compelled", "P3 verdict is still a compulsion")
    expect("minimal_arity" in extra, False, "P3 does NOT claim minimal arity")
    expect(extra["explained_by_subtuple"], [[0, 2]], "P3 names the culprit sub-pair")

    # the guards themselves
    expect(arity_verdict("unsat", "unsat", True, [])[0], "vacuous", "vacuity guard fires")
    expect(arity_verdict("sat", "unknown", True, [])[0], "undecided", "a cap is never negative")
    expect(arity_verdict("sat", "unsat", True, None)[0], "undetermined-subtuples",
           "no verdict without sub-tuple evidence")
    expect(arity_verdict("sat", "unsat", False, [])[0], "not-locally-proper",
           "a non-locally-proper pattern is not a finding")
    expect(len(partitions(2, 6)), 2, "partitions(2) count")
    expect(len(partitions(3, 6)), 5, "partitions(3) count")
    expect(len(partitions(4, 6)), 15, "partitions(4) count")
    expect(len(partitions(3, 2)), 4, "partitions(3) capped at k=2 drops the rainbow")

    # the fingerprint really separates stages (phrased so the printed value cannot be misread:
    # both lines report the SAME word for a pass)
    expect("same" if make_stage("a", 4, [(0, 1)])["fingerprint"]
           == make_stage("b", 4, [(0, 1)])["fingerprint"] else "differs",
           "same", "fingerprint of the same edge set under a different label")
    expect("same" if make_stage("a", 4, [(0, 1)])["fingerprint"]
           == make_stage("a", 4, [(0, 2)])["fingerprint"] else "differs",
           "differs", "fingerprint of a different edge set")

    # ---- M48: the screen, and the boundary that refuses --------------------------------------
    # P4 the planted SCREEN positive: the compelled triple is worn by NO colouring, so the screen
    #    must surface it as a candidate; and a pattern that IS worn must not be surfaced.
    cols = harvest(p5, 3, 64, workers=8, cap=30.0)
    expect(len(cols), 64, "P4 harvest is a full multiple of 64")
    M = agreement_masks(cols, 5)
    cands = {(c.tup, c.blocks) for c in screen3(M, p5)}
    expect(((1, 3, 4), ((0,), (1,), (2,))) in cands,
           True, "P4 the compelled triple survives the screen as a CANDIDATE")
    expect(all(observed_by_mask(M, t, [list(b) for b in bl])
               for (t, bl) in {((1, 3, 4), ((0,), (1,), (2,)))} ^ set()), False,
           "P4 and the screen agrees it was never observed")
    # the planted screen NEGATIVE: an observed pattern is not a candidate
    expect(any(c.tup == (0, 1, 2) and c.blocks == ((0,), (1,), (2,)) for c in screen3(M, p5)),
           observed_by_mask(M, (0, 1, 2), [[0], [1], [2]]) is False,
           "P4 an OBSERVED pattern is not emitted as a candidate")
    # P5 the vectorized screen against the slow generic control — same claim, different code
    disagree = [(c.tup, c.blocks) for c in screen3(M, p5)
                if observed_by_mask(M, c.tup, [list(b) for b in c.blocks])]
    expect(disagree, [], "P5 screen3 agrees with the generic pattern_mask control")
    # P6 the boundary refuses a candidate and a headline-less summary
    for bad, what in ((Candidate((0, 1, 2), ((0,), (1,), (2,)), "x", 64), "a bare candidate"),
                      ([Candidate((0, 1, 2), ((0,), (1,), (2,)), "x", 64)], "a list of them"),
                      ({"kind": "summary"}, "a summary with no headline")):
        try:
            check_recordable(bad)
            expect("accepted", "REFUSED", f"P6 record refuses {what}")
        except SystemExit:
            expect("REFUSED", "REFUSED", f"P6 record refuses {what}")
    check_recordable({"kind": "summary", "headline": "0 in 5 questions"})
    # P7 the padding trap: a harvest that is not a multiple of 64 must be rejected, not silently
    #    negated into spurious observations
    try:
        agreement_masks(cols[:63], 5)
        expect("accepted", "REFUSED", "P7 a non-multiple-of-64 harvest is refused")
    except SystemExit:
        expect("REFUSED", "REFUSED", "P7 a non-multiple-of-64 harvest is refused")
    # P8 jackpot eligibility marks the few, and an arity-3 row can never be one
    ud = dict(p5, unit_distance=True)
    expect(jackpot_eligible(ud, 5, 2, ((0, 1),), "sqrt3"), True,
           "P8 an arity-2 same-colour sqrt3 row at k=5 on a unit-distance stage IS eligible")
    expect(jackpot_eligible(ud, 5, 3, ((0, 1, 2),), "sqrt3"), False,
           "P8 an arity-3 row is NEVER eligible (M48 §0a D2)")
    expect(jackpot_eligible(ud, 5, 2, ((0,), (1,)), "sqrt3"), False,
           "P8 a FORCED pair (distinct pattern) is not a virtual edge")
    expect(jackpot_eligible(ud, 6, 2, ((0, 1),), "sqrt3"), False, "P8 k must be 5")
    expect(jackpot_eligible(p5, 5, 2, ((0, 1),), "sqrt3"), False,
           "P8 the stage must be a genuine unit-distance graph")
    expect(jackpot_eligible(ud, 5, 2, ((0, 1),), "norm13"), False,
           "P8 the class must be sqrt3 or 2")
    # P9 the headline carries the enumeration
    hl = negative_headline("arity-3", 657_385_070, 11, p5, 8192)
    expect("657,385,070" in hl and "8,192" in hl and "EXCLUDED" in hl, True,
           "P9 the negative headline states its enumeration, harvest and exclusions")

    print("SELF-TEST", "PASS" if not fails else "FAIL")
    if fails:
        for f in fails:
            print("   ", f)
        raise SystemExit(1)


def main() -> None:
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--self-test", action="store_true")
    a = ap.parse_args()
    if a.self_test:
        self_test()
    else:
        ap.print_help()


if __name__ == "__main__":
    main()
