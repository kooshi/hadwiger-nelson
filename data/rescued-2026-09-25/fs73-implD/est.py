import sys, math; sys.path.insert(0,'tools')
import fs73_lattice as FL
from fractions import Fraction as Fr
for s in ['twounits:14','twounits:30','twounits:42']:
    lat = FL.fabric(s)
    G = lat.gram_int()
    D = FL._det(G)  # det of M^2 G
    M = lat.M
    # det of trace Gram G_real = D / M^(2*8)
    logdet = math.log(abs(D)) - 16*math.log(M)
    vol8 = math.pi**4/24 * 2**8
    est = vol8 / math.exp(logdet/2)
    print(s, 'log10 est count of trace-norm<=4 vectors', math.log10(est))
