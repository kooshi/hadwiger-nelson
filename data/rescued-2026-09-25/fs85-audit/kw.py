import re,sys
T=open('/home/kooshi/source/library/notes/polymath16-threads-1-18-text.txt',encoding='utf-8').read()
threads=re.split(r'########## pm/(\d\d)\.txt',T)
# threads: ['', '01', text, '02', text...]
pat=re.compile(sys.argv[1],re.I); w=int(sys.argv[2]) if len(sys.argv)>2 else 300; cap=int(sys.argv[3]) if len(sys.argv)>3 else 30
only=sys.argv[4].split(',') if len(sys.argv)>4 else None
n=0
for i in range(1,len(threads),2):
    t=threads[i]; s=threads[i+1]
    if only and t not in only: continue
    for m in pat.finditer(s):
        n+=1
        if n>cap: break
        print(f"[{t} @{m.start()}] ...{s[max(0,m.start()-w):m.end()+w]}...\n")
print("matches shown", min(n,cap), "of", n if n<=cap else ">"+str(cap))
