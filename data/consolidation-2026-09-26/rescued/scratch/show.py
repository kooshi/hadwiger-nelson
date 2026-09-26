import re,sys
t=open('/home/kooshi/source/lean-dir/CLAUDE.md',encoding='utf-8').read()
def rx(s): return r"\s+".join(re.escape(w) for w in s.split())
for a in sys.argv[1:]:
    ms=list(re.finditer(rx(a),t))
    print(f"== {a[:50]!r}: {len(ms)} match(es)")
    for m in ms[:2]:
        print(t[max(0,m.start()-150):m.end()+250].replace("\n","⏎"))
