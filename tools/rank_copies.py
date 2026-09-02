#!/usr/bin/env python3
"""rank_copies — the composition ranking by TWO enumerations (M52 §Bʹ item 2, phase 3): for one
batch B, the classes of a composed object are a subset of the plain object's, and a plain class
absent from the composed list is KILLED by the copies (no extension exists). So the kill mass of
each composition is `1 − |S_comp(B)| / |S_plain(B)|`, exact, and the per-class kill masks are the set
differences — with no pool export, no tiers, no unknowns (both lists must be EXACT).

    python3 tools/rank_copies.py --plain <plain classes.jsonl> --composed <label>=<classes.jsonl> ...

Also the set-cover read across compositions (which classes each kills that the others do not) and
the hitting set of the SURVIVORS on each composed object over B (the kept cheats if B were the
whole cull batch) — the dial reading per composition on this batch. Writes
`data/m52/rank-<batch tag>.json`. UNTRUSTED like all of tools/; a composed list that is NOT a subset
of the plain one is a loud refusal (the projections are canonical per stage — a mismatch means the
two enumerations were not over the same live block or batch)."""
from __future__ import annotations
import argparse, json, sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
from cull_enum import hitting_set

OUT = Path(__file__).resolve().parent.parent / "data" / "m52"


def load(path):
    lines = Path(path).read_text().splitlines()
    head = json.loads(lines[0]); body = [json.loads(l) for l in lines[1:]]
    body = [s for s in body if isinstance(s, str)]
    summ_path = Path(path).with_name("enumerate.json")
    summ = json.loads(summ_path.read_text()) if summ_path.exists() else {}
    return head, set(body), summ


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--plain", required=True); ap.add_argument("--composed", nargs="+", required=True)
    ap.add_argument("--batch", required=True, help="u-v,u-v,… the batch B (must equal each list's new cheats)")
    a = ap.parse_args()
    B = [tuple(int(x) for x in e.split("-")) for e in a.batch.split(",")]
    hp, Sp, sump = load(a.plain)
    assert sump.get("claim") == "exact", "the plain list must be EXACT"
    print(f"[rank] plain: {len(Sp)} classes (exact), batch {a.batch}", flush=True)
    rows = {}
    masks_plain = {s: frozenset(j for j, (u, v) in enumerate(B) if s[u] == s[v]) for s in Sp}
    for spec in a.composed:
        name, path = spec.split("=", 1)
        h, Sc, summ = load(path)
        assert summ.get("claim") == "exact", f"{name}: the composed list must be EXACT (claim {summ.get('claim')!r})"
        extra = Sc - Sp
        if extra:
            raise SystemExit(f"[rank] REFUSED {name}: {len(extra)} composed classes are NOT plain classes — the enumerations disagree on the stage (live block / batch / canonicalization)")
        killed = Sp - Sc
        K, method = hitting_set(sorted(set(masks_plain[s] for s in Sc), key=len), len(B)) if Sc else ([], "empty")
        rows[name] = dict(classes=len(Sc), killed=len(killed), kill_fraction=round(1 - len(Sc) / len(Sp), 4),
                          survivors_hitting_set=[list(B[j]) for j in K], kept_if_batch=len(K), method=method,
                          points=summ.get("width"))
        print(f"[rank] {name}: {len(Sc)} classes survive of {len(Sp)} → kill fraction {rows[name]['kill_fraction']:.4f}; "
              f"hitting set of the survivors over B: keep {len(K)} of {len(B)} ({method})", flush=True)
    # the set-cover read: unique kills per composition
    survivors = {name: set(load(spec.split('=', 1)[1])[1]) for name, spec in ((s.split('=', 1)[0], s) for s in a.composed)}
    for name in rows:
        others = set.intersection(*[survivors[o] for o in rows if o != name]) if len(rows) > 1 else Sp
        unique = (others - survivors[name])
        rows[name]["unique_kills_vs_others"] = len(unique)
    tag = a.batch.replace(",", "_")[:60]
    out = dict(kind="rank-copies", batch=[list(e) for e in B], plain_classes=len(Sp), rows=rows,
               claim_scope="exact set differences of exact class lists; kill = no extension to the composed object exists")
    OUT.mkdir(parents=True, exist_ok=True)
    (OUT / f"rank-{tag}.json").write_text(json.dumps(out, indent=1))
    print(f"[rank] wrote {OUT / ('rank-' + tag + '.json')}")


if __name__ == "__main__":
    main()
