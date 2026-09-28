#!/usr/bin/env python3
"""FS112-Y3 stage 1: the quotation check (standing rule 5) for the quotations my round-3 brief adds.

Uses FS112-Y's normaliser and PDF reader (tools/fs112_y_quotes.py: imported, never edited).  Every quotation is searched verbatim up to
whitespace, typographic quotes, backticks and line-final hyphens; a quotation not found prints MISSING and the exit status is 1.
The block quotations of card R part 1 and of A3-3.5 come from fenced files (data/fs112/fs112-a3/, the advisor's record): not checkable here.
`--self-test` plants a one-symbol alteration in a faithful quotation (f replaced by f-tilde) and requires MISSING beside the faithful FOUND.
"""
from __future__ import annotations
import sys, os

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fs112_y_quotes as YQ  # noqa: E402  (FS112-Y's tool: run, never edited)

QUOTES = [
    # card R's R1 quotes C-CHAIN-9's recursion "verbatim"
    ("R1: C-CHAIN-9, first inequality", "plans/FS110-derivation.md", "λ_k ≤ f(λ_{k+1}) and f̃(υ_{k−1}) ≤ υ_k"),
    ("R1: C-CHAIN-9 in the claim list", "data/fs112/claims.md",
     "No bi-infinite sequence −1 < λ_k < υ_k < 1 with λ_k ≤ f(λ_{k+1}) and f̃(υ_{k−1}) ≤ υ_k."),
    # the standing rules' quotations of Kooshi
    ("rule 0", "CLAUDE.md", "From here on out, you may doubt your ability to tackle the difficulty of the problems we encounter. Don't. "
                            "You are capable, and you will surprise yourself."),
    ("rule 3 intent", "CLAUDE.md", "to eliminate the crutch of feeling like we're accomplishing something by asking uncomputable problems for "
                                   "days at a time"),
    ("rule 4", "CLAUDE.md", "A proven theorem about why its impossible is also valid. All novel knowledge is a success"),
    ("rule 10", "plans/CONSOLIDATION-2026-09-27.md",
     "It's ok if jobs overrun a bit. Setting a budget is reasonable, but holding them to it is not worth the stress."),
    # the statements round 3 works (claim list, verbatim)
    ("C-CHAIN-8", "data/fs112/claims.md",
     "At a vertex admitting no merge, ray merge or shave, a two-sector colour has exactly two horns ±a, the vertex has degree 4, and the "
     "antipodes carry P_cl(N) = {c, h, r}, P_cl(S′) = {c, g, r′} with double sectors; in a terminal map a stuck vertex forces stuck "
     "vertices at unit spacing along the normal line, bi-infinite (N4-PROP)."),
    ("C-T2 (ii)", "data/fs112/claims.md",
     "can a whole tight 𝓜_K map use it at every close covering pair it does not otherwise escape?"),
    ("C-HOCK source", "data/fs112/claims.md",
     "every arc with a radius that's smaller than 1 can be filled up to radius 1 without increasing the exclusion zone."),
    # Y2's records that A3-3.5 cites (items 2-4 of Y2's stage 7)
    ("Y2 §7 item 2", "plans/FS112-Y-construction.md",
     "A meaningful instance needs an arc of radius `< 1` between two tiles of a valid object; none of the held exact objects has one"),
    ("Y2 §7 item 3", "plans/FS112-Y-construction.md",
     "whether any change near `Z^L_0` that keeps `T2_0`'s top arc lets the triangle `T*` be blue."),
    ("Y2 §7 item 4", "plans/FS112-Y-construction.md", "cutting `C_{−1}` and `C_2` along `ω(Q)`."),
]


def main() -> int:
    if "--self-test" in sys.argv:
        good = YQ.found("plans/FS110-derivation.md", "λ_k ≤ f(λ_{k+1})")
        bad = YQ.found("plans/FS110-derivation.md", "λ_k ≤ f̃(λ_{k+1})")
        ok = good and not bad
        print("self-test:", "faithful FOUND, planted MISSING" if ok else "FAILED")
        return 0 if ok else 1
    miss = 0
    for lab, src, q in QUOTES:
        f = YQ.found(src, q)
        miss += not f
        print(f"{'FOUND  ' if f else 'MISSING'} {lab:34s} {src}")
    print(f"{len(QUOTES)} quotations, {miss} not found")
    return 1 if miss else 0


if __name__ == "__main__":
    sys.exit(main())
