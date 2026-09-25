#!/usr/bin/env python3
"""J17 stage 1: the zbMATH discovery gate J04 could not finish (HTTP 502 after one query).

Runs each query against the zbMATH Open API, saves the raw JSON beside this script, and prints
one line per query: HTTP status, total hits, and each hit's Zbl number, year and title.
A 404 with "No results found" is a genuine zero; any other non-200 is reported as a failure,
never as a zero (the gate's own failure mode: a failed query reading as an empty one).
"""
import json
import subprocess
import sys
import time
from pathlib import Path

HERE = Path(__file__).resolve().parent
API = "https://api.zbmath.org/v1/document/_search"

QUERIES = [
    # control: J04's one answered query (2 hits recorded in plans/M2-kernel-lane.md §2.3)
    ("Q0-control", 'ab:"chromatic number" & ab:"plane" & ab:"algebraic" & ab:"de Bruijn"'),
    # the seven that returned HTTP 502 for J04
    ("Q1", 'ab:"unit distance" & ab:"real closed"'),
    ("Q2", 'ab:"chromatic number of the plane" & ab:"number field"'),
    ("Q3", 'ab:"unit distance graph" & ab:"algebraic numbers"'),
    ("Q4", 'ab:"chromatic number" & ab:"real algebraic" & ab:"plane"'),
    ("Q5", 'ab:"chromatic number" & ab:"subfield" & ab:"plane"'),
    ("Q6", 'ab:"specialization" & ab:"unit distance"'),
    ("Q7", 'ab:"real place" & ab:"chromatic"'),
    # the brief's additions
    ("Q8-madore", 'au:"Madore, David"'),
    ("Q9-rag", 'ab:"real closed" & ab:"chromatic number"'),
    # extra, cheap: the other real-algebraic-geometry wordings, and the posers' own words
    ("Q10-rag", 'ab:"Tarski" & ab:"chromatic number"'),
    ("Q11-rag", 'ab:"real algebraic numbers" & ab:"unit distance"'),
    ("Q12-poser", 'ab:"chromatic number" & ab:"finitely generated" & ab:"extension"'),
    ("Q13-benda-perles", 'an:0951.05037'),
    ("Q14-fischer1990", 'an:0703.05018 | ti:"Additive k-colorable extensions of the rational plane"'),
]


def run(tag: str, q: str) -> None:
    out = HERE / f"{tag}.json"
    cmd = [
        "curl", "-sS", "-G", "--max-time", "60", "-o", str(out), "-w", "%{http_code}",
        API, "--data-urlencode", f"search_string={q}", "--data-urlencode", "results_per_page=100",
    ]
    code = subprocess.run(cmd, capture_output=True, text=True).stdout.strip()
    try:
        data = json.loads(out.read_text())
    except Exception as e:  # a non-JSON body is a failure, never a zero
        print(f"{tag}\tHTTP {code}\tFAILED (body not JSON: {e})\t{q}")
        return
    status = data.get("status", {})
    if code == "404" and "No results" in str(status.get("internal_code", "")):
        print(f"{tag}\tHTTP 404\t0 hits (genuine zero)\t{q}")
        return
    if code != "200":
        print(f"{tag}\tHTTP {code}\tFAILED ({status})\t{q}")
        return
    res = data.get("result") or []
    total = status.get("nr_total_results")
    print(f"{tag}\tHTTP 200\t{total} hits\t{q}")
    for r in res:
        zbl = (r.get("identifier") or "")
        year = r.get("year")
        title = (r.get("title") or {}).get("title") if isinstance(r.get("title"), dict) else r.get("title")
        src = ""
        try:
            src = r["source"]["series"][0]["title"] if r.get("source", {}).get("series") else ""
        except Exception:
            pass
        print(f"\t{zbl}\t{year}\t{title}\t{src}")


if __name__ == "__main__":
    only = set(sys.argv[1:])
    for tag, q in QUERIES:
        if only and tag not in only:
            continue
        run(tag, q)
        time.sleep(1.5)
