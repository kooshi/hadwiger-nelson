#!/usr/bin/env python3
"""cube_certify — cube-and-conquer over the campaign's two forcing encodings (M53 §B D2, §Bʹ.4, §Bʺ.1).

    python3 tools/cube_certify.py --edges build/m51-edges-<label>.json --encoding onehot|binary3 \
        --out build/m53-cube/<name> [--drop u-v] [--split 3 --cube-cap 600 --conflicts 0 --max-depth 9 \
        --workers 32] [--result data/m53/cube-certify-<name>.json]
    python3 tools/cube_certify.py --self-test

The formula F is the SAME clause set the monolithic ask uses — `twodist.forces_clauses` (one-hot with
first-occurrence breaking and A ≠ B) or `rigidity.binary3_clauses` (3-bit codes, codes 5–7 banned,
vertex 0 pinned) — so the cubed verdict and the monolithic verdict are about one formula. A cube is a
PREFIX pin over one global split order (the object's degree order, the breaking's own; the vertex the
encoding already pins is skipped): the cube at depth d pins the first d split vertices to codes in
0..4, and a split replaces a cube by its five extensions. Invariant I: the open and closed leaves
together cover every model of F, because F implies "code ∈ 0..4" at every vertex (the one-hot's
at-least-one clause, the 3-bit's ban), so a model consistent with a cube is consistent with the child
wearing its code. Hence UNSAT ⟸ every leaf refuted; SAT ⟸ a leaf's model, VALIDATED here against the
object (proper on unit ∪ standing, codes < 5, the pair separated) — a verdict independent of the cube
machinery — and in object mode a REFUSAL (the standing set does not force); UNKNOWN ⟸ a leaf undecided
at the depth cap, named. A SAT leaf whose decoded colouring fails validation is an INSTRUMENT FAULT,
never a refusal. Over the symmetry-broken one-hot the same argument covers the models of F ∧ brk.
Improper cubes are run, not pruned (cadical refutes them by one clause; the journal stays complete).
The journal `cubes.jsonl` is append-only and the frontier is a function of it, so re-running the same
command resumes; a journal from another formula is refused by its header. Budgets: `--conflicts N`
(deterministic, cadical `-c`) or `--cube-cap` seconds (cadical `-t`, machine-dependent). UNTRUSTED like
all of tools/; the kernel form of I is M05's cover theorem."""
from __future__ import annotations
import argparse, hashlib, itertools, json, os, queue, random, subprocess, sys, tempfile, threading, time
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
import coloring, forcer, rigidity  # noqa: E402
import twodist as T  # noqa: E402

ROOT = Path(__file__).resolve().parent.parent
K = 5


# ---------------------------------------------------------------- the formula

class Formula:
    """F, its pin literals per (vertex, code), its decoder, and the split order — for one encoding."""

    def __init__(self, encoding: str, n: int, unit, standing, A: int, B: int):
        self.encoding, self.n, self.A, self.B = encoding, n, A, B
        self.unit = [tuple(e) for e in unit]; self.standing = [tuple(e) for e in standing]
        edges = self.unit + self.standing
        order = T._degree_order(n, edges)
        if encoding == "onehot":
            self.clauses = T.forces_clauses(n, self.unit, self.standing, A, B)
            self.nvars = n * K
            pinned = {order[0]}                      # the breaking fixes the first vertex's colour
        elif encoding == "binary3":
            self.clauses = rigidity.binary3_clauses(n, edges, [(A, B)])
            self.nvars = n * 3
            pinned = {0}                             # the generator pins vertex 0
        else:
            raise SystemExit(f"[cube] unknown encoding {encoding!r} (onehot | binary3)")
        self.order = [v for v in order if v not in pinned]
        self.base_text = "".join(" ".join(map(str, c)) + " 0\n" for c in self.clauses)
        self.sha = hashlib.sha256(self.base_text.encode()).hexdigest()[:16]

    def pin(self, v: int, c: int) -> list[list[int]]:
        if self.encoding == "onehot":
            return [[coloring.var(v, c, K)]]
        return [[rigidity.binary3_bit(v, i)] if (c >> i) & 1 else [-rigidity.binary3_bit(v, i)] for i in range(3)]

    def decode(self, model: set[int]) -> list[int]:
        return rigidity.decode(model, self.n, K) if self.encoding == "onehot" else rigidity.binary3_decode(model, self.n)

    def validate(self, col: list[int]) -> str | None:
        """None if `col` is a separating colouring of the object; else the reason."""
        if any(c > 4 or c < 0 for c in col):
            return "a code outside 0..4"
        for u, v in self.unit:
            if col[u] == col[v]:
                return f"monochromatic unit edge {(u, v)}"
        for u, v in self.standing:
            if col[u] == col[v]:
                return f"monochromatic standing cheat {(u, v)}"
        if col[self.A] == col[self.B]:
            return f"the pair {self.A},{self.B} shares a colour"
        return None

    def cube_clauses(self, cube: tuple[int, ...]) -> list[list[int]]:
        out: list[list[int]] = []
        for d, c in enumerate(cube):
            out += self.pin(self.order[d], c)
        return out


def solve(f: Formula, cube: tuple[int, ...], cap: float | None, conflicts: int | None):
    """(status, model): sat | unsat | unknown; a crash raises (the HALT rule)."""
    units = f.cube_clauses(cube)
    with tempfile.NamedTemporaryFile("w", suffix=".cnf", delete=False) as t:
        t.write(f"p cnf {f.nvars} {len(f.clauses) + len(units)}\n")
        t.write(f.base_text)
        for c in units:
            t.write(" ".join(map(str, c)) + " 0\n")
        path = t.name
    cmd = [forcer.CADICAL, "-q"]
    if conflicts:
        cmd += ["-c", str(conflicts)]
    if cap:
        cmd += ["-t", str(int(cap))]
    cmd.append(path)
    try:
        r = subprocess.run(cmd, capture_output=True, text=True)
    finally:
        os.unlink(path)
    if r.returncode == 20:
        return "unsat", None
    if r.returncode == 10:
        return "sat", {int(x) for line in r.stdout.splitlines() if line.startswith("v ") for x in line[2:].split() if x != "0"}
    if r.returncode == 0:
        return "unknown", None
    raise RuntimeError(f"cadical crashed on cube {cube}: rc {r.returncode} {r.stderr[-200:]!r}")


# ------------------------------------------------------------------ the tree

def header_of(f: Formula, a, label: str, drop) -> str:
    return (f"# kind=cube-certify encoding={f.encoding} object={label} formula_sha={f.sha} n={f.n} "
            f"standing={len(f.standing)} drop={drop or '-'} k={K} split={a.split} max_depth={a.max_depth} "
            f"order_head={','.join(map(str, f.order[:16]))}")


def frontier_from_journal(path: Path, header: str, split: int):
    """The open leaves implied by the journal: the initial depth-`split` cubes, each split row replaced
    by its five children, every closed row removed. Refuses a journal from another formula."""
    initial = set(itertools.product(range(K), repeat=split))
    closed: dict[tuple, dict] = {}
    if not path.exists():
        return initial, closed, 0
    lines = path.read_text().splitlines()
    if not lines:
        return initial, closed, 0
    h = lines[0].strip()
    key = lambda s: {kv.split("=")[0]: kv.split("=", 1)[1] for kv in s.lstrip("# ").split() if "=" in kv}
    hk, mk = key(h), key(header)
    for k in ("encoding", "formula_sha", "n", "standing", "drop", "k", "split", "max_depth"):
        if hk.get(k) != mk.get(k):
            raise SystemExit(f"[cube] REFUSED: journal {path} is for another run — {k}={hk.get(k)!r} there, {mk.get(k)!r} here")
    live = set(initial)
    for line in lines[1:]:
        if not line.startswith("{"):
            continue
        r = json.loads(line); cube = tuple(r["cube"])
        if r["verdict"] == "split":
            live.discard(cube)
            for c in range(K):
                live.add(cube + (c,))
        else:
            live.discard(cube); closed[cube] = r
    return live, closed, len(lines) - 1


def run_tree(f: Formula, a, out: Path, label: str, drop, log=print) -> dict:
    out.mkdir(parents=True, exist_ok=True)
    jp = out / "cubes.jsonl"
    header = header_of(f, a, label, drop)
    live, closed, replayed = frontier_from_journal(jp, header, a.split)
    if not jp.exists():
        jp.write_text(header + "\n")
    lock = threading.Lock(); stop = threading.Event()
    q: queue.Queue = queue.Queue()
    for cube in sorted(live):
        q.put(cube)
    state = {"outstanding": len(live), "unsat": 0, "sat": 0, "open": 0, "split": 0, "solver_s": 0.0, "deepest": 0,
             "sat_row": None, "open_cubes": []}
    for r in closed.values():
        state[r["verdict"]] += 1
        if r["verdict"] == "sat" and state["sat_row"] is None:
            state["sat_row"] = r
        if r["verdict"] == "open":
            state["open_cubes"].append(r["cube"])
    log(f"[cube {f.encoding} {label}] formula {f.sha}: {len(f.clauses):,} clauses / {f.nvars:,} vars; split order head "
        f"{f.order[:8]}; {len(live)} leaves to ask ({replayed} journal rows replayed: {state['unsat']} unsat, "
        f"{state['sat']} sat, {state['open']} open); cap {a.cube_cap}s / {a.conflicts or 'no'} conflicts; {a.workers} workers", flush=True)

    def record(row: dict) -> None:
        with lock:
            with jp.open("a") as fh:
                fh.write(json.dumps(row) + "\n")

    def worker() -> None:
        while True:
            try:
                cube = q.get(timeout=0.5)
            except queue.Empty:
                with lock:
                    if state["outstanding"] == 0:
                        return
                continue
            if stop.is_set():
                with lock:
                    state["outstanding"] -= 1
                continue
            t0 = time.time()
            st, model = solve(f, cube, a.cube_cap, a.conflicts)
            secs = round(time.time() - t0, 1)
            with lock:
                state["solver_s"] += secs; state["deepest"] = max(state["deepest"], len(cube))
            if st == "unsat":
                record({"cube": list(cube), "verdict": "unsat", "seconds": secs})
                with lock:
                    state["unsat"] += 1; state["outstanding"] -= 1
            elif st == "sat":
                col = f.decode(model); why = f.validate(col)
                row = {"cube": list(cube), "verdict": "sat", "seconds": secs, "colouring": "".join(map(str, col)),
                       "validated": why is None, "reason": why}
                record(row)
                with lock:
                    state["sat"] += 1; state["outstanding"] -= 1
                    if state["sat_row"] is None:
                        state["sat_row"] = row
                stop.set()
            elif len(cube) < a.max_depth:
                record({"cube": list(cube), "verdict": "split", "seconds": secs})
                with lock:
                    state["split"] += 1; state["outstanding"] += K - 1
                for c in range(K):
                    q.put(cube + (c,))
            else:
                record({"cube": list(cube), "verdict": "open", "seconds": secs})
                with lock:
                    state["open"] += 1; state["outstanding"] -= 1; state["open_cubes"].append(list(cube))
            q.task_done()

    t0 = time.time()
    threads = [threading.Thread(target=worker, daemon=True) for _ in range(a.workers)]
    for th in threads:
        th.start()
    last = time.time()
    while any(th.is_alive() for th in threads):
        time.sleep(1.0)
        if time.time() - last >= a.progress_every:
            last = time.time()
            with lock:
                log(f"[cube {f.encoding} {label}] leaves: {state['unsat']} refuted · {state['sat']} sat · {state['open']} open · "
                    f"{state['split']} split · {state['outstanding']} outstanding · deepest {state['deepest']} · "
                    f"{state['solver_s']:.0f} solver-s · {time.time()-t0:.0f} s wall", flush=True)
    wall = time.time() - t0
    if state["sat"]:
        r = state["sat_row"]
        verdict = "SAT" if r["validated"] else "INSTRUMENT-FAULT"
    elif state["open"]:
        verdict = "UNKNOWN"
    else:
        verdict = "UNSAT"
    leaves = state["unsat"] + state["sat"] + state["open"]
    res = {"kind": "cube-certify", "encoding": f.encoding, "object": label, "drop": drop, "formula_sha": f.sha,
           "clauses": len(f.clauses), "vars": f.nvars, "n": f.n, "standing": len(f.standing), "pair": [f.A, f.B],
           "split": a.split, "max_depth": a.max_depth, "cube_cap_s": a.cube_cap, "conflicts": a.conflicts, "workers": a.workers,
           "leaves": leaves, "refuted": state["unsat"], "sat": state["sat"], "open": state["open"], "splits": state["split"],
           "deepest": state["deepest"], "solver_seconds": round(state["solver_s"], 1), "wall_seconds": round(wall, 1),
           "verdict": verdict, "open_cubes": state["open_cubes"][:200], "sat_leaf": state["sat_row"],
           "journal": str(jp), "machine": os.uname().nodename, "written": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()),
           "claim_scope": "UNSAT = every leaf of a complete cover of F's models refuted by cadical (one encoding); "
                          "SAT = a leaf's model validated against the object (proper, codes < 5, pair separated) — in object "
                          "mode a REFUSAL; UNKNOWN = an open leaf at the depth cap, verdict withheld; a wall cap is not reproducible"}
    if verdict == "UNSAT":
        log(f"[cube {f.encoding} {label}] UNSAT — {leaves:,} leaves all refuted (deepest {state['deepest']} · cap {a.cube_cap}s/leaf · "
            f"{state['solver_s']:.0f} solver-s · {wall/3600:.2f} h wall)", flush=True)
    elif verdict == "SAT":
        r = state["sat_row"]
        log(f"[cube {f.encoding} {label}] REFUSED — leaf {tuple(r['cube'])} is SAT and the colouring is VALIDATED (proper on "
            f"{len(f.unit):,} unit edges and {len(f.standing)} cheats, separates {f.A}/{f.B}): the standing set does NOT force — "
            f"investigate, never retry", flush=True)
    elif verdict == "INSTRUMENT-FAULT":
        log(f"[cube {f.encoding} {label}] INSTRUMENT FAULT — cadical reported SAT on leaf {tuple(state['sat_row']['cube'])} but the "
            f"decoded colouring fails validation ({state['sat_row']['reason']}): the decoder or the clause generator is wrong", flush=True)
    else:
        log(f"[cube {f.encoding} {label}] UNKNOWN — {state['open']} leaves open at the depth cap {a.max_depth} "
            f"(first {state['open_cubes'][:3]}), {state['unsat']:,} refuted; verdict withheld: raise --max-depth or --cube-cap and re-run (resumes)", flush=True)
    return res


# ------------------------------------------------------------------- object mode

def stage_from_sidecar(path: Path, drop):
    d = json.loads(path.read_text())
    assert d.get("kind") == "object-edges", f"{path}: not an object-edges sidecar"
    removed = {tuple(e) for e in d["removed"]}
    standing = [tuple(e) for e in d["cheats"] if tuple(e) not in removed]
    if drop:
        if drop not in standing:
            raise SystemExit(f"[cube] REFUSED: --drop {drop} is not a standing cheat of {d['object']}")
        standing = [e for e in standing if e != drop]
    A, B = d["forced_pair"]
    return d["object"], int(d["n"]), [tuple(e) for e in d["unit_edges"]], standing, int(A), int(B), d


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--edges"); ap.add_argument("--encoding", default="binary3"); ap.add_argument("--out")
    ap.add_argument("--drop", default=None, help="u-v: remove one standing cheat too (the planted red: the floor census says SAT)")
    ap.add_argument("--split", type=int, default=3); ap.add_argument("--max-depth", type=int, default=9)
    ap.add_argument("--cube-cap", type=float, default=600.0); ap.add_argument("--conflicts", type=int, default=0)
    ap.add_argument("--workers", type=int, default=32); ap.add_argument("--progress-every", type=float, default=60.0)
    ap.add_argument("--result", default=None); ap.add_argument("--self-test", action="store_true")
    a = ap.parse_args()
    if a.self_test:
        return self_test(a)
    drop = tuple(int(x) for x in a.drop.split("-")) if a.drop else None
    label, n, unit, standing, A, B, side = stage_from_sidecar(Path(a.edges), drop)
    f = Formula(a.encoding, n, unit, standing, A, B)
    name = f"{label}-{a.encoding}" + (f"-drop-{a.drop}" if a.drop else "")
    res = run_tree(f, a, Path(a.out), label, a.drop)
    res["fingerprint_bare"], res["fingerprint_removed"] = side.get("fingerprint_bare"), side.get("fingerprint_removed")
    res["standing_sha"] = hashlib.sha256(json.dumps(sorted(standing)).encode()).hexdigest()[:16]
    rp = Path(a.result) if a.result else ROOT / "data" / "m53" / f"cube-certify-{name}.json"
    rp.parent.mkdir(parents=True, exist_ok=True); rp.write_text(json.dumps(res, indent=1))
    print(f"[cube] wrote {rp}", flush=True)


# -------------------------------------------------------------------- self-test

def self_test(a):
    """Seen red and green before the first real run (§Bʺ.1's test column)."""
    import shutil
    a.workers, a.cube_cap, a.conflicts, a.progress_every = 8, 30.0, 0, 3600.0
    tmp = Path(tempfile.mkdtemp(prefix="cube-selftest-"))
    quiet = lambda *x, **k: None
    # (a) K6 at five colours, both encodings, split 3: 125 leaves, all refuted, the leaf set = every assignment
    k6 = [(i, j) for i in range(6) for j in range(i + 1, 6)]
    for enc in ("onehot", "binary3"):
        a.split, a.max_depth = 3, 3
        f = Formula(enc, 6, k6, [], 0, 1)
        res = run_tree(f, a, tmp / f"k6-{enc}", "K6", None, log=quiet)
        rows = [json.loads(l) for l in (tmp / f"k6-{enc}" / "cubes.jsonl").read_text().splitlines()[1:]]
        leaves = {tuple(r["cube"]) for r in rows}
        assert res["verdict"] == "UNSAT" and res["leaves"] == 125 and leaves == set(itertools.product(range(5), repeat=3)), (enc, res["verdict"], res["leaves"], len(leaves))
        print(f"[cube self-test] K6 {enc}: UNSAT, 125 leaves = every assignment of the first 3 split vertices (cover I visible)")
    # (b) a colourable graph: C5 plus a pendant path — SAT, model validated
    g = [(0, 1), (1, 2), (2, 3), (3, 4), (4, 0), (5, 6), (6, 0)]
    for enc in ("onehot", "binary3"):
        a.split, a.max_depth = 2, 4
        f = Formula(enc, 7, g, [], 0, 6)
        res = run_tree(f, a, tmp / f"sat-{enc}", "C5+path", None, log=quiet)
        assert res["verdict"] == "SAT" and res["sat_leaf"]["validated"], (enc, res["verdict"])
        col = [int(c) for c in res["sat_leaf"]["colouring"]]
        assert f.validate(col) is None
        print(f"[cube self-test] C5+path {enc}: SAT, model validated {res['sat_leaf']['colouring']}")
    # (c) ten random graphs, five with an embedded K6: cube verdict = monolithic verdict, both encodings
    rng = random.Random(53); agree = 0
    for t in range(10):
        n = 12; E = {(i, j) for i in range(n) for j in range(i + 1, n) if rng.random() < 0.35}
        if t % 2:
            E |= {(i, j) for i in range(6) for j in range(i + 1, 6)}
        E = sorted(E); Aa, Bb = 10, 11
        E = [e for e in E if e != (Aa, Bb)]
        for enc in ("onehot", "binary3"):
            a.split, a.max_depth = 2, 4
            f = Formula(enc, n, E, [], Aa, Bb)
            res = run_tree(f, a, tmp / f"rand{t}-{enc}", f"rand{t}", None, log=quiet)
            st, _ = forcer._solve(f.clauses, f.nvars, 60)
            assert {"UNSAT": "unsat", "SAT": "sat"}[res["verdict"]] == st, (t, enc, res["verdict"], st)
            agree += 1
    print(f"[cube self-test] {agree} cube-vs-monolithic agreements over 10 random graphs × 2 encodings (5 with a planted K6)")
    # (d) resume: a journal holding one `split` row and nothing else must issue exactly that cube's five children
    a.split, a.max_depth = 1, 3
    f = Formula("binary3", 6, k6, [], 0, 1)
    d = tmp / "resume"; d.mkdir()
    (d / "cubes.jsonl").write_text(header_of(f, a, "K6", None) + "\n" + json.dumps({"cube": [0], "verdict": "split", "seconds": 0}) + "\n")
    res = run_tree(f, a, d, "K6", None, log=quiet)
    rows = [json.loads(l) for l in (d / "cubes.jsonl").read_text().splitlines()[1:]]
    issued = {tuple(r["cube"]) for r in rows if r["verdict"] != "split"}
    expect = {(c,) for c in range(1, 5)} | {(0, c) for c in range(5)}
    assert issued == expect and res["verdict"] == "UNSAT", (issued ^ expect, res["verdict"])
    print(f"[cube self-test] resume: a journal with one split row issued exactly its five children plus the other four initial cubes")
    # (e) a journal from another formula is refused
    f2 = Formula("binary3", 6, k6[:-1], [], 0, 1)
    try:
        run_tree(f2, a, d, "K6", None, log=quiet); raise AssertionError("a foreign journal was accepted")
    except SystemExit as ex:
        assert "another run" in str(ex)
    print("[cube self-test] a journal from another formula is REFUSED (formula sha named)")
    # (f) the planted instrument fault: a decoder that lies must be reported as INSTRUMENT-FAULT, not SAT
    f3 = Formula("binary3", 7, g, [], 0, 6)
    f3.validate = lambda col: "planted: the validator rejects everything"
    a.split, a.max_depth = 2, 4
    res = run_tree(f3, a, tmp / "fault", "C5+path", None, log=quiet)
    assert res["verdict"] == "INSTRUMENT-FAULT", res["verdict"]
    print("[cube self-test] a SAT leaf failing validation is reported INSTRUMENT-FAULT, never SAT")
    shutil.rmtree(tmp)
    print("[cube self-test] all green")


if __name__ == "__main__":
    main()
