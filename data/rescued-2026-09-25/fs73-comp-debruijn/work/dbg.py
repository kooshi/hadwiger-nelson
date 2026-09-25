import json, theta_exact as T
from sympy.solvers.simplex import linprog, InfeasibleLPError
orig=T.lp
def lp(c,A,b,r):
    v,x=orig(c,A,b,r)
    if v is None:
        # re-run to see exception
        A2=[list(row) for row in A]+[[1 if i==j else 0 for j in range(r)] for i in range(r)]
        b2=list(b)+[1]*r
        try: print('RERUN',linprog(c,A=A2,b=b2))
        except Exception as e: print('EXC',type(e).__name__,e)
    return v,x
T.lp=lp
Uc=json.load(open('q11_Uc.json'))
try: T.theta_exact(Uc,3)
except TypeError as e: print('stopped')
