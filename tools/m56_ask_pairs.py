#!/usr/bin/env python3
"""M56: ask the solver about `candidates_for_ask` from an additive `forced` record — the jackpot protocol
(five_dial.pair_ask, polarity 'eq': UNSAT ⟹ forced equal). A HIT is re-asked under a second encoding
(shuffled vertex order); a confirmed hit writes data/m56/JACKPOT-<stage>.json and exits 3. Refutations carry
their verified separating colouring's fingerprint only (the colourings are re-derivable).

    python3 tools/m56_ask_pairs.py data/m56/forced-heule510-k5.json --heule510 --wall 300
"""
import sys, json, time, argparse, hashlib
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
import additive as AD
from five_dial import pair_ask

ap = argparse.ArgumentParser(); ap.add_argument("record"); ap.add_argument("--wall", type=float, default=300.0); ap.add_argument("--out")
ap.add_argument("--seed", action="store_true"); ap.add_argument("--object"); ap.add_argument("--witness"); ap.add_argument("--heule510", action="store_true")
ap.add_argument("--degrey", action="store_true"); ap.add_argument("--field16"); ap.add_argument("--graph"); ap.add_argument("--planted")
a = ap.parse_args()
rec = json.loads(Path(a.record).read_text()); ch = AD.load_chunk(a)
assert rec["stage"]["fingerprint"] == ch.fingerprint(), ("the record is for another stage", rec["stage"]["fingerprint"], ch.fingerprint())
k = rec["k"]; cands = [tuple(p) for p in rec["candidates_for_ask"]]
print(f"[ask] {ch.label()} k={k}: {len(cands)} forced-additively candidates, wall {a.wall}s each", flush=True)
out = dict(kind="additive-ask", stage=ch.header(), k=k, record=a.record, wall=a.wall, asked=len(cands), results=[], hits=[], unknown=[])
t0 = time.time()
for i, (p, q) in enumerate(cands):
    st, col = pair_ask(ch.n, ch.edges, k, p, q, "eq", wall=a.wall)
    row = dict(pair=[p, q], verdict=st)
    if st == "refuted":
        row["colouring_sha"] = hashlib.sha256(json.dumps(col).encode()).hexdigest()[:16]
    elif st == "HIT":
        st2, _ = pair_ask(ch.n, ch.edges, k, p, q, "eq", wall=a.wall, shuffle_seed=12345)
        row["second_encoding"] = st2
        if st2 == "HIT":
            print("\n" + "!" * 78 + f"\nJACKPOT CANDIDATE: pair ({p}, {q}) forced equal at k={k} on {ch.label()} in TWO encodings — HALT AND VERIFY\n" + "!" * 78, flush=True)
            out["hits"].append(row)
    else:
        out["unknown"].append(row)
    out["results"].append(row)
    if (i + 1) % 10 == 0 or i + 1 == len(cands):
        print(f"[ask] {i + 1}/{len(cands)}: refuted {sum(r['verdict'] == 'refuted' for r in out['results'])}, hits {len(out['hits'])}, unknown {len(out['unknown'])} [{time.time() - t0:.0f}s]", flush=True)
out["seconds"] = round(time.time() - t0, 1)
out["claim_scope"] = "each candidate asked once (polarity eq: a proper k-colouring separating the pair exists?) with a wall; 'refuted' = a verified separating colouring exists (the pair is NOT forced); 'HIT' in two encodings = a jackpot candidate to verify by hand; 'unknown' = the wall"
path = Path(a.out) if a.out else AD.DATA / (("JACKPOT-" if out["hits"] else "ask-") + f"{ch.name}-k{k}.json")
path.write_text(json.dumps(out, indent=1)); print(f"[ask] wrote {path}")
sys.exit(3 if out["hits"] else 0)
