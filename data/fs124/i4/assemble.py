#!/usr/bin/env python3
"""FS124-I4 (iteration only, never evidence): write a scratch file = the helper module as it stands under Proofs/ + the
part files given, inside its namespace, so that `lean1.sh` can check new text before it is moved into the module.
  assemble.py <out.lean> <part.txt> [<part.txt> …]"""
import pathlib, sys
ROOT = pathlib.Path(__file__).resolve().parents[3]
h = (ROOT / "Proofs/HadwigerNelson/Plane/ClosePairWitness.lean").read_text()
marker = "\nend HadwigerNelson.Plane\n"
assert h.endswith(marker)
body = h[:-len(marker)]
for part in sys.argv[2:]:
    body += pathlib.Path(part).read_text()
pathlib.Path(sys.argv[1]).write_text(body + marker)
print(f"wrote {sys.argv[1]}: helper {len(h.splitlines())} lines + {len(sys.argv) - 2} part(s)")
