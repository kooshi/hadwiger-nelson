#!/usr/bin/env python3
"""FS131-L5: the landing tree's vacuity scan against `main`'s gated scan, row for row, and both scans' `declarations=` and
`refutations-skipped=` reconciled module by module (after FS131-OL1's `tools/fs131_ol_vacdiff.py`, which read one module).

Inputs: the two scan logs, and the two outputs of `data/fs131/l5/count-modules.lean` (one `DECL <kind> <module> <name>[ REF]`
line per declaration the scan counts, taken on `main`'s library and on the landing's).

  1. the counter agrees with each scan: its `TOTAL declarations=… refutations=…` equals that scan's `declarations=`,
     `refutations-skipped=` (COUNTER-DISAGREES otherwise) — so the module table below is a table of what the scan counted;
  2. every SITE and EVIDENCE row of `main`'s scan is in the landing scan (LOST otherwise), unless its declaration is gone from
     the landing library (a ruled removal: printed as `gone-with-its-declaration`, and the declaration must be absent from the
     landing's DECL lines — a row lost while its declaration stands is LOST);
  3. every row the landing adds belongs to a declaration that `main`'s library does not hold (NOT NEW otherwise: a declaration of
     `main` gained a row, which a landing that changes no carrier cannot do — unless `--carriers-in H1,H2,…` names the carrier
     heads this landing enters, and the row's carrier has one of those heads);
  4. no added SITE row reads VACUOUS, STALE or UNKNOWN (FLAGGED: the brief's stop — such a site goes to the coordinator);
  5. the nine counts of both scans, their differences, and `declarations` and `refutations-skipped` by module: modules only in the
     landing, modules whose count changed, and the sum, which must equal the scans' difference (MODULE-SUM otherwise).

Prints the added rows' tally by verdict and carrier head, and by module.

Usage: fs131_l5_vacdiff.py MAIN_SCAN LANDING_SCAN MAIN_COUNT LANDING_COUNT [--carriers-in H1,H2] [--rows]
       fs131_l5_vacdiff.py MAIN_SCAN LANDING_SCAN MAIN_COUNT LANDING_COUNT --plant
           in memory: a `main` row dropped though its declaration stands; a row added to a declaration of `main`; an added row of
           a new declaration reading UNKNOWN; the landing's `declarations=` raised by one. Must exit 1 naming all four.
Exit 0 when every check holds; 1 otherwise; 2 when an input cannot be read.
"""
import collections
import re
import sys

COUNTS = ("declarations", "refutations-skipped", "sites", "vacuous", "stale", "declared", "witnessed", "generic", "unknown")


def read_scan(path):
    rows, counts = collections.Counter(), {}
    for ln in open(path, encoding="utf-8"):
        ln = ln.rstrip("\n")
        if ln.startswith("SITE ") or ln.startswith("EVIDENCE "):
            rows[ln] += 1
        elif ln.startswith("=== SCANNED === ") or ln.startswith("=== TOTALS === "):
            counts.update({k: int(v) for k, v in re.findall(r"([\w-]+)=(\d+)", ln)})
    return rows, counts


def read_count(path):
    decls, mods, refs, total = {}, collections.Counter(), collections.Counter(), {}
    for ln in open(path, encoding="utf-8"):
        p = ln.split()
        if ln.startswith("DECL ") and len(p) >= 4:
            decls[p[3]] = (p[1], p[2])
            mods[p[2]] += 1
            if p[-1] == "REF" and len(p) == 5:
                refs[p[2]] += 1
        elif ln.startswith("TOTAL "):
            total = {k: int(v) for k, v in re.findall(r"(\w+)=(\d+)", ln)}
    return decls, mods, refs, total


def name_of(row):
    return row.split(" :: ")[0].split()[2]


def head_of(row):
    """The carrier's head as printed: the last dotted component before the first space, for `F.Valid`, `ArcMap.IsHorn F …`."""
    if " :: " not in row:
        return ""
    c = row.split(" :: ", 1)[1].strip()
    c = re.sub(r" \[by .*\]$", "", c)
    first = c.split()[0].lstrip("(¬")
    return first.split(".")[-1].rstrip(")")


def main(argv):
    plant = "--plant" in argv
    show = "--rows" in argv
    carriers_in = set()
    if "--carriers-in" in argv:
        carriers_in = set(argv[argv.index("--carriers-in") + 1].split(","))
    a = [x for i, x in enumerate(argv) if not x.startswith("--") and (i == 0 or argv[i - 1] != "--carriers-in")]
    if len(a) != 4:
        print(__doc__)
        return 2
    (mrows, mcounts), (lrows, lcounts) = read_scan(a[0]), read_scan(a[1])
    (mdecl, mmods, mrefs, mtot), (ldecl, lmods, lrefs, ltot) = read_count(a[2]), read_count(a[3])
    for label, rows, counts in (("main", mrows, mcounts), ("landing", lrows, lcounts)):
        if not rows or any(k not in counts for k in COUNTS):
            print(f"UNREADABLE: the {label} scan holds {sum(rows.values())} row(s) and counts {sorted(counts)}")
            return 2
    for label, decl, tot in (("main", mdecl, mtot), ("landing", ldecl, ltot)):
        if not decl or "declarations" not in tot:
            print(f"UNREADABLE: the {label} count holds {len(decl)} DECL line(s) and totals {tot}")
            return 2
    if plant:
        lrows = lrows.copy()
        lcounts = dict(lcounts)
        victim = next(r for r in sorted(mrows) if name_of(r) in ldecl)
        lrows[victim] -= 1
        old = next(n for n in sorted(mdecl) if n in ldecl and mdecl[n][0] == "THM")
        lrows[f"SITE GENERIC {old} :: F.Valid"] += 1
        new = next((n for n in sorted(ldecl) if n not in mdecl and ldecl[n][0] == "THM"), None)
        if new is None:
            print("PLANT TARGET ABSENT: the landing library holds no theorem that main's lacks")
            return 2
        lrows[f"SITE UNKNOWN {new} :: F.Valid"] += 1
        lcounts["declarations"] += 1
        print(f"planted: dropped `{victim[:70]}…`; a row on main's `{old}`; an UNKNOWN row on new `{new}`; declarations +1")
    bad = 0
    # 1. the counter against each scan
    for label, tot, counts in (("main", mtot, mcounts), ("landing", ltot, lcounts)):
        ok = tot["declarations"] == counts["declarations"] and tot["refutations"] == counts["refutations-skipped"]
        print(f"counter vs the {label} scan: declarations {tot['declarations']} / {counts['declarations']}, "
              f"refutations {tot['refutations']} / {counts['refutations-skipped']}: {'agree' if ok else 'COUNTER-DISAGREES'}")
        bad += 0 if ok else 1
    # 2. lost rows
    lost = mrows - lrows
    gone = 0
    for r in sorted(lost):
        n = name_of(r)
        if n not in ldecl:
            gone += lost[r]
            print("gone-with-its-declaration", r[:200])
        else:
            print("LOST", r[:200])
            bad += 1
    # 3, 4. added rows
    added = lrows - mrows
    tally, bymod = collections.Counter(), collections.Counter()
    for r in sorted(added):
        n = name_of(r)
        kind, verdict = r.split()[0], r.split()[1]
        head = head_of(r) if kind == "SITE" else "(evidence)"
        owner = n if n in ldecl else next((q for q in (n.rsplit(".", i)[0] for i in range(1, 4)) if q in ldecl), None)
        if n in mdecl and not (head in carriers_in):
            print("NOT NEW", r[:200])
            bad += 1
            continue
        if show:
            print("added", r[:240])
        if kind == "SITE" and verdict in ("VACUOUS", "STALE", "UNKNOWN"):
            print("FLAGGED", r[:240])
            bad += 1
        if kind == "EVIDENCE":
            print("added-evidence", r[:240])
        tally[(kind, verdict, head)] += added[r]
        bymod[(ldecl[owner][1] if owner else "?").replace("Proofs.HadwigerNelson.", "")] += added[r]
    print(f"main rows {sum(mrows.values())}, landing rows {sum(lrows.values())}; lost {sum(lost.values())} "
          f"({gone} with a removed declaration); added {sum(added.values())}")
    for (kind, verdict, head), c in sorted(tally.items()):
        print(f"  added {kind} {verdict} on {head}: {c}")
    for m, c in sorted(bymod.items()):
        print(f"  added rows in {m}: {c}")
    # 5. the counts, and the two library counts by module
    for k in COUNTS:
        print(f"  {k}: {mcounts[k]} -> {lcounts[k]} ({lcounts[k] - mcounts[k]:+d})")
    dsum = rsum = 0
    for m in sorted(set(mmods) | set(lmods)):
        d, r = lmods[m] - mmods[m], lrefs[m] - mrefs[m]
        if d or r or m not in mmods:
            tag = "new module" if m not in mmods else ("gone module" if m not in lmods else "changed")
            print(f"  module {m.replace('Proofs.HadwigerNelson.', '')}: declarations {mmods[m]} -> {lmods[m]} ({d:+d}), "
                  f"refutations {mrefs[m]} -> {lrefs[m]} ({r:+d})  [{tag}]")
        dsum += d
        rsum += r
    okd = dsum == lcounts["declarations"] - mcounts["declarations"]
    okr = rsum == lcounts["refutations-skipped"] - mcounts["refutations-skipped"]
    print(f"  by module: declarations {dsum:+d}, refutations {rsum:+d}: {'equal to the scans difference' if okd and okr else 'MODULE-SUM differs from the scans'}")
    bad += 0 if (okd and okr) else 1
    print("vacdiff:", "PASS" if not bad else f"FAIL ({bad})")
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
