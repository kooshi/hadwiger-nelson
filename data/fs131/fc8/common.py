# FS131-FC8: shared helpers (whitespace-flexible slot matching, as the target files wrap lines).
import re, os
R = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "..", "..")) + "/"
_cache = {}
def rd(p):
    if p not in _cache: _cache[p] = open(R + p).read()
    return _cache[p]
def flat(s): return re.sub(r"\s+", " ", s).strip()
def pat(s): return r"[\s>]+".join(re.escape(t) for t in s.split())
def count(path, s): return len(re.findall(pat(s), rd(path)))
def find(path, s): return [m for m in re.finditer(pat(s), rd(path))]
