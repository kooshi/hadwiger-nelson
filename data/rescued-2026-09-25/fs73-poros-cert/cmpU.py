import sys, io, contextlib, runpy
sys.path.insert(0, 'tools')
import fs73_lattice as FL
buf = io.StringIO()
with contextlib.redirect_stdout(buf):
    ns = runpy.run_path('/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs73-poros-cert/olat.py')
U = ns['U']
def to8(Z):   # Z = 9z in basis 1, zeta6, w, zeta6 w  ->  z as (x0..x3, y0..y3) over 36 on (1, sqrt3, sqrt11, sqrt33)
    a,b,c,d = Z
    return (4*a+2*b+2*c+d, 0, 0, -d, 0, 2*b+d, 2*c+d, 0)
lat = FL.degrey(); lat.saturate('trace')
print('M', lat.M, 'rank', lat.rank, 'H', lat.H)
mine = {to8(Z) for Z in U}
theirs = {tuple(u) for u in lat.U8}
print('mine', len(mine), 'theirs', len(theirs), 'equal', mine == theirs)
# delta vectors in their H-coordinates
v8 = to8((0,0,-8,0)); e8 = to8((8,0,0,0))
print('v in H-coords', lat.coords(v8), ' 8/9 in H-coords', lat.coords(e8))
