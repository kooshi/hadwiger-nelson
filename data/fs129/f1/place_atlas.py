import re,subprocess,itertools,sys
F='/home/kooshi/source/lean-dir-fs129-close/tools/viz_proof_atlas_facts.py'
orig=open(F,encoding='utf-8').read()
def setpos(s,i,x,y):
    pat=re.compile(r'(N\("%s",.*?at=\()\d+, \d+(\))'%i,re.S)
    assert len(pat.findall(s))==1
    return pat.sub(lambda m:m[1]+'%d, %d'%(x,y)+m[2],s,count=1)
def lint(s):
    open(F,'w',encoding='utf-8').write(s)
    r=subprocess.run(['python3',F],capture_output=True,text=True,cwd='/home/kooshi/source/lean-dir-fs129-close')
    out=r.stdout+r.stderr
    return [l for l in out.split('\n') if 'overlap' in l or 'covers' in l], out
cur=orig
for nid,xr,yr in (('QFREE',range(30,100,6),range(380,610,10)),('QPRUNE',range(20,100,6),range(380,610,10)),('TOP5',range(120,180,6),range(380,470,6))):
    best=None
    for x,y in itertools.product(xr,yr):
        t=setpos(cur,nid,x,y); ls,_=lint(t)
        mine=[l for l in ls if nid in l]
        if not mine:
            # tie-break: closest to original
            best=(x,y); 
            o=re.search(r'N\("%s",.*?at=\((\d+), (\d+)\)'%nid,cur,re.S); ox,oy=int(o[1]),int(o[2])
            d=(x-ox)**2+(y-oy)**2
            if 'bd' not in locals() or bd[0]!=nid or d<bd[1]: bd=(nid,d,x,y)
    print(nid,bd); cur=setpos(cur,nid,bd[2],bd[3])
ls,out=lint(cur); print(out[-400:])
