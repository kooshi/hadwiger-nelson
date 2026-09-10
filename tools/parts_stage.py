#!/usr/bin/env python3
"""A reduction STAGE: his working graph `W` together with its companion `C`, as one object.

The domain pass (`plans/M63-parts-reproduction.md` §M) settled the shape, and this is it:

  * a **Drawing** is a vertex set over the base plus its derived edges -- `M`, `A`, `W`, `R` and the
    `L`/`S` halves are one type in five roles;
  * a **Companion** is (extra vertices, extra edges) whose vertices are NEVER deletable, which is
    both why `[Parts2020a]`'s framework covers mono-pairs and non-mono-sets and why his
    symmetry-setting pendants (§5.8) cost nothing against the vertex budget;
  * the key property is always `W u C refuses four colours`, which makes MONOTONICITY structural
    (§O) rather than a fact to be checked per property;
  * the **atoms** are the orbits of a chosen output subgroup on `W`'s deletable vertices -- one
    mechanism replacing `mkstate`'s `granularity` flag and `symstate`'s `sym` rung.

A type-M stage needs no rotation arithmetic. `typem.Arena` already holds `L` at indices `0..n` and
`S` at `n..2n` with the (L,S) block given by the `rho15` cross-edge law, and forbids the S-side
centre so the rotation centre is shared exactly once. Selecting a side is then a bitmask.
"""
from __future__ import annotations
import os, sys, time
from collections import defaultdict

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import typem as T
import parts_repro as P
import parts_report as R

# the unit triangle of L that [Parts2020a] §5.9 pins: (0,0), (1,0), (1/2, sqrt3/2), in his coordinates
PIN_TRIANGLE = ((0, 0, 0, 0), (12, 0, 0, 0), (6, 0, 6, 0))


class Stage:
    """`W u C` over a restricted point list, with the deletable atoms named and the CNF built once.

    Attributes
      A         -- the arena (L at 0..n, S at n..2n, S-side centre forbidden)
      present   -- bitmask of `W u C`
      fixed     -- bitmask of vertices that are never deleted (all of `C`, plus `W`'s fixed part)
      atoms     -- list of bitmasks, disjoint, union = present & ~fixed
      rung      -- the order of the output symmetry group whose orbits the atoms are
      side      -- which half is being reduced, for the record
    """

    def __init__(self, base, L_tuples, S_tuples, side="S", rung=1, pin=True):
        if side not in ("L", "S"):
            raise ValueError("side is 'L' or 'S' -- L and S are minimized separately against a "
                             "frozen companion ([Parts2020a] §5.3)")
        keys = sorted(set(L_tuples) | set(S_tuples))
        self.base, self.side, self.rung = base, side, rung
        self.keys = keys
        self.ix = {t: i for i, t in enumerate(keys)}
        pts = [P.kpoint(t) for t in keys]
        E_int, _ = T.unit_edges_fast(pts)
        E_cross = T.cross_edges_rho15_fast(pts)
        self.A = T.Arena(pts, E_int, E_cross)
        n = self.A.n
        Lbits = 0
        for t in L_tuples:
            Lbits |= 1 << self.ix[t]
        Sbits = 0
        for t in S_tuples:
            i = self.ix[t]
            if i != self.A.centre:                       # the centre is shared, L-side only
                Sbits |= 1 << (n + i)
        self.present = Lbits | Sbits
        self.Lbits, self.Sbits = Lbits, Sbits
        deletable = Sbits if side == "S" else (Lbits & ~(1 << self.A.centre))
        self.fixed = self.present & ~deletable
        self.atoms, self.atom_labels = self._atoms(deletable, rung)
        self.pin = tuple(self.ix[t] for t in PIN_TRIANGLE) if pin else ()
        if pin:
            for t in PIN_TRIANGLE:
                if t not in self.ix or not (Lbits >> self.ix[t]) & 1:
                    raise ValueError(f"the §5.9 pin triangle needs {t} on the L side; it is absent. "
                                     f"Pass pin=False to run without symmetry breaking.")

    def _atoms(self, deletable, rung):
        """The out-orbits of the deletable vertices. rung 1 = singletons; rung 24 = base orbits;
        anything between = the orbits of the corresponding subgroup of <zeta6> x| Gal."""
        n = self.A.n
        verts = [v for v in range(2 * n) if (deletable >> v) & 1]
        if rung == 1:
            return [1 << v for v in verts], [[self.side, self.keys[v % n]] for v in verts]
        if rung == 24:
            buck = defaultdict(int)
            for v in verts:
                buck[self.base.of[self.keys[v % n]]] |= 1 << v
            keys = sorted(buck, key=lambda oi: (self.base.radii[oi][0], self.base.label[oi]))
            return [buck[k] for k in keys], [[self.side, list(self.base.label[k])] for k in keys]
        raise NotImplementedError(
            f"rung {rung} is not built yet. Rungs 1 and 24 exist; the intermediate rungs are the "
            f"orbits of a subgroup of the order-24 group and are M63 phase E's work.")

    # ---------------------------------------------------------------- the key property
    def cnf(self, k=4):
        """One-time CNF (his §5.8 accelerator: extract the common part once). Presence selectors on
        the atoms; everything in `fixed` is hard. Vertex order is by increasing Euclidean distance
        from the centre, which is his §5.9 recommendation and is free here because `parts_lattice`
        already returns the base in that order."""
        n = self.A.n
        live = [v for v in range(2 * n) if (self.present >> v) & 1]
        loc = {v: i for i, v in enumerate(live)}
        var = lambda i, c: i * k + c + 1
        top = len(live) * k
        sel = []
        for _ in self.atoms:
            top += 1
            sel.append(top)
        of = {}
        for ai, m in enumerate(self.atoms):
            mm = m
            while mm:
                v = (mm & -mm).bit_length() - 1
                mm &= mm - 1
                of[v] = ai
        cls = []
        for v in live:
            i = loc[v]
            ai = of.get(v)
            if ai is None:
                cls.append([var(i, c) for c in range(k)])          # fixed: must be coloured
            else:
                cls.append([-sel[ai]] + [var(i, c) for c in range(k)])
                for c in range(k):
                    cls.append([-var(i, c), sel[ai]])
        for (u, v) in self.A.induced(self.present):
            iu, iv = loc[u], loc[v]
            for c in range(k):
                cls.append([-var(iu, c), -var(iv, c)])
        for j, v in enumerate(self.pin):                            # §5.9: a rainbow unit triangle
            cls.append([var(loc[v], j)])
        return cls, sel, top, loc

    @property
    def side_fixed(self) -> int:
        """Vertices of the side being reduced that are never deleted -- for S, the shared centre.

        `|M|` on that side is `weight(kept atoms) + side_fixed`, so a reduction reports a vertex
        count comparable with his tables rather than an atom count comparable with nothing."""
        return 1 if self.side == "S" else 1        # the rotation centre, on whichever side owns it

    def fingerprint(self):
        n = self.A.n
        live = [v for v in range(2 * n) if (self.present >> v) & 1]
        loc = {v: i for i, v in enumerate(live)}
        return R.fp_edges(len(live), [(loc[u], loc[v]) for u, v in self.A.induced(self.present)])

    def describe(self):
        n = self.A.n
        nl, ns = self.Lbits.bit_count(), self.Sbits.bit_count()
        E = self.A.induced(self.present)
        cross = sum(1 for u, v in E if (u < n) != (v < n))
        return (f"stage: reduce {self.side}   L {nl} + S {ns} = {nl + ns} vertices, "
                f"{len(E)} edges ({cross} connection)   atoms {len(self.atoms)} at rung {self.rung}"
                f"   fp {self.fingerprint()[:12]}")


def refuses(stage, kept, wall=600.0, solver=None):
    """('unsat' | 'sat' | 'unknown') for the selection that keeps exactly `kept` atoms.

    Assumptions are the POSITIVE selectors only: a dropped atom's presence variable is left free,
    and the solver may always set it false, so SAT holds exactly when the kept selection is
    four-colourable. Adding negative assumptions would be equivalent and slower."""
    from pysat.solvers import Solver
    own = solver is None
    if own:
        cls, sel, top, _ = stage.cnf()
        solver = Solver(name="cadical153", bootstrap_with=cls)
        stage._sel = sel
    sel = stage._sel
    st = solver.solve(assumptions=[sel[a] for a in kept])
    if own:
        solver.delete()
    return "sat" if st else "unsat"
