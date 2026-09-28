#!/usr/bin/env python3
"""FS114-N7 exact checks for stage 3: the open-cap family OC in N4's bowtie frame (p = 0, q1 = e(30), top = e(90), q3 = e(150),
q4 = e(210), bot = e(270), q2 = e(330)), and the (Q)-arc gap lemma N7-QOPP at a named arc.
Checks:
  BOT   at bot the half-planes facing away from q4 and from q2 meet in exactly [240, 300] (directions 235/305 fail, 245/295 pass)
  ARC   the arc q4 + e(phi), phi in (270, 330), lies outside the closed unit disc about p, inside B(bot,1), and outside the closed
        unit disc about q2 (named phi = 280, 300, 320); P = q4 + e(270) = sqrt3 e(240) and P' = q2 + e(270) = sqrt3 e(300) are sqrt3 apart
  TOP   at top the half-planes facing away from p and from q1 meet in [60, 180] (directions 55/185 fail, 65/175 pass)
  QOPP  for a (Q) arc [u, v] = [20, 70] the inner window [v-90, u+90] and the outer anti-window [v+90, u+270] leave two gaps of
        length v - u, so tiles adjacent at p cannot be its inner and outer tiles (named directions in each gap belong to neither)
Run: python3 tools/fs114_n7_oc.py [--plant]   (plant: q4 moved to e(215), so |q4 - bot| < 1: exactly the two BOT-inside lines (bot
itself now lies in B(q4,1)) and the ARC line 'P = q4 + e(270)' must fail; no TOP, QOPP or other ARC line.)"""
import sys
import sympy as sp
PLANT = '--plant' in sys.argv
deg = sp.pi / 180
e = lambda a: sp.Matrix([sp.cos(a * deg), sp.sin(a * deg)])
n2 = lambda v: sp.nsimplify(sp.simplify(v.dot(v)))
fails = 0
def check(name, cond):
    global fails
    ok = bool(cond); print(('OK   ' if ok else 'FAIL ') + name); fails += (not ok)
q1, top, q3, bot, q2 = e(30), e(90), e(150), e(270), e(330)
q4 = e(215) if PLANT else e(210)
t = sp.Rational(1, 100)
# BOT: a tile at bot outside B(q4,1) and B(q2,1): cone in [240,300]
for d, inside in ((235, False), (245, True), (295, True), (305, False)):
    P = bot + t * e(d)
    ok = (sp.N(n2(P - q4)) >= 1 and sp.N(n2(P - q2)) >= 1)
    check(f'BOT dir {d}: outside B(q4,1) and B(q2,1) is {inside}', ok == inside)
for phi in (280, 300, 320):
    x = q4 + e(phi)
    check(f'ARC phi={phi}: |x|>1, |x-bot|<1, |x-q2|>1',
          sp.N(n2(x)) > 1 and sp.N(n2(x - bot)) < 1 and sp.N(n2(x - q2)) > 1)
P, Pp = q4 + e(270), q2 + e(270)
check('ARC P = q4 + e(270) = sqrt3 e(240)', sp.simplify(n2(P - sp.sqrt(3) * e(240))) == 0)
check("ARC P' = q2 + e(270) = sqrt3 e(300)", sp.simplify(n2(Pp - sp.sqrt(3) * e(300))) == 0)
check("ARC |P - P'|^2 = 3", sp.simplify(n2(sp.sqrt(3) * e(240) - Pp) - 3) == 0)
# TOP: a tile at top outside B(p,1)'s closure-facing half and outside B(q1,1): cone in [60,180]
for d, inside in ((55, False), (65, True), (175, True), (185, False)):
    P = top + t * e(d)
    ok = (sp.N(n2(P)) >= 1 and sp.N(n2(P - q1)) >= 1)
    check(f'TOP dir {d}: outside B(p,1) and B(q1,1) is {inside}', ok == inside)
# QOPP at [u, v] = [20, 70]: windows at p
u, v = 20, 70
def in_arc(x, lo, hi):
    return (x - lo) % 360 <= (hi - lo) % 360
Win, Wout = (v - 90, u + 90), (v + 90, u + 270)
for g in ((u + 90 + v + 90) / 2, (u + 270 + v + 270) / 2):
    check(f'QOPP gap direction {g}: in neither window', not in_arc(g, *Win) and not in_arc(g, *Wout))
# the windows are exactly the directions facing every arc point (inner) / facing away from every arc point (outer)
for d in (Win[0] + 1, Win[1] - 1):
    check(f'QOPP inner dir {d} faces u and v', all(sp.N((t * e(d) - e(w)).dot(t * e(d) - e(w))) < 1 for w in (u, v)))
for d in (Wout[0] + 1, Wout[1] - 1):
    check(f'QOPP outer dir {d} faces away from u and v', all(sp.N((t * e(d) - e(w)).dot(t * e(d) - e(w))) > 1 for w in (u, v)))
print('RESULT', 'OK' if fails == 0 else f'{fails} FAIL')
sys.exit(1 if fails else 0)
