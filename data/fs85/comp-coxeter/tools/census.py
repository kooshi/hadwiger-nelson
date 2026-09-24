"""Read (never recompute) FS-73's committed census of the 380 pinned four-colourings of Lambda/8Lambda, and express each as a
function on O_E/8 via z -> 9z mod 8 (9 = 1 mod 8).  Coxeter, FS-85.  Reading a committed record; no enumeration."""
import json, gzip
from fractions import Fraction as Q
from efield import *
BASE='/home/kooshi/source/lean-dir/data/fs73/census/'
L=json.load(open(BASE+'lattice-degrey.json'))
Mden=L['M']
def row_to_E(r):
    a,b,c,d,e,f,g,h=r
    assert b==0 and c==0 and e==0 and h==0, r
    alpha=Q(a,Mden); delta=Q(d,Mden); beta=Q(f,Mden); gamma=Q(g,Mden)
    i3=2*Z-1; i11=2*W-1; s33=-(i3*i11)
    return E(alpha)+E(beta)*i3+E(gamma)*i11+E(delta)*s33
HB=[row_to_E(r) for r in L['H']]
UL=[row_to_E(r) for r in L['U']]
assert set(UL)==set(UNITS), 'U mismatch'
def key8(z):
    """class of z in Lambda/8Lambda as a 4-tuple mod 8 of 9z on basis 1,zeta,w,zeta w"""
    c=[x*9 for x in z.c]; assert all(x.denominator==1 for x in c)
    return tuple(int(x)%8 for x in c)
# lattice coordinates n (w.r.t. HB) -> key8
import itertools
def load(allc=False):
    d=json.load(open(BASE+'K-8Lambda-classes.json'))
    if allc:
        a=json.load(gzip.open(BASE+'K-8Lambda-classes-all.json.gz'))
        return d,a
    return d,None
def colouring_map(s):
    """s: 4096-digit string -> dict key8 -> colour"""
    out={}
    for idx in range(4096):
        n=[(idx>>9)&7,(idx>>6)&7,(idx>>3)&7,idx&7]
        z=sum((HB[i]*n[i] for i in range(4)),E(0))
        out[key8(z)]=int(s[idx])
    assert len(out)==4096
    return out
