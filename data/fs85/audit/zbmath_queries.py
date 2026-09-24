"""FS-85 input audit, task A3: the prior-art queries run against the zbMATH Open API (WORKFLOW 3.2 item 8).

Each query is in the discipline's words (never this project's coined vocabulary).  The script prints, per query, the hit
count and every hit's year, authors, title, source, and whether its text is a reviewer's review or an author's summary
(an author's summary is a claim, never a reading).  A negative measures the query's words (G21).
Run:  python3 zbmath_queries.py [--full]      (network; the raw JSON is written to $ZB_OUT or ./zbmath-raw/)
"""
import json, os, sys, urllib.error, urllib.parse, urllib.request

API = "https://api.zbmath.org/v1/document/_search"
QUERIES = [
    # A3.1/A3.2: periodicity of all colourings of a lattice-like unit-distance graph
    ('periodic colourings, unit distance', 'ab:"unit distance" & ab:"periodic" & ab:"color*"'),
    ('periodic colourings, chromatic number of the plane', 'ab:"chromatic number of the plane" & ab:"periodic"'),
    ('periodic, 4-colourings', 'ab:"periodic" & ab:"4-coloring*"'),
    ('colourings of a lattice, all periodic', 'ab:"colorings" & ab:"lattice" & ab:"periodic" & cc:05C15'),
    ('frozen colourings', 'ab:"frozen" & ab:"coloring*"'),
    ('frozen, Z^d, homomorphisms', 'ab:"frozen" & ab:"Z^d"'),
    ('proper colourings of Z^d', 'ab:"proper colorings" & ab:"Z^d"'),
    ('colourings of Z^d, periodic', 'ab:"colorings" & ab:"Z^d" & ab:"periodic"'),
    ('hom-shift, periodic points', 'ab:"hom-shift*"'),
    ('Hubai', 'au:"Hubai, Tamas"'),
    ('Hubai (accent)', 'au:"Hubai, Tamás"'),
    ('Parts', 'au:"Parts, Jaan"'),
    ('Mixon, all', 'au:"Mixon, Dustin G."'),
    ('Gibbs, Philip, chromatic', 'au:"Gibbs, Philip*" & ab:"chromatic"'),
    ('Polymath, Hadwiger-Nelson', 'au:"Polymath" & ab:"chromatic"'),
    ('Moser spindle ring / ring colourings', 'ab:"unit distance" & ab:"ring" & ab:"coloring*"'),
    # A3.3: triangle-free uniquely colourable circulants / Cayley graphs for every k
    ('uniquely colorable circulant', 'ab:"uniquely" & ab:"colorable" & ab:"circulant*"'),
    ('uniquely colorable Cayley graph', 'ab:"uniquely" & ab:"colorable" & ab:"Cayley"'),
    ('uniquely colorable triangle-free', 'ab:"uniquely" & ab:"colorable" & ab:"triangle-free"'),
    ('uniquely colorable, girth / short cycles', 'ab:"uniquely" & ab:"colorable" & (ab:"girth" | ab:"short cycles")'),
    ('uniquely colourable (British)', 'ab:"uniquely colourable"'),
    ('Nesetril, uniquely colorable', 'au:"Nesetril, Jaroslav" & ab:"uniquely"'),
    ('uniquely k-colorable, cycles', 'ti:"uniquely colorable" | ti:"uniquely colourable" | ti:"uniquely k-colorable"'),
    # A3.4: distance graphs on Z (and circulants) with forced pairs / unique colouring up to period
    ('distance graph on integers, chromatic number, unique', 'ab:"distance graph*" & ab:"integers" & ab:"unique*"'),
    ('distance graph, triangle-free, chromatic 4', 'ab:"distance graph*" & ab:"triangle-free"'),
    ('distance graph, periodic colouring', 'ab:"distance graph*" & ab:"periodic" & ab:"color*"'),
    ('circulant, uniquely, chromatic', 'ab:"circulant" & ab:"chromatic" & ab:"unique*"'),
    ('Sidon set, distance graph', 'ab:"distance graph*" & ab:"Sidon"'),
    ('Mycielski, distance graph / circulant', 'ab:"Mycielski*" & (ab:"distance graph*" | ab:"circulant*" | ab:"Cayley")'),
    # A3.3 follow-up: the input the product route needs -- triangle-free circulants / abelian Cayley graphs of large chromatic number
    ('circulant, triangle-free', 'ab:"circulant*" & ab:"triangle-free"'),
    ('Cayley, abelian, triangle-free, chromatic', 'ab:"Cayley graph*" & ab:"triangle-free" & ab:"chromatic number"'),
    ('Cayley, abelian, girth, chromatic', 'ab:"Cayley graph*" & ab:"abelian" & ab:"girth" & ab:"chromatic"'),
    ('every graph an induced subgraph of a circulant', 'ab:"induced subgraph" & ab:"circulant*"'),
    ('uniquely colorable, direct product', 'ab:"uniquely" & ab:"colorable" & (ab:"direct product" | ab:"categorical product" | ab:"tensor product")'),
    ('Greenwell-Lovasz, product colouring', 'au:"Greenwell, D*" & au:"Lovasz, L*"'),
    # A3.4 follow-up: sum-free (triangle-free) integer distance graphs, their colourings and uniqueness
    ('distance graph, sum-free', 'ab:"distance graph*" & ab:"sum-free"'),
    ('integer distance graph, chromatic number', 'ab:"integer distance graph*" & ab:"chromatic"'),
    ('distance graph, uniquely', 'ab:"distance graph*" & ab:"uniquely"'),
    ('circulant, forced / all colourings periodic', 'ab:"circulant*" & ab:"colorings" & ab:"all"'),
]


def run(q, n=100):
    """zbMATH answers a query with no hits by HTTP 404 and 'No results found' in the body: read that as zero hits."""
    url = API + "?" + urllib.parse.urlencode({"search_string": q, "results_per_page": n})
    try:
        with urllib.request.urlopen(url, timeout=90) as r:
            return json.load(r)
    except urllib.error.HTTPError as e:
        body = json.loads(e.read().decode())
        if e.code == 404 and "No results found" in body.get("status", {}).get("internal_code", ""):
            return {"result": [], "status": body.get("status")}
        raise


def show(d, full=False):
    res = d.get("result") or []
    for x in res:
        au = "; ".join(a["name"] for a in x["contributors"]["authors"])[:70]
        kind = ",".join(c.get("contribution_type", "?") for c in x.get("editorial_contributions", [])) or "none"
        print(f"   {x.get('year')}  {au}  |  {x['title']['title'][:110]}  |  {x['source']['source'][:60]}  [{kind}]  {x['zbmath_url']}")
        if full:
            for c in x.get("editorial_contributions", []):
                print("        " + c.get("text", "")[:600].replace("\n", " "))
    return len(res)


if __name__ == "__main__":
    full = "--full" in sys.argv
    out = os.environ.get("ZB_OUT", "zbmath-raw")
    os.makedirs(out, exist_ok=True)
    for i, (name, q) in enumerate(QUERIES):
        try:
            d = run(q)
        except Exception as e:
            print(f"[{i:02d}] {name}: QUERY FAILED ({e})   {q}")
            continue
        json.dump(d, open(os.path.join(out, f"q{i:02d}.json"), "w"))
        res = d.get("result") or []
        print(f"[{i:02d}] {name}: {len(res)} hit(s)   {q}")
        show(d, full)
