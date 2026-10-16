# FS131-FC8 stage 2: print the table of owed items (data/fs131/fc8/owed.md), every count read from the files by script.
import rows, re, subprocess, collections
from common import *
out = []
cnt = collections.Counter()
def esc(s): return str(s).replace("|", "\\|").replace("\n", " ")
for r in rows.ROWS:
    st = r["status"]
    if st == "ready" and r["cnt"] != 1: st = "CHECK"; r["note"] += f" [demoted by the build: slot occurs {r['cnt']} times]"
    r["status"] = st; cnt[st] += 1
    slot = esc(r["slot"] or "-")
    c = "-" if r["cnt"] is None else str(r["cnt"])
    nb = f" ({len(r['bullets'])} bullets)" if r.get("bullets") else ""
    out.append(f"| {esc(r['id'])} | {esc(r['item'])}{nb} | {esc(r['source'])} | {esc(r['draft'])} | {esc(r['file'] or '-')}: {slot} | {c} | **{st}** | {esc(r['note'])} |")
hdr = "| id | item | source (list; item) | draft's address | slot on `main` (file: words it replaces or follows) | occurrences | status | note |\n|---|---|---|---|---|---|---|---|"
txt = "# FS131-FC8 stage 2 — the table of owed items\n\nBase: `main` at 5af212aca (this branch's parent). Every count below was read from the files by `data/fs131/fc8/build_table.py` (rows in `rows.py`); a `ready` row is one whose draft's text was extracted by script from its record and whose slot occurs exactly once. Rows ordered: the Davies/README drafts, the ledger rows, the closed-questions file, the LEAN.md lines (in the order the stage-3 script files them), the bibliography lines, then the rest.\n\n"
txt += "Counts: " + ", ".join(f"{k} {v}" for k, v in sorted(cnt.items())) + f"  (total {sum(cnt.values())} rows)\n\n" + hdr + "\n" + "\n".join(out) + "\n"
open(R + "data/fs131/fc8/owed.md", "w").write(txt); print(dict(cnt))
