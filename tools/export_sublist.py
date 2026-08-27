#!/usr/bin/env python3
"""Export the COMMITTABLE class sub-list as a standalone class-list jsonl for the descent engine.

Mirrors `run_design` exactly: S_commit = filter_sub(obj, cols, keep) over the tag's full
separating-colouring list, with keep/commit read from the tag's hitting-set file. The header keeps
the full list's enumeration fields (same object, same order) and replaces `batch` with the COMMIT
edges — the convention WO-5 §7.3 reads (ladder centres = object `removed` ∪ header `batch`); its
`stage_fingerprint` is obj.fingerprint(removed + commit), the object these colourings are proper
on. Class lines are copied verbatim from the source list (already JSON-encoded digit strings).

Usage: python3 tools/export_sublist.py <object-label> <tag>
  e.g. python3 tools/export_sublist.py S29-depth2r-it2v2-depth1 S29-depth2r-it2v2-depth1-it2v2
"""
import hashlib, json, sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
import batchkill as bk

label, tag = sys.argv[1], sys.argv[2]
obj, removed = bk.load_object(label)
src = bk.BUILD / f"m50-S-{tag}.jsonl"
hit = json.loads((bk.BUILD / f"m50-hitting-{tag}.json").read_text())
keep = [tuple(e) for e in hit["keep"]]
commit = [tuple(e) for e in hit["commit"]]
lines = src.read_text().splitlines()
header = json.loads(lines[0])
assert header["kind"] == "enumeration-header"
body = lines[1:]
cols = [[int(ch) for ch in json.loads(line)] for line in body]
sub_idx = [i for i, c in enumerate(cols) if all(c[a] != c[b] for a, b in keep)]
assert len(sub_idx) == len(bk.filter_sub(obj, cols, keep)), "filter mismatch"
out_header = dict(header)
out_header["batch"] = [list(e) for e in commit]
out_header["stage_fingerprint"] = obj.fingerprint(list(removed) + commit)
out_header["sub_of"] = {"list": src.name, "list_sha256_16": hashlib.sha256(src.read_bytes()).hexdigest()[:16],
                        "keep": [list(e) for e in keep], "filter": "filter_sub(obj, cols, keep)",
                        "stage_fingerprint_convention": "obj.fingerprint(removed + commit)"}
dst = bk.BUILD / f"m51-Scommit-{tag}.jsonl"
with dst.open("w") as f:
    f.write(json.dumps(out_header) + "\n")
    for i in sub_idx:
        f.write(body[i] + "\n")
print(f"wrote {dst.name}: {len(sub_idx)} classes of {len(cols)}; keep {len(keep)} commit {len(commit)}; "
      f"removed {len(removed)}; sha256 {hashlib.sha256(dst.read_bytes()).hexdigest()[:16]}")
