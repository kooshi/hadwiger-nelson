#!/usr/bin/env python3
"""FS116-Y1 stage 2: Y-SAT -- the capped strip about its midline vertex p = P_0, made saturated on a disc B(p, r) by four partner tiles, checked
exactly; the saturation certifier's controls (SQ9, R7) and its refusals (the capped strip at its midline, FS111-VM2-STRIP-MID).

THE OBJECT F(r) (0 < r < 1/4, H = 5/4; every point in Q(sqrt3)(sqrt5), the strip's tower; p = P_0 = (0, 0)).
  The arches U_j, D_j, j = -3..2, of FS114-YB's strip (tools/fs114_yb_objects.py Strip, imported, never edited).
  The top tiles T_-1 (M), T_1 (O) trimmed at y = H (their straight sides from the apexes up to H, top straight); T_0 (R) trimmed at H with the
  notch [-r, r] x [1, H] removed; the partner tiles M* = [0, r] x [1, H] (colour M = D_0's) and O* = [-r, 0] x [1, H] (colour O = D_-1's).
  Below, the mirror images in y = 0: B_-1 (P), B_1 (B) trimmed at -H, B_0 (G) notched, and beta* = mirror of M* (colour P = U_0's), alpha* = mirror
  of O* (colour B = U_-1's).  Twenty-two tiles.  The domain is the union; its rim is every piece no second tile shares.

THE CHECKS.
  1. validity: FS114-YB's exact checker (tools/fs114_yb_exact.py) and driver check_finite (tools/fs114_yb_run.py), unedited: every same-colour pair,
     a tile with itself included, ACCEPTs (no two interior points of one colour at distance exactly 1);
  2. the map: every non-rim piece shared by exactly two tiles in opposite directions (YB's consistency); the rim pieces form one closed chain;
  3. the disc: every rim piece is at distance > R = 1 + r from p (exact: every realised candidate distance, scaled by 1/R, compared with 1), and
     p lies inside (the rim is one Jordan curve, so the closed disc B(p, R) lies in the domain's interior);
  4. p: exactly four tiles have p as a corner, of four colours;
  5. SATURATION ON B(p, r), by certificate.  COVERAGE: every piece of every tile whose distance from p is at most r (exact, scaled by 1/r) is either
     certified whole, or is an axis-parallel segment with an end at p certified on [p, p + r u].  CERTIFICATES: a segment target [A, B] on the
     boundary of two tiles (the tiles holding a segment piece that contains it): for each of the two tiles t, the unit normal n pointing AWAY from t
     (dot(n, J(u)) < 0 for t's piece direction u; t lies to the left of its counter-clockwise chain) and the translate [A + n, B + n] contained in a
     segment piece of a tile of t's colour -- M-PINCH's tangent type, the partner a unit along the normal on the far side; an arc target of radius 1
     about y: y in a closed tile of each side colour -- the split type.  A boundary point x of the target then has a point of each side colour's
     support at distance exactly 1; a vertex's colours are side colours of its incident pieces and inherit a partner by closure.  (The essential
     multicolour of a boundary point is at most its two side colours; a certificate for both is enough.)
  6. CONTACT at named points (a second instrument, for refusals): colour c has a contact at x iff some closed c-tile has min <= 1 <= max from x
     (a closed tile is connected, so its distances from x fill [min, max]).

CONTROLS (the certifier and the contact test must accept or refuse each as known before any verdict on F(r) is believed):
  sq9      the square nine-colouring of side 1/2 (FS111-W-SQ9), squares (i, j), |i|, |j| <= 5, coloured (i mod 3, j mod 3); p = (0, 0), r = 1: every
           piece meeting B(p, 1) certified whole by the tangent type  -> ACCEPT (validity and saturation)
  r7       R7 (FS111-M-R7): Reuleaux triangles of width 1 on the up triangles of the unit triangular lattice, coloured by Lambda/2Lambda, cusped down
           triangles coloured by Lambda/M; p = (0, 0), r = 1/2: every piece meeting B(p, 1/2) is a unit arc certified by the split type -> ACCEPT
  strip    the capped strip itself about p: the midline point (1/4, 0) has NO contact for either side colour (P, M) and neither does (1/10, 0) for M
           -> the certificate for [p, (r, 0)] FAILS (FS111-VM2-STRIP-MID reproduced)
PLANTS (registered in plans/FS116-Y1-construction.md stage 2 before the first run):
  lift     M* lifted by 1/20 (M* = [0, r] x [1 + 1/20, H], T_0's notch floor unchanged, the gap given to T_0): the certificate for [p, (r, 0)] FAILS
           (M has no segment piece on y = 1) and the contact test finds no M contact at (r/2, 0)
  wide     M* widened to x in [0, 1/2] (r = 1/5 kept; T_0's notch and T_1 cut to match): validity REJECTs (M*, T_-1)
  swap     M* coloured O and O* coloured M (and their mirrors): validity ACCEPTs (each new pair tight at one corner or within < 1), and the certificate
           FAILS (partners of the wrong colour)
Run: python3 tools/fs116_y1_sat.py controls [--sq9n N] | object [r_num r_den] [--plant NAME]
(--sq9n 4: the SQ9 patch too small for its rim-most partners -- the certifier's control plant: the SQ9 control then reads NOT AS KNOWN)
"""
from __future__ import annotations
import os
import sys
from fractions import Fraction as Fr

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fs114_yb_exact as X      # noqa: E402  (FS114-YB's checker, unedited)
import fs114_yb_run as RUN      # noqa: E402  (its driver check_finite, unedited)
import fs114_yb_objects as O    # noqa: E402  (its strip, unedited)

Seg, Arc, Tile = X.Seg, X.Arc, X.Tile
vadd, vsub, vmul, n2, dot, cross, J, veq = X.vadd, X.vsub, X.vmul, X.n2, X.dot, X.cross, X.J, X.veq


# ================================================================ exact helpers
def scaled_piece(pc, p, s):
    """the piece moved by -p and scaled by 1/s (s > 0 in the tower)."""
    f = lambda z: vmul(1 / s, vsub(z, p))
    if pc.kind == "S":
        return Seg(f(pc.P), f(pc.Q))
    return Arc(f(pc.C), pc.rho / s, f(pc.P), f(pc.Q), pc.ccw)


def piece_dist_cmp(p, pc, s):
    """(some point of the piece at distance < s, some at distance == s, the minimum is < or == s) -- exact; min is attained at a candidate."""
    sp = scaled_piece(pc, p, s)
    z = (s.T(0), s.T(0))
    cs = X.point_piece(z, sp)
    signs = [c.cmp1() for c in cs]
    return min(signs)          # -1: min < s; 0: min == s; 1: min > s


def on_seg(z, sg):
    v = vsub(sg.Q, sg.P)
    w = vsub(z, sg.P)
    if not cross(v, w).is0():
        return False
    t = dot(w, v)
    return t.sign() >= 0 and (t - n2(v)).sign() <= 0


def seg_in_seg(a, b, sg):
    return on_seg(a, sg) and on_seg(b, sg)


def in_closed(z, tile):
    return X.inside(z, tile) >= 0


def contact(z, tiles, colour):
    """does some closed tile of this colour have a point at distance exactly 1 from z?"""
    for t in tiles:
        if t.colour != colour:
            continue
        lt, gt, eq, ins = X.point_tile(z, t)
        mn_le = lt or eq
        mx_ge = gt or eq
        if mn_le and mx_ge:
            return t.name
    return None


# ================================================================ the saturation certifier
def side_tiles_seg(tiles, a, b):
    """tiles with a segment piece containing [a, b], each with that piece's direction"""
    out = []
    for t in tiles:
        for pc in t.pieces:
            if pc.kind == "S" and seg_in_seg(a, b, pc):
                out.append((t, vsub(pc.Q, pc.P)))
    return out


def certify_seg(tiles, a, b, n_unit):
    """tangent-type certificate for the target [a, b] with unit normal +-n_unit.  Returns (ok, lines)."""
    lines, ok = [], True
    d = vsub(b, a)
    if not dot(d, n_unit).is0() or not (n2(n_unit) - 1).is0():
        return False, ["normal not a unit normal"]
    sides = side_tiles_seg(tiles, a, b)
    if len(sides) != 2:
        return False, [f"target on {len(sides)} tile boundaries (need 2): {[t.name for t, _ in sides]}"]
    for t, u in sides:
        n = n_unit if dot(n_unit, J(u)).sign() < 0 else vmul(n2(n_unit) * -1, n_unit)
        if not (dot(n, J(u)).sign() < 0):
            return False, ["normal side undecided"]
        a2, b2 = vadd(a, n), vadd(b, n)
        hit = None
        for s in tiles:
            if s.colour != t.colour or s is t:
                continue
            for pc in s.pieces:
                if pc.kind == "S" and seg_in_seg(a2, b2, pc):
                    hit = s.name
                    break
            if hit:
                break
        lines.append(f"  side {t.name} ({t.colour}): partner segment {X.fpt(a2)}->{X.fpt(b2)} {'on ' + hit if hit else 'NOT FOUND'}")
        ok &= hit is not None
    return ok, lines


def certify_arc(tiles, pc, sides):
    """split-type certificate: pc a unit arc about y; y in a closed tile of each side colour."""
    lines, ok = [], True
    if not (pc.rho - 1).is0():
        return False, ["not a unit arc"]
    y = pc.C
    for t in sides:
        hit = None
        for s in tiles:
            if s.colour == t.colour and in_closed(y, s):
                hit = s.name
                break
        lines.append(f"  side {t.name} ({t.colour}): centre {X.fpt(y)} {'in ' + hit if hit else 'NOT in any closed tile of this colour'}")
        ok &= hit is not None
    return ok, lines


def saturation(tiles, p, r, radial_ok=True, show=True):
    """certify every boundary point within distance r of p.  Pieces are collected once per unordered pair (piece, reverse)."""
    T = p[0].T
    rr = T(r) if not isinstance(r, X.Num) else r
    seen, allok, n_cert = [], True, 0
    report = []
    for t in tiles:
        for pc in t.pieces:
            if any(X._same_piece_rev(pc, q) or (pc.kind == q.kind and veq(pc.P, q.P) and veq(pc.Q, q.Q)) for q in seen):
                continue
            if piece_dist_cmp(p, pc, rr) > 0:
                continue
            seen.append(pc)
            owners = [s for s in tiles if any(X._same_piece_rev(pc, q) or (q.kind == pc.kind and veq(q.P, pc.P) and veq(q.Q, pc.Q)) for q in s.pieces)]
            if len(owners) != 2:
                allok = False
                report.append(f"piece {pc} within r: {len(owners)} owners (a rim piece inside the saturation disc)")
                continue
            if pc.kind == "A":
                ok, lines = certify_arc(tiles, pc, owners)
                tag = "whole arc"
            else:
                a, b = pc.P, pc.Q
                v = vsub(b, a)
                axis = v[0].is0() or v[1].is0()
                if radial_ok and axis and (veq(a, p) or veq(b, p)) and (n2(v) - rr * rr).sign() > 0:
                    q = b if veq(a, p) else a
                    w = vsub(q, p)
                    L = abs_axis(w)
                    a, b = p, vadd(p, vmul(rr / L, w))
                    tag = "radial part [p, p + r u]"
                else:
                    tag = "whole segment"
                v = vsub(b, a)
                if not axis:
                    n_unit = unit_normal(v)
                else:
                    L = abs_axis(v)
                    n_unit = (-(v[1] / L), v[0] / L)
                if n_unit is None:
                    ok, lines = False, ["segment direction has no unit normal in the tower"]
                else:
                    ok, lines = certify_seg(tiles, a, b, n_unit)
            n_cert += 1
            report.append(f"{'CERT ' if ok else 'FAIL '} {tag} {pc} owners {[o.name for o in owners]}")
            report += lines
            allok &= ok
    if show:
        for ln in report:
            print("  " + ln)
    print(f"  saturation on B(p, {float(rr):.4g}): {'CERTIFIED' if allok else 'NOT CERTIFIED'} -- pieces within r: {n_cert}")
    return allok


def abs_axis(w):
    return w[0] if w[1].is0() and w[0].sign() > 0 else (-w[0] if w[1].is0() else (w[1] if w[1].sign() > 0 else -w[1]))


def unit_normal(v):
    """a unit normal of v when |v|^2 is a square of a rational (used for the R7 control's chords, never for F(r))"""
    s = n2(v)
    try:
        q = Fr(float(s)).limit_denominator(10 ** 6)
    except Exception:
        return None
    import math
    num, den = q.numerator, q.denominator
    rn, rd = math.isqrt(num), math.isqrt(den)
    if rn * rn != num or rd * rd != den or not (s - q).is0():
        return None
    L = s.T(Fr(rn, rd))
    return (-(v[1] / L), v[0] / L)


# ================================================================ the fragment F(r)
def build(r=Fr(1, 5), H=Fr(5, 4), plant=None):
    S = O.Strip(capped=False)
    T = S.T
    q = S.q
    one = S.one
    tiles = [t for t in S.tiles(-3, 2) if t.name[0] in "UD"]

    def top_trim(m, notch=None, wide=None):
        Vm, Al, Ar = S.V(m), S.A(m - 1), S.A(m)
        xl, xr = q(Fr(m, 2) - Fr(1, 4)), q(Fr(m, 2) + Fr(1, 4))
        hh = q(H)
        if wide is not None:          # plant 'wide': T_1 cut at x = wide on its top part
            pass
        ps = [Arc(S.P(m + 1), one, Vm, Ar, False), Seg(Ar, (xr, hh))]
        if notch is None:
            ps.append(Seg((xr, hh), (xl, hh)))
        else:
            r0, r1, y0 = notch
            ps += [Seg((xr, hh), (q(r1), hh)), Seg((q(r1), hh), (q(r1), q(y0))), Seg((q(r1), q(y0)), (q(0), q(y0))),
                   Seg((q(0), q(y0)), (q(-r0), q(y0))), Seg((q(-r0), q(y0)), (q(-r0), hh)), Seg((q(-r0), hh), (xl, hh))]
        ps += [Seg((xl, hh), Al), Arc(S.P(m - 1), one, Al, Vm, False)]
        return ps

    def rect(x0, x1, y0, y1, split_bottom=None):
        return [Seg((q(x0), q(y0)), (q(x1), q(y0))), Seg((q(x1), q(y0)), (q(x1), q(y1))), Seg((q(x1), q(y1)), (q(x0), q(y1))),
                Seg((q(x0), q(y1)), (q(x0), q(y0)))]

    y_m = Fr(1) + (Fr(1, 20) if plant == "lift" else 0)
    cM, cO = ("O", "M") if plant == "swap" else ("M", "O")
    if plant == "wide":
        raise SystemExit("plant 'wide' is built by build_wide()")
    tops = [
        Tile("T-1", "M", top_trim(-1)),
        Tile("T1", "O", top_trim(1)),
        Tile("T0", "R", top_trim(0, notch=(r, r, Fr(1)))),
        Tile("M*", cM, rect(0, r, y_m, H)),
        Tile("O*", cO, rect(-r, 0, Fr(1), H)),
    ]
    if plant == "lift":           # the gap [0, r] x [1, 1 + 1/20] joins T_0: T_0's notch floor on the right is raised
        t0 = tops[2]
        ps = top_trim(0, notch=(r, r, Fr(1)))
        # replace the notch floor's right half: (r,1)->(0,1) becomes (r, 1+1/20) -> (0, 1+1/20) -> (0, 1)
        new = []
        for pc in ps:
            if pc.kind == "S" and veq(pc.P, (q(r), q(H))) and veq(pc.Q, (q(r), q(1))):
                new.append(Seg((q(r), q(H)), (q(r), q(y_m))))
            elif pc.kind == "S" and veq(pc.P, (q(r), q(1))) and veq(pc.Q, (q(0), q(1))):
                new += [Seg((q(r), q(y_m)), (q(0), q(y_m))), Seg((q(0), q(y_m)), (q(0), q(1)))]
            else:
                new.append(pc)
        tops[2] = Tile("T0", "R", new)
        tops[4] = Tile("O*", cO, [Seg((q(-r), q(1)), (q(0), q(1))), Seg((q(0), q(1)), (q(0), q(y_m))), Seg((q(0), q(y_m)), (q(0), q(H))),
                                  Seg((q(0), q(H)), (q(-r), q(H))), Seg((q(-r), q(H)), (q(-r), q(1)))])
    bot_col = {"T-1": "P", "T1": "B", "T0": "G", "M*": ("B" if plant == "swap" else "P"), "O*": ("P" if plant == "swap" else "B")}
    bot_name = {"T-1": "B-1", "T1": "B1", "T0": "B0", "M*": "beta*", "O*": "alpha*"}
    for t in tops:
        tiles.append(t)
        src = t
        if plant == "lift" and t.name in ("T0", "M*", "O*"):      # the plant acts above only; below stays faithful
            src = {"T0": Tile("T0", "R", top_trim(0, notch=(r, r, Fr(1)))), "M*": Tile("M*", "M", rect(0, r, 1, H)),
                   "O*": Tile("O*", "O", rect(-r, 0, 1, H))}[t.name]
        tiles.append(Tile(bot_name[t.name], bot_col[t.name], O.Strip.mirror(src.pieces)))
    return S, tiles


def build_wide(r=Fr(1, 5), H=Fr(5, 4)):
    """plant 'wide': M* = [0, 1/2] x [1, H]; T_0's notch [-r, 1/4] and T_1's top-left corner [1/4, 1/2] x [1, H] removed to make room."""
    S, tiles = build(r, H)
    q, one = S.q, S.one
    tiles = [t for t in tiles if t.name not in ("T0", "T1", "M*")]
    Vm, Al, Ar = S.V(0), S.A(-1), S.A(0)
    hh = q(H)
    t0 = [Arc(S.P(1), one, Vm, Ar, False), Seg(Ar, (q(Fr(1, 4)), q(1))), Seg((q(Fr(1, 4)), q(1)), (q(0), q(1))), Seg((q(0), q(1)), (q(-r), q(1))),
          Seg((q(-r), q(1)), (q(-r), hh)), Seg((q(-r), hh), (q(Fr(-1, 4)), hh)), Seg((q(Fr(-1, 4)), hh), Al), Arc(S.P(-1), one, Al, Vm, False)]
    V1, A0, A1 = S.V(1), S.A(0), S.A(1)
    t1 = [Arc(S.P(2), one, V1, A1, False), Seg(A1, (q(Fr(3, 4)), hh)), Seg((q(Fr(3, 4)), hh), (q(Fr(1, 2)), hh)), Seg((q(Fr(1, 2)), hh), (q(Fr(1, 2)), q(1))),
          Seg((q(Fr(1, 2)), q(1)), (q(Fr(1, 4)), q(1))), Seg((q(Fr(1, 4)), q(1)), A0), Arc(S.P(0), one, A0, V1, False)]
    ms = [Seg((q(0), q(1)), (q(Fr(1, 4)), q(1))), Seg((q(Fr(1, 4)), q(1)), (q(Fr(1, 2)), q(1))), Seg((q(Fr(1, 2)), q(1)), (q(Fr(1, 2)), hh)),
          Seg((q(Fr(1, 2)), hh), (q(0), hh)), Seg((q(0), hh), (q(0), q(1)))]
    tiles += [Tile("T0", "R", t0), Tile("T1", "O", t1), Tile("M*", "M", ms)]
    return S, tiles


# ================================================================ object checks
def rim_chain(rim):
    """do the rim pieces form one closed chain?"""
    if not rim:
        return False
    rest = list(rim)
    cur = rest.pop(0)
    start = cur.P
    end = cur.Q
    while rest:
        nxt = [pc for pc in rest if veq(pc.P, end)]
        if len(nxt) != 1:
            return False
        rest.remove(nxt[0])
        end = nxt[0].Q
    return veq(end, start)


def check_object(tiles, p, R, r, label, certify=True, show=False):
    print(f"== {label}: {len(tiles)} tiles")
    rej, tmin, tmax = RUN.check_finite(tiles, "  validity")
    table = [(t.name, pc) for t in tiles for pc in t.pieces]
    rim = [pc for i, (nm, pc) in enumerate(table)
           if not any(j != i and X._same_piece_rev(pc, q) for j, (nm2, q) in enumerate(table))]
    bad, _ = X.consistency(tiles, open_ok=lambda pc: any(pc is q for q in rim))
    print(f"  map: pieces {len(table)}, rim pieces {len(rim)}, inconsistent {len(bad)}; rim one closed chain: {rim_chain(rim)}")
    T = p[0].T
    RR = T(R)
    far = [pc for pc in rim if piece_dist_cmp(p, pc, RR) <= 0]
    inside_p = sum(1 for t in tiles if X.inside(p, t) >= 0)
    print(f"  disc: rim pieces at distance <= R = {float(RR):.6g} from p: {len(far)}; tiles whose closure holds p: {inside_p}")
    for pc in far:
        print(f"     {pc}")
    at_p = [t for t in tiles if any(veq(pc.P, p) for pc in t.pieces)]
    cols = sorted({t.colour for t in at_p})
    print(f"  p: corner of {[t.name for t in at_p]}, colours {cols}")
    sat = saturation(tiles, p, r, show=show) if certify else None
    ok = (not rej) and not bad and rim_chain(rim) and not far and len(cols) >= 4 and (sat is None or sat)
    print(f"  => {label}: {'ALL HOLD' if ok else 'FAILS'}")
    return ok, rej, sat


def contacts(tiles, pts, T):
    for (x, y), cols in pts:
        z = (T(x), T(y))
        for c in cols:
            print(f"  contact at ({float(x):.4g}, {float(y):.4g}) for colour {c}: {contact(z, tiles, c) or 'NONE'}")


# ================================================================ controls
def sq9(n=5):
    Tq = X.Tower.base()
    h = Fr(1, 2)
    tiles = []
    for i in range(-n, n + 1):
        for j in range(-n, n + 1):
            ps = [(Tq(i * h), Tq(j * h)), (Tq((i + 1) * h), Tq(j * h)), (Tq((i + 1) * h), Tq((j + 1) * h)), (Tq(i * h), Tq((j + 1) * h))]
            tiles.append(Tile(f"S{i},{j}", (i % 3, j % 3), O.poly(ps)))
    return tiles


def r7(n=3):
    """R7 on the lattice points a e1 + b e2, |a|, |b| <= n (e1 = (1, 0), e2 = (1/2, sqrt3/2)); up (a, b): Reuleaux on L, L + e1, L + e2; down (a, b): cusped
    triangle on L + e1, L + e1 + e2, L + e2 with concave unit arcs about the opposite far corners."""
    T3 = X.Tower.base().extend(3, "3")
    r3 = T3.gen(1)
    one = T3(1)

    def L(a, b):
        return (T3(a) + T3(Fr(b, 2)), r3 * Fr(b, 2))
    tiles = []
    for a in range(-n, n + 1):
        for b in range(-n, n + 1):
            A, B, C = L(a, b), L(a + 1, b), L(a, b + 1)
            up = Tile(f"u{a},{b}", ("u", a % 2, b % 2), [Arc(C, one, A, B, True), Arc(A, one, B, C, True), Arc(B, one, C, A, True)])
            D = L(a + 1, b + 1)
            # down triangle B, D, C (counter-clockwise: B -> D -> C); its sides are concave: each side bulges inward, an arc about the far vertex
            # of the adjacent up triangle.  Side B->D is shared with the up triangle (B, D, L(a+2, b))'s side ... about L(a+2, b)? no: about the
            # opposite corner of the up triangle across that side, which is L(a + 2, b) -- its arc from B to D about L(a+2, b) is clockwise.
            E1, E2, E3 = L(a + 2, b), L(a, b + 2), L(a, b)   # far corners: across B-D is up (a+1, b) with third corner L(a+2, b)
            dn = Tile(f"d{a},{b}", ("d", (a - b) % 3), [Arc(L(a + 1, b) if False else E1, one, B, D, False),
                                                          Arc(L(a, b + 1) if False else E2, one, D, C, False),
                                                          Arc(E3, one, C, B, False)])
            tiles += [up, dn]
    return T3, tiles


def controls(n9=5):
    ok = True
    # SQ9
    t9 = sq9(n9)
    Tq = X.Tower.base()
    p = (Tq(0), Tq(0))
    print("== control sq9 (k = 9): validity on the patch; saturation certified on B(p, 1)")
    rej, _, _ = RUN.check_finite(t9, "  validity")
    s = saturation(t9, p, 1, radial_ok=False, show=False)
    ok &= (not rej) and s
    print(f"  => sq9: {'ACCEPT as known' if (not rej) and s else 'NOT AS KNOWN'}")
    # R7
    T3, t7 = r7(2)
    p7 = (T3(0), T3(0))
    print("== control r7 (k = 7): validity on the patch; saturation certified on B(p, 1/2) (split type)")
    rej7, _, _ = RUN.check_finite(t7, "  validity")
    s7 = saturation(t7, p7, Fr(1, 2), radial_ok=False, show=False)
    ok &= (not rej7) and s7
    print(f"  => r7: {'ACCEPT as known' if (not rej7) and s7 else 'NOT AS KNOWN'}")
    # the capped strip about p: FS111-VM2-STRIP-MID
    S = O.Strip(capped=True)
    ts = S.tiles(-5, 4)
    T = S.T
    ps = (T(0), T(0))
    print("== control strip: the capped strip about p = P_0 (not saturated on its midline, FS111-VM2-STRIP-MID)")
    c1 = contact((T(Fr(1, 4)), T(0)), ts, "P")
    c2 = contact((T(Fr(1, 4)), T(0)), ts, "M")
    c3 = contact((T(Fr(1, 10)), T(0)), ts, "M")
    c4 = contact(ps, ts, "M")
    print(f"  contact at (1/4, 0) for P: {c1 or 'NONE'}; for M: {c2 or 'NONE'}; at (1/10, 0) for M: {c3 or 'NONE'}; at p for M: {c4 or 'NONE'}")
    sat = saturation(ts, ps, Fr(1, 5), show=False)
    good = c1 is None and c2 is None and c3 is None and c4 is not None and not sat
    ok &= good
    print(f"  => strip: {'REFUSED as known' if good else 'NOT AS KNOWN'}")
    print(f"CONTROLS {'ALL AS KNOWN' if ok else 'NOT AS KNOWN'}")
    return ok


def main():
    args = sys.argv[1:]
    plant = args[args.index("--plant") + 1] if "--plant" in args else None
    if not args or args[0] == "controls":
        n9 = int(args[args.index("--sq9n") + 1]) if "--sq9n" in args else 5
        return 0 if controls(n9) else 1
    if args[0] == "object":
        r = Fr(int(args[1]), int(args[2])) if len(args) > 2 and args[1].isdigit() else Fr(1, 5)
        if plant == "wide":
            S, tiles = build_wide(r)
        else:
            S, tiles = build(r, plant=plant)
        T = S.T
        p = (T(0), T(0))
        ok, rej, sat = check_object(tiles, p, 1 + r, r, f"F({r}){' plant ' + plant if plant else ''}", show=True)
        contacts(tiles, [((r / 2, 0), ["P", "M"]), ((-r / 2, 0), ["B", "O"]), ((0, r / 2), ["B", "P"]), ((0, -r / 2), ["O", "M"])], T)
        return 0 if ok else 1
    print(__doc__)
    return 2


if __name__ == "__main__":
    sys.exit(main())
