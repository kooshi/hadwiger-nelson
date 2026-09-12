#!/usr/bin/env python3
"""The committed driver for M63's reductions: build a stage, name its frame, run it, write it.

**Why a driver at all.** Both stored reduction records and two of M64's artifacts were produced by
scratch scripts that were never committed (M63 §S.3 M64-9, M64-10), so nothing in the repository
could rebuild them. Everything here is a named function with a self-test, and every record it
writes carries its producer, its configuration, the hashes that identify the search, and the
provenance stamp.

    python3 tools/parts_run.py reduce --L FILE --S FILE --reduce {L,S,LS} --out PATH
            [--S-frame stored | contains:FILE | refuses-with:FILE | coset:N]
            [--rung 1 | stab | order:K | H<K>#<I>]
            [--max-minima N] [--phase2-wall SEC] [--wall-ask SEC] [--slice-conflicts N]
            [--checkpoint PATH]        # defaults to <out>.ckpt.json, so nobody forgets one
            [--prediction 'P-C4.1: ...']   # registered before the run, carried in the record
            [--dry-run]                # print what the run will be, and stop
    python3 tools/parts_run.py frames --L FILE --S FILE [--contains FILE | --refuses-with FILE]
    python3 tools/parts_run.py --self-test

`--reduce`, not `--side`: "side" is not English for both halves, and the domain pass made the
parameter a SET of halves (§M). `Stage.side` survives as the spelling, for the records on disk.

**A group element is named by its image of `(2, 0, 4, 2)`**, whose orbit the order-24 group acts on
freely -- 24 distinct images, asserted here before any name is emitted (§O5). An index into
`typem.parts_group()`'s enumeration order is an accident of that order and would silently change
meaning if it ever moved; the image cannot. It also gives the group's multiplication table for
free: composition is `a[b[(2,0,4,2)]]`, because the naming is injective.

**Frames are double cosets, not elements.** Applying a group element to the S half alone is a
different problem; applying it to both halves is the same problem (§O4: conjugate diagonally by the
element of `Stab(W_L)`). So the inequivalent relative frames are `Stab(W_L) \\ G / Stab(S)`, the
converse is NOT claimed, and the honest sentence is "at most N inequivalent problems"."""
from __future__ import annotations
import argparse, hashlib, json, os, sys, time
from collections import defaultdict

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import parts_faces as F
import parts_repro as P
import parts_report as R
import parts_reduce as RED
import parts_stage as PS
import parts_vtx as V
import typem as T

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
FREE_POINT = (2, 0, 4, 2)          # trivial stabiliser, measured; the name of a group element


# ====================================================================== the group, named by action
class Group:
    """The order-24 base group, with every element named by its image of a free point."""

    def __init__(self, base):
        self.base = base
        self.g = F.base_group_perms(base)
        self.names = [tuple(g[FREE_POINT]) for g in self.g]
        if len(set(self.names)) != len(self.g):
            raise SystemExit(
                f"the naming point {FREE_POINT} has a nontrivial stabiliser on this base "
                f"({len(set(self.names))} distinct images of {len(self.g)} elements), so an element "
                f"cannot be named by its action on it. Choose another free point before naming "
                f"anything (§O5).")
        self.by_name = {n: i for i, n in enumerate(self.names)}
        self.identity = next(i for i, g in enumerate(self.g)
                             if all(g[t] == t for t in list(base.tups)[:64]))

    def __len__(self):
        return len(self.g)

    def image(self, i, tuples):
        return {self.g[i][t] for t in tuples}

    def compose(self, a, b):
        """a . b, by the naming point: (a.b)(x) = a(b(x)), and the naming is injective."""
        return self.by_name[tuple(self.g[a][self.g[b][FREE_POINT]])]

    def inverse(self, a):
        return next(i for i in range(len(self.g)) if self.compose(a, i) == self.identity)

    def stab(self, tuples):
        S = set(tuples)
        return [i for i in range(len(self.g)) if self.image(i, S) == S]

    def double_cosets(self, A, B):
        """`A \\ G / B` as lists of element indices, the coset holding the identity first, then
        ordered by their smallest element name -- so `coset:2` means the same thing every run."""
        seen, out = set(), []
        for i in range(len(self.g)):
            if i in seen:
                continue
            c = sorted({self.compose(a, self.compose(i, b)) for a in A for b in B})
            seen |= set(c)
            out.append(c)
        out.sort(key=lambda c: (self.identity not in c, min(self.names[i] for i in c)))
        return out


# ====================================================================== sides and frames
def load_side(name):
    """A `.vtx` file from `data/m62/parts-ref11/JP/Large/` by basename (or a path)."""
    p = name if os.path.sep in name else os.path.join(V.REF11, name)
    if not p.endswith(".vtx"):
        p += ".vtx"
    return V.load_lattice(p)


FRAME_REFUSAL = """frame refused: the stored frame of {sfile} does not satisfy `{prop}`.
  Qualifying frames, by double coset (representative named by its image of (2,0,4,2)):
{rows}
  Choose one:  --S-frame coset:{first}"""


def frames(base, G, L_tuples, S_tuples, contains=None, refuses_with_L=None, log=print):
    """One row per double coset of `Stab(W_L) \\ G / Stab(S)`: its representative's name, its size,
    whether the stored frame (the identity) lies in it, and which members have the requested
    property. Applying `h` to S alone is a new problem; applying it to both halves is the same
    problem, so these cosets are the inequivalent relative frames (§O4, one direction only)."""
    A, B = G.stab(L_tuples), G.stab(S_tuples)
    cosets = G.double_cosets(A, B)
    rows = []
    # REPORT FROM INSIDE. With `refuses_with` this builds a stage and asks a refusal for every
    # one of the 24 elements, which on an M6B-sized pair is twenty minutes -- and as first
    # written it logged nothing at all, so phase C3 sat at 99% CPU with an empty log and no way
    # to tell work from a wedge (M63 §R2.5, the fifth instrument of the same shape). The
    # parameter was there; the calls were not.
    t0, done = time.time(), 0
    if refuses_with_L is not None:
        log(f"  frame search: {len(cosets)} double cosets over {sum(len(c) for c in cosets)} "
            f"elements, one stage build and one refusal ask each "
            f"(|Stab(W_L)| = {len(A)}, |Stab(S)| = {len(B)})")
    for k, c in enumerate(cosets, 1):
        qual = []
        for i in c:
            img = G.image(i, S_tuples)
            if contains is not None and not set(contains) <= img:
                continue
            if refuses_with_L is not None:
                # USE THE PIN. Measured 2026-09-11 on a cold refusing ask, same stage, same
                # solver, the pin the only difference: 3.07 s with it against 190.6 s without --
                # **62x**, which is most of the "thousandfold" §R2.4 first read as warm-up. This
                # search asked 24 cold refusing questions with `pin=False` and took forty minutes;
                # with the pin it is about a minute. §5.9's pin is three unit clauses and no new
                # variables, and it may never change an answer (`Stage.pin_is_sound`).
                try:
                    st = PS.Stage(base, refuses_with_L, sorted(img), side="L", rung=1, pin=True)
                except ValueError:
                    # the pin triangle is not on this L side; a companion graph need not carry it
                    st = PS.Stage(base, refuses_with_L, sorted(img), side="L", rung=1, pin=False)
                v = PS.refuses(st, list(range(len(st.atoms))))
                done += 1
                log(f"    element {done}/{sum(len(x) for x in cosets)} of coset {k} "
                    f"{tuple(G.names[i])}: {v}  [{time.time()-t0:.0f}s]")
                if v != "unsat":
                    continue
            qual.append(i)
        rows.append({"coset": k, "size": len(c), "rep": list(G.names[c[0]]),
                     "holds_stored_frame": G.identity in c,
                     "qualifying": [list(G.names[i]) for i in qual],
                     "qualifying_idx": qual, "members_idx": c})
    return rows


def pick_frame(spec, rows, G, sfile, prop_text):
    """The group element the run will use, and the coset it lies in. **Never silent**: with a
    requested property the stored frame is preferred and the refusal lists the qualifying cosets."""
    if spec.startswith("coset:"):
        k = int(spec.split(":", 1)[1])
        row = next((r for r in rows if r["coset"] == k), None)
        if row is None:
            raise SystemExit(f"there are {len(rows)} double cosets; coset:{k} does not exist")
        pool = row["qualifying_idx"] or row["members_idx"]
        i = G.identity if G.identity in pool else pool[0]
        return i, row
    qual = [r for r in rows if r["qualifying_idx"]]
    if spec == "stored" and prop_text is None:
        return G.identity, next(r for r in rows if G.identity in r["members_idx"])
    if not qual:
        raise SystemExit(f"no frame satisfies `{prop_text}`: the property is unreachable under the "
                         f"order-24 group, so the run cannot be set up as asked")
    for r in qual:                                        # prefer the stored frame when it qualifies
        if G.identity in r["qualifying_idx"]:
            return G.identity, r
    if spec == "stored":
        listing = "\n".join(
            f"    coset {r['coset']}  {tuple(r['rep'])}   {r['size']} elements   "
            f"{'holds ' + str(len(r['qualifying_idx'])) + ' qualifying' if r['qualifying_idx'] else 'none qualify'}"
            for r in rows)
        raise SystemExit(FRAME_REFUSAL.format(sfile=sfile, prop=prop_text, rows=listing,
                                              first=qual[0]["coset"]))
    return qual[0]["qualifying_idx"][0], qual[0]


# ====================================================================== rungs
def atom_perm(stage, gmap):
    """The permutation `gmap` induces on the stage's atoms, or None when it does not preserve them.

    Atoms are keyed by `(half, tuple)`: the group acts DIAGONALLY, the same element on both halves,
    which is what makes it an automorphism of the whole type-M arena (M62 §R19(1))."""
    alab = [(l[0], tuple(l[1])) for l in stage.atom_labels]
    ix = {t: i for i, t in enumerate(alab)}
    out = []
    for h, t in alab:
        k = (h, gmap.get(t))
        if k not in ix:
            return None
        out.append(ix[k])
    return tuple(out)


def rung_maps_for(base, stage, G, spec):
    """'1' -> None. 'stab' -> the stage's whole stabiliser. 'order:K' -> the unique subgroup of that
    order, REFUSING when there are several and naming them. 'H<K>#<I>' -> the I-th subgroup of order
    K in `parts_faces.subgroups` order. Always a subgroup of the STAGE's stabiliser, never of the
    base group (M64 §1)."""
    if spec in ("1", None):
        return None, {"order": 1, "spec": "1"}
    aut = F.stage_symmetry(base, stage, G.g)
    live = [i for i in range(len(G)) if atom_perm(stage, G.g[i]) in set(aut.perms)]
    if spec == "stab":
        return [G.g[i] for i in live], {"order": len(live), "spec": "stab",
                                        "elements": [list(G.names[i]) for i in live]}
    subs = F.subgroups(aut)
    if spec.startswith("order:"):
        k = int(spec.split(":", 1)[1])
        cand = [h for h in subs if h.order == k]
        if len(cand) != 1:
            raise SystemExit(f"{len(cand)} subgroups of order {k} in Aut(A) (order {aut.order}); "
                             f"name one as H{k}#0 .. H{k}#{len(cand)-1}")
        sub = cand[0]
    elif spec.startswith("H") and "#" in spec:
        k, i = spec[1:].split("#")
        cand = [h for h in subs if h.order == int(k)]
        sub = cand[int(i)]
    else:
        raise SystemExit(f"unknown rung spec {spec!r}; one of 1 | stab | order:K | H<K>#<I>")
    perms = set(sub.perms)
    sel = [i for i in live if atom_perm(stage, G.g[i]) in perms]
    return [G.g[i] for i in sel], {"order": len(sel), "spec": spec,
                                   "elements": [list(G.names[i]) for i in sel]}


# ====================================================================== the run
def build(args, log=print):
    """Everything the run needs, assembled and named: base, group, frame, stage, config."""
    base = P.Base(P.PARTS_R)
    G = Group(base)
    L = load_side(args.L)
    S = load_side(args.S)
    prop_text, contains, refuses_with = None, None, None
    if args.S_frame.startswith("contains:"):
        contains = load_side(args.S_frame.split(":", 1)[1])
        prop_text = f"contains {os.path.basename(args.S_frame.split(':', 1)[1])}"
    elif args.S_frame.startswith("refuses-with:"):
        refuses_with = load_side(args.S_frame.split(":", 1)[1])
        prop_text = f"refuses four colours with {os.path.basename(args.S_frame.split(':', 1)[1])}"
    rows = frames(base, G, L, S, contains=contains, refuses_with_L=refuses_with, log=log)
    gi, row = pick_frame(args.S_frame, rows, G, os.path.basename(args.S), prop_text)
    S_framed = sorted(G.image(gi, S))
    stage = PS.Stage(base, L, S_framed, side=args.reduce, rung=1, pin=not args.no_pin)
    maps, rung_cfg = rung_maps_for(base, stage, G, args.rung)
    if maps is not None:
        stage = PS.Stage(base, L, S_framed, side=args.reduce, pin=not args.no_pin, rung_maps=maps)
    config = {
        "problem": {
            "L": {"source": os.path.basename(args.L), "n": len(L), "fp": R.fp_tuples(L)},
            "S": {"source": os.path.basename(args.S), "n": len(S), "fp": R.fp_tuples(S),
                  "frame": {"image_of": list(FREE_POINT), "is": list(G.names[gi]),
                            "coset": row["coset"], "of_cosets": len(rows),
                            "found_by": args.S_frame,
                            "is_stored_frame": gi == G.identity}},
            "side": args.reduce, "rung": rung_cfg,
            "cross_law": {"cos": T.kstr(stage.cross_law.cos), "name": stage.cross_law.name},
            "base_r": P.PARTS_R, "base_fp": R.fp_base(base), "pin": not args.no_pin},
        "budgets": {"wall_ask": args.wall_ask, "max_minima": args.max_minima,
                    "phase2_wall": args.phase2_wall, "slice_conflicts": args.slice_conflicts}}
    return base, G, stage, config, rows, row, gi


def announcement(stage, config, rows, row, out, ckpt):
    """The text of the 15-minute announcement, generated by the tool that knows the forecast."""
    n_atoms = len(stage.atoms)
    ph1 = n_atoms * 0.02
    others = [r["coset"] for r in rows if r["coset"] != row["coset"]]
    return "\n".join([
        f"stage      {stage.describe()[7:]}",
        f"identity   {stage.identity()[:12]}  (graph {stage.fingerprint()[:8]}, deletable "
        f"{stage.deletable.bit_count()}, atoms {n_atoms}, pin {len(stage.pin)}, law cos "
        f"{config['problem']['cross_law']['cos']})",
        f"frames     S frame: coset {row['coset']} of {len(rows)}, element "
        f"{'the identity (the stored frame)' if config['problem']['S']['frame']['is_stored_frame'] else 'NOT the stored frame'}"
        f", named by its image of {tuple(FREE_POINT)}: {tuple(config['problem']['S']['frame']['is'])}"
        + (f"; coset(s) {others} are DIFFERENT problems (at most {len(rows)} inequivalent; the "
           f"converse is not claimed)" if others else ""),
        f"forecast   phase 1 ~ {ph1:.0f} s ({n_atoms} asks at the L451 refusing mean of 0.02 s); the "
        f"level is UNMEASURED at this atom count -- the L451 level at 450 atoms took 605 s over "
        f"16,683 asks, so 20-90 min ASSUMING those ask means hold here, which is exactly what C4.0 "
        f"measures and may refute",
        f"budgets    wall_ask {config['budgets']['wall_ask']} s (conflict slices of "
        f"{config['budgets']['slice_conflicts']}), max_minima {config['budgets']['max_minima']}, "
        f"phase2_wall {config['budgets']['phase2_wall']}",
        f"checkpoint {ckpt}  (resumable; budgets may change on a relaunch, the problem may not)",
        f"writes     {out}",
    ])


def run_reduce(args, log=print):
    base, G, stage, config, rows, row, gi = build(args, log=log)
    ckpt = args.checkpoint or (args.out + ".ckpt.json")
    if args.dry_run:
        print(announcement(stage, config, rows, row, args.out, ckpt))
        return None
    if os.path.exists(args.out):
        raise SystemExit(f"{args.out} exists. A stored record is never overwritten (M64 §6.6); "
                         f"write a regeneration beside it as <name>.v2.json.")
    log(announcement(stage, config, rows, row, args.out, ckpt))
    rec = RED.reduce_stage(stage, wall_ask=args.wall_ask, max_minima=args.max_minima,
                           phase2_wall=args.phase2_wall, checkpoint=ckpt, config=config, log=log,
                           slice_conflicts=args.slice_conflicts,
                           verify_checkpoint=getattr(args, "verify_checkpoint", 0))
    out = finish_record(base, G, stage, config, rec, args)
    tmp = args.out + ".tmp"
    os.makedirs(os.path.dirname(os.path.abspath(args.out)), exist_ok=True)
    with open(tmp, "w") as f:
        json.dump(out, f, indent=1)
    os.replace(tmp, args.out)
    log(f"\n{out['headline']}\nwrote {args.out}")
    return out


def finish_record(base, G, stage, config, rec, args):
    """The schema-2 record: the state's decided facts plus the derived views a reader needs.

    It is SELF-CONTAINED -- the atom labels let a reader map atoms to (half, lattice tuple) without
    rebuilding the stage -- and it never carries an aggregate verdict."""
    state = rec.pop("state")
    alab = [[l[0], list(l[1])] for l in stage.atom_labels]
    centre_t = list(stage.keys[stage.A.centre])
    Aset = rec.get("A", rec.get("A_sample", []))
    verts = defaultdict(list)
    for a in Aset:
        for h, t in stage.vertex_labels(stage.atoms[a]):
            verts[h].append(list(t))
    verts["L"].append(centre_t)                      # the shared centre is never an atom
    A_vertices = {h: sorted(map(tuple, v)) for h, v in verts.items()}
    orbit_of = F._orbit_map(base, stage)
    labels = sorted({orbit_of(a) for a in range(len(stage.atoms))}, key=str)
    rows = []
    for m in rec.get("minima", [])[:4096]:
        c = defaultdict(int)
        for a in m:
            c[orbit_of(a)] += 1
        rows.append([c[l] for l in labels])
    canon = None
    if A_vertices.get("L"):
        imgs = []
        for i in range(len(G)):
            imgs.append(tuple(sorted(tuple(G.g[i][tuple(t)]) for t in A_vertices["L"])))
        canon = R.fp_tuples(min(imgs))
    head = (f"{config['problem']['side']} reduction of {config['problem']['L']['source']} against "
            f"{config['problem']['S']['source']} (frame coset {config['problem']['S']['frame']['coset']} "
            f"of {config['problem']['S']['frame']['of_cosets']}): {rec['verdict']}, "
            f"{rec.get('bound_render', 'no bound')}"
            + (f", |M| = {rec['M_vertices']} vertices" if rec.get("M_vertices") else "")
            + f", level {R.Count(**rec['M_set']['count']).render() if rec.get('M_set') else '-'}"
            + f", {len(rec.get('undecided_candidates', []))} undecided [tuning]")
    out = {"kind": "m63-reduction", "schema": 2, "producer": "tools/parts_run.py:run_reduce",
           "headline": head,
           "config": config,
           "problem_sha256": state.problem_sha256, "stage_identity": stage.identity(),
           "config_sha256": hashlib.sha256(
               json.dumps(config, sort_keys=True, separators=(",", ":")).encode()).hexdigest(),
           "predictions": [{"id": p.split(":", 1)[0].strip(),
                            "registered": p.split(":", 1)[1].strip() if ":" in p else p,
                            "measured": head, "relation": "scored by hand in M63 §R2"}
                           for p in (args.prediction or [])],
           **rec,
           "atoms": alab,
           "minima_fp": hashlib.blake2b(
               json.dumps(sorted(map(sorted, rec.get("minima", []))), separators=(",", ":")).encode(),
               digest_size=16).hexdigest(),
           "member_profiles": {"orbits": [list(l) if isinstance(l, tuple) else l for l in labels],
                               "rows": rows,
                               "note": "one row per minimum, capped at 4096 rows"},
           "A_vertices": {h: [list(t) for t in v] for h, v in A_vertices.items()},
           "A_fp": {h: R.fp_tuples(v) for h, v in A_vertices.items()},
           "A_canonical_fp_L": canon,
           "base_fingerprint": R.fp_base(base),
           "launches": state.launches, "status": state.status,
           "provenance": R.provenance(config=config)}
    return out


# ====================================================================== CLI and self-test
def cmd_frames(args):
    base = P.Base(P.PARTS_R)
    G = Group(base)
    L, S = load_side(args.L), load_side(args.S)
    contains = load_side(args.contains) if args.contains else None
    rw = load_side(args.refuses_with) if args.refuses_with else None
    rows = frames(base, G, L, S, contains=contains, refuses_with_L=rw)
    print(f"Stab(W_L) = {len(G.stab(L))}, Stab(S) = {len(G.stab(S))}; "
          f"{len(rows)} double cosets (at most {len(rows)} inequivalent problems; the converse is "
          f"not claimed, §O4)")
    for r in rows:
        print(f"  coset {r['coset']}  rep {tuple(r['rep'])}  {r['size']} elements  "
              f"{'holds the stored frame' if r['holds_stored_frame'] else ''}  "
              f"qualifying {len(r['qualifying'])}")


def compare_records(a: dict, b: dict) -> dict:
    """c1.7: a regenerated record against the stored one.

    `regenerated-identical` proves that the committed driver computes the same level from the same
    stage. It does NOT prove the stored record was right (§O8). And the two failure modes are not
    the same: a differing **Y** is EXPECTED and reported, because the harvest order is a launch
    artifact -- a fresh solver may return a different model for the same colourable ask, and the
    shrink starts from that model -- while a differing **level** is a defect. The verdict names
    which."""
    ours = {tuple(sorted(m)) for m in a.get("minima", [])}
    theirs = {tuple(sorted(m)) for m in b.get("minima", [])}
    fields = {
        "stage_fingerprint": (a.get("stage_fingerprint"), b.get("stage_fingerprint")),
        "bound": (a.get("bound"), b.get("bound")),
        "M_vertices": (a.get("M_vertices"), b.get("M_vertices")),
        "verdict": (a.get("verdict"), b.get("verdict")),
        "level_size": (len(ours), len(theirs)),
        "A_atoms": (a.get("A_atoms"), b.get("A_atoms")),
        "A": (sorted(a.get("A", [])), sorted(b.get("A", []))),
    }
    bad = [k for k, (x, y) in fields.items() if x != y]
    if ours != theirs:
        bad.append("minima")
    Y = (a.get("hypergraph", {}).get("correction_sets"),
         b.get("hypergraph", {}).get("correction_sets"))
    Ysets = ({tuple(c) for c in a.get("hypergraph", {}).get("sets", [])},
             {tuple(c) for c in b.get("hypergraph", {}).get("sets", [])})
    return {
        "verdict": "regenerated-identical" if not bad else
                   "regenerated-differs:" + ",".join(bad),
        "fields_compared": sorted(fields) + ["minima"],
        "differing": bad,
        "minima_only_in_new": len(ours - theirs), "minima_only_in_stored": len(theirs - ours),
        "Y": {"new": Y[0], "stored": Y[1], "identical": Ysets[0] == Ysets[1],
              "only_in_new": len(Ysets[0] - Ysets[1]), "only_in_stored": len(Ysets[1] - Ysets[0]),
              "gated": False,
              "note": "reported, never gated: the harvest is a launch artifact (§O2). A control "
                      "demanding an identical Y would assert something false about correct code."},
        "asks": {"new": a.get("asks", {}).get("colourable", {}).get("n"),
                 "stored": b.get("asks", {}).get("colourable", {}).get("n")},
    }


def cmd_compare(args):
    out = compare_records(json.load(open(args.new)), json.load(open(args.stored)))
    print(json.dumps(out, indent=1))
    return out


def _self_test():
    """Controls: the naming point is free; the frame refusal fires and lists its cosets; the coset
    numbering is stable; the joint working graph is the one M63 §S.2 #8 measured."""
    fails = []

    def chk(name, cond, detail=""):
        print(f"  {'ok  ' if cond else 'FAIL'} {name}{('  ' + detail) if detail else ''}")
        if not cond:
            fails.append(name)

    base = P.Base(P.PARTS_R)
    G = Group(base)
    chk("the naming point is free (24 distinct images)", len(set(G.names)) == 24)
    chk("the identity is index 0 and names itself",
        G.identity == 0 and G.names[G.identity] == FREE_POINT, str(G.names[G.identity]))
    chk("composition by the naming point is the group law",
        all(G.compose(a, G.inverse(a)) == G.identity for a in range(24)))
    A412, A166, S136 = load_side("v412e2106"), load_side("v166e774"), load_side("v136e564")
    rows = frames(base, G, A412, A166, contains=S136)
    chk("the joint problem has two double cosets of size 12",
        [r["size"] for r in rows] == [12, 12], str([r["size"] for r in rows]))
    chk("exactly one coset qualifies, with six elements, and it holds the stored frame",
        sum(1 for r in rows if r["qualifying"]) == 1 and
        len(rows[0]["qualifying"]) == 6 and rows[0]["holds_stored_frame"],
        f"qualifying per coset {[len(r['qualifying']) for r in rows]}")
    chk("the stored frame itself does NOT contain S136 (so the frame must be chosen)",
        not set(S136) <= G.image(G.identity, A166))
    try:
        pick_frame("stored", rows, G, "v166e774.vtx", "contains v136e564.vtx")
        chk("the frame refusal fires", False, "a frame was picked silently")
    except SystemExit as e:
        chk("the frame refusal fires and lists the cosets",
            "frame refused" in str(e) and "coset 1" in str(e) and "--S-frame coset:" in str(e),
            str(e).splitlines()[0])
    gi, row = pick_frame("contains:v136e564.vtx", rows, G, "v166e774.vtx", "contains v136e564.vtx")
    S_framed = sorted(G.image(gi, A166))
    chk("the chosen frame contains S136 and is coset 1", set(S136) <= set(S_framed) and
        row["coset"] == 1, f"element {tuple(G.names[gi])}")
    st = PS.Stage(base, A412, S_framed, side="LS", rung=1)
    n = st.present.bit_count()
    e = len(st.A.induced(st.present))
    chk("the joint working graph is 577 vertices / 2904 edges / 576 atoms (M63 §S.2 #8)",
        (n, e, len(st.atoms)) == (577, 2904, 576), f"{n} vertices, {e} edges, {len(st.atoms)} atoms")
    chk("the record is inside it",
        set(load_side("v374e1860")) <= set(A412) and set(S136) <= set(S_framed))
    print(f"\n{'ALL CONTROLS FIRED' if not fails else 'FAILED: ' + ', '.join(fails)}")
    return not fails


def main():
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("--self-test", action="store_true", dest="selftest")
    sub = ap.add_subparsers(dest="cmd")
    r = sub.add_parser("reduce")
    r.add_argument("--L", required=True)
    r.add_argument("--S", required=True)
    r.add_argument("--reduce", required=True, choices=["L", "S", "LS"])
    r.add_argument("--out", required=True)
    r.add_argument("--S-frame", dest="S_frame", default="stored")
    r.add_argument("--rung", default="1")
    r.add_argument("--max-minima", type=int, default=0)
    r.add_argument("--phase2-wall", type=float, default=0.0)
    r.add_argument("--wall-ask", type=float, default=600.0)
    r.add_argument("--slice-conflicts", type=int, default=RED.SLICE_CONFLICTS)
    r.add_argument("--checkpoint")
    r.add_argument("--verify-checkpoint", dest="verify_checkpoint", type=int, default=0,
                   metavar="N", help="re-ask N restored correction sets on load and REFUSE the "
                                     "resume if any fails; off by default, on for any checkpoint "
                                     "that has been moved or edited")
    r.add_argument("--prediction", action="append")
    r.add_argument("--no-pin", action="store_true")
    r.add_argument("--dry-run", action="store_true")
    r.set_defaults(f=run_reduce)
    f = sub.add_parser("frames")
    f.add_argument("--L", required=True)
    f.add_argument("--S", required=True)
    f.add_argument("--contains")
    f.add_argument("--refuses-with", dest="refuses_with")
    f.set_defaults(f=cmd_frames)
    c = sub.add_parser("compare")
    c.add_argument("--new", required=True)
    c.add_argument("--stored", required=True)
    c.set_defaults(f=cmd_compare)
    a = ap.parse_args()
    if a.selftest:
        sys.exit(0 if _self_test() else 1)
    if not getattr(a, "f", None):
        ap.error("give a subcommand or --self-test")
    a.f(a)


if __name__ == "__main__":
    main()
