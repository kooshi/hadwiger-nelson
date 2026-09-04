#!/usr/bin/env python3
"""commit_cull — mint the CULLED object as a chain object (M53 §B D1, §Bʹ.1, §Bʺ.5).

    python3 tools/commit_cull.py --object <label> --cull data/m52/cull-result-<it>.json --new-label <label>-cull149 \
        --onehot data/m52/final-certify-149.json [--cube-onehot data/m53/cube-certify-….json] \
        --cube-binary3 data/m53/cube-certify-….json [--sidecar-check build/m51-edges-<label>+cull149.json] \
        [--spectrum data/m53/spectrum-<new-label>.json] [--candidate]
    python3 tools/commit_cull.py --self-test

A cull is a REMOVAL with no halo: the new object has the same points and provenance, `removed` =
the object's removed ∪ the cull's dropped (the union over all three descent moves — halo, deletion,
cull — because the forcing claim depends only on `unit ∪ standing`), and the reason lives in the
`cull-commit` row beside `batch-commit` and `deletion-commit`. An object file exists only for a
COMMITTED object (both encodings UNSAT on the standing set); the mint's soundness rests on the
certificate's refutation of the culled standing set, never on the cull's own bookkeeping — a REFUSED
certificate stops the mint. The one named exception: `--candidate` mints with an explicit top-level
`candidate` marker when the 3-bit is undecided at the cube front-end's depth cap (F3), so the campaign
can continue on the object while the row and the file both say CANDIDATE. The set identities are
asserted (dropped = loop ⊎ culler, standing_after = kept_final, removed_new = removed ⊎ dropped), the
sidecar the engine already used is compared edge for edge, and a spectrum's census row is adopted
under the new label after its fingerprints are checked. UNTRUSTED like all of tools/."""
from __future__ import annotations
import argparse, hashlib, json, shutil, subprocess, sys, time
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
import batchkill as BK  # noqa: E402
import twodist as T  # noqa: E402

ROOT = Path(__file__).resolve().parent.parent


def pairs_of(xs):
    out = []
    for x in xs:
        if isinstance(x, str):
            u, v = (int(t) for t in x.split("-"))
        else:
            u, v = (int(t) for t in x)
        out.append((u, v) if u < v else (v, u))
    return out


def standing_sha(standing) -> str:
    return hashlib.sha256(json.dumps(sorted(standing)).encode()).hexdigest()[:16]


def compose(obj, removed, cull: dict):
    """(dropped, standing_new, removed_new) with the identities asserted."""
    standing = [tuple(e) for e in obj.cheats if tuple(e) not in set(map(tuple, removed))]
    loop = pairs_of(cull["loop"]["dropped"]); rust = pairs_of(cull["rust"]["dropped"])
    assert not (set(loop) & set(rust)), "a cheat dropped by both instruments"
    dropped = sorted(set(loop) | set(rust))
    bad = set(dropped) - set(standing)
    assert not bad, f"dropped cheats that are not standing on the object: {sorted(bad)[:6]}"
    standing_new = [e for e in standing if e not in set(dropped)]
    kept = set(pairs_of(cull["kept_final"]))
    assert set(standing_new) == kept, (f"standing after the cull ≠ the cull result's kept_final: "
                                       f"{len(set(standing_new) - kept)} extra, {len(kept - set(standing_new))} missing")
    removed_new = [tuple(e) for e in removed] + dropped
    assert len(set(removed_new)) == len(removed_new), "removed and dropped overlap"
    return dropped, standing_new, removed_new, {"loop": len(loop), "rust": len(rust)}


def check_onehot(path: Path, label: str, fp_old: str, dropped, standing_new) -> dict:
    d = json.loads(path.read_text())
    assert d.get("kind") == "m52-final-certify" and d["label"] == label, (d.get("kind"), d.get("label"))
    assert d["fingerprint"] == fp_old, f"the one-hot certificate is for object {d['fingerprint']}, not {fp_old}"
    assert set(pairs_of(d["dropped"])) == set(dropped), "the one-hot certificate's dropped set differs"
    assert d["standing_after"] == len(standing_new)
    return {"outcome": d["onehot"]["outcome"], "seconds": d["onehot"]["secs"], "instrument": f"monolithic one-hot ({path.name})",
            "cap": d.get("cap")}


def check_cube(path: Path, encoding: str, standing_new) -> dict:
    d = json.loads(path.read_text())
    assert d.get("kind") == "cube-certify" and d["encoding"] == encoding, (d.get("kind"), d.get("encoding"), encoding)
    assert d.get("drop") in (None, "-"), "a --drop run is a control, not a certificate"
    assert d["standing_sha"] == standing_sha(standing_new), f"the {encoding} cube run is over another standing set"
    return {"verdict": d["verdict"], "leaves": d["leaves"], "open": d["open"], "deepest": d["deepest"],
            "solver_seconds": d["solver_seconds"], "wall_seconds": d["wall_seconds"], "instrument": f"{encoding} cubed ({path.name})"}


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--object"); ap.add_argument("--cull"); ap.add_argument("--new-label")
    ap.add_argument("--onehot"); ap.add_argument("--cube-onehot", default=None); ap.add_argument("--cube-binary3", default=None)
    ap.add_argument("--sidecar-check", default=None); ap.add_argument("--spectrum", default=None)
    ap.add_argument("--candidate", action="store_true", help="mint with an explicit candidate marker when the 3-bit is undecided (F3)")
    ap.add_argument("--self-test", action="store_true")
    a = ap.parse_args()
    if a.self_test:
        return self_test()
    t0 = time.time()
    obj, removed = BK.load_object(a.object)
    cull = json.loads(Path(a.cull).read_text())
    assert cull["object"] == a.object and cull["object_fingerprint"] == obj.fingerprint(removed), "the cull result is for another object"
    dropped, standing_new, removed_new, by = compose(obj, removed, cull)
    fp_new, fp_bare = obj.fingerprint(removed_new), obj.fingerprint()
    print(f"[cull-commit] {a.object} → {a.new_label}: standing {len(dropped) + len(standing_new)} → {len(standing_new)} "
          f"({len(dropped)} dropped: {by['loop']} by the enumeration loop, {by['rust']} by the culler); removed {len(removed)} → {len(removed_new)}; "
          f"fingerprint {fp_new} (bare {fp_bare})", flush=True)
    if a.sidecar_check:
        side = json.loads(Path(a.sidecar_check).read_text())
        assert side["fingerprint_removed"] == fp_new, f"the sidecar {a.sidecar_check} is for {side['fingerprint_removed']}, this object is {fp_new}"
        assert side["fingerprint_bare"] == fp_bare
        print(f"[cull-commit] the engine's sidecar carries the same removed-fingerprint {fp_new}")
    # the certificate
    onehot = check_onehot(Path(a.onehot), a.object, obj.fingerprint(removed), dropped, standing_new)
    cube1 = check_cube(Path(a.cube_onehot), "onehot", standing_new) if a.cube_onehot else None
    cube3 = check_cube(Path(a.cube_binary3), "binary3", standing_new) if a.cube_binary3 else None
    for name, r in (("one-hot", onehot),):
        if r["outcome"] == "sat":
            raise SystemExit(f"[cull-commit] REFUSED: the {name} certificate says SAT — a separating colouring of the culled set exists; investigate, never mint")
    for name, r in (("cubed one-hot", cube1), ("cubed 3-bit", cube3)):
        if r and r["verdict"] in ("SAT", "INSTRUMENT-FAULT"):
            raise SystemExit(f"[cull-commit] REFUSED: the {name} run says {r['verdict']} — investigate, never mint")
    onehot_ok = onehot["outcome"] == "unsat" or (cube1 and cube1["verdict"] == "UNSAT")
    reencode_ok = bool(cube3 and cube3["verdict"] == "UNSAT")
    if not onehot_ok:
        raise SystemExit("[cull-commit] REFUSED: no UNSAT one-hot certificate of the culled set — nothing to mint")
    verdict = "committed" if reencode_ok else "candidate"
    if verdict == "candidate" and not a.candidate:
        raise SystemExit("[cull-commit] the 3-bit is not UNSAT (cubed 3-bit: "
                         f"{cube3['verdict'] if cube3 else 'not given'}); an object file means BOTH encodings — pass --candidate to mint "
                         "with the explicit candidate marker (F3), or finish the 3-bit first")
    ue = obj.unit_edges()
    doc = {"prov": obj.prov[214:], "removed": [list(e) for e in removed_new],
           **({"deleted": sorted(obj.deleted)} if obj.deleted else {}),
           "fingerprint": fp_new, "fingerprint_bare": fp_bare, "n": obj.n, "unit": len(ue), "cheats": len(standing_new)}
    if verdict == "candidate":
        doc["candidate"] = {"reencode": cube3["verdict"].lower() if cube3 else "not-run",
                            "open_cubes": (json.loads(Path(a.cube_binary3).read_text()).get("open_cubes", [])[:20] if cube3 else []),
                            "result": a.cube_binary3, "note": "F3: the 3-bit is undecided at the cube front-end's depth cap; the one-hot is UNSAT"}
    out = BK.BUILD / f"m50-object-{a.new_label}.json"
    out.write_text(json.dumps(doc))
    obj2, removed2 = BK.load_object(a.new_label)
    assert obj2.fingerprint(removed2) == fp_new and len(removed2) == len(removed_new) and obj2.n == obj.n
    print(f"[cull-commit] wrote {out.name} and re-loaded it (fingerprint {fp_new} re-derived; {len(removed2)} removed)", flush=True)
    row = {"kind": "cull-commit", "label": a.new_label, "from": a.object, "dropped": [list(e) for e in dropped], "dropped_by": by,
           "standing_after": len(standing_new), "undecided_at_cull": len(cull["rust"].get("undecided", [])),
           "onehot": onehot, "cube_onehot": cube1, "reencode": cube3, "verdict": verdict,
           "object_after": {"n": obj.n, "unit": len(ue), "cheats": len(standing_new)},
           "fingerprint": fp_new, "fingerprint_bare": fp_bare, "seconds": round(time.time() - t0, 1),
           "claim_scope": "the object with the culled cheats removed (no geometry) still forces A = B: committed = UNSAT in both "
                          "encodings on the culled standing set (monolithic or cubed one-hot, cubed 3-bit); candidate = one-hot only, "
                          "the 3-bit's open cubes named in the object file's `candidate` field"}
    T.record(BK.BUILD / "m50-batch.json", row)
    # the sidecar for the new label, compared edge for edge with the one the engine already used
    r = subprocess.run([sys.executable, str(ROOT / "tools" / "export_edges.py"), a.new_label], capture_output=True, text=True)
    assert r.returncode == 0, r.stderr[-400:]
    side_new = json.loads((BK.BUILD / f"m51-edges-{a.new_label}.json").read_text())
    if a.sidecar_check:
        side = json.loads(Path(a.sidecar_check).read_text())
        assert side_new["unit_edges"] == side["unit_edges"] and side_new["cheats"] == side["cheats"], "sidecar edge lists differ"
        assert set(map(tuple, side_new["removed"])) == set(map(tuple, side["removed"])), "sidecar removed sets differ"
        print(f"[cull-commit] sidecar m51-edges-{a.new_label}.json equals {Path(a.sidecar_check).name} edge for edge "
              f"({len(side['unit_edges'])} unit, {len(side['cheats'])} cheats, {len(side['removed'])} removed)")
    # the spectrum's census row, adopted under the new label
    if a.spectrum:
        sp = json.loads(Path(a.spectrum).read_text())
        c = sp["conditioning"]
        assert c["fingerprint_bare"] == fp_bare and c["fingerprint_removed"] == fp_new, "the spectrum is over another object"
        lists = sp["lists"]
        examined = set(pairs_of(lists["necessary"])) | set(pairs_of(lists["droppable-alone"])) | set(pairs_of(lists["unknown"])) | set(pairs_of(lists.get("engine-error", [])))
        assert examined == set(standing_new), "the spectrum's lists do not partition the standing set"
        crow = dict(sp["census_row"]); crow["label"] = a.new_label; crow["source"] = a.spectrum
        T.record(BK.BUILD / "m50-batch.json", crow)
        print(f"[cull-commit] adopted the spectrum's census row: floor {crow['floor']}, droppable-alone {len(crow['droppable_alone'])}, unknown {crow['unknown']}")
    snap = ROOT / "data" / "m51" / out.name
    shutil.copy(out, snap)
    print(f"[cull-commit] {verdict.upper()}: {a.new_label} — {len(standing_new)} standing cheats, {obj.n} points; snapshot {snap.relative_to(ROOT)} [{time.time()-t0:.0f}s]")


def self_test():
    """The tamper red and the pinned fingerprint on the real iteration-4 data."""
    lab = "S29-depth2r-it2v2-depth1-it2v2-depth1-vdel28-it2v2-depth1"
    obj, removed = BK.load_object(lab)
    cull = json.loads((ROOT / "data" / "m52" / "cull-result-it4.json").read_text())
    dropped, standing_new, removed_new, by = compose(obj, removed, cull)
    # the object file's `removed` is the FULL history (78 on it-4: 71 live + 7 at deleted vertices); the
    # sidecar's is the live subset (71) — the fingerprint is taken over the full history in both places
    assert (len(dropped), len(standing_new), len(removed_new) - len(removed), by) == (124, 149, 124, {"loop": 114, "rust": 10}), (len(dropped), len(standing_new), len(removed_new), by)
    fp = obj.fingerprint(removed_new)
    side = json.loads((BK.BUILD / f"m51-edges-{lab}+cull149.json").read_text())
    assert fp == side["fingerprint_removed"] == "a79347720ccda3ed", (fp, side["fingerprint_removed"])
    print(f"[cull-commit self-test] identities hold (124 = 114 + 10 dropped, 149 standing, removed {len(removed)} → {len(removed_new)}); fingerprint {fp} = the sidecar's, pinned")
    # the tamper red: one extra dropped cheat changes the fingerprint and is refused against the sidecar
    extra = next(e for e in standing_new)
    fp_bad = obj.fingerprint(removed_new + [extra])
    assert fp_bad != side["fingerprint_removed"]
    print(f"[cull-commit self-test] planted red: one extra dropped cheat {extra} gives {fp_bad} ≠ {side['fingerprint_removed']} — refused")
    # a cull result whose kept_final disagrees is refused
    bad = json.loads(json.dumps(cull)); bad["kept_final"] = bad["kept_final"][:-1]
    try:
        compose(obj, removed, bad); raise AssertionError("a disagreeing kept_final was accepted")
    except AssertionError as ex:
        assert "kept_final" in str(ex)
    print("[cull-commit self-test] a cull result whose kept set disagrees with the drops is REFUSED; all green")


if __name__ == "__main__":
    main()
