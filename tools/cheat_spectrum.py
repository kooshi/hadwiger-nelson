#!/usr/bin/env python3
"""cheat_spectrum — the single-cheat spectrum: every standing cheat of an object enumerated ALONE
(M53 §B D4, §Bʹ.2, §Bʺ.2). For a standing cheat e the engine lists S_e, the separating-colouring
classes of the object with e absent; |S_e| is the cheat's own cost (the batch's ranking column), and
the run is at once a floor census by a SECOND instrument (R3) and a re-ask of the cull's undecided
cheats by a different method (an EXACT 0-class run is the enumerator's cube refutation of
`unit ∪ standing∖{e} ∪ {A≠B}` — G18's shape where the culler's monolithic probe was undecided).

    python3 tools/cheat_spectrum.py --edges build/m51-edges-<label>.json --out build/m53-spectrum/<label> \
        [--culler-journal build/m52-rustcull-it4/cull.jsonl] [--loop-rows build/m52-cull-<label>.jsonl] \
        [--floor data/m51/m51-floor-it5-verdicts.jsonl] [--jobs 4 --threads 4 --max-classes 50000 \
        --conflicts 40000000 --wall 30m] [--result data/m53/spectrum-<label>.json]
    python3 tools/cheat_spectrum.py --regression     # the M52 enum-rank batch must reproduce 15,218 exact

The verdict per cheat, each with its evidence (§Bʺ.2): NECESSARY ⟸ ≥ 1 line written, the line
re-validated here (proper on unit ∪ standing∖{e}, the pair separated, AND monochromatic on e — the
third is a consequence of the object's certificate and a refusal if it fails); DROPPABLE-ALONE ⟸ the
run is exact with 0 lines (V3: every leaf refuted on a fresh solver); UNKNOWN otherwise (0 lines and
open leaves). Witness transfer: the culler's witness for e (found against a standing set ⊇ this one)
is a separating colouring of this stage, so for an EXACT run its palette class is among the lines —
a witnessed cheat with an exact-0 run, or an exact run not containing its witness, is an INSTRUMENT
CONTRADICTION and this tool refuses. A witness colouring identifies its own cheat (it violates exactly
one standing cheat); the planted red — one digit of a real witness changed — must be refused before
any real read. Re-running the same command resumes (the engine's journals; finished cheats skipped).
UNTRUSTED like all of tools/: a droppable-alone verdict enters the object only through a commit's
two-encoding certificate."""
from __future__ import annotations
import argparse, json, os, subprocess, sys, time
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path
import numpy as np

ROOT = Path(__file__).resolve().parent.parent
BUILD = ROOT / "build"
ENGINE = Path.home() / "source/descent-engine/target/release/descent"


# ----------------------------------------------------------------- the stage

class Stage:
    """The object as its edges sidecar holds it: the unit graph, the standing cheats, the pair."""

    def __init__(self, side_path: Path):
        d = json.loads(side_path.read_text())
        assert d.get("kind") == "object-edges", f"{side_path}: not an object-edges sidecar"
        self.path, self.label, self.n = side_path, d["object"], int(d["n"])
        self.deleted = set(int(v) for v in d.get("deleted", []))
        self.live = [int(v) for v in d["seed_live"]]
        self.A, self.B = (int(v) for v in d["forced_pair"])
        self.unit = np.array(d["unit_edges"], dtype=np.int64)
        self.cheats = [tuple(int(x) for x in e) for e in d["cheats"]]
        self.removed = set(tuple(int(x) for x in e) for e in d["removed"])
        self.standing = [c for c in self.cheats if c not in self.removed]
        c = d.get("counts", {})
        assert len(self.standing) == c.get("cheats_remaining", len(self.standing)), \
            (len(self.standing), c.get("cheats_remaining"))
        self.fp_bare, self.fp_removed = d["fingerprint_bare"], d["fingerprint_removed"]
        self.sha = __import__("hashlib").sha256(side_path.read_bytes()).hexdigest()[:16]
        self.pos = {v: i for i, v in enumerate(self.live)}

    def violated_standing(self, col: np.ndarray) -> list[tuple[int, int]]:
        return [(u, v) for u, v in self.standing if col[u] == col[v]]

    def validate_lines(self, cols: np.ndarray, e: tuple[int, int] | None, what: str) -> None:
        """Every row: proper on unit ∪ standing∖{e}, A ≠ B, and (when e is given) mono on e. REFUSES."""
        if cols.ndim == 1:
            cols = cols[None, :]
        assert cols.shape[1] == self.n, (what, "width", cols.shape[1], self.n)
        assert (cols < 5).all(), (what, "a digit ≥ 5")
        for lo in range(0, len(cols), 4096):
            c = cols[lo:lo + 4096]
            bad = (c[:, self.unit[:, 0]] == c[:, self.unit[:, 1]])
            if bad.any():
                i, j = np.argwhere(bad)[0]
                raise SystemExit(f"[spectrum] REFUSED {what}: line {lo + i} is monochromatic on unit edge "
                                 f"{tuple(self.unit[j])} — not a proper colouring")
            if (c[:, self.A] == c[:, self.B]).any():
                raise SystemExit(f"[spectrum] REFUSED {what}: a line does not separate the pair {self.A},{self.B}")
            others = np.array([x for x in self.standing if x != e], dtype=np.int64)
            bad = (c[:, others[:, 0]] == c[:, others[:, 1]])
            if bad.any():
                i, j = np.argwhere(bad)[0]
                raise SystemExit(f"[spectrum] REFUSED {what}: line {lo + i} is monochromatic on standing cheat "
                                 f"{tuple(others[j])} (not the one absent, {e})")
            if e is not None and not (c[:, e[0]] == c[:, e[1]]).all():
                raise SystemExit(f"[spectrum] REFUSED {what}: a line separating the pair is proper on {e} too — "
                                 f"it would be a separating colouring of the WHOLE object, which the certificate "
                                 f"refutes: investigate the object's certificate before anything else")

    def canon(self, col: np.ndarray) -> str:
        """The palette-canonical seed projection: first-occurrence relabelling over the live seed columns."""
        m: dict[int, str] = {}; out = []
        for v in self.live:
            c = int(col[v])
            if c not in m:
                m[c] = str(len(m))
            out.append(m[c])
        return "".join(out)


def digits(s: str) -> np.ndarray:
    return np.frombuffer(s.encode(), dtype=np.uint8) - 48


# --------------------------------------------------------------- the priors

def load_witnesses(stage: Stage, culler_journal: Path | None, loop_rows: Path | None):
    """{cheat: (colouring, source)} from the Rust culler's `holds` rows (the colouring identifies its
    cheat) and the enumeration cull's kept witnesses (a class index into a batch's list)."""
    W: dict[tuple[int, int], tuple[np.ndarray, str]] = {}
    if culler_journal and culler_journal.exists():
        for line in culler_journal.read_text().splitlines():
            if not line.startswith("{"):
                continue
            r = json.loads(line)
            if "holds" not in r:
                continue
            col = digits(r["colours"])
            viol = stage.violated_standing(col)
            if len(viol) != 1:
                raise SystemExit(f"[spectrum] REFUSED culler witness (group {r['holds']}): it violates "
                                 f"{len(viol)} standing cheats {viol[:4]}, not exactly one")
            stage.validate_lines(col, viol[0], f"culler witness group {r['holds']} for {viol[0]}")
            W.setdefault(viol[0], (col, f"culler holds {r['holds']}"))
    if loop_rows and loop_rows.exists():
        for line in loop_rows.read_text().splitlines():
            if not line.startswith("{"):
                continue
            r = json.loads(line)
            for key, idx in (r.get("witnesses") or {}).items():
                e = tuple(int(x) for x in key.split("-"))
                lines = Path(r["classes"]).read_text().splitlines()
                col = digits(json.loads(lines[1 + int(idx)]))
                viol = stage.violated_standing(col)
                if viol != [e]:
                    raise SystemExit(f"[spectrum] REFUSED loop witness {key} (line {idx} of {r['classes']}): "
                                     f"it violates {viol}, not exactly {e}")
                stage.validate_lines(col, e, f"loop witness {key}")
                W.setdefault(e, (col, f"loop {Path(r['classes']).parent.name}:{idx}"))
    return W


def load_floor(path: Path | None) -> set[tuple[int, int]]:
    if not path or not path.exists():
        return set()
    out = set()
    for line in path.read_text().splitlines():
        if line.strip():
            r = json.loads(line)
            if r.get("st") == "sat":
                out.add(tuple(int(x) for x in r["edge"]))
    return out


def planted_red(stage: Stage, W: dict) -> str:
    """One digit of a real witness changed must be REFUSED by the validation (seen red before any read)."""
    e, (col, src) = next(iter(W.items()))
    bad = col.copy()
    # flip the colour of an endpoint of a unit edge: the edge becomes mono, or the pair merges
    u = int(stage.unit[0, 0]); bad[u] = (bad[u] + 1) % 5
    if bad[int(stage.unit[0, 0])] != col[int(stage.unit[0, 1])]:
        bad[u] = col[int(stage.unit[0, 1])]
    try:
        stage.validate_lines(bad, e, "PLANT")
    except SystemExit as ex:
        return f"planted red fired: a witness with one digit changed was refused ({str(ex)[:90]}…)"
    raise SystemExit("[spectrum] PLANTED RED DID NOT FIRE: a corrupted witness passed validation — the checker is broken")


# ------------------------------------------------------------------ one cheat

def run_one(stage: Stage, e: tuple[int, int], out: Path, a) -> dict:
    tag = f"{e[0]}-{e[1]}"
    d = out / tag; d.mkdir(parents=True, exist_ok=True)
    summ_p = d / "enumerate.json"
    if summ_p.exists():
        s = json.loads(summ_p.read_text())
        done = s.get("claim") == "exact" or int(s.get("classes", 0)) >= a.max_classes or not a.rerun_open
        if done:
            return read_one(stage, e, d, a, resumed=True)
        # --rerun-open: the engine resumes (exhausted leaves are not re-asked, open ones are asked again
        # at this launch's budget), so a relaunch with a raised budget continues an open run
    cmd = [str(a.engine), "enumerate", "--edges", str(stage.path), "--out", str(d), "--floor", tag,
           "--threads", str(a.threads), "--max-classes", str(a.max_classes), "--conflicts", str(a.conflicts),
           "--wall", a.wall, "--no-color"]
    t0 = time.time()
    with (d / "run.log").open("a") as log:
        log.write(f"# {time.strftime('%Y-%m-%dT%H:%M:%SZ', time.gmtime())} {' '.join(cmd)}\n"); log.flush()
        rc = subprocess.run(cmd, stdout=log, stderr=subprocess.STDOUT).returncode
    secs = time.time() - t0
    if not summ_p.exists():
        return {"cheat": list(e), "verdict": "engine-error", "rc": rc, "seconds": round(secs, 1),
                "log_tail": (d / "run.log").read_text()[-400:]}
    s = json.loads(summ_p.read_text())
    ver = s.get("verification") or {}
    if ver.get("disagreements"):
        # a REAL contradiction: the verification pass disagreed with a leaf — not D68's undecided case
        raise SystemExit(f"[spectrum] ENGINE CONTRADICTION on {e}: verification disagreements {ver['disagreements'][:4]} "
                         f"(rc {rc}) — stop the campaign and report; see {d / 'report.txt'}")
    # rc 3 with an UNDECIDED verification and no disagreement is the engine's D68 wording for "budget ran out"
    # (filed 2026-09-02): the run is OPEN, its written lines stand (re-validated below), and it says nothing else
    r = read_one(stage, e, d, a, resumed=False); r["seconds"] = round(secs, 1); r["rc"] = rc
    if rc != 0 and not ver.get("undecided"):
        r["verdict"] = "engine-error"; r["log_tail"] = (d / "run.log").read_text()[-400:]
    return r


def read_one(stage: Stage, e: tuple[int, int], d: Path, a, resumed: bool) -> dict:
    s = json.loads((d / "enumerate.json").read_text())
    lines = (d / "classes.jsonl").read_text().splitlines() if (d / "classes.jsonl").exists() else []
    body = [json.loads(l) for l in lines[1:]]
    body = [x for x in body if isinstance(x, str)]
    count = len(body)
    engine_count = int(s.get("classes", count))
    # the LINES are the evidence (each is re-validated below); an engine summary that counts fewer
    # (seen on a resumed capped run: one class row in the journal, "0 found so far" in the summary) is
    # recorded as a discrepancy for the engine's defect list, never folded either way
    discrepancy = None if engine_count == count else {"engine_classes": engine_count, "lines": count}
    if count:
        cols = np.stack([digits(x) for x in body])
        stage.validate_lines(cols, e, f"classes of {e}")
    exact = s.get("claim") == "exact" and not s.get("open")
    claim = "exact" if exact else ("capped" if count >= a.max_classes else "open")
    verdict = "necessary" if count >= 1 else ("droppable-alone" if exact else "unknown")
    ev = ({"lines_validated": count, "mono_on_cheat": True} if count else
          ({"leaves_refuted": s.get("exhausted"), "verification": s.get("verification", {}).get("leaves_refuted")} if exact
           else {"open_leaves": len(s.get("open") or []), "stop_reason": "wall-or-budget"}))
    return {"cheat": list(e), "count": count, "claim": claim, "verdict": verdict, "evidence": ev,
            "leaves": s.get("leaves"), "solves": s.get("solves"), "solver_seconds": s.get("solver_seconds"),
            "stage_fingerprint": s.get("stage_fingerprint"), "out_dir": str(d),
            "seconds": None, "resumed": resumed, **({"engine_discrepancy": discrepancy} if discrepancy else {}),
            "_canon": ({stage.canon(digits(x)) for x in body} if (exact and count) else None)}


# ------------------------------------------------------------------- driver

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--edges"); ap.add_argument("--out")
    ap.add_argument("--culler-journal", default=None); ap.add_argument("--loop-rows", default=None)
    ap.add_argument("--floor", default=None); ap.add_argument("--undecided", default=None,
                    help="the culler's cull.json (its undecided_groups are the 'undecided' prior)")
    ap.add_argument("--jobs", type=int, default=8); ap.add_argument("--threads", type=int, default=2)
    ap.add_argument("--max-classes", type=int, default=10000); ap.add_argument("--conflicts", type=int, default=40_000_000)
    ap.add_argument("--wall", default="10m"); ap.add_argument("--rerun-open", action="store_true")
    ap.add_argument("--engine", default=str(ENGINE)); ap.add_argument("--result", default=None)
    ap.add_argument("--regression", action="store_true", help="re-run the M52 enum-rank batch: 15,218 exact expected")
    a = ap.parse_args()
    a.engine = Path(a.engine)
    if not a.engine.exists():
        raise SystemExit(f"[spectrum] engine binary missing at {a.engine} — build it: (cd ~/source/descent-engine && cargo build --release)")
    if a.regression:
        return regression(a)
    t0 = time.time()
    stage = Stage(Path(a.edges)); out = Path(a.out); out.mkdir(parents=True, exist_ok=True)
    W = load_witnesses(stage, Path(a.culler_journal) if a.culler_journal else None,
                       Path(a.loop_rows) if a.loop_rows else None)
    floor = load_floor(Path(a.floor) if a.floor else None)
    und = set()
    if a.undecided and Path(a.undecided).exists():
        und = {tuple(int(x) for x in k.split("-")) for k in json.loads(Path(a.undecided).read_text()).get("undecided_groups", {})}
    bad = (floor | und | set(W)) - set(stage.standing)
    if bad:
        raise SystemExit(f"[spectrum] REFUSED: prior names cheats that are not standing on {stage.label}: {sorted(bad)[:6]}")
    red = planted_red(stage, W) if W else "no witnesses given — planted red not run"
    print(f"[spectrum] {stage.label}: {len(stage.standing)} standing cheats (bare {stage.fp_bare}, removed-fp {stage.fp_removed}); "
          f"priors: floor {len(floor)}, witnessed {len(W)}, undecided {len(und - set(W))}; {red}", flush=True)
    print(f"[spectrum] engine {a.engine} · jobs {a.jobs} × threads {a.threads} · cap {a.max_classes} classes · "
          f"{a.conflicts} conflicts · wall {a.wall}", flush=True)
    results: dict[tuple[int, int], dict] = {}
    done = 0
    ex = ThreadPoolExecutor(max_workers=a.jobs)
    try:
        futs = {ex.submit(run_one, stage, e, out, a): e for e in stage.standing}
        for f in as_completed(futs):
            e = futs[f]; done += 1
            try:
                r = f.result()
            except SystemExit:
                ex.shutdown(wait=False, cancel_futures=True); raise
            except Exception as exc:  # noqa: BLE001
                r = {"cheat": list(e), "verdict": "driver-error", "count": 0, "claim": "?", "error": repr(exc)[:300], "seconds": None}
                results[e] = r; print(f"[spectrum] {done}/{len(stage.standing)} {e[0]}-{e[1]}: DRIVER ERROR {r['error']}", flush=True); continue
            results[e] = r
            if r["verdict"] == "engine-error":
                print(f"[spectrum] {done}/{len(stage.standing)} {e[0]}-{e[1]}: ENGINE ERROR rc={r.get('rc')} — {r.get('log_tail', '')[-160:]!r}", flush=True)
                continue
            wc = "n/a"
            if e in W:
                if r["claim"] == "exact":
                    if r["count"] == 0:
                        raise SystemExit(f"[spectrum] INSTRUMENT CONTRADICTION: {e} has a witness ({W[e][1]}) but its "
                                         f"single enumeration is EXACT with 0 classes — one of the two engines is wrong")
                    wc = "found" if stage.canon(W[e][0]) in r["_canon"] else None
                    if wc is None:
                        raise SystemExit(f"[spectrum] INSTRUMENT CONTRADICTION: {e}'s exact list ({r['count']} classes) does "
                                         f"not contain its witness's palette class ({W[e][1]}) — the enumeration is incomplete or the witness is not of this stage")
                elif r["count"]:
                    wc = "not-checkable-capped"
                else:
                    # an OPEN run that found no colouring within its wall is not a contradiction: the stage
                    # is SAT (the witness is validated on it), the solver just did not reach a class in
                    # time — the witness supplies the class, and the cheat is necessary with count ≥ 1
                    wc = "supplies-the-class"; r["verdict"] = "necessary"
                    r["evidence"] = {"witness_validated": True, "source": W[e][1], "enumerator": "open, no class within the wall"}
            r["witness_check"] = wc
            r["prior"] = [t for t, s in (("floor", floor), ("witnessed", set(W)), ("undecided", und - set(W))) if e in s]
            print(f"[spectrum] {done}/{len(stage.standing)} {e[0]}-{e[1]}: {r['count']:,} classes {r['claim']} in "
                  f"{r['seconds'] if r['seconds'] is not None else 'resumed'} s — {r['verdict']}"
                  f"{' (witness ' + wc + ')' if wc != 'n/a' else ''}{' [' + ','.join(r['prior']) + ']' if r['prior'] else ''}", flush=True)
            if done % 10 == 0:
                tally = {}
                for x in results.values():
                    tally[x["verdict"]] = tally.get(x["verdict"], 0) + 1
                print(f"[spectrum]   tally after {done}: {tally}", flush=True)
    finally:
        ex.shutdown(wait=False)
    write_result(stage, results, W, floor, und, a, red, t0)


def write_result(stage, results, W, floor, und, a, red, t0):
    recs = []
    for e, r in results.items():
        r = dict(r); r.pop("_canon", None); r.setdefault("prior", []); r.setdefault("witness_check", "n/a")
        recs.append(r)
    recs.sort(key=lambda r: (r.get("count", 10 ** 9) if r["verdict"] not in ("engine-error", "driver-error") else 10 ** 12, r["cheat"]))
    lists = {v: sorted(r["cheat"] for r in recs if r["verdict"] == v) for v in ("necessary", "droppable-alone", "unknown", "engine-error", "driver-error")}
    lists["engine-error"] += lists.pop("driver-error")
    exact_counts = sorted(r["count"] for r in recs if r.get("claim") == "exact")
    med = exact_counts[len(exact_counts) // 2] if exact_counts else None
    n_exact = sum(1 for r in recs if r.get("claim") == "exact"); n_cap = sum(1 for r in recs if r.get("claim") == "capped")
    wfound = sum(1 for r in recs if r["witness_check"] == "found"); wcap = sum(1 for r in recs if r["witness_check"] == "not-checkable-capped")
    fl_ok = sum(1 for r in recs if "floor" in r["prior"] and r.get("count", 0) >= 1)
    und_only = und - set(W)
    und_v = {v: sum(1 for r in recs if "undecided" in r["prior"] and r["verdict"] == v) for v in ("necessary", "droppable-alone", "unknown")}
    headline = (f"{stage.label}: {len(stage.standing)} standing cheats enumerated alone (cap {a.max_classes:,} classes · "
                f"{a.conflicts:,} conflicts · {a.threads} threads · wall {a.wall}): {len(lists['necessary'])} necessary (≥ 1 class; "
                f"{n_exact} exact, {n_cap} capped), {len(lists['droppable-alone'])} droppable-alone (exact 0), "
                f"{len(lists['unknown'])} unknown (0 classes, open leaves), {len(lists['engine-error'])} engine errors; "
                f"median exact count {med}; culler/loop witnesses found {wfound}/{len(W)} (exact runs), not checkable {wcap} (capped); "
                f"floor {fl_ok}/{len(floor)} ≥ 1; of the {len(und_only)} undecided: {und_v['necessary']} necessary, "
                f"{und_v['droppable-alone']} droppable-alone, {und_v['unknown']} unknown.")
    # the census row unions the spectrum's own evidence with the floor census's `sat` verdicts (a
    # colouring existed for those 27 at the census — not retained — so a floor cheat whose run found no
    # class within the wall is necessary BY THE CENSUS, and only unknown to the enumerator)
    fl = {tuple(e) for e in floor}
    nec_all = sorted({tuple(e) for e in lists["necessary"]} | fl)
    unk_all = sorted({tuple(e) for e in lists["unknown"] + lists["engine-error"]} - fl)
    by_census_only = sorted(fl - {tuple(e) for e in lists["necessary"]})
    census_row = {"kind": "recurse-census", "label": stage.label, "instrument": "cheat_spectrum (descent enumerate, one cheat absent) ∪ the floor census's sat verdicts",
                  "floor": len(nec_all), "unknown": len(unk_all),
                  "essential_alone": [list(e) for e in nec_all], "droppable_alone": lists["droppable-alone"],
                  "unknown_alone": [list(e) for e in unk_all], "necessary_by_census_only": [list(e) for e in by_census_only],
                  "object_fingerprint": stage.fp_removed, "fingerprint_bare": stage.fp_bare,
                  "claim_scope": "essential_alone = cheats whose single absence admits ≥ 1 separating class (validated); "
                                 "droppable_alone = exact 0 classes (the enumerator's refutation, one encoding); unknown_alone = "
                                 "0 classes with open leaves or an engine error; a batch may spend any examined cheat"}
    res = {"kind": "cheat-spectrum", "label": stage.label, "headline": headline, "cheats": recs, "lists": lists,
           "census_row": census_row,
           "conditioning": {"max_classes": a.max_classes, "conflicts": a.conflicts, "threads": a.threads, "jobs": a.jobs,
                            "wall": a.wall, "engine": str(a.engine), "engine_commit": engine_commit(a.engine),
                            "sidecar": str(stage.path), "sidecar_sha256_16": stage.sha, "fingerprint_bare": stage.fp_bare,
                            "fingerprint_removed": stage.fp_removed, "planted_red": red, "machine": os.uname().nodename,
                            "seconds": round(time.time() - t0, 1), "written": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime())},
           "scope": "a capped count is a lower bound (≥ count); necessary = at least one validated separating class exists with "
                    "the cheat absent; droppable-alone = the enumerator refuted every leaf (one encoding) and enters the object "
                    "only through a commit's two-encoding certificate; unknown = undecided, never folded"}
    rp = Path(a.result) if a.result else ROOT / "data" / "m53" / f"spectrum-{stage.label}.json"
    rp.parent.mkdir(parents=True, exist_ok=True); rp.write_text(json.dumps(res, indent=1))
    print(f"[spectrum] {headline}\n[spectrum] wrote {rp} [{time.time()-t0:.0f}s]", flush=True)


def engine_commit(engine: Path) -> str:
    try:
        return subprocess.run(["git", "-C", str(engine.parent.parent.parent), "rev-parse", "--short", "HEAD"],
                              capture_output=True, text=True).stdout.strip()
    except Exception:  # noqa: BLE001
        return "?"


def regression(a):
    """Same instrument, same input: the M52 enum-rank batch on the UN-culled iteration-4 sidecar must
    reproduce 15,218 classes, exact — before 149 fresh runs are believed."""
    lab = "S29-depth2r-it2v2-depth1-it2v2-depth1-vdel28-it2v2-depth1"
    src = BUILD / "m52-enum-rank" / lab / "classes.jsonl"
    head = json.loads(src.read_text().splitlines()[0])
    side = json.loads((BUILD / f"m51-edges-{lab}.json").read_text())
    removed = {tuple(e) for e in side["removed"]}
    floor = [tuple(e) for e in head["batch"] if tuple(e) not in removed]
    out = BUILD / "m53-spectrum" / "regression"
    cmd = [str(a.engine), "enumerate", "--edges", str(BUILD / f"m51-edges-{lab}.json"), "--out", str(out),
           "--floor", ",".join(f"{u}-{v}" for u, v in floor), "--threads", "8", "--max-classes", "200000",
           "--conflicts", str(a.conflicts), "--no-color"]
    print(f"[spectrum regression] {len(floor)} floor cheats (batch {len(head['batch'])} = {len(removed)} removed + floor): {' '.join(cmd)}", flush=True)
    t0 = time.time(); rc = subprocess.run(cmd, capture_output=True, text=True)
    s = json.loads((out / "enumerate.json").read_text())
    ok = s.get("claim") == "exact" and int(s["classes"]) == 15218 and s.get("stage_fingerprint") == head["stage_fingerprint"]
    print(f"[spectrum regression] classes {s.get('classes')} claim {s.get('claim')!r} stage {s.get('stage_fingerprint')} "
          f"(expected 15218 exact {head['stage_fingerprint']}) — {'GREEN' if ok else 'RED'} [{time.time()-t0:.0f}s]", flush=True)
    if not ok:
        raise SystemExit(f"[spectrum regression] RED: rc {rc.returncode}; stderr tail {rc.stderr[-300:]!r}")


if __name__ == "__main__":
    main()
