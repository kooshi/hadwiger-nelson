"""Smallest group-MUS for colouring problems (FS-32).

**The reduction stage, restated.** Give each droppable vertex-group a *presence* literal; then

    hard  ∧  {a_g : g ∈ S}   is UNSAT   exactly when the selection S refuses k colours,

so a minimal working selection is a **group MUS** and the smallest one is a **smallest group MUS**.
Weight a group by its vertex count and the optimum is minimum *vertices*, which is the number the
record is quoted in. `plans/FS32-smus-reduction.md` §M1 has the modelling; the two rules below are
§M2's and they are the ones that keep an answer honest.

**Rule 1 — the centre, and anything else a hard clause pins, belongs to NO group.** A pinned vertex
that is also droppable makes the encoding assert "wears colour 0" and "wears no colour" at once, so
dropping it is UNSAT *for a reason unrelated to colouring* and every optimum below it is corrupt.
`hard_vertices` is that set and it carries no presence literal.

**Rule 2 — an oracle `unknown` is folded into NEITHER answer.** In the hitting-set loop, folding an
unknown as *colourable* adds an unproven correction set, at which point the hitting-set value stops
being a lower bound and the search can return a selection **lighter than the true optimum** — a
smaller-than-true answer wearing the shape of a record. So a budgeted run ends as a **sandwich**
`[LB, UB]`, reported as one.
"""
from __future__ import annotations
from dataclasses import dataclass, field


@dataclass
class Groups:
    """The droppable vertex-groups of one arena, and the vertices that are never droppable."""
    members: list[list[int]]                    # group -> arena vertices, pairwise disjoint
    labels: list = field(default_factory=list)
    hard: list[int] = field(default_factory=list)   # present always; NO presence literal

    def weights(self) -> list[int]:
        """Vertex count, so an optimum is minimum vertices rather than minimum groups."""
        return [len(m) for m in self.members]

    def check(self, n_vertices: int) -> None:
        seen = {}
        for gi, mem in enumerate(self.members):
            for v in mem:
                if not (0 <= v < n_vertices):
                    raise ValueError(f"group {gi} has vertex {v} outside 0..{n_vertices}")
                if v in seen:
                    raise ValueError(f"vertex {v} is in groups {seen[v]} and {gi} — not disjoint")
                seen[v] = gi
        for v in self.hard:
            if v in seen:
                raise ValueError(f"vertex {v} is BOTH hard and in group {seen[v]} (Rule 1)")
        covered = len(seen) + len(self.hard)
        if covered != n_vertices:
            raise ValueError(f"{covered} of {n_vertices} vertices are accounted for; every vertex "
                             f"must be in exactly one group or hard")


def encode(n_vertices: int, edges, groups: Groups, pins=(), k: int = 4, precedence: bool = True):
    """(WCNF, presence_var_of_group). `pins` are (vertex, colour, polarity) hard unit facts.

    **`precedence` breaks the palette symmetry, and M52 measured that symmetry at 6.5–35× of solver
    time, twice.** A proper colouring stays proper under any permutation of the colours, so a solver
    explores up to `k!` copies of every search tree; value precedence keeps exactly one — colour `c`
    may be used only if colour `c-1` is already used at a strictly lower vertex. The compact
    encoding uses `used[v][c]` = "colour c appears at or before v", which is `O(n·k)` clauses rather
    than the `O(n²·k)` of the direct form.

    It composes with presence literals for free: an absent vertex wears no colour, so it simply does
    not participate, and the constraint stays sound because *some* permutation of any colouring is
    in order of first use."""
    from pysat.formula import WCNF
    groups.check(n_vertices)

    def var(v, c):
        return v * k + c + 1

    top = n_vertices * k
    pres = []
    for _ in groups.members:
        top += 1
        pres.append(top)
    gof = {}
    for gi, mem in enumerate(groups.members):
        for v in mem:
            gof[v] = gi

    w = WCNF()
    for v in range(n_vertices):
        gi = gof.get(v)
        if gi is None:                                   # hard vertex: unconditional
            w.append([var(v, c) for c in range(k)])
        else:
            a = pres[gi]
            w.append([-a] + [var(v, c) for c in range(k)])       # present => wears a colour
            for c in range(k):
                w.append([-var(v, c), a])                        # wears a colour => present
    for (u, v) in edges:
        for c in range(k):
            w.append([-var(u, c), -var(v, c)])
    for (v, c, pol) in pins:
        w.append([var(v, c) if pol else -var(v, c)])
    if precedence and k > 1:
        used = {}
        for v in range(n_vertices):
            for c in range(k):
                top += 1
                used[(v, c)] = top
        for c in range(k):
            w.append([-var(0, c), used[(0, c)]])
            for v in range(1, n_vertices):
                w.append([-var(v, c), used[(v, c)]])              # wearing c makes c used
                w.append([-used[(v - 1, c)], used[(v, c)]])        # used is monotone in v
                w.append([used[(v - 1, c)], var(v, c), -used[(v, c)]])
        for c in range(1, k):
            w.append([-var(0, c)])                                 # v0 can only wear colour 0
            for v in range(1, n_vertices):
                w.append([-var(v, c), used[(v - 1, c - 1)]])        # c needs c-1 used strictly before
    for gi, wt in enumerate(groups.weights()):
        w.append([pres[gi]], weight=wt)                          # soft: "keep this group"
    return w, pres


def smallest(n_vertices: int, edges, groups: Groups, pins=(), k: int = 4,
             solver: str = "g3", verbose: int = 0):
    """The minimum-weight group selection that refuses `k` colours, or None if none does.

    Returns (group_indices, weight). A `None` means the FULL selection is k-colourable — the arena
    is vacuous — and is reported as that, never as a failure."""
    from pysat.examples.optux import OptUx
    w, pres = encode(n_vertices, edges, groups, pins, k)
    with OptUx(w, solver=solver, verbose=verbose) as ux:
        mus = ux.compute()
        if mus is None:
            return None
        # OptUx returns 1-based indices into the soft-clause list, which is our group list in order.
        gi = sorted(i - 1 for i in mus)
        return gi, sum(groups.weights()[i] for i in gi)


def refutes(n_vertices: int, edges, groups: Groups, keep, pins=(), k: int = 4, wall: float = 600.0):
    """Independent re-verification: build the induced graph from geometry and ask directly.

    Nothing anywhere trusts the MUS tool's own bookkeeping; every reported selection comes back
    through here, and an `unknown` at the wall is returned as `unknown` and never as a verdict."""
    from pysat.solvers import Solver
    keep = set(keep)
    live = set(groups.hard)
    for gi in keep:
        live.update(groups.members[gi])
    idx = {v: i for i, v in enumerate(sorted(live))}

    def var(i, c):
        return i * k + c + 1
    cnf = [[var(i, c) for c in range(k)] for i in idx.values()]
    for (u, v) in edges:
        if u in idx and v in idx:
            for c in range(k):
                cnf.append([-var(idx[u], c), -var(idx[v], c)])
    for (v, c, pol) in pins:
        if v in idx:
            cnf.append([var(idx[v], c) if pol else -var(idx[v], c)])
    with Solver(name="cadical153", bootstrap_with=cnf) as s:
        s.conf_budget(int(wall * 100000))
        r = s.solve_limited(expect_interrupt=False)
    return {True: "sat", False: "unsat", None: "unknown"}[r], len(live)
