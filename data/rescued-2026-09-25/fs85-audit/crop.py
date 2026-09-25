"""Crop Table 4 images of [Parts2020hv] into zoomed row strips for reading by eye (scratch only)."""
import sys
from PIL import Image
import numpy as np
S='/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs85-audit/'
def rows(f):
    im=np.asarray(Image.open(S+'img/'+f).convert('L'))
    white=(im>245).mean(axis=1)>0.97
    # row bands = maximal runs of non-white lines
    bands=[];start=None
    for y,w in enumerate(white):
        if not w and start is None: start=y
        if w and start is not None:
            if y-start>40: bands.append((start,y))
            start=None
    if start is not None and len(white)-start>40: bands.append((start,len(white)))
    return bands
if __name__=='__main__':
    f=sys.argv[1]
    b=rows(f)
    if len(sys.argv)==2: print(f,len(b),b); sys.exit()
    r0,r1,scale=int(sys.argv[2]),int(sys.argv[3]),float(sys.argv[4])
    im=Image.open(S+'img/'+f)
    y0=b[r0][0]-3; y1=b[r1][1]+3
    c=im.crop((0,y0,im.size[0],y1)); c=c.resize((int(c.size[0]*scale),int(c.size[1]*scale)),Image.LANCZOS)
    out=S+'strip.png' if len(sys.argv)<6 else S+sys.argv[5]
    c.save(out); print(out,c.size)
