import re
def wsr(s, old, new, count=1):
    """replace old in s, matching any whitespace run in old against any whitespace run in s"""
    toks=old.split()
    pat=r'\s+'.join(re.escape(t) for t in toks)
    ms=list(re.finditer(pat,s))
    assert len(ms)==count,(len(ms),old[:80])
    return s[:ms[0].start()]+new+s[ms[0].end():]
