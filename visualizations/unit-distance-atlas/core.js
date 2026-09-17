// ===== exact core: multiquadratic fields, unit vectors, lattice growth, shapes =====
const Core = (() => {
  const gcd = (a, b) => { a = Math.abs(a); b = Math.abs(b); while (b) { const t = a % b; a = b; b = t; } return a; };
  const isqrt = (n) => { if (n < 0) return -1; let r = Math.floor(Math.sqrt(n)); while (r * r > n) r--; while ((r + 1) * (r + 1) <= n) r++; return r; };
  const primesOf = (n) => { const ps = []; for (let p = 2; p * p <= n; p++) { let e = 0; while (n % p === 0) { n /= p; e++; } if (e % 2) ps.push(p); } if (n > 1) ps.push(n); return ps; };
  const symdiff = (a, b) => { const s = new Set(a); for (const x of b) s.has(x) ? s.delete(x) : s.add(x); return [...s].sort((x, y) => x - y); };
  const inter = (a, b) => a.filter((x) => b.includes(x));
  const prod = (ps) => ps.reduce((m, p) => m * p, 1);

  // A real multiquadratic field Q(√g1, …, √gk): basis √d_S over squarefree d_S, S ⊆ {1..k} as a bitmask.
  function makeField(radicands) {
    const basis = []; // [{primes, pivot}]
    for (const r of radicands) {
      let v = primesOf(Math.floor(Math.abs(r)));
      for (const b of basis) if (v.includes(b.pivot)) v = symdiff(v, b.primes);
      if (v.length) basis.push({ primes: v, pivot: v[v.length - 1] });
    }
    const k = basis.length, n = 1 << k;
    const P = []; // prime set of d_S
    for (let S = 0; S < n; S++) { let v = []; for (let j = 0; j < k; j++) if (S >> j & 1) v = symdiff(v, basis[j].primes); P.push(v); }
    const d = P.map(prod), gens = basis.map((b) => prod(b.primes));
    const c = [];   // √d_S · √d_T = c[S][T] · √d_(S^T)
    for (let S = 0; S < n; S++) { c.push([]); for (let T = 0; T < n; T++) c[S].push(prod(inter(P[S], P[T]))); }
    const pairs = []; // for R ≠ 0: [S, T, c] with S < T, S ^ T = R
    for (let R = 0; R < n; R++) { pairs.push([]); if (!R) continue; for (let S = 0; S < n; S++) { const T = S ^ R; if (S < T) pairs[R].push([S, T, c[S][T]]); } }
    const sq = d.map(Math.sqrt);
    const eps = []; // eps[σ][S] = sign of √d_S under the embedding σ
    for (let s = 0; s < n; s++) { eps.push([]); for (let S = 0; S < n; S++) { let b = S & s, par = 0; while (b) { par ^= b & 1; b >>= 1; } eps[s].push(par ? -1 : 1); } }
    return { k, n, gens, d, c, pairs, sq, eps, hasSqrt3: d.includes(3) };
  }

  // Every unit vector (x, y) ∈ F² with N·x, N·y in the Z-span of the basis. A vector is an Int32Array
  // [X_0..X_{n-1}, Y_0..Y_{n-1}]. Exhaustive: DFS over the irrational coefficient pairs, largest d first,
  // pruned by the rational part (Σ d_S(X_S²+Y_S²) = N²) and by every real embedding (each image lies on
  // the circle of radius N); the rational pair is then solved from the linear constraints.
  function* unitVectors(F, N, budget = 4e7) {
    const { n, d, c, sq, eps } = F, N2 = N * N, out = [], seen = new Set();
    const order = []; for (let S = 1; S < n; S++) order.push(S); order.sort((a, b) => d[b] - d[a]);
    const X = new Array(n).fill(0), Y = new Array(n).fill(0);
    const L = new Array(n).fill(0);            // L[R] = Σ_{0<S<T, S^T=R} c(X_S X_T + Y_S Y_T)
    const px = new Float64Array(n), py = new Float64Array(n);
    let nodes = 0, stopped = false;
    const push = (a, b) => {
      const v = new Int32Array(2 * n); v[0] = a; v[n] = b; for (let S = 1; S < n; S++) { v[S] = X[S]; v[n + S] = Y[S]; }
      const key = v.join(','); if (!seen.has(key)) { seen.add(key); out.push(v); }
    };
    const leaf = (B) => {
      let R0 = 0; for (const S of order) if (X[S] || Y[S]) { R0 = S; break; }
      if (!R0) { for (let a = -N; a <= N; a++) { const r = N2 - a * a, b = isqrt(r); if (b >= 0 && b * b === r) { push(a, b); push(a, -b); } } return; }
      const u = X[R0], v = Y[R0], g = u * u + v * v, Lr = L[R0], s2 = B * g - Lr * Lr;
      if (s2 < 0) return; const s = isqrt(s2); if (s * s !== s2) return;
      for (const t of s ? [s, -s] : [0]) {
        const an = -Lr * u - t * v, cn = -Lr * v + t * u;
        if (an % g || cn % g) continue; const a = an / g, b = cn / g;
        if (a * a + b * b !== B) continue;
        let ok = true; for (let R = 1; R < n && ok; R++) if (a * X[R] + b * Y[R] + L[R] !== 0) ok = false;
        if (ok) push(a, b);
      }
    };
    function* rec(i, B) {
      if (++nodes > budget) { stopped = true; return; }
      if ((nodes & 0x3fff) === 0) yield nodes;
      const remPairs = order.length - i + 1, slack = Math.sqrt(remPairs * B) + 1e-6;
      for (let s = 0; s < n; s++) { const r = Math.hypot(px[s], py[s]); if (Math.abs(r - N) > slack) return; }
      if (i === order.length) { leaf(B); return; }
      const S = order[i], dS = d[S], xm = isqrt(Math.floor(B / dS));
      for (let x = -xm; x <= xm; x++) {
        const Bx = B - dS * x * x, ym = isqrt(Math.floor(Bx / dS));
        for (let y = -ym; y <= ym; y++) {
          X[S] = x; Y[S] = y;
          for (let j = 0; j < i; j++) { const T = order[j]; if (X[T] || Y[T]) L[S ^ T] += c[S][T] * (x * X[T] + y * Y[T]); }
          for (let s = 0; s < n; s++) { const e = eps[s][S] * sq[S]; px[s] += x * e; py[s] += y * e; }
          yield* rec(i + 1, Bx - dS * y * y);
          for (let s = 0; s < n; s++) { const e = eps[s][S] * sq[S]; px[s] -= x * e; py[s] -= y * e; }
          for (let j = 0; j < i; j++) { const T = order[j]; if (X[T] || Y[T]) L[S ^ T] -= c[S][T] * (x * X[T] + y * Y[T]); }
          X[S] = 0; Y[S] = 0;
          if (stopped) return;
        }
      }
    }
    yield* rec(0, N2);
    for (const v of out) if (!isUnit(F, N, v)) throw new Error('enumeration produced a non-unit vector');
    return { W: out, complete: !stopped, nodes };
  }

  // exact test: is the integer vector v (over denominator N) a unit vector?
  function isUnit(F, N, v) {
    const { n, d, pairs } = F; let q = 0;
    for (let S = 0; S < n; S++) q += d[S] * (v[S] * v[S] + v[n + S] * v[n + S]);
    if (q !== N * N) return false;
    for (let R = 1; R < n; R++) { let t = 0; for (const [S, T, cc] of pairs[R]) t += cc * (v[S] * v[T] + v[n + S] * v[n + T]); if (t) return false; }
    return true;
  }
  const embed = (F, N, v) => { let x = 0, y = 0; for (let S = 0; S < F.n; S++) { x += v[S] * F.sq[S]; y += v[F.n + S] * F.sq[S]; } return [x / N, y / N]; };

  const hashVec = (v) => { let h1 = 0x811c9dc5, h2 = 0x9e3779b9; for (let i = 0; i < v.length; i++) { h1 = Math.imul(h1 ^ v[i], 16777619); h2 = Math.imul(h2 ^ (v[i] + i), 0x85ebca6b) ^ (h2 >>> 13); } return (h1 >>> 0) * 2097152 + ((h2 >>> 0) >>> 11); };
  const eqAt = (A, i, B, j, m) => { for (let t = 0; t < m; t++) if (A[i + t] !== B[j + t]) return false; return true; };

  // growth. 'ball': the word-length ball of the Cayley graph about the seeds (ties: nearest the centre).
  // 'closure': the seeds and their unit stars, then repeatedly the nearest lattice point that already has two
  // or more unit neighbours drawn (a rhombus, triangle or spindle completion); a point with one only if none has two.
  function* grow(F, N, W, seeds, target, mode) {
    const m = 2 * F.n;
    const pts = new Int32Array((target + 1) * m); let np = 0;
    const pmap = new Map();
    let cx = 0, cy = 0; for (const s of seeds) { const [x, y] = embed(F, N, s); cx += x / seeds.length; cy += y / seeds.length; }
    const cand = new Map(); const cP = [], cW = [], cS = [], cD = [], cDone = [];
    const heaps = [[], [], []];
    const hpush = (h, key, id) => { h.push([key, id]); let i = h.length - 1; while (i) { const p = (i - 1) >> 1; if (h[p][0] <= h[i][0]) break; [h[p], h[i]] = [h[i], h[p]]; i = p; } };
    const hpop = (h) => { const top = h[0], last = h.pop(); if (h.length) { h[0] = last; let i = 0; for (;;) { const l = 2 * i + 1, r = l + 1; let b = i; if (l < h.length && h[l][0] < h[b][0]) b = l; if (r < h.length && h[r][0] < h[b][0]) b = r; if (b === i) break; [h[b], h[i]] = [h[i], h[b]]; i = b; } } return top; };
    const tmp = new Int32Array(m);
    const same = (i) => { for (let t = 0; t < m; t++) if (pts[i * m + t] !== tmp[t]) return false; return true; };
    const findTmp = () => { const l = pmap.get(hashVec(tmp)); if (l) for (const i of l) if (same(i)) return i; return -1; };
    const depth = []; let capped = false; const candCap = 1500000;
    const addPoint = (vec, dep) => {
      for (let t = 0; t < m; t++) tmp[t] = vec[t];
      if (findTmp() >= 0) return;
      pts.set(vec, np * m); const h = hashVec(vec); const l = pmap.get(h); l ? l.push(np) : pmap.set(h, [np]); depth.push(dep);
      const i = np++;
      for (let w = 0; w < W.length; w++) {
        const Wv = W[w]; for (let t = 0; t < m; t++) tmp[t] = pts[i * m + t] + Wv[t];
        if (findTmp() >= 0) continue;
        const hh = hashVec(tmp); let id = -1; const cl = cand.get(hh);
        if (cl) for (const j of cl) { const P = cP[j] * m, Wj = W[cW[j]]; let eq = true; for (let t = 0; t < m && eq; t++) if (pts[P + t] + Wj[t] !== tmp[t]) eq = false; if (eq) { id = j; break; } }
        const isNew = id < 0;
        if (isNew) {
          if (cP.length >= candCap) { capped = true; continue; }
          id = cP.length; cP.push(i); cW.push(w); cS.push(0); cDone.push(false);
          const [x, y] = embed(F, N, tmp); cD.push(Math.hypot(x - cx, y - cy));
          cl ? cl.push(id) : cand.set(hh, [id]);
        }
        cS[id]++;
        if (mode === 'ball') { if (isNew) hpush(heaps[0], (dep + 1) * 1e6 + cD[id], id); }
        else if (cS[id] === 1) hpush(heaps[1], cD[id], id);
        else if (cS[id] === 2) hpush(heaps[2], cD[id], id);
      }
    };
    const materialise = (id) => { const vec = new Int32Array(m), P = cP[id] * m, Wv = W[cW[id]]; for (let t = 0; t < m; t++) vec[t] = pts[P + t] + Wv[t]; return vec; };
    for (const s of seeds) if (np < target) addPoint(s, 0);
    if (mode === 'closure') { // the unit stars of the seeds, nearest first
      const star = []; for (let id = 0; id < cP.length; id++) star.push(id);
      star.sort((a, b) => cD[a] - cD[b]);
      for (const id of star) { if (np >= target) break; if (!cDone[id]) { cDone[id] = true; addPoint(materialise(id), 1); } }
    }
    while (np < target) {
      let id = -1;
      const order = mode === 'ball' ? [heaps[0]] : [heaps[2], heaps[1]];
      for (const h of order) { while (h.length) { const [, j] = hpop(h); if (!cDone[j]) { id = j; break; } } if (id >= 0) break; }
      if (id < 0) break;
      cDone[id] = true; addPoint(materialise(id), depth[cP[id]] + 1);
      if ((np & 63) === 0) yield np;
    }
    return { pts: pts.slice(0, np * m), np, capped };
  }

  // all exact unit edges among the points: float grid proposes, exact arithmetic decides
  function edgesOf(F, N, pts, np) {
    const m = 2 * F.n, xy = new Float64Array(2 * np);
    for (let i = 0; i < np; i++) { const [x, y] = embed(F, N, pts.subarray(i * m, (i + 1) * m)); xy[2 * i] = x; xy[2 * i + 1] = y; }
    const grid = new Map(); const cell = (x) => Math.floor(x);
    for (let i = 0; i < np; i++) { const k = cell(xy[2 * i]) * 65536 + cell(xy[2 * i + 1]); const l = grid.get(k); l ? l.push(i) : grid.set(k, [i]); }
    let maxAbs = 0; for (let i = 0; i < pts.length; i++) maxAbs = Math.max(maxAbs, Math.abs(pts[i]));
    const bound = 4 * maxAbs * maxAbs * Math.max(...F.d) * F.n * F.n;
    const safe = bound < 2 ** 52;
    const E = [], dv = new Int32Array(m); let proposals = 0;
    for (let i = 0; i < np; i++) {
      const gx = cell(xy[2 * i]), gy = cell(xy[2 * i + 1]);
      for (let ax = -1; ax <= 1; ax++) for (let ay = -1; ay <= 1; ay++) {
        const l = grid.get((gx + ax) * 65536 + gy + ay); if (!l) continue;
        for (const j of l) {
          if (j <= i) continue; const dx = xy[2 * i] - xy[2 * j], dy = xy[2 * i + 1] - xy[2 * j + 1];
          if (Math.abs(dx * dx + dy * dy - 1) > 1e-7) continue;
          proposals++;
          for (let t = 0; t < m; t++) dv[t] = pts[j * m + t] - pts[i * m + t];
          if (safe ? isUnit(F, N, dv) : isUnitBig(F, N, dv)) E.push(i, j);
        }
      }
    }
    return { E: new Int32Array(E), xy, proposals };
  }
  function isUnitBig(F, N, v) {
    const { n, d, pairs } = F, b = (x) => BigInt(x); let q = 0n;
    for (let S = 0; S < n; S++) q += b(d[S]) * (b(v[S]) * b(v[S]) + b(v[n + S]) * b(v[n + S]));
    if (q !== b(N) * b(N)) return false;
    for (let R = 1; R < n; R++) { let t = 0n; for (const [S, T, cc] of pairs[R]) t += b(cc) * (b(v[S]) * b(v[T]) + b(v[n + S]) * b(v[n + T])); if (t) return false; }
    return true;
  }

  // ---- shapes on the drawn graph ----
  function adjacency(np, E) {
    const adj = Array.from({ length: np }, () => []);
    for (let e = 0; e < E.length; e += 2) { adj[E[e]].push(E[e + 1]); adj[E[e + 1]].push(E[e]); }
    for (const l of adj) l.sort((a, b) => a - b);
    return adj;
  }
  function triangles(adj) {
    const T = [];
    for (let u = 0; u < adj.length; u++) for (const v of adj[u]) if (v > u) {
      const A = adj[u], B = adj[v]; let i = 0, j = 0;
      while (i < A.length && j < B.length) { if (A[i] < B[j]) i++; else if (A[i] > B[j]) j++; else { if (A[i] > v) T.push(u, v, A[i]); i++; j++; } }
    }
    return T;
  }
  // Moser spindles: an apex a with two rhombus tips (b + c − a over a triangle abc) at unit distance.
  // In the plane each tip at distance √3 fixes its rhombus, and one spindle has one apex.
  function spindles(F, pts, np, adj, T) {
    const m = 2 * F.n, pmap = new Map();
    for (let i = 0; i < np; i++) { const h = hashVec(pts.subarray(i * m, (i + 1) * m)); const l = pmap.get(h); l ? l.push(i) : pmap.set(h, [i]); }
    const tmp = new Int32Array(m);
    const find = () => { const l = pmap.get(hashVec(tmp)); if (l) for (const i of l) { let ok = true; for (let t = 0; t < m && ok; t++) if (pts[i * m + t] !== tmp[t]) ok = false; if (ok) return i; } return -1; };
    const tips = Array.from({ length: np }, () => new Map()); // apex -> tip -> [b, c]
    for (let e = 0; e < T.length; e += 3) {
      const tri = [T[e], T[e + 1], T[e + 2]];
      for (let r = 0; r < 3; r++) {
        const a = tri[r], b = tri[(r + 1) % 3], c = tri[(r + 2) % 3];
        for (let t = 0; t < m; t++) tmp[t] = pts[b * m + t] + pts[c * m + t] - pts[a * m + t];
        const tip = find(); if (tip >= 0) tips[a].set(tip, [b, c]);
      }
    }
    const S = [];
    for (let a = 0; a < np; a++) {
      const ts = [...tips[a].keys()];
      for (let i = 0; i < ts.length; i++) for (let j = i + 1; j < ts.length; j++)
        if (bsearch(adj[ts[i]], ts[j])) S.push([a, ...tips[a].get(ts[i]), ts[i], ...tips[a].get(ts[j]), ts[j]]);
    }
    return S;
  }
  const bsearch = (A, x) => { let lo = 0, hi = A.length - 1; while (lo <= hi) { const mid = (lo + hi) >> 1; if (A[mid] === x) return true; if (A[mid] < x) lo = mid + 1; else hi = mid - 1; } return false; };
  // shortest odd cycle of the drawn graph, by breadth-first search from every vertex
  function shortestOddCycle(adj) {
    const np = adj.length, dist = new Int32Array(np), par = new Int32Array(np), q = new Int32Array(np);
    let best = Infinity, cyc = null;
    for (let s = 0; s < np; s++) {
      dist.fill(-1); dist[s] = 0; par[s] = -1; let h = 0, t = 0; q[t++] = s;
      while (h < t) {
        const u = q[h++]; if (2 * dist[u] + 1 >= best) break;
        for (const v of adj[u]) {
          if (dist[v] < 0) { dist[v] = dist[u] + 1; par[v] = u; q[t++] = v; }
          else if (dist[v] === dist[u] && u < v) {
            const len = 2 * dist[u] + 1;
            if (len < best) {
              const pu = [], pv = []; let x = u, y = v;
              while (x !== y) { pu.push(x); pv.push(y); x = par[x]; y = par[y]; }
              const c = [...pu, x, ...pv.reverse()];
              if (c.length === len) { best = len; cyc = c; }
            }
          }
        }
      }
      if (best === 3) break;
    }
    return cyc;
  }
  // an odd cycle found by breadth-first search from one vertex: the first same-level edge, closed through the tree
  function oddCycleFrom(adj, s) {
    const np = adj.length, dist = new Int32Array(np).fill(-1), par = new Int32Array(np), q = new Int32Array(np);
    dist[s] = 0; par[s] = -1; let h = 0, t = 0; q[t++] = s;
    while (h < t) {
      const u = q[h++];
      for (const v of adj[u]) {
        if (dist[v] < 0) { dist[v] = dist[u] + 1; par[v] = u; q[t++] = v; }
        else if (dist[v] === dist[u]) { const pu = [], pv = []; let x = u, y = v; while (x !== y) { pu.push(x); pv.push(y); x = par[x]; y = par[y]; } return [...pu, x, ...pv.reverse()]; }
      }
    }
    return null;
  }
  // shortest odd cycle of the Cayley graph of the directions, by breadth-first search from 0 with a point cap
  function* cayleyOddCycle(F, N, W, cap) {
    const m = 2 * F.n; let store = new Int32Array(Math.min(cap, 4096) * m); let np = 0;
    const pmap = new Map(), level = [], parent = [], via = [];
    const ensure = () => { if ((np + 1) * m > store.length) { const s2 = new Int32Array(store.length * 2); s2.set(store); store = s2; } };
    const tmp = new Int32Array(m);
    const find = () => { const l = pmap.get(hashVec(tmp)); if (l) for (const i of l) { let ok = true; for (let t = 0; t < m && ok; t++) if (store[i * m + t] !== tmp[t]) ok = false; if (ok) return i; } return -1; };
    const add = (lev, p, w) => { ensure(); store.set(tmp, np * m); const h = hashVec(tmp); const l = pmap.get(h); l ? l.push(np) : pmap.set(h, [np]); level.push(lev); parent.push(p); via.push(w); return np++; };
    tmp.fill(0); add(0, -1, -1);
    let head = 0, L = -1;
    while (head < np) {
      const u = head++;
      if (level[u] !== L) { L = level[u]; yield { level: L, points: np }; }
      for (let w = 0; w < W.length; w++) {
        for (let t = 0; t < m; t++) tmp[t] = store[u * m + t] + W[w][t];
        const v = find();
        if (v < 0) { if (np >= cap) return { found: false, radius: L, points: np }; add(level[u] + 1, u, w); }
        else if (level[v] === level[u]) {
          const words = []; let x = u; const a = []; while (x > 0) { a.push(via[x]); x = parent[x]; }
          let y = v; const b = []; while (y > 0) { b.push(via[y]); y = parent[y]; }
          // closed walk 0 → u → v → 0 of length 2L+1; shortest odd closed walk through 0 is a cycle
          const walk = [...a.reverse(), w]; const back = b; // v = sum(b); return along −b in reverse
          const verts = []; const acc = new Int32Array(m); verts.push(acc.slice());
          for (const wi of walk) { for (let t = 0; t < m; t++) acc[t] += W[wi][t]; verts.push(acc.slice()); }
          for (let i = 0; i < back.length - 1; i++) { for (let t = 0; t < m; t++) acc[t] -= W[back[i]][t]; verts.push(acc.slice()); }
          return { found: true, length: 2 * level[u] + 1, verts, points: np };
        }
      }
    }
    return { found: false, radius: L, points: np, exhausted: true };
  }

  // exact coordinate as text: (Σ X_S √d_S) / N, reduced
  function fmt(F, N, v, off) {
    let g = N; for (let S = 0; S < F.n; S++) g = gcd(g, v[off + S]);
    const den = N / g; let s = '';
    for (let S = 0; S < F.n; S++) {
      const a = v[off + S] / g; if (!a) continue;
      const mag = Math.abs(a), rad = F.d[S] === 1 ? '' : '√' + F.d[S];
      const term = rad ? (mag === 1 ? rad : mag + rad) : String(mag);
      s += s ? (a < 0 ? ' − ' : ' + ') + term : (a < 0 ? '−' : '') + term;
    }
    if (!s) return '0';
    const multi = s.includes(' + ') || s.includes(' − ');
    return den === 1 ? s : (multi ? '(' + s + ')' : s) + '/' + den;
  }

  return { gcd, isqrt, makeField, unitVectors, isUnit, embed, grow, edgesOf, hashVec, adjacency, triangles, spindles, shortestOddCycle, oddCycleFrom, cayleyOddCycle, fmt };
})();
if (typeof module !== 'undefined') module.exports = Core;
