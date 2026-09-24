"""numpy view of the census: colourings as arrays over O_E/8 (index = 512a+64b+8c+d for 9z = a+b zeta+c w+d zeta w mod 8)."""
import numpy as np, itertools
from census import *
IDX=np.arange(4096)
DIG=np.stack([(IDX>>9)&7,(IDX>>6)&7,(IDX>>3)&7,IDX&7],axis=1)
def kidx(k): return ((k[0]%8)<<9)|((k[1]%8)<<6)|((k[2]%8)<<3)|(k[3]%8)
def shift_idx(k):
    D=(DIG+np.array(k))%8
    return (D[:,0]<<9)|(D[:,1]<<6)|(D[:,2]<<3)|D[:,3]
def arr(s):
    m=colouring_map(s); a=np.zeros(4096,dtype=np.int8)
    for k,v in m.items(): a[kidx(k)]=v
    return a
_SH={}
def sh(k):
    k=tuple(x%8 for x in k)
    if k not in _SH: _SH[k]=shift_idx(k)
    return _SH[k]
