#!/usr/bin/env python3
"""FS131-OL1: the landing tree's vacuity scan against `main`'s gated scan, row for row, with the new rows read as OPEN's.

The landing adds one module, `Plane/ValidMap/OpenMove`, and removes nothing of `main`'s. So:

  * every SITE and EVIDENCE row of `main`'s scan must be in the landing scan (LOST otherwise);
  * every row the landing scan adds must belong to a declaration of `OpenMove` — a name the file declares (QA1's `qualified_decls`,
    imported, never copied) or one generated under such a name (NOT OPEN'S otherwise);
  * no added SITE row may read VACUOUS, STALE or UNKNOWN (FLAGGED: the brief's stop — such a site goes to the coordinator, never to
    the baseline), and no EVIDENCE row is expected (OpenMove states no closed `Nonempty`, `IsEmpty` or `¬ P` theorem), so an added
    one is printed and counted, and fails only under `--no-evidence`.

Prints the added rows, their tally by verdict and carrier head, and the nine counts of both scans with their differences.

Usage: fs131_ol_vacdiff.py <main log> <landing log> [--no-evidence]
       fs131_ol_vacdiff.py --plant <main log> <landing log>   in memory: one main row dropped from the landing view, one row of a
                                                               non-OPEN declaration added, one OPEN row added reading UNKNOWN;
                                                               must exit 1 naming all three
Exit 0 when every check holds; 1 otherwise; 2 when a log holds no SITE row or no accounting line.
"""
import collections
import pathlib
import re
import sys

sys.path.insert(0, str(pathlib.Path(__file__).resolve().parent))
from fs131_qa1_dupes import qualified_decls  # noqa: E402

ROOT = pathlib.Path(__file__).resolve().parents[1]
OPENMOVE = ROOT / "Proofs/HadwigerNelson/Plane/ValidMap/OpenMove.lean"
COUNTS = ("declarations", "refutations-skipped", "sites", "vacuous", "stale", "declared", "witnessed", "generic", "unknown")


def read(path):
    rows, counts = collections.Counter(), {}
    for ln in open(path, encoding="utf-8"):
        ln = ln.rstrip("\n")
        if ln.startswith("SITE ") or ln.startswith("EVIDENCE "):
            rows[ln] += 1
        elif ln.startswith("=== SCANNED === ") or ln.startswith("=== TOTALS === "):
            counts.update({k: int(v) for k, v in re.findall(r"([\w-]+)=(\d+)", ln)})
    return rows, counts


def name_of(row):
    return row.split(" :: ")[0].split()[2]


def main(argv):
    plant = "--plant" in argv
    no_evidence = "--no-evidence" in argv
    a = [x for x in argv if not x.startswith("--")]
    if len(a) != 2:
        print(__doc__)
        return 2
    (mainrows, maincounts), (landing, landcounts) = read(a[0]), read(a[1])
    for label, rows, counts in (("main", mainrows, maincounts), ("landing", landing, landcounts)):
        if not rows or any(k not in counts for k in COUNTS):
            print(f"UNREADABLE: the {label} log holds {sum(rows.values())} row(s) and counts {sorted(counts)}")
            return 2
    ours = {q for q, _ in qualified_decls(OPENMOVE.read_text())}
    if plant:
        victim = sorted(mainrows)[0]
        landing = landing.copy()
        landing[victim] -= 1
        landing["SITE GENERIC HadwigerNelson.Plane.ArcMap.exists_shave_aux :: F.Valid"] += 1
        landing["SITE UNKNOWN HadwigerNelson.Plane.ArcMap.exists_open :: F.Valid"] += 1
    bad = 0
    lost = mainrows - landing
    for r in sorted(lost):
        print("LOST", r)
        bad += 1
    added = landing - mainrows
    tally = collections.Counter()
    for r in sorted(added):
        n = name_of(r)
        kind, verdict = r.split()[0], r.split()[1]
        if not (n in ours or any(n.startswith(q + ".") for q in ours)):
            print("NOT OPEN'S", r)
            bad += 1
            continue
        print("added", r)
        if kind == "SITE" and verdict in ("VACUOUS", "STALE", "UNKNOWN"):
            print("FLAGGED", r)
            bad += 1
        if kind == "EVIDENCE" and no_evidence:
            print("UNEXPECTED EVIDENCE", r)
            bad += 1
        carrier = r.split(" :: ")[1] if " :: " in r else ""
        head = re.sub(r"^\(?[\w.₀-₉']+\.(\w+)\b.*$", r"\1", carrier) if kind == "SITE" else ""
        tally[(kind, verdict, head)] += added[r]
    print(f"main rows {sum(mainrows.values())}, landing rows {sum(landing.values())}, lost {sum(lost.values())}, "
          f"added {sum(added.values())} ({len(ours)} names declared in OpenMove)")
    for (kind, verdict, head), c in sorted(tally.items()):
        print(f"  added {kind} {verdict} on {head or '(evidence)'}: {c}")
    for k in COUNTS:
        print(f"  {k}: {maincounts[k]} -> {landcounts[k]} ({landcounts[k] - maincounts[k]:+d})")
    print("vacdiff:", "PASS" if not bad else f"FAIL ({bad})")
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
