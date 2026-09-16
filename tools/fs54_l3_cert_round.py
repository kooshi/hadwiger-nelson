#!/usr/bin/env python3
"""fs54_l3_cert_round -- turn an iterate of the level-3 semidefinite programme for alpha(UD(F_q, 2)) into an EXACT
rational certificate that `tools/fs54_l3_cert_check.py` accepts.

It is the untrusted half of the pair: it uses numpy, the float iterate of `tools/fs54_d4_quad.py`'s ADMM (or SCS)
and any heuristic at all, because nothing it writes is believed until the checker -- standard library, exact
arithmetic, its own rebuild of every orbit and every matrix entry from q and the modulus -- has accepted it.
Derivation: `plans/FS54-L3-certificate-soundness.md`.

WHAT IT DOES (subcommand `round`).
  1. Copies the checkpoint (a live solve rewrites it; the copy's sha256 and iteration count go in the provenance).
  2. Rebuilds the programme with `fs54_d4_quad` and projects the iterate onto the PSD cone.  The float
     certificate-shaped value N (the pricing page's section 3) is recorded as the READING this rounding aims at.
  3. For each of the solver's character blocks: eigendecompose, drop eigenvalues below `--cut` (relative to the
     block's largest), take the square-root factor, and move it to the checker's presentation -- columns are the
     signed orbit sums  sum_{w in H r_i} chi(h_w) e_w  of the block's representatives, and the Gram factor is
     multiplied by diag(sqrt(|Stab r_i| / |H|)) (derived beside `to_checker_basis`) -- then scale by sqrt(t) for the
     best t found in floats and round to integers over `--den`.
  4. Scores the ROUNDED factors in floats through the solver's own constraint matrix (a second, independent
     implementation of the pairing), then computes the multipliers and N EXACTLY with the checker's pairing
     (mu = max(0, a), lambda = max(0, -a), N = o0 + c0 + sum mu -- the determined rule), writes the certificate,
     and runs the checker on it in a fresh process, saving its log.
The float score of step 4 and the exact N must agree to rounding noise; they come from two different
implementations of the programme, so their agreement is a control on the checker's semantics.

Subcommand `transport` rewrites a certificate through the field isomorphism F_3[t]/(t^3-t-1) -> F_3[t]/(t^3-t-2)
(points relabelled, variables re-canonicalised, multipliers permuted, N unchanged): the faithful twin of the
wrong-modulus plant.  Subcommand `controls` builds the plants from genuine certificates and runs the checker on
each, recording what it printed.

USAGE (the .venv python; keep BLAS threads modest when other jobs run)
  .venv/bin/python tools/fs54_l3_cert_round.py round --q 27 --modulus 't^3-t-1' --ckpt data/fs54/d4/ckpt/admm-q27.npz \
      --den 1000000000 --jobs 8 --out data/fs54/cert-q27-l3-N143.json
"""

from __future__ import annotations

import argparse
import hashlib
import json
import math
import shutil
import subprocess
import sys
import time
from fractions import Fraction
from pathlib import Path

import numpy as np

sys.path.insert(0, str(Path(__file__).resolve().parent))
import fs54_d4_quad as Q            # noqa: E402  the programme as the solver saw it
import fs54_l3_cert_check as C      # noqa: E402  the checker's pairing, so the multipliers are what it verifies

REPO = Path(__file__).resolve().parent.parent
ANCHORS = {"Y": lambda d: [[0, "+"]], "MY": lambda d: [[0, "-"]], "++": lambda d: [[0, "+"], [d, "+"]],
           "+-": lambda d: [[0, "+"], [d, "-"]], "--": lambda d: [[0, "-"], [d, "-"]]}


def sha256_file(p):
    h = hashlib.sha256()
    with open(p, "rb") as fh:
        for chunk in iter(lambda: fh.read(1 << 20), b""):
            h.update(chunk)
    return h.hexdigest()


# ------------------------------------------------------------------------------------------------ the programme
def block_meta(P, Tb, family, dreps):
    """The solver's blocks in `Q.build`'s order, with what `Q.blocks_for` computes but does not return: the pattern,
    d, the group H (as permutation rows), the character, the representatives R and their stabiliser sizes."""
    n = P.n
    out = []
    for pat in Q.FAMILIES[family]:
        ds = [0] if pat in ("Y", "MY") else [d for d in dreps if not (P.unit[d] and pat in ("++", "+-"))]
        for d in ds:
            gens = Q.pattern_group(P, pat, d)
            k = len(gens)
            elems, bits_of = [], []
            for bits in range(1 << k):
                g = np.arange(n)
                for i in range(k):
                    if bits >> i & 1:
                        g = gens[i][g]
                elems.append(g)
                bits_of.append(bits)
            H = np.array(elems)
            rep = H.min(axis=0)
            reps = np.nonzero(rep == np.arange(n))[0]
            st_all = (H == np.arange(n)[None, :]).sum(axis=0)
            for chi in range(1 << k):
                chis = np.array([(-1) ** bin(b & chi).count("1") for b in bits_of], dtype=np.int64)
                fixed = H[:, reps] == reps[None, :]
                valid = np.all((chis[:, None] == 1) | ~fixed, axis=0)
                R = reps[valid]
                if len(R) == 0:
                    continue
                out.append(dict(label=f"{pat}@{d}/chi{chi}", pat=pat, d=int(d), m=len(R), H=H, chis=chis, R=R,
                                st=st_all[R].astype(np.int64), anchors=ANCHORS[pat](int(d))))
    return out


def columns_of(meta):
    """the signed orbit sums of the representatives, as the checker's flat [point, coefficient, ...] lists"""
    H, chis = meta["H"], meta["chis"]
    cols = []
    for r in meta["R"]:
        col = {}
        for h in range(len(H)):
            w = int(H[h, r])
            if w in col:
                assert col[w] == int(chis[h]), "a character that does not kill the stabiliser"
            col[w] = int(chis[h])
        flat = []
        for w in sorted(col):
            flat += [w, col[w]]
        cols.append(flat)
    return cols


def to_checker_basis(meta):
    """The diagonal D with  Z_checker = D Z_solver D.

    The solver's block is B[i,j] = sum_h chi(h) A[r_i, h r_j] / sqrt(st_i st_j).  The checker pairs a block Z' with
    columns c_i = sum_{w in H r_i} chi(h_w) e_w  as  sum_{i,j} Z'[i,j] sum_{w,w'} c_i[w] c_j[w'] A[w,w'], and
    sum_{w in H r_i} c_i[w] f(w) = (1/st_i) sum_h chi(h) f(h r_i); by the H-invariance of A as a function of the
    canonical forms (H fixes the anchor set) and chi(h) chi(h') = chi(h h'), the inner double sum is
    (|H| / (st_i st_j)) sum_g chi(g) A[r_i, g r_j] = |H| B[i,j] / sqrt(st_i st_j).  So <Z', .> = <Z, B> exactly when
    Z'[i,j] = Z[i,j] sqrt(st_i st_j) / |H|, i.e. D = diag(sqrt(st_i / |H|)).  A wrong D would only weaken the
    certificate (any D keeps Z' PSD); the float score of the rounded factors through the solver's own matrix
    (`float_score`) is the control that this one is right."""
    return np.sqrt(meta["st"] / len(meta["H"]))


def rebuild(q, modulus, family="l3", log=print):
    P = Q.Plane(q, modulus)
    dreps, _, _ = Q.d_classes(P)
    Tb = Q.Tables(P, dreps, log=lambda *a: None)
    blocks = Q.build(P, Tb, family, dreps)
    data, cone, oc = Q.assemble_scs(P, Tb, blocks)
    meta = block_meta(P, Tb, family, dreps)
    got = [(b[0], b[1]) for b in blocks]
    want = [(m["label"], m["m"]) for m in meta]
    assert got == want, "block_meta disagrees with fs54_d4_quad.build's block order"
    assert cone["l"] == Tb.nvar and list(cone["s"]) == [m["m"] for m in meta]
    return P, dreps, Tb, data, cone, oc, meta


def block_views(vec, cone, K):
    """float m x m matrices of the PSD blocks of a cone vector (scaled lower-triangle vectorisation)"""
    off = cone["l"]
    mats = []
    for m in cone["s"]:
        L = m * (m + 1) // 2
        i, j, sc = K.idx[m]
        M = np.zeros((m, m))
        M[i, j] = vec[off:off + L] * sc
        M[j, i] = M[i, j]
        mats.append(M)
        off += L
    return mats


def vectorise(mats, cone, K):
    out = np.zeros(cone["l"] + sum(m * (m + 1) // 2 for m in cone["s"]))
    off = cone["l"]
    for M, m in zip(mats, cone["s"]):
        L = m * (m + 1) // 2
        i, j, sc = K.idx[m]
        out[off:off + L] = M[i, j] / sc
        off += L
    return out


def factors(mats, cut):
    """per block: G (r x m float) with G^T G = the block's eigen-truncated part; eigenvalues below cut * max dropped"""
    Gs, ranks = [], []
    for M in mats:
        ev, V = np.linalg.eigh(M)
        top = max(ev[-1], 0.0)
        keep = ev > cut * max(top, 1e-300)
        G = (np.sqrt(ev[keep])[:, None] * V[:, keep].T) if keep.any() else np.zeros((0, M.shape[0]))
        Gs.append(G)
        ranks.append(int(keep.sum()))
    return Gs, ranks


def float_score(Gc_list, metas, den, data, cone, oc, K):
    """N through the SOLVER's constraint matrix for integer checker-basis factors over den: Z_solver = D^-1 (G^T G /
    den^2) D^-1.  Float, but an independent implementation of the pairing."""
    mats = []
    for Gi, meta in zip(Gc_list, metas):
        D = to_checker_basis(meta)
        Zc = (Gi.T.astype(np.float64) @ Gi.astype(np.float64)) / float(den) ** 2 if len(Gi) else np.zeros((meta["m"],) * 2)
        mats.append(Zc / D[:, None] / D[None, :])
    return Q.certificate_shaped_value(data, cone, oc, vectorise(mats, cone, K))


def round_factors(Gs, metas, den, t):
    out = []
    for G, meta in zip(Gs, metas):
        Gc = G * math.sqrt(t) * to_checker_basis(meta)[None, :]
        assert np.abs(Gc).max(initial=0.0) * den < 2.0 ** 62, "a Gram entry over den would overflow int64: lower --den"
        Gi = np.rint(Gc * den).astype(np.int64)
        if len(Gi):
            nz = np.any(Gi != 0, axis=1)
            Gi = Gi[nz]
        out.append(Gi)
    return out


# ------------------------------------------------------------------------------------------------ the certificate
def variables_of(Tb, n):
    P4 = np.stack([np.zeros(Tb.nvar, dtype=np.int64), Tb.var_key // ((n + 1) * (n + 1)), (Tb.var_key // (n + 1)) % (n + 1),
                   Tb.var_key % (n + 1)], axis=1)
    return [[int(x) for x in row if x < n] for row in P4]


def claim_text(q, modulus, alpha):
    fld = f"F_{q}^2" if modulus is None else f"F_{q}^2 (F_{q} = F_{C.is_prime_power(q)[0]}[t]/({modulus}))"
    return (f"every independent set of the unit-distance graph on {fld} -- every set of points no two of which differ by a "
            f"vector of quadrance 1 -- has at most {alpha} points")


def build_cert(q, modulus, P, Tb, metas, Gi_list, den):
    F = C.Field(q, modulus)
    mats = {}
    order = []
    for meta, Gi in zip(metas, Gi_list):
        key = (meta["pat"], meta["d"])
        if key not in mats:
            mats[key] = {"anchors": meta["anchors"], "blocks": []}
            order.append(key)
        if len(Gi) == 0:
            continue
        mats[key]["blocks"].append({"label": meta["label"], "columns": columns_of(meta),
                                    "gram": {"den": int(den), "num": [[int(x) for x in row] for row in Gi]}})
    n = P.n
    cert = {
        "kind": C.KIND, "q": q, "p": F.p, "f": F.f, "modulus": modulus, "edges_sha256": C.graph_sha256(F),
        "N": "0", "alpha_bound": 0, "claim": "",
        "vertex_index": f"v = x*{q} + y for the point (x, y) of F_{q}^2, with 0 <= x, y < {q}",
        "edge_rule": (f"two points are adjacent iff their difference (dx, dy) satisfies dx^2 + dy^2 = 1 in F_{q}"
                      + ("" if modulus is None else
                         f", where F_{q} = F_3[t]/({modulus}) and an element c_0 + c_1 t + c_2 t^2 is named by the integer "
                         f"whose base-3 digits are (c_0, c_1, c_2), most significant first (so 1 is named 9 and t is named 3)")),
        "symmetry": ("variables are the orbits of sets of 2 to 4 points under V x| G0, G0 generated by the rotations by the "
                     "points of the unit circle, the reflection (x, y) -> (x, -y) and the Frobenius; each variable is named by "
                     "its canonical form, the least (as a sorted tuple) of the nonzero points of g(T - t) over t in T and g in G0, "
                     "listed with the origin prepended and sorted by (size, points)"),
        "matrix_form": ("each matrix has anchors [point, sign] and entries A[u,w] = (1/s) sum_z prod_a [z+a in S]^sign "
                        "[z+u in S][z+w in S] averaged over the group, expanded by [.]^- = 1 - [.]; it is presented as "
                        "sum over blocks of U Z U^T with U's columns given sparsely and Z = G^T G / den^2"),
        "variables": variables_of(Tb, n),
        "matrices": [mats[k] for k in order],
        "multipliers": {},
        "derivation": "plans/FS54-L3-certificate-soundness.md",
        "produced_by": ("tools/fs54_l3_cert_round.py (untrusted: a floating-point ADMM iterate proposes, exact rational "
                        "arithmetic disposes); checked by tools/fs54_l3_cert_check.py, which rebuilds the plane, its group, "
                        "every canonical form and every matrix entry from q and the modulus alone"),
    }
    return cert


def exact_fill(cert, q, modulus, jobs, log=print):
    F = C.Field(q, modulus)
    Pc = C.Plane(F)
    index, K = C.read_variables(cert, Pc.n)
    t0 = time.time()
    lf = C.fill_multipliers(cert, Pc, index, K, jobs=jobs, log=log)
    alpha = cert["alpha_bound"]
    cert["claim"] = claim_text(q, modulus, alpha)
    return lf, time.time() - t0


def write_json(obj, path):
    Path(path).parent.mkdir(parents=True, exist_ok=True)
    tmp = Path(str(path) + ".tmp")
    with open(tmp, "w") as fh:
        json.dump(obj, fh, separators=(",", ":"))
    tmp.replace(path)


def run_checker(cert_path, log_path, jobs, k=None):
    cmd = ["python3", str(REPO / "tools/fs54_l3_cert_check.py"), str(cert_path), "--jobs", str(jobs)]
    if k:
        cmd += ["--k", str(k)]
    t0 = time.time()
    with open(log_path, "w") as fh:
        fh.write(f"$ {' '.join(cmd)}\n")
        fh.flush()
        r = subprocess.run(cmd, stdout=fh, stderr=subprocess.STDOUT, cwd=REPO)
    dt = time.time() - t0
    text = Path(log_path).read_text()
    return r.returncode, dt, text


# ------------------------------------------------------------------------------------------------ subcommands
def cmd_round(a):
    t_all = time.time()
    src = Path(a.ckpt)
    snap = Path(a.snapshot) if a.snapshot else src.with_name(src.stem + f"-certcopy-{time.strftime('%Y%m%dT%H%M%S')}.npz")
    if not a.snapshot or not snap.exists():
        shutil.copy(src, snap)
    digest = sha256_file(snap)
    z = np.load(snap)
    iters = int(z["iters"])
    raw = z["X"] if "X" in z.files else z["y"]
    fp = json.loads(str(z["fingerprint"]))
    print(f"[round] snapshot {snap} (sha256 {digest[:16]}..., {iters} iterations, fingerprint {fp})", flush=True)
    P, dreps, Tb, data, cone, oc, metas = rebuild(a.q, a.modulus, a.family)
    if fp.get("nvar") != Tb.nvar or fp.get("rows") != data["A"].shape[0] or fp.get("q") != a.q:
        raise SystemExit(f"the checkpoint's fingerprint does not match the rebuilt programme: {fp}")
    K = Q.ConeProjector(cone)
    Zv = K.project(raw)
    reading = Q.certificate_shaped_value(data, cone, oc, Zv)
    print(f"[round] float certificate-shaped N of the projected iterate (the READING): {reading['N']:.6f} "
          f"(sum mu {reading['mu_sum']:.6f})", flush=True)
    mats = block_views(Zv, cone, K)
    Gs, ranks = factors(mats, a.cut)
    trunc = float_score([G * to_checker_basis(m)[None, :] * a.den for G, m in zip(Gs, metas)], metas, a.den, data, cone, oc, K)
    print(f"[round] eigen-truncation at cut {a.cut:g}: ranks sum {sum(ranks)}, Gram entries {sum(r * m['m'] for r, m in zip(ranks, metas))}; "
          f"float N {trunc['N']:.6f}", flush=True)
    best = None
    for t in np.linspace(a.tmin, a.tmax, a.tsteps):
        Gi = round_factors(Gs, metas, a.den, t)
        sc = float_score(Gi, metas, a.den, data, cone, oc, K)
        print(f"[round]   scale t = {t:.4f}: rounded over den {a.den}: float N {sc['N']:.6f} (sum mu {sc['mu_sum']:.6f})", flush=True)
        if best is None or sc["N"] < best[0]:
            best = (sc["N"], t, Gi, sc)
    fN, t, Gi_list, sc = best
    print(f"[round] chosen scale {t:.4f}: float N of the ROUNDED factors {fN:.6f}", flush=True)
    cert = build_cert(a.q, a.modulus, P, Tb, metas, Gi_list, a.den)
    lf, dt = exact_fill(cert, a.q, a.modulus, a.jobs, log=lambda s: print("[exact] " + s, flush=True))
    Nx = Fraction(cert["N"])
    print(f"[round] EXACT N = {float(Nx):.9f} (floor {math.floor(Nx)}), computed in {dt:.0f} s; float score of the same "
          f"factors {fN:.9f}; difference {float(Nx) - fN:.3e}", flush=True)
    cert["provenance"] = {
        "checkpoint": str(src), "snapshot": str(snap), "snapshot_sha256": digest, "iterations": iters,
        "solver": fp.get("method", "scs"), "fingerprint": fp,
        "float_reading_N": reading["N"], "float_reading_sum_mu": reading["mu_sum"],
        "eigenvalue_cut_relative": a.cut, "gram_denominator": a.den, "scale": float(t),
        "float_score_rounded_N": fN, "exact_N_float": float(Nx),
        "ranks_sum": int(sum(ranks)), "gram_entries": int(sum(len(G) * m["m"] for G, m in zip(Gi_list, metas))),
        "blocks_nonzero": int(sum(1 for G in Gi_list if len(G))), "blocks": len(metas),
        "seconds": time.time() - t_all, "produced": time.strftime("%Y-%m-%dT%H:%M:%S"),
    }
    out = Path(a.out.replace("{N}", str(math.floor(Nx))))
    write_json(cert, out)
    print(f"[round] wrote {out} ({out.stat().st_size / 2**20:.1f} MiB)", flush=True)
    if not a.no_check:
        logp = Path(a.log.replace("{N}", str(math.floor(Nx)))) if a.log else out.with_suffix(".check.log")
        code, dt, text = run_checker(out, logp, a.jobs, k=a.k)
        print(f"[round] checker exit {code} in {dt:.0f} s; log {logp}", flush=True)
        print("\n".join(text.strip().splitlines()[-6:]), flush=True)
        return code
    return 0


def field_iso_27(src_mod, dst_mod):
    """the point map of the field isomorphism F_3[t]/(src) -> F_3[t]/(dst): t -> a root r of src in dst"""
    Fs, Fd = C.Field(27, src_mod), C.Field(27, dst_mod)
    # the source polynomial's coefficients, read from its own reduction: t^3 = red[0] + red[1] t + red[2] t^2
    red_s = Fs.red
    one = Fd.one
    roots = []
    for r in range(27):
        r2 = Fd.mul(r, r)
        r3 = Fd.mul(r2, r)
        rhs = Fd.add(Fd.add(_scalar(Fd, red_s[0]), Fd.mul(_scalar(Fd, red_s[1]), r)), Fd.mul(_scalar(Fd, red_s[2]), r2))
        if r3 == rhs:
            roots.append(r)
    assert roots, "no root: the moduli do not define isomorphic fields"
    r = roots[0]
    pw = [9, 3, 1]                                   # names of 1, t, t^2 in the source (most significant digit first)

    def phi(a):
        c = [(a // pw[i]) % 3 for i in range(3)]
        out = Fd.zero
        rp = one
        for i in range(3):
            out = Fd.add(out, Fd.mul(_scalar(Fd, c[i]), rp))
            rp = Fd.mul(rp, r)
        return out

    table = [phi(a) for a in range(27)]
    for a in range(27):
        for b in range(27):
            assert table[Fs.add(a, b)] == Fd.add(table[a], table[b]) and table[Fs.mul(a, b)] == Fd.mul(table[a], table[b])
    return [table[v // 27] * 27 + table[v % 27] for v in range(729)], r


def _scalar(F, c):
    """the integer c in F_p, as a field element name"""
    out = F.zero
    for _ in range(c % F.p):
        out = F.add(out, F.one)
    return out


def cmd_transport(a):
    cert = json.loads(Path(a.cert).read_text())
    phi, r = field_iso_27(cert["modulus"], a.to)
    Pd = C.Plane(C.Field(27, a.to))
    newvars = []
    for v in cert["variables"]:
        k = Pd.key([phi[x] for x in v])
        newvars.append([0] + list(k))
    order = sorted(range(len(newvars)), key=lambda i: (len(newvars[i]), newvars[i]))
    assert len({tuple(v) for v in newvars}) == len(newvars), "transport merged two variables"
    out = json.loads(json.dumps(cert))
    out["modulus"] = a.to
    out["edges_sha256"] = C.graph_sha256(C.Field(27, a.to))
    out["variables"] = [newvars[i] for i in order]
    for name in ("lower", "upper"):
        out["multipliers"][name] = [cert["multipliers"][name][i] for i in order]
    for mo in out["matrices"]:
        mo["anchors"] = [[phi[p], s] for p, s in mo["anchors"]]
        for blk in mo["blocks"]:
            newcols = []
            for col in blk["columns"]:
                pairs = sorted((phi[col[j]], col[j + 1]) for j in range(0, len(col), 2))
                newcols.append([x for pr in pairs for x in pr])
            blk["columns"] = newcols
    out["claim"] = claim_text(27, a.to, out["alpha_bound"])
    out.setdefault("provenance", {})["transported"] = (f"from {a.cert} through the field isomorphism t -> {r} (the name of a root "
                                                      f"of {cert['modulus']} in F_3[t]/({a.to})); N unchanged")
    write_json(out, a.out)
    print(f"[transport] wrote {a.out}: t -> {r}, {len(newvars)} variables re-canonicalised")


def cmd_controls(a):
    """Plants on genuine certificates, each run through the checker in a fresh process; results to a JSON record."""
    results = []
    work = Path(a.workdir)
    work.mkdir(parents=True, exist_ok=True)
    logdir = Path(a.logdir or a.workdir)
    logdir.mkdir(parents=True, exist_ok=True)

    def run(name, cert_obj_or_path, expect, fragment, jobs):
        if isinstance(cert_obj_or_path, (str, Path)):
            path = Path(cert_obj_or_path)
        else:
            path = work / f"{name}.json"
            write_json(cert_obj_or_path, path)
        logp = logdir / f"{name}.log"
        code, dt, text = run_checker(path, logp, jobs, k=a.k)
        last = [ln for ln in text.strip().splitlines() if ln.startswith(("CERTIFIED", "NOT A CERTIFICATE"))]
        verdict = last[-1] if last else text.strip().splitlines()[-1]
        certified = code == 0 and verdict.startswith("CERTIFIED")
        ok = certified if expect == "pass" else (not certified and fragment.lower() in verdict.lower())
        results.append(dict(control=name, expect=expect, fragment=fragment, exit=code, seconds=round(dt, 1),
                            printed=verdict, as_designed=ok, log=str(logp)))
        print(f"[controls] {'OK ' if ok else 'BAD'} {name}: expected {expect}, exit {code}, {dt:.0f} s\n           {verdict[:230]}",
              flush=True)

    for spec in a.genuine:
        path, jobs = spec.split(":") if ":" in spec else (spec, "1")
        run(f"genuine-{Path(path).stem}", path, "pass", "", int(jobs))
    if a.plant_from:
        base = json.loads(Path(a.plant_from).read_text())
        jobs = a.plant_jobs
        tag = Path(a.plant_from).stem

        def mut(f):
            c = json.loads(json.dumps(base))
            f(c)
            return c

        def flip(c):
            m = c["multipliers"]
            i = max(range(len(m["lower"])), key=lambda i: m["lower"][i])
            m["lower"][i] = -m["lower"][i]
        run(f"{tag}-a-flipped-sign", mut(flip), "refuse", "is negative", jobs)

        def smallest_block(c):
            """the Gram block of least (order, rank): its exact LDL is cheap even at q = 27"""
            best = None
            for mi, mo in enumerate(c["matrices"]):
                for bi, b in enumerate(mo["blocks"]):
                    if "gram" in b:
                        key = (len(b["columns"]), len(b["gram"]["num"]))
                        if best is None or key < best[0]:
                            best = (key, mi, bi)
            return c["matrices"][best[1]]["blocks"][best[2]]

        def densify_first_block(c, perturb):
            blk = smallest_block(c)
            G = blk.pop("gram")
            den, num = G["den"], G["num"]
            m = len(num[0])
            Z = [[sum(num[k][i] * num[k][j] for k in range(len(num))) for j in range(m)] for i in range(m)]
            if perturb:
                # make it indefinite with the smallest-looking change: a 2x2 principal minor goes negative
                i, j = 0, 1
                big = int(math.isqrt(Z[i][i] * Z[j][j])) + 1 + abs(Z[i][j])
                Z[i][j] += big
                Z[j][i] += big
            blk["Z"] = {"den": den * den, "num": Z}
        # the faithful dense twin changes nothing but the presentation, so the identity and N are unchanged
        run(f"{tag}-b-faithful-dense-block", mut(lambda c: densify_first_block(c, False)), "pass", "", jobs)
        run(f"{tag}-b-indefinite-dense-block", mut(lambda c: densify_first_block(c, True)), "refuse",
            "NOT positive semidefinite", jobs)

        def gram_bump(c):
            smallest_block(c)["gram"]["num"][0][0] += 1
        run(f"{tag}-b2-gram-entry-bumped", mut(gram_bump), "refuse", "identity fails", jobs)

        def smaller(c):
            N = Fraction(c["N"]) - Fraction(1, 10 ** 12)
            c["N"] = f"{N.numerator}/{N.denominator}"
        run(f"{tag}-d-smaller-N", mut(smaller), "refuse", "constant term", jobs)
    if a.modulus_plant:
        base = json.loads(Path(a.modulus_plant).read_text())
        tag = Path(a.modulus_plant).stem

        def other_mod(c, keep_hash):
            c["modulus"] = "t^3-t-2"
            if not keep_hash:
                c["edges_sha256"] = C.graph_sha256(C.Field(27, "t^3-t-2"))
        c1 = json.loads(json.dumps(base))
        other_mod(c1, keep_hash=True)
        run(f"{tag}-c-other-modulus-hash-kept", c1, "refuse", "edges_sha256", a.plant_jobs)
        c2 = json.loads(json.dumps(base))
        other_mod(c2, keep_hash=False)
        run(f"{tag}-c-other-modulus-hash-updated", c2, "refuse", "variable", a.plant_jobs)
        if a.transported:
            run(f"{tag}-c-faithful-transported", a.transported, "pass", "", a.plant_jobs)
    rec = dict(kind="fs54-l3-certificate-controls", results=results, all_as_designed=all(r["as_designed"] for r in results))
    prev = json.loads(Path(a.out).read_text()) if Path(a.out).exists() and a.append else None
    if prev:
        rec["results"] = prev["results"] + results
        rec["all_as_designed"] = all(r["as_designed"] for r in rec["results"])
    Path(a.out).parent.mkdir(parents=True, exist_ok=True)
    Path(a.out).write_text(json.dumps(rec, indent=1))
    print(f"[controls] {sum(r['as_designed'] for r in results)}/{len(results)} as designed; wrote {a.out}")
    return 0 if rec["all_as_designed"] else 1


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    sub = ap.add_subparsers(dest="cmd", required=True)
    r = sub.add_parser("round")
    r.add_argument("--q", type=int, required=True)
    r.add_argument("--modulus")
    r.add_argument("--family", default="l3")
    r.add_argument("--ckpt", required=True)
    r.add_argument("--snapshot", help="use (or create) this copy instead of a timestamped one")
    r.add_argument("--out", required=True, help="may contain {N}, replaced by floor(N)")
    r.add_argument("--log", help="checker log path; may contain {N}")
    r.add_argument("--den", type=int, default=10 ** 9)
    r.add_argument("--cut", type=float, default=1e-10)
    r.add_argument("--tmin", type=float, default=1.0)
    r.add_argument("--tmax", type=float, default=1.0)
    r.add_argument("--tsteps", type=int, default=1)
    r.add_argument("--jobs", type=int, default=8)
    r.add_argument("--k", type=int)
    r.add_argument("--no-check", action="store_true")
    t = sub.add_parser("transport")
    t.add_argument("--cert", required=True)
    t.add_argument("--to", default="t^3-t-2")
    t.add_argument("--out", required=True)
    c = sub.add_parser("controls")
    c.add_argument("--genuine", nargs="*", default=[], help="PATH[:JOBS] certificates that must be CERTIFIED")
    c.add_argument("--plant-from", help="a genuine certificate to plant (a), (b), (b'), (d) in")
    c.add_argument("--modulus-plant", help="a genuine q = 27 certificate to refile against t^3-t-2")
    c.add_argument("--transported", help="its faithful transport, which must pass")
    c.add_argument("--plant-jobs", type=int, default=1)
    c.add_argument("--k", type=int)
    c.add_argument("--workdir", required=True, help="where the planted certificates are written (large at q = 27)")
    c.add_argument("--logdir", help="where the checker logs go (default: the workdir)")
    c.add_argument("--out", required=True)
    c.add_argument("--append", action="store_true")
    a = ap.parse_args()
    if a.cmd == "round":
        sys.exit(cmd_round(a))
    if a.cmd == "transport":
        sys.exit(cmd_transport(a))
    sys.exit(cmd_controls(a))


if __name__ == "__main__":
    main()
