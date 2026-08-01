#!/usr/bin/env python3
"""A subgraph's **whole** colouring property at a chosen set of ports.

UNTRUSTED. Nothing here is believed: a gadget this tool proposes is re-certified in Lean from
scratch, against a fresh refutation per pattern. A bug here can only cost a theorem, never buy one.

`Gadget.ofUnsat` in Lean turns *one* refuted colour pattern of the ports into a gadget. A search
does not know which pattern to refute — it wants the **profile**: for every colouring of the ports
that is distinguishable at all, is it achievable or is it impossible? That profile is what turns "a
subgraph" into "a gadget", and it is what a library of gadgets is made of.

Two facts make the profile cheap.

* **Only the partition of the ports matters.** Renaming colours carries proper colourings to proper
  colourings, so `[2,3,2]` and `[0,1,0]` ask the same question. The patterns worth asking about are
  one per partition of the ports into at most `k` blocks — 202 at six ports and five colours rather
  than 15,625. `coloring.canon_patterns` is that list and it agrees element-for-element with
  `Proofs/HadwigerNelson/Pattern.lean`.
* **Each question is far cheaper than a whole-graph refutation.** Pinning the ports fixes several
  variables before search begins, and a gadget worth having is tens of vertices, not hundreds.

Output is JSON: the graph, the ports, the colour count, and one entry per canonical pattern saying
`unsat` (this pattern is impossible — a gadget) or `sat` with a witness colouring (this pattern
happens — and the witness is what makes the answer checkable by hand).

    python3 tools/profile.py --graph tools/spindle.json --ports 0 3 --colours 4
    python3 tools/profile.py --graph tools/corespindle63.json --ports 0 1 2 --colours 4 --out p.json
    python3 tools/profile.py --check --colours 5 --ports-count 3    # print the pattern list only
"""

from __future__ import annotations

import argparse
import json
import os
import subprocess
import sys
import tempfile
from concurrent.futures import ProcessPoolExecutor
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

REPO = Path(__file__).resolve().parent.parent
CADICAL = os.environ.get("CADICAL") or str(
    Path(subprocess.run(["lean", "--print-prefix"], capture_output=True, text=True,
                        check=True, cwd=REPO).stdout.strip()) / "bin" / "cadical")

from coloring import canon_patterns, unvar, write_cnf  # noqa: E402


def load_graph(path: Path) -> tuple[int, list[tuple[int, int]]]:
    """`(n, edges)` from any of this repository's graph JSONs."""
    d = json.load(open(path))
    edges = [(int(a), int(b)) for a, b in d["edges"]]
    n = int(d["n"]) if "n" in d else len(d["coords"])
    return n, edges


def ask(n: int, edges: list[tuple[int, int]], pins: list[tuple[int, int]],
        k: int, timeout: float | None) -> tuple[str, list[int] | None]:
    """Is there a proper `k`-colouring with these vertices pinned to these colours?

    Returns `("unsat", None)`, `("sat", colouring)`, or `("timeout", None)` — **three outcomes, and
    the third is not folded into either other one.** A profiler that reported an unfinished search as
    "not refuted" would quietly turn a hard gadget into a missing one.
    """
    with tempfile.TemporaryDirectory() as td:
        cnf = Path(td) / "f.cnf"
        write_cnf(cnf, n, edges, pins, k)
        cmd = [CADICAL, "-q", str(cnf)]
        try:
            r = subprocess.run(cmd, capture_output=True, text=True, timeout=timeout)
        except subprocess.TimeoutExpired:
            return "timeout", None
        if r.returncode == 20:
            return "unsat", None
        if r.returncode != 10:
            raise RuntimeError(f"cadical returned {r.returncode}: {r.stdout[:200]}")
        true_vars = {int(x) for line in r.stdout.splitlines() if line.startswith("v")
                     for x in line.split()[1:] if int(x) > 0}
        colour = [0] * n
        for x in true_vars:
            v, c = unvar(x, k)
            if v < n:
                colour[v] = c
        return "sat", colour


def _job(args):
    n, edges, ports, pattern, k, timeout = args
    pins = list(zip(ports, pattern))
    status, model = ask(n, edges, pins, k, timeout)
    return {"pattern": pattern, "pins": pins, "status": status,
            "model": model if status == "sat" else None}


def profile(n: int, edges: list[tuple[int, int]], ports: list[int], k: int,
            jobs: int, timeout: float | None) -> list[dict]:
    pats = canon_patterns(k, len(ports))
    work = [(n, edges, ports, p, k, timeout) for p in pats]
    with ProcessPoolExecutor(max_workers=jobs) as ex:
        return list(ex.map(_job, work))


RHOMBUS = [(0, 1), (0, 2), (1, 2), (1, 3), (2, 3)]


def self_test() -> None:
    """The tool's own controls, and both directions of each.

    A profiler that answered "refuted" to everything, or to nothing, would look exactly like a
    working one on any single question. So each check below has a partner that must come out the
    other way:

      * the **rhombus** — two triangles glued along an edge — forces its two *non-adjacent* far
        corners to share a colour at three colours, and forces nothing at four;
      * a lone edge refutes "the ends agree" and not "the ends differ";
      * the canonical pattern list matches `Pattern.lean`'s counts, which is the one place this tool
        and Lean have to agree.
    """
    def expect(got, want, what):
        if got != want:
            raise SystemExit(f"SELF-TEST FAILED — {what}: got {got}, wanted {want}")
        print(f"  ok  {what}")

    rows = profile(4, RHOMBUS, [0, 3], 3, 1, 30)
    expect([r["status"] for r in rows], ["sat", "unsat"],
           "rhombus at 3 colours: far corners may agree, may not differ")
    rows = profile(4, RHOMBUS, [0, 3], 4, 1, 30)
    expect([r["status"] for r in rows], ["sat", "sat"],
           "rhombus at 4 colours: it forces nothing — the negative partner")
    rows = profile(2, [(0, 1)], [0, 1], 3, 1, 30)
    expect([r["status"] for r in rows], ["unsat", "sat"],
           "one edge: the ends may not agree, may differ")
    expect([len(canon_patterns(5, m)) for m in (3, 4, 5, 6)], [5, 15, 52, 202],
           "canonical pattern counts agree with Pattern.lean")
    expect(canon_patterns(5, 3), [[0, 0, 0], [0, 0, 1], [0, 1, 0], [0, 1, 1], [0, 1, 2]],
           "canonical pattern list agrees with Pattern.lean, element for element")
    print("self-test: OK")


def main() -> None:
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--graph", type=Path)
    ap.add_argument("--ports", type=int, nargs="+", default=[])
    ap.add_argument("--colours", type=int, default=4)
    ap.add_argument("--jobs", type=int, default=os.cpu_count() or 1)
    ap.add_argument("--timeout", type=float, default=None,
                    help="seconds per pattern; an expiry is reported, never silently counted as sat")
    ap.add_argument("--out", type=Path)
    ap.add_argument("--check", action="store_true",
                    help="print the canonical pattern list and exit — compare against Lean's "
                         "`#eval (canonPatterns k m).map (List.ofFn ·)`")
    ap.add_argument("--ports-count", type=int, default=3, help="ports, for --check")
    ap.add_argument("--self-test", action="store_true", help="run the tool's own controls and exit")
    args = ap.parse_args()

    if args.self_test:
        self_test()
        return

    if args.check:
        for p in canon_patterns(args.colours, args.ports_count):
            print(p)
        print(f"-- {len(canon_patterns(args.colours, args.ports_count))} patterns "
              f"at {args.colours} colours and {args.ports_count} ports")
        return

    if args.graph is None or not args.ports:
        ap.error("--graph and --ports are required unless --check")

    n, edges = load_graph(args.graph)
    if len(set(args.ports)) != len(args.ports):
        ap.error("a port list that names one vertex twice asks a question with no answer: "
                 "pinning one vertex to two colours is satisfiable in this encoding and the gadget "
                 "it would produce admits everything (see Instances/DeGrey/Controls.lean)")
    rows = profile(n, edges, args.ports, args.colours, args.jobs, args.timeout)

    refuted = [r for r in rows if r["status"] == "unsat"]
    stuck = [r for r in rows if r["status"] == "timeout"]
    print(f"graph      {args.graph.name}: {n} vertices, {len(edges)} edges")
    print(f"ports      {args.ports}  at {args.colours} colours")
    print(f"patterns   {len(rows)} canonical "
          f"({args.colours ** len(args.ports)} before the partition quotient)")
    print(f"refuted    {len(refuted)}")
    print(f"achieved   {len(rows) - len(refuted) - len(stuck)}")
    if stuck:
        print(f"UNRESOLVED {len(stuck)} — raise --timeout; these are neither refuted nor achieved")
    for r in refuted:
        print(f"  gadget: pins {r['pins']}")

    if args.out:
        json.dump({"graph": str(args.graph), "n": n, "edges": edges, "ports": args.ports,
                   "colours": args.colours, "profile": rows}, open(args.out, "w"))
        print(f"wrote      {args.out}")


if __name__ == "__main__":
    main()
