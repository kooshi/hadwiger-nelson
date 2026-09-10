"""The single-deletion criticality census, and why it is computed once and never again.

**The theorem this rests on.** Write `S ⊨ ¬4` for "the induced subgraph on selection `S` refuses
four colours". Colourability is *downward closed*: a proper colouring of `S` restricts to a proper
colouring of every `S' ⊆ S`. So if `keep` minus `g` is four-COLOURABLE — `g` is **critical** for `keep`
— then for every `S ⊆ keep` with `g ∈ S` the set `S` minus `g` is a subset of `keep` minus `g` and is
therefore colourable too: **`g` is critical for `S` as well.**

Two consequences, and they are the whole reason this file exists.

1. **A criticality witness is permanent.** Taken at the FULL arena it is the strongest form there
   is, and it holds for every selection any descent will ever reach. The eight-seed portfolio of
   2026-09-10 spent 4.4 CPU-hours re-discovering the same witnesses eight times, sequentially,
   inside eight descents that could not share them.
2. **The census is a rigorous LOWER bound.** Every critical group is in *every* working selection,
   so `sum of their weights <= the minimum`. Every other instrument here produces upper bounds.

**And it is embarrassingly parallel**, because every ask is `keep` minus `g` from the SAME `keep` --
no ask depends on another's answer. That is the one place in a descent where the dependency partial
order is an antichain, and it is exactly the expensive part of the sequential algorithm.

**Verdict vocabulary (G21, and the house rule that no word may mean "clean").** `critical` = a
four-colouring of `keep` minus `g` was exhibited. `droppable-alone` = its refusal was proved, which
says nothing about dropping it *together with* anything else. `undecided` = the budget ran out and
the group is KEPT, which is the safe direction and is NOT evidence of criticality. A census with
undecideds is a fixed point of its budget, and the summary line says so in those words.
"""
from __future__ import annotations
import hashlib, json


def fingerprint(nv: int, edges, members) -> str:
    """`same object?` as a comparison rather than a memory (the standing rule).

    Covers the vertex count, the edge set and the group partition -- the three things that decide
    what an ask means. A census whose fingerprint differs from the arena in front of you is a
    census of a different graph, whatever its filename says."""
    h = hashlib.blake2b(digest_size=16)
    h.update(f"nv={nv};ne={len(edges)};ng={len(members)};".encode())
    for (u, v) in sorted((min(a, b), max(a, b)) for a, b in edges):
        h.update(f"{u},{v};".encode())
    for mem in members:
        h.update((",".join(map(str, sorted(mem))) + "|").encode())
    return h.hexdigest()


def summarise(rows, weights):
    """The census as a report. Every count carries its enumeration; nothing reads as 'clean'."""
    crit = sorted(r["group"] for r in rows if r["verdict"] == "critical")
    drop = sorted(r["group"] for r in rows if r["verdict"] == "droppable-alone")
    und = sorted(r["group"] for r in rows if r["verdict"] == "undecided")
    lb = sum(weights[g] for g in crit)
    return dict(asked=len(rows), of=len(weights),
                critical=len(crit), droppable_alone=len(drop), undecided=len(und),
                critical_groups=crit, droppable_groups=drop, undecided_groups=und,
                lower_bound_weight=lb,
                lower_bound_scope=("weight of the groups whose single deletion was WITNESSED "
                                   "four-colourable; a rigorous lower bound on the minimum "
                                   + ("-- and it is a lower bound on the lower bound, because "
                                      f"{len(und)} groups were undecided at budget and are counted "
                                      "as if droppable" if und else "")),
                drop_capacity_weight=sum(weights[g] for g in drop),
                budget_fixed_point=bool(und))
