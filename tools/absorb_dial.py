#!/usr/bin/env python3
"""absorb_dial — M55's subcommands of the five-colour dial (`plans/M55-absorption.md` §4, §7, §Bʹʹʹ),
dispatched from `tools/five_dial.py`:

    five_dial.py absorb        --graph <stage> [--k 5]            # the hub-absorption census: does the base extend?
    five_dial.py core5         <stage> [--k 5]                    # the k-core: what a k-colour sweep can see at all
    five_dial.py nu-exact      <stage> [--k 5] [--wall] [--max]   # ν = fewest deletions to (k−1)-colourability, bracketed
    five_dial.py multi-spindle --object <L4> (--pairs "x,y;…" | --flower x,y --powers 1,-1,…) [--full]
    five_dial.py shrink        --object <L4> --pair x,y           # the 1-minimal forcing core (checkpointed)
    five_dial.py cross-lattice --exact … --cross … --depth 2      # the F₂₄₇ cross lattice one depth further

THE THEOREM EACH LEANS ON (`Proofs/HadwigerNelson/Absorb.lean`). A vertex set A EXTENDS at k colours when
every proper k-colouring of G[A] restricts from one of G; then the pair compulsions of G among A's
vertices are G[A]'s own, and none exist when G[A] is (k−1)-colourable. `absorb` checks the hypotheses of
`extends_of_hubs` (pieces fused at hubs, at most one base neighbour per piece vertex, non-hub chords a
matching with pairwise non-adjacent piece endpoints, the piece-union-plus-hubs (k−1)-colourable) and
reports the verdict WITH the hypothesis that failed. `core5` peels vertices of degree < k: by
`extends_of_extensionOrder` the peeled vertices are invisible at k colours. `nu-exact` measures
ν = δ_{k−1} (D5: the fifth colour's smallest class = the fewest deletions to 4-colourability) by a
cardinality ladder with two encodings, or by implicit hitting sets over re-verified solver cores; it
prints EXACT only when a certified lower bound meets a verified colouring.

Every SAT colouring is verified in Python; every UNSAT is solver-trusted and named as such. UNTRUSTED like
all of tools/. Headlines carry their population and their conditioning (G21).
"""
from __future__ import annotations
import json, random, sys, time
from fractions import Fraction as Fr
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
from five_dial import (Stage, load_stage, sat, colour_clauses, var, decode, verify_proper,   # noqa: E402
                       build_multi_spindle, shrink_core, KExt, sqrt_KExt, mp_str, planted_stage)

ROOT = Path(__file__).resolve().parent.parent
DATA = ROOT / "data" / "m55"
BUILD = ROOT / "build" / "m55"


# ----------------------------------------------------------------------------- pieces and hubs

def pieces_of_stage(st: Stage) -> tuple[list[int], dict[str, dict]]:
    """From the builder's side labels: the base A (every vertex carrying side 'U') and the pieces
    {side: {vertices, hub}} — hub = the base vertex named ('U', pairᵢ[0]) for side 'Rᵢ'. A stage with
    explicit meta 'absorb' = {base: [...], pieces: {name: {vertices, hub}}} is taken as given."""
    m = st.meta or {}
    if "absorb" in m:
        return sorted(m["absorb"]["base"]), {k: dict(vertices=sorted(v["vertices"]), hub=v.get("hub")) for k, v in m["absorb"]["pieces"].items()}
    names = m.get("names")
    if not names:
        raise SystemExit("[absorb] the stage carries no side labels (meta.names) and no meta.absorb: nothing to partition")
    base = [v for v, nm in enumerate(names) if any(s == "U" for s, _ in nm)]
    label_of = {}
    for v, nm in enumerate(names):
        for s, lab in nm:
            if s == "U":
                label_of[lab] = v
    pieces: dict[str, dict] = {}
    for v, nm in enumerate(names):
        if any(s == "U" for s, _ in nm):
            continue
        for s, _ in nm:
            pieces.setdefault(s, dict(vertices=[], hub=None))["vertices"].append(v)
    for i, sp in enumerate(m.get("spindles", [])):
        side = f"R{i}"
        if side in pieces:
            pieces[side]["hub"] = label_of.get(sp["pair"][0])
    return sorted(base), pieces


def absorb_census(st: Stage, k: int, wall: float | None = None, log=print) -> dict:
    """The hypotheses of `Absorb.extends_of_hubs` at k colours (the piece union must be (k−1)-colourable),
    per piece and overall; the verdict names the failing hypothesis. Also the D5 bound."""
    base, pieces = pieces_of_stage(st)
    A = set(base); n = st.n
    hub_of = {}
    for name, pc in pieces.items():
        for v in pc["vertices"]:
            hub_of[v] = pc["hub"]
    outside = [v for v in range(n) if v not in A]
    missing = [v for v in outside if v not in hub_of]
    if missing:
        raise SystemExit(f"[absorb] {len(missing)} vertices outside the base belong to no piece (first {missing[:5]})")
    # hcomp: adjacent piece vertices share a hub (pieces never touch, or share the hub)
    hcomp_bad = [(u, v) for u, v in st.edges if u not in A and v not in A and hub_of[u] != hub_of[v]]
    # hdeg: ≤ 1 base neighbour per piece vertex
    base_nb = {v: sorted(w for w in st.adj[v] if w in A) for v in outside}
    hist: dict[int, int] = {}
    for v in outside:
        hist[len(base_nb[v])] = hist.get(len(base_nb[v]), 0) + 1
    hdeg_bad = [v for v in outside if len(base_nb[v]) >= 2]
    # hind: the non-hub-attached piece vertices are pairwise non-adjacent
    attached = [v for v in outside if any(w != hub_of[v] for w in base_nb[v])]
    att = set(attached)
    hind_bad = [(u, v) for u, v in st.edges if u in att and v in att]
    # hcol: G[piece union ∪ hubs] is (k−1)-colourable (gives ψ and h at once)
    hubs = sorted(set(h for h in hub_of.values() if h is not None))
    piece_plus = sorted(set(outside) | set(hubs))
    idx = {v: i for i, v in enumerate(piece_plus)}
    E = [(idx[u], idx[v]) for u, v in st.edges if u in idx and v in idx]
    t0 = time.time()
    cl = colour_clauses(len(piece_plus), E, k - 1)
    if piece_plus:
        cl.append([var(0, 0, k - 1)])
    stt, model = sat(cl, wall=wall)
    hcol = dict(status=stt, seconds=round(time.time() - t0, 1))
    if stt == "sat":
        col = decode(model, len(piece_plus), k - 1)
        assert verify_proper(col, E) is None, "the piece colouring is improper"
        hcol["verified"] = True
    # the base's own colourability (ν(A) = 0 iff (k−1)-colourable)
    bidx = {v: i for i, v in enumerate(base)}
    EB = [(bidx[u], bidx[v]) for u, v in st.edges if u in bidx and v in bidx]
    stb, mb = sat(colour_clauses(len(base), EB, k - 1) + ([[var(0, 0, k - 1)]] if base else []), wall=wall)
    base_col = dict(status=stb)
    if stb == "sat":
        colb = decode(mb, len(base), k - 1); assert verify_proper(colb, EB) is None
        base_col["verified"] = True
    per_piece = {}
    for name, pc in pieces.items():
        vs = pc["vertices"]
        per_piece[name] = dict(size=len(vs), hub=pc["hub"], base_neighbour_histogram={str(d): sum(1 for v in vs if len(base_nb[v]) == d) for d in sorted(set(len(base_nb[v]) for v in vs))},
                               non_hub_chords=sum(1 for v in vs if v in att), hub_chords=sum(1 for v in vs if pc["hub"] in base_nb[v]))
    ok = not hcomp_bad and not hdeg_bad and not hind_bad and hcol["status"] == "sat"
    reasons = []
    if hcomp_bad: reasons.append(f"hcomp: {len(hcomp_bad)} piece–piece edges across different hubs (first {hcomp_bad[:3]})")
    if hdeg_bad: reasons.append(f"hdeg: {len(hdeg_bad)} piece vertices with ≥ 2 base neighbours (first {hdeg_bad[:5]})")
    if hind_bad: reasons.append(f"hind: {len(hind_bad)} edges among the non-hub-attached piece vertices (first {hind_bad[:3]})")
    if hcol["status"] != "sat": reasons.append(f"hcol: the piece union plus hubs is {'NOT ' + str(k-1) + '-colourable (the pieces are themselves ' + str(k) + '-chromatic)' if hcol['status'] == 'unsat' else 'undecided at the wall'}")
    bound = None
    if ok:
        bound = (0 if stb == "sat" else None)
        if bound is not None:
            bound += len(attached)
    verdict = (f"the base extends at {k} colours by Absorb.extends_of_hubs — no pair compulsion at {k} colours among the base's {len(base)} vertices"
               + (f"; D5: ν ≤ ν(base) + {len(attached)} = {bound}" if bound is not None else "")) if ok else "NOT absorbed by theorem — " + "; ".join(reasons)
    log(f"[absorb] {st.label()} k={k}: base {len(base)} ({(k-1)}-colourable: {stb}), pieces {len(pieces)} ({len(outside)} vertices, hubs {hubs}); "
        f"base-neighbour histogram over the piece vertices {dict(sorted(hist.items()))}; piece–piece edges across hubs {len(hcomp_bad)}; "
        f"non-hub chords {len(attached)} with {len(hind_bad)} edges among their piece endpoints; piece∪hubs {k-1}-colourable: {hcol['status']} "
        f"[{hcol['seconds']}s]. VERDICT: {verdict}", flush=True)
    for name, pc in sorted(per_piece.items()):
        log(f"[absorb]   piece {name}: {pc['size']} vertices, hub {pc['hub']}, hub chords {pc['hub_chords']}, non-hub chords {pc['non_hub_chords']}, base-neighbour histogram {pc['base_neighbour_histogram']}")
    return dict(kind="absorb-census", stage=st.header(), k=k, theorem="Absorb.extends_of_hubs", base_size=len(base), base_colourable=base_col,
                pieces=per_piece, base_neighbour_histogram={str(d): c for d, c in sorted(hist.items())},
                hcomp_violations=hcomp_bad[:200], hdeg_violations=hdeg_bad[:200], hind_violations=hind_bad[:200], hcol=hcol,
                non_hub_chords=len(attached), absorbed=ok, d5_bound=bound, verdict=verdict,
                claim_scope=f"the hypotheses of extends_of_hubs checked by enumeration on the stage's edge list (hcomp, hdeg, hind) and by one verified "
                            f"{k-1}-colouring SAT ask on the piece union plus hubs (hcol); 'absorbed' means every {k}-colouring of the base extends, "
                            f"so compulsions among base vertices are the base's own; pairs with a piece-side endpoint are NOT covered by the verdict")


def extension_ask(st: Stage, base: list[int], colouring: dict[int, int], k: int, wall=None) -> str:
    """Does the given k-colouring of the base extend to the whole stage? 'sat' (a verified extension) /
    'unsat' / 'unknown'. The red's direct witness."""
    cl = colour_clauses(st.n, st.edges, k)
    for v, c in colouring.items():
        cl.append([var(v, c, k)])
    stt, model = sat(cl, wall=wall)
    if stt == "sat":
        col = decode(model, st.n, k)
        assert verify_proper(col, st.edges) is None
        assert all(col[v] == c for v, c in colouring.items())
    return stt


def cmd_absorb(a):
    st = load_stage(a)
    DATA.mkdir(parents=True, exist_ok=True)
    rec = absorb_census(st, a.k, a.wall)
    out = Path(a.out) if a.out else DATA / f"absorb-{st.name}-k{a.k}.json"
    out.write_text(json.dumps(rec, indent=1)); print(f"[absorb] wrote {out}")


# ----------------------------------------------------------------------------- the k-core

def k_core(st: Stage, k: int) -> dict:
    """Peel every vertex of degree < k (i.e. ≤ k − 1) repeatedly; the remainder is the k-core. The
    reversed peel order is an ExtensionOrder from the core at k − 1 (re-checked here)."""
    deg = [len(st.adj[v]) for v in range(st.n)]
    alive = [True] * st.n
    order = []
    rounds = 0
    changed = True
    while changed:
        changed = False; rounds += 1
        for v in range(st.n):
            if alive[v] and deg[v] <= k - 1:
                alive[v] = False; order.append(v); changed = True
                for w in st.adj[v]:
                    if alive[w]:
                        deg[w] -= 1
    core = [v for v in range(st.n) if alive[v]]
    # re-check: adding the peeled vertices back in reverse order, each has ≤ k−1 neighbours among core ∪ earlier
    present = set(core); ok = True
    for v in reversed(order):
        if sum(1 for w in st.adj[v] if w in present) > k - 1:
            ok = False; break
        present.add(v)
    return dict(core=core, peeled=order, rounds=rounds - 1, recheck_ok=ok)


def cmd_core(a):
    st = load_stage(a)
    r = k_core(st, a.k)
    print(f"[core{a.k}] {st.label()}: {a.k}-core {len(r['core'])} of {st.n} vertices ({len(r['peeled'])} peeled in {r['rounds']} rounds; "
          f"the reversed peel order re-checked as an ExtensionOrder at {a.k-1}: {r['recheck_ok']}) — by Absorb.extends_of_extensionOrder the "
          f"{len(r['peeled'])} peeled vertices are invisible at {a.k} colours; max degree in the core {max((len([w for w in st.adj[v] if w in set(r['core'])]) for v in r['core']), default=0)}", flush=True)
    DATA.mkdir(parents=True, exist_ok=True)
    out = Path(a.out) if a.out else DATA / f"core-{st.name}-k{a.k}.json"
    out.write_text(json.dumps(dict(kind="k-core", stage=st.header(), k=a.k, theorem="Absorb.extends_of_extensionOrder", core_size=len(r["core"]),
                                   core=r["core"], peeled_in_order=r["peeled"], rounds=r["rounds"], recheck_ok=r["recheck_ok"],
                                   claim_scope=f"iterated removal of vertices of degree ≤ {a.k-1}; the peel order reversed is a greedy extension order from the core, re-checked"), indent=1))
    print(f"[core{a.k}] wrote {out}")


# ----------------------------------------------------------------------------- ν, exactly

def decode_partial(model, n: int, kc: int) -> list[int]:
    """A colouring from a selector model: deleted vertices (no true colour) get 0; they are excluded from
    the edges that are checked."""
    true = set(l for l in model if l > 0)
    return [next((c for c in range(kc) if var(v, c, kc) in true), 0) for v in range(n)]


def _selector_clauses(n, edges, kc, perm=None):
    """A kc-colouring of G − S with S given by selector literals d_v (true = deleted): vertex clauses
    d_v ∨ ⋁_c x_vc, edge clauses d_u ∨ d_v ∨ ¬x_uc ∨ ¬x_vc, the palette pin d_0 ∨ x_00. `perm` relabels."""
    perm = perm or list(range(n))
    d = lambda v: n * kc + perm[v] + 1
    cl = []
    for v in range(n):
        cl.append([d(v)] + [var(perm[v], c, kc) for c in range(kc)])
    for u, v in edges:
        for c in range(kc):
            cl.append([d(u), d(v), -var(perm[u], c, kc), -var(perm[v], c, kc)])
    cl.append([d(0), var(perm[0], 0, kc)])
    return cl, d


def nu_ladder(st: Stage, k: int, wall: float, smax: int, log=print, lower0: int = 0) -> dict:
    """ν by the cardinality ladder: for s = lower0, lower0+1, …: is there S with |S| ≤ s and G − S
    (k−1)-colourable? UNSAT (two encodings: totalizer, then seqcounter on a relabelled formula) raises
    the lower bound; SAT gives S with a verified colouring — ν = s exactly if the rung below refused."""
    from pysat.card import CardEnc, EncType
    from pysat.solvers import Solver
    kc = k - 1; n = st.n
    t0 = time.time(); lower = lower0; upper = None; S = None; rungs = []
    for s in range(lower0, smax + 1):
        rung = dict(s=s)
        for enc_name, enc, seed in (("totalizer", EncType.totalizer, None), ("seqcounter", EncType.seqcounter, 20260906)):
            perm = list(range(n))
            if seed is not None:
                random.Random(seed).shuffle(perm)
            cl, d = _selector_clauses(n, st.edges, kc, perm)
            top = n * kc + n
            card = CardEnc.atmost(lits=[d(v) for v in range(n)], bound=s, top_id=top, encoding=enc)
            cl = cl + card.clauses
            tt = time.time()
            stt, model = sat(cl, wall=wall)
            rung[enc_name] = dict(status=stt, seconds=round(time.time() - tt, 1))
            if stt == "sat":
                true = set(l for l in model if l > 0)
                Sset = sorted(v for v in range(n) if d(v) in true)
                inv = [0] * n
                for i, pi in enumerate(perm):
                    inv[pi] = i
                colp = decode_partial(model, n, kc)   # colours on relabelled vertices
                col = [colp[perm[v]] for v in range(n)]
                E = [e for e in st.edges if e[0] not in set(Sset) and e[1] not in set(Sset)]
                assert verify_proper(col, E) is None, "the ladder's colouring is improper on G − S"
                upper = len(Sset); S = Sset
                rung["S"] = Sset
                break
            if stt == "unknown":
                break
        rungs.append(rung)
        log(f"[nu] rung s={s}: " + ", ".join(f"{e}: {rung[e]['status']} [{rung[e]['seconds']}s]" for e in ("totalizer", "seqcounter") if e in rung)
            + (f" → S = {S} (verified)" if upper is not None and upper <= s else ""), flush=True)
        if upper is not None:
            break
        if all(rung.get(e, {}).get("status") == "unsat" for e in ("totalizer", "seqcounter")):
            lower = s + 1
        else:
            break   # an unknown: the ladder stops; report the bracket
    exact = upper is not None and upper == lower
    return dict(method="ladder", lower=lower, upper=upper, exact=exact, S=S, rungs=rungs, seconds=round(time.time() - t0, 1))


def nu_ihs(st: Stage, k: int, wall: float, log=print, ckpt: Path | None = None, verify_cores: bool = True) -> dict:
    """ν by implicit hitting sets: solve the (k−1)-colouring of G − S with assumptions ¬d_v (v ∉ S);
    UNSAT → the core K (the vertices whose presence was used) is a (k)-chromatic subgraph, re-verified
    by a relabelled plain refutation of G[K]; every deletion set must meet every core, so S := an exact
    minimum hitting set (RC2); SAT → a verified colouring of G − S, and ν = |S| exactly."""
    from pysat.solvers import Solver
    from pysat.formula import WCNF
    from pysat.examples.rc2 import RC2
    kc = k - 1; n = st.n
    cl, d = _selector_clauses(n, st.edges, kc)
    cores: list[list[int]] = []
    if ckpt and ckpt.exists():
        cores = json.loads(ckpt.read_text())["cores"]
        log(f"[nu] resumed {len(cores)} cores from {ckpt}")
    t0 = time.time(); S: list[int] = []; it = 0; result = None
    with Solver(name="cadical153", bootstrap_with=cl) as s:
        while time.time() - t0 < wall:
            it += 1
            # the exact minimum hitting set of the cores
            if cores:
                w = WCNF(); verts = sorted(set(v for K in cores for v in K))
                for v in verts:
                    w.append([-(v + 1)], weight=1)
                for K in cores:
                    w.append([v + 1 for v in K])
                with RC2(w) as rc2:
                    m = rc2.compute(); S = sorted(v for v in verts if (v + 1) in set(m))
            else:
                S = []
            Sset = set(S)
            assum = [-d(v) for v in range(n) if v not in Sset]
            tt = time.time()
            r = s.solve(assumptions=assum)
            dt = time.time() - tt
            if r:
                model = s.get_model()
                col = decode_partial(model, n, kc)
                E = [e for e in st.edges if e[0] not in Sset and e[1] not in Sset]
                assert verify_proper(col, E) is None, "the IHS colouring is improper on G − S"
                log(f"[nu] iter {it}: S = {S} (|S| = {len(S)}, the exact hitting set of {len(cores)} cores) — G − S is {kc}-colourable (verified) [{dt:.1f}s]", flush=True)
                result = dict(method="ihs", lower=len(S), upper=len(S), exact=True, S=S, cores=len(cores), iterations=it)
                break
            core_lits = s.get_core() or []
            K = sorted(-l - n * kc - 1 for l in core_lits if l < 0)
            if verify_cores:
                idx = {v: i for i, v in enumerate(K)}
                EK = [(idx[u], idx[v]) for u, v in st.edges if u in idx and v in idx]
                perm = list(range(len(K))); random.Random(len(cores) + 7).shuffle(perm)
                EKp = [(perm[u], perm[v]) for u, v in EK]
                stt, _ = sat(colour_clauses(len(K), EKp, kc) + [[var(perm[0], 0, kc)]], wall=wall)
                if stt != "unsat":
                    raise SystemExit(f"[nu] a solver core failed its re-verification ({stt}): halting — the lower bound would be unsafe")
            cores.append(K)
            log(f"[nu] iter {it}: S = {S} refuted; core of {len(K)} vertices (re-verified); cores {len(cores)} [{dt:.1f}s, total {time.time()-t0:.0f}s]", flush=True)
            if ckpt:
                ckpt.parent.mkdir(parents=True, exist_ok=True)
                ckpt.write_text(json.dumps(dict(cores=cores, S=S)))
    if result is None:
        result = dict(method="ihs", lower=len(S), upper=None, exact=False, S=None, cores=len(cores), iterations=it, note="wall reached: lower = the exact hitting set of the re-verified cores")
    result["seconds"] = round(time.time() - t0, 1)
    return result


def cmd_nu_exact(a):
    st = load_stage(a)
    print(f"[nu] {st.label()} k={a.k}: ν = the fewest deletions to {a.k-1}-colourability (D5); method {a.method}, wall {a.wall}s", flush=True)
    t0 = time.time()
    # the cheap upper bound from any checkpointed sweep models
    ub_models = None
    for ck in [ROOT / "build" / "m54" / f"sweep-models-{st.name}-k{a.k}.txt", BUILD / f"sweep-models-{st.name}-k{a.k}.txt"]:
        if ck.exists():
            best = None
            for line in ck.read_text().splitlines():
                if line.strip():
                    col = [int(ch) for ch in line.strip()]
                    if verify_proper(col, st.edges) is None:
                        m = min(col.count(c) for c in range(a.k)); best = m if best is None else min(best, m)
            ub_models = best
            print(f"[nu] upper bound from {ck.name}: ν ≤ {ub_models} (the smallest class over the checkpointed verified {a.k}-colourings)", flush=True)
    lower0 = a.lower
    if a.method == "ladder":
        r = nu_ladder(st, a.k, a.wall, a.max, lower0=lower0)
    else:
        BUILD.mkdir(parents=True, exist_ok=True)
        r = nu_ihs(st, a.k, a.wall, ckpt=BUILD / f"nu-ihs-{st.name}-k{a.k}.json")
    if ub_models is not None and (r["upper"] is None or ub_models < r["upper"]):
        r["upper_from_models"] = ub_models
    lo, up = r["lower"], r["upper"] if r["upper"] is not None else ub_models
    if r["exact"]:
        head = f"ν({st.name}) = {r['lower']} EXACT at k={a.k} (lower: {'the exact hitting set of ' + str(r['cores']) + ' re-verified cores' if r['method']=='ihs' else 'two cardinality encodings refuse s = ' + str(r['lower']-1)}; upper: a verified {a.k-1}-colouring of G − S, S = {r['S']})"
    else:
        head = f"ν({st.name}) ∈ [{lo}, {up}] at k={a.k} after the wall (lower {'solver-trusted, two encodings' if r['method']=='ladder' else 'the exact hitting set of re-verified cores'}; upper {'a verified colouring' if up is not None else 'none'})"
    print(f"[nu] {head} [{time.time()-t0:.0f}s]", flush=True)
    DATA.mkdir(parents=True, exist_ok=True)
    out = Path(a.out) if a.out else DATA / f"nu-{st.name}-k{a.k}.json"
    out.write_text(json.dumps(dict(kind="nu-exact", stage=st.header(), k=a.k, theorem="D5 (plans/M55-absorption.md §3): ν = δ_{k−1}", headline=head, **r,
                                   seconds=round(time.time() - t0, 1),
                                   claim_scope="ladder: UNSAT rungs are solver-trusted in two encodings (totalizer; seqcounter on a relabelled formula), the SAT rung's deletion set and colouring verified; "
                                               "ihs: every core re-verified by a relabelled plain refutation of G[K], the hitting set exact (RC2), the final colouring verified"), indent=1))
    print(f"[nu] wrote {out}")


# ----------------------------------------------------------------------------- objects: stars, flowers, cores

def core_for_pair(label: str, pair) -> list[int] | None:
    x, y = pair
    c1 = ROOT / "data" / "m53" / "forced-spindle-core-8over3.json"
    if c1.exists():
        W = json.loads(c1.read_text())
        if W["object"] == label and tuple(W["pair"]) == (x, y):
            return W["core_vertices"]
    for ck in (ROOT / "build" / "m54" / f"shrink-{x}-{y}.json", BUILD / f"shrink-{x}-{y}.json"):
        if ck.exists():
            d = json.loads(ck.read_text())
            if d.get("complete") and d.get("core_labels"):
                return d["core_labels"]
    return None


def cmd_multi_spindle(a):
    import batchkill as BK
    label = a.object; q = Fr(a.q)
    obj, _ = BK.load_object(label)
    full = sorted(i for i in range(obj.n) if i not in obj.deleted)
    if a.flower:
        pair = tuple(int(t) for t in a.flower.split(","))
        powers = [int(t) for t in a.powers.split(",")]
        core = full if a.full else core_for_pair(label, pair)
        if core is None:
            raise SystemExit(f"[multi] no 1-minimal core known for pair {pair}: run `five_dial.py shrink --object {label} --pair {pair[0]},{pair[1]}` or pass --full")
        spindles = [(pair, q, core, p) for p in powers]
        name = f"flower-{pair[0]}_{pair[1]}-p{'_'.join(str(p) for p in powers)}" + ("-full" if a.full else "")
    else:
        pairs = [tuple(int(t) for t in s.split(",")) for s in a.pairs.split(";")]
        spindles = []
        for pr in pairs:
            core = full if a.full else core_for_pair(label, pr)
            if core is None:
                raise SystemExit(f"[multi] no 1-minimal core known for pair {pr}: run `five_dial.py shrink --object {label} --pair {pr[0]},{pr[1]}` or pass --full")
            spindles.append((pr, q, core, 1))
        name = None
    st, unames, info = build_multi_spindle(label, spindles, a.dps)
    if name:
        st.name = name
    ok4 = sat(colour_clauses(st.n, st.edges, 4) + [[var(0, 0, 4)]])[0] == "sat"
    ok5 = sat(colour_clauses(st.n, st.edges, 5) + [[var(0, 0, 5)]])[0] == "sat"
    print(f"[multi] 4-colourable: {ok4} (must be False); 5-colourable: {ok5} (must be True); fingerprint {st.fingerprint()}", flush=True)
    DATA.mkdir(parents=True, exist_ok=True)
    out = Path(a.out) if a.out else DATA / f"{st.name}.json"
    out.write_text(json.dumps(dict(name=st.name, n=st.n, edges=st.edges,
                                   meta=dict(info, four_colourable=ok4, five_colourable=ok5, names=[[list(x) for x in nm] for nm in unames]),
                                   points=[[mp_str(z.real), mp_str(z.imag)] for z in st.pts])))
    print(f"[multi] wrote {out} (a --graph stage for absorb / critical / core5 / nu-exact / sweep)")


def cmd_shrink(a):
    pair = tuple(int(t) for t in a.pair.split(","))
    BUILD.mkdir(parents=True, exist_ok=True)
    ckpt = BUILD / f"shrink-{pair[0]}-{pair[1]}.json"
    core, tried, complete = shrink_core(a.object, pair, ckpt, wall_total=a.wall)
    print(f"[shrink] pair {pair}: {'complete' if complete else 'hit its wall after ' + str(tried) + ' tried'}; core {len(core)} → {ckpt}")
    if not complete:
        sys.exit(2)


# ----------------------------------------------------------------------------- the cross lattice, one depth further

def cmd_cross2(a):
    """The glue census over every non-adjacent pair of W ∪ P₁ at distance < 2, exact in F_m; the new pool P₂;
    the grown stage W ∪ P₁ ∪ P₂ with all unit edges exact; the total-degree profile of the pool."""
    import mpmath as mp, numpy as np
    from scipy.spatial import cKDTree
    from concurrent.futures import ProcessPoolExecutor
    import five_dial as FD
    rec = json.loads(Path(a.exact).read_text()); cr = json.loads(Path(a.cross).read_text())
    m = rec["m"]; mp.mp.dps = 40
    F = type(f"K{m}", (KExt,), {"m": m, "__slots__": ()})
    pts_json = list(rec["points"]); nW = len(pts_json)
    keyf = lambda pj: (json.dumps(pj[0]), json.dumps(pj[1]))
    seen = {keyf(pj): i for i, pj in enumerate(pts_json)}
    p1_ids = []
    for e in cr["pool"]:
        pj = [e["x"], e["y"]]; kk = keyf(pj)
        if kk not in seen:
            seen[kk] = len(pts_json); pts_json.append(pj)
        p1_ids.append(seen[kk])
    n1 = len(pts_json)
    X = [F.of_json(p[0]) for p in pts_json]; Y = [F.of_json(p[1]) for p in pts_json]
    Z = [mp.mpc(X[i].mp(), Y[i].mp()) for i in range(n1)]
    one = F.one()
    def unit_edges(Zs, Xs, Ys):
        arr = np.array([[float(z.real), float(z.imag)] for z in Zs]); tr = cKDTree(arr)
        E, near = [], 0
        for i, j in tr.query_pairs(1 + 1e-6):
            dd = abs(Zs[i] - Zs[j])
            if abs(dd - 1) < 1e-6:
                dx, dy = Xs[i] - Xs[j], Ys[i] - Ys[j]
                if dx * dx + dy * dy == one:
                    E.append((min(i, j), max(i, j)))
                else:
                    near += 1
        return sorted(E), near
    E1, near1 = unit_edges(Z, X, Y)
    eset = set(E1)
    t0 = time.time()
    arr = np.array([[float(z.real), float(z.imag)] for z in Z]); tr = cKDTree(arr)
    pairs = [(min(i, j), max(i, j)) for i, j in tr.query_pairs(2 - 1e-9) if (min(i, j), max(i, j)) not in eset and abs(Z[i] - Z[j]) < 2]
    mc = rec.get("core_size", nW)
    side = lambda i: 0 if i < mc else (1 if i < nW else 2)          # core / copy / pool
    if getattr(a, "cross_only", False):
        before = len(pairs)
        pairs = [(i, j) for i, j in pairs if not (side(i) == side(j) and side(i) < 2)]
        print(f"[cross2] --cross-only: {len(pairs)} of {before} pairs kept (both endpoints on one K-coset side dropped: their glue points are that side's own partner lattice)", flush=True)
    print(f"[cross2] W ∪ P₁: {n1} points ({nW} in W, {n1 - nW} pool), {len(E1)} unit edges (near-misses rejected {near1}); non-adjacent pairs at d < 2: {len(pairs)} [{time.time()-t0:.0f}s]", flush=True)
    chunks = [pairs[i::a.workers] for i in range(a.workers)]
    results = []
    with ProcessPoolExecutor(max_workers=a.workers, initializer=FD._init_cross, initargs=(pts_json, m)) as ex:
        for res in ex.map(FD._glue_of_pairs, chunks):
            results.extend(res)
    infield = [(i, j, pts) for i, j, pts in results if pts is not None]
    print(f"[cross2] in-F{m} glue points: {len(infield)} pairs of {len(pairs)} ({100*len(infield)/max(1,len(pairs)):.3f} %) [{time.time()-t0:.0f}s]", flush=True)
    pool: dict[tuple, dict] = {}; coincide = 0
    for i, j, pts in infield:
        for gx, gy in pts:
            kk = (json.dumps(gx), json.dumps(gy))
            if kk in seen:
                coincide += 1; continue
            e = pool.setdefault(kk, dict(x=gx, y=gy, parents=set())); e["parents"].update((i, j))
    P2 = list(pool.values())
    for e in P2:
        e["parents"] = sorted(e["parents"])
    fus = sum(1 for e in P2 if len(e["parents"]) >= 3)
    # the grown stage
    pts2 = pts_json + [[e["x"], e["y"]] for e in P2]
    X2 = X + [F.of_json(e["x"]) for e in P2]; Y2 = Y + [F.of_json(e["y"]) for e in P2]
    Z2 = Z + [mp.mpc(x.mp(), y.mp()) for x, y in zip(X2[n1:], Y2[n1:])]
    E2, near2 = unit_edges(Z2, X2, Y2)
    n2 = len(pts2)
    deg = [0] * n2
    for u, v in E2:
        deg[u] += 1; deg[v] += 1
    pool_ids = list(range(nW, n2))
    prof = {}
    for v in pool_ids:
        key = str(deg[v]) if deg[v] < 5 else "≥5"
        prof[key] = prof.get(key, 0) + 1
    print(f"[cross2] pool P₂: {len(P2)} distinct new points ({coincide} glue points coincide with existing points), fusions (≥ 3 parents) {fus}; "
          f"grown stage W ∪ P₁ ∪ P₂: {n2} points, {len(E2)} unit edges (near-misses rejected {near2}); total-degree profile of the {len(pool_ids)} pool points {dict(sorted(prof.items()))} [{time.time()-t0:.0f}s]", flush=True)
    DATA.mkdir(parents=True, exist_ok=True)
    name = rec["stage"]["name"]
    tag = "-crossonly" if getattr(a, "cross_only", False) else ""
    out = Path(a.out) if a.out else DATA / f"cross-lattice-depth2{tag}-{name}.json"
    out.write_text(json.dumps(dict(kind="cross-lattice-depth2", exact=a.exact, cross=a.cross, m=m, W_points=nW, P1_points=n1 - nW, pairs_tested=len(pairs),
                                   infield_pairs=len(infield), P2_points=len(P2), coincident=coincide, fusions=fus, grown_points=n2, grown_edges=len(E2),
                                   near_rejected=[near1, near2], pool_degree_profile=prof, pool=[dict(x=e["x"], y=e["y"], parents=e["parents"]) for e in P2],
                                   seconds=round(time.time() - t0, 1),
                                   claim_scope=f"every non-adjacent pair of W ∪ P₁ at distance < 2 (40-digit screen) tested exactly for r = 4/d² − 1 square in K(√{m}); glue points exact and re-verified at unit distance from both parents; all unit edges of the grown stage confirmed exactly")))
    stage_out = DATA / f"W-plus-cross-depth2{tag}.json"
    stage_out.write_text(json.dumps(dict(name=f"W-plus-cross-depth2{tag}", n=n2, edges=E2, meta=dict(exact=a.exact, cross=a.cross, cross2=str(out), W_points=nW, P1_points=n1 - nW, P2_points=len(P2)),
                                         points=[[mp.nstr(z.real, 60), mp.nstr(z.imag, 60)] for z in Z2])))
    print(f"[cross2] wrote {out} and the grown stage {stage_out}")


# ----------------------------------------------------------------------------- planted controls

def planted_absorb_stage(name: str) -> Stage:
    if name == "k33-pendants":                           # the red: K₃,₃ on 0..5, pendants 6..11; base = pendants, one piece, no hub
        E = [(i, j) for i in range(3) for j in range(3, 6)] + [(i, i + 6) for i in range(6)]
        return Stage("planted-K33-pendants", 12, E, "planted", meta=dict(absorb=dict(base=list(range(6, 12)), pieces={"B": dict(vertices=list(range(6)), hub=None)})))
    if name == "k4e-hub":                                # the green: K₄−e on 0..3, path 2–4–5, chord 5–1; base 0..3, piece {4,5} with hub 2
        E = [(i, j) for i in range(4) for j in range(i + 1, 4) if (i, j) != (0, 1)] + [(2, 4), (4, 5), (1, 5)]
        return Stage("planted-K4e-hub", 6, E, "planted", meta=dict(absorb=dict(base=[0, 1, 2, 3], pieces={"B": dict(vertices=[4, 5], hub=2)})))
    if name == "k4e-hub-deg2":                           # hdeg violated: the piece vertex 5 also adjacent to 3
        E = [(i, j) for i in range(4) for j in range(i + 1, 4) if (i, j) != (0, 1)] + [(2, 4), (4, 5), (1, 5), (3, 5)]
        return Stage("planted-K4e-hub-deg2", 6, E, "planted", meta=dict(absorb=dict(base=[0, 1, 2, 3], pieces={"B": dict(vertices=[4, 5], hub=2)})))
    if name == "k6-path":                                # K₆ on 0..5 with a pendant path 5–6–7–8: the 5-core is K₆
        E = [(i, j) for i in range(6) for j in range(i + 1, 6)] + [(5, 6), (6, 7), (7, 8)]
        return Stage("planted-K6-path", 9, E, "planted")
    raise SystemExit(f"unknown planted absorb stage {name}")


def self_test():
    fails = []
    def expect(got, want, what):
        ok = got == want
        print(f"  {'ok  ' if ok else 'FAIL'} {what}: {got!r}" + ("" if ok else f" (want {want!r})"))
        if not ok:
            fails.append(what)
    quiet = lambda *_, **__: None
    r = absorb_census(planted_absorb_stage("k33-pendants"), 3, log=quiet)
    expect(r["absorbed"], False, "K33-pendants: not absorbed by theorem")
    expect(len(r["hind_violations"]), 9, "K33-pendants: hind violated on the nine K33 edges")
    expect(r["hcol"]["status"], "sat", "K33-pendants: the piece is 2-colourable")
    red = {6: 2, 7: 1, 8: 0, 9: 2, 10: 1, 11: 0}
    expect(extension_ask(planted_absorb_stage("k33-pendants"), list(range(6, 12)), red, 3), "unsat", "K33-pendants: the red colouring does not extend (direct ask)")
    r = absorb_census(planted_absorb_stage("k4e-hub"), 3, log=quiet)
    expect(r["absorbed"], True, "K4e-hub: absorbed by extends_of_hubs")
    expect(r["d5_bound"], None if r["base_colourable"]["status"] != "sat" else 0 + 1, "K4e-hub: D5 bound (base K4−e is not 2-colourable → no bound)")
    r = absorb_census(planted_absorb_stage("k4e-hub-deg2"), 3, log=quiet)
    expect((r["absorbed"], r["hdeg_violations"]), (False, [5]), "K4e-hub-deg2: hdeg violated at vertex 5, by name")
    c = k_core(planted_absorb_stage("k6-path"), 5)
    expect((sorted(c["core"]), c["peeled"], c["recheck_ok"]), ([0, 1, 2, 3, 4, 5], [6, 7, 8], True), "K6-path: 5-core = K6, the whole path peeled in the first round, the reversed order re-checked")
    c = k_core(planted_stage("k5"), 5)
    expect(c["core"], [], "a lone K5 peels entirely at 5 (degree 4): invisible at five colours")
    r = nu_ladder(planted_stage("two-k5"), 5, 60, 5, log=quiet)
    expect((r["exact"], r["lower"]), (True, 2), "ν(K5 ⊔ K5) = 2 by the ladder")
    r = nu_ihs(planted_stage("two-k5"), 5, 60, log=quiet)
    expect((r["exact"], r["lower"], len(r["S"])), (True, 2, 2), "ν(K5 ⊔ K5) = 2 by hitting sets")
    r = nu_ladder(planted_stage("k5"), 5, 60, 5, log=quiet)
    expect((r["exact"], r["lower"]), (True, 1), "ν(K5) = 1 by the ladder")
    r = nu_ihs(planted_stage("k5e"), 4, 60, log=quiet)
    expect((r["exact"], r["lower"]), (True, 1), "ν(K5−e) = 1 at 4 by hitting sets")
    print(f"absorb self-test: {len(fails)} failure(s)" + (f" — {fails}" if fails else ""))
    sys.exit(1 if fails else 0)
