import numpy as np, time
d = np.load('ball14.npz')
X, col = d['X'], d['col']
lo = X.min(0); hi = X.max(0)
print('coord ranges', lo, hi, 'box', np.prod(hi-lo+1))
shape = tuple(int(h-l+1) for l,h in zip(lo,hi))
# pad to power-friendly sizes
pad = tuple(int(2**np.ceil(np.log2(s))) for s in shape)
print(shape, pad, np.prod(pad))
w = np.exp(2j*np.pi/3)
f = np.zeros(pad, dtype=np.complex64)
Y = X - lo
f[Y[:,0],Y[:,1],Y[:,2],Y[:,3]] = w**col
t=time.time()
F = np.fft.fftn(f)
print('fft', time.time()-t)
A = np.abs(F)/len(X)
idx = np.argsort(A.ravel())[::-1][:25]
for i in idx:
    k = np.unravel_index(i, pad)
    theta = [ (kk/pp if kk<=pp/2 else kk/pp-1) for kk,pp in zip(k,pad)]
    print(round(float(A.ravel()[i]),4), k, [round(t_,4) for t_ in theta])
