import json, sys, urllib.parse, urllib.request
def get(url):
    req = urllib.request.Request(url, headers={"User-Agent": "lean-dir mailto:none@example.com"})
    with urllib.request.urlopen(req, timeout=60) as r: return json.load(r)
def abstract(w):
    inv = w.get("abstract_inverted_index") or {}
    pos = sorted((p, t) for t, ps in inv.items() for p in ps)
    return " ".join(t for _, t in pos)
# find Berend 1984 TAMS
d = get("https://api.openalex.org/works?search=" + urllib.parse.quote("Multi-invariant sets on compact abelian groups") + "&per-page=3")
for w in d["results"]:
    print(w["id"], w.get("publication_year"), w["title"], w.get("cited_by_count"))
bid = d["results"][0]["id"].split("/")[-1]
c = get(f"https://api.openalex.org/works?filter=cites:{bid}&per-page=100&select=id,title,publication_year,abstract_inverted_index,authorships")
print("citers:", c["meta"]["count"])
for w in sorted(c["results"], key=lambda w: w["publication_year"] or 0):
    au = ", ".join(a["author"]["display_name"] for a in w["authorships"][:3])
    ab = abstract(w)
    print(f"- {w['publication_year']} | {au} | {w['title']}")
    if any(k in (w['title'] or '').lower()+ab.lower() for k in ["s-adic","solenoid","minimal","isometr","compact factor","rotation","non-expansive","nonexpansive","invariant set","closed invariant","orbit closure"]):
        print("    ABS:", ab[:700])
