import sys, time

def build(p):
    circle = [(a, b) for a in range(p) for b in range(p) if (a*a + b*b) % p == 1]
    n = p * p
    adj = [0] * n
    for x in range(p):
        for y in range(p):
            v = x * p + y
            m = 0
            for (a, b) in circle:
                m |= 1 << (((x + a) % p) * p + (y + b) % p)
            adj[v] = m
    return n, adj, len(circle)

def colourable(n, adj, k, limit):
    """DSATUR backtracking with forward checking. Returns (result, nodes) where
    result is True/False, or None on timeout."""
    t0 = time.time()
    colour = [-1] * n
    # domain masks: bit c set => colour c still allowed
    full = (1 << k) - 1
    dom = [full] * n
    nodes = 0
    # symmetry breaking: vertex 0 gets colour 0 (vertex-transitive), one neighbour gets colour 1
    order_fixed = []
    sys.setrecursionlimit(10000)
    def assign(v, c, trail):
        colour[v] = c
        m = adj[v]
        while m:
            u = (m & -m).bit_length() - 1
            m &= m - 1
            if colour[u] == -1 and dom[u] >> c & 1:
                dom[u] &= ~(1 << c)
                trail.append(u)
                if dom[u] == 0:
                    return False
        return True
    def undo(v, c, trail):
        colour[v] = -1
        for u in trail:
            dom[u] |= 1 << c
    def solve(depth):
        nonlocal nodes
        nodes += 1
        if nodes & 4095 == 0 and time.time() - t0 > limit:
            raise TimeoutError
        if depth == n:
            return True
        # pick uncoloured vertex with smallest domain, tiebreak by most coloured neighbours (DSATUR-ish)
        best = -1; bestsz = 99; bestdeg = -1
        for v in range(n):
            if colour[v] == -1:
                sz = bin(dom[v]).count('1')
                if sz < bestsz:
                    best, bestsz = v, sz
                    if sz <= 1: break
        v = best
        d = dom[v]
        while d:
            c = (d & -d).bit_length() - 1
            d &= d - 1
            trail = []
            ok = assign(v, c, trail)
            if ok and solve(depth + 1):
                return True
            undo(v, c, trail)
        return False
    # fix vertex 0 -> 0, its first neighbour -> 1
    tr = []
    assign(0, 0, tr)
    u0 = (adj[0] & -adj[0]).bit_length() - 1
    tr2 = []
    assign(u0, 1, tr2)
    try:
        res = solve(2)
    except TimeoutError:
        return None, nodes
    return res, nodes

if __name__ == "__main__":
    p = int(sys.argv[1]); k = int(sys.argv[2]); limit = float(sys.argv[3]) if len(sys.argv) > 3 else 60
    n, adj, deg = build(p)
    t = time.time()
    res, nodes = colourable(n, adj, k, limit)
    print(f"p={p} n={n} degree={deg} k={k} -> {res} (nodes={nodes}, {time.time()-t:.1f}s)")
