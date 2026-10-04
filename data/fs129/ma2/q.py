"""FS129-MA2 reading helper (no judgement): mention contexts and content greps over data/fs129/index/theorems.jsonl.
usage: q.py ctx G<n>            -- each entry mentioning G<n>, with 100 chars of context around the first mention
       q.py grep <regex> [A|R]  -- entries whose statement or not_claimed matches regex (case-insensitive), era-filtered
       q.py show <id>           -- an entry's key fields
"""
import json, re, sys
recs = [json.loads(l) for l in open("data/fs129/index/theorems.jsonl")][1:]
by = {r["id"]: r for r in recs}
cmd = sys.argv[1]
if cmd == "ctx":
    g = sys.argv[2]
    pat = re.compile(r".{0,110}\b" + g + r"\b.{0,110}", re.S)
    for r in recs:
        gn = int(g[1:])
        if gn in (r.get("mentions_grokkings") or []) or gn in (r.get("grokkings") or []) or gn in (r.get("uses_grokkings") or []):
            txt = " ".join(str(r.get(k) or "") for k in ("statement","not_claimed","uses_raw","rests_text","model","handoff","title"))
            m = pat.search(txt)
            print(f"{r['id']} [{r['era']}] :: " + (m.group(0).replace("\n"," ") if m else "(mention not in indexed fields)"))
elif cmd == "grep":
    rx = re.compile(sys.argv[2], re.I)
    era = sys.argv[3] if len(sys.argv) > 3 else None
    n = 0
    for r in recs:
        if era and r["era"] != era: continue
        txt = (r.get("statement") or "") + " || " + (r.get("not_claimed") or "")
        if rx.search(txt):
            n += 1
            print(f"{r['id']} [{r['era']}] {r['file']}:{r['line']} :: {(r.get('statement') or '')[:260]}")
    print("hits:", n)
elif cmd == "show":
    r = by[sys.argv[2]]
    for k in ("id","era","file","line","title","statement","not_claimed","uses_raw","grade","minds","verdict","rests_text","handoff","n_dependents_transitive"):
        print(f"{k}: {r.get(k)}")
