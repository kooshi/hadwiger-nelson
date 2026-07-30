#!/usr/bin/env python3
"""Emit a clause table and a segmented certificate for `HadwigerNelson.maskCheck`.

**Untrusted generator.** Lean re-derives the whole formula from its own definitions through
`ClauseTable.agreesWithCNF`, and re-runs every propagation step through `runChunks`. A bug here can
only make a check fail; it cannot make a theorem false. What each mistake looks like is tabulated in
`Proofs/HadwigerNelson/Sat/MaskCheck.lean`, indexed by the fault it causes.

## What it emits, and why in that shape

    Table00..NN.lean   the clause table in subtrees, one module each -- because a 2.4 MB table
                       literal cost M04 3.8 GB of elaboration memory, and this one is ~50 MB
    Table.lean         the subtrees joined by a `Chunks` spine, plus `agreesWithCNF` by the kernel
    Seg000..NNN.lean   one certificate segment each: its chunks, and a `Justified -> Justified`
                       theorem by `decide +kernel`.  Segments are *implications*, so they elaborate
                       independently and in parallel -- 6.9 hours of wall clock becomes ~3 minutes
                       per segment over 32 cores
    Cert.lean          the base case, the segments composed, and `<name>_unsat`

## Two packings, two field widths, neither trusted

The clause table packs literals at `field` bits with `0` reserved as a slot terminator, and each
chunk carries its own slot capacity (measured: uniform capacity costs 2.1x the artifact, because
learned clauses have a long tail).  The certificate packs ids at `fw` bits, which is a different
number -- `runStream_sound` is proved for every decoder, so the two packings cannot interfere.

Usage:
    tools/emit_mask.py BASE.cnf PINS TRIMMED.lrat NAME DIR MODULE_PREFIX [--segments N]

  BASE.cnf   the formula's own clauses in `coloringCNF` order, as `scripts/Dimacs.lean` printed them
  PINS       repr of [(vertex, colour), ...] -- the cube, in `cubeCNF` order
  NAME       the Lean prefix for the generated declarations, e.g. `halfA`
"""
import sys, os, json, array

sys.set_int_max_str_digits(4_000_000)

PER_CHUNK = 64          # clause slots per chunk: ~80 Kbit chunks, near the spike's measured optimum
CERT_CHUNK_BITS = 50000  # ditto for the certificate
TABLE_MODULES = 16       # table subtrees, hence modules, hence parallel elaboration


# ------------------------------------------------------------------ reading

def read_base(path):
    out = []
    for line in open(path):
        if line[0] in "pc":
            continue
        t = line.split()
        out.append([int(x) for x in t[:-1]])
    return out


def read_lrat(path):
    cl, hn, ids = [], [], []
    for line in open(path):
        p = line.split()
        if len(p) < 2 or p[1] == "d":
            continue
        z = p.index("0", 1)
        ids.append(int(p[0]))
        cl.append([int(x) for x in p[1:z]])
        hn.append([int(x) for x in p[z + 1:-1]])
    return cl, hn, ids


def backward_trim(cl, hn, ids):
    """Keep only the additions the empty clause needs, in derivation order.

    Not an optimisation of the emitter's own runtime: it is a factor of 1.4-20x on the *kernel's*
    work, because every dropped addition is a clause the table need not hold and a hint list the
    checker need not walk.
    """
    ix = {v: i for i, v in enumerate(ids)}
    empty = next(i for i, c in enumerate(cl) if not c)
    keep = bytearray(len(cl))
    keep[empty] = 1
    st = [empty]
    while st:
        i = st.pop()
        for h in hn[i]:
            j = ix.get(abs(h))
            if j is not None and not keep[j]:
                keep[j] = 1
                st.append(j)
    order = [i for i in range(len(cl)) if keep[i]]
    assert order[-1] == empty, "the empty clause must be the last kept addition"
    return order


# ------------------------------------------------------------------ packing

def fld(lit):
    """A DIMACS literal as a table field: Lean variable `|lit| - 1`, sign in bit 0, `0` reserved."""
    v = abs(lit) - 1
    return (2 * v if lit > 0 else 2 * v + 1) + 1


def pack_table(clauses, field, per_chunk):
    """[(slot capacity, packed word)] -- one entry per chunk, capacity local to the chunk."""
    out = []
    for s in range(0, len(clauses), per_chunk):
        blk = clauses[s:s + per_chunk]
        lits = max(len(c) for c in blk)
        sb = field * lits
        w = 0
        for j, c in enumerate(blk):
            sv = 0
            for k, l in enumerate(c):
                sv |= fld(l) << (k * field)
            w |= sv << (j * sb)
        out.append((lits, w))
    return out


def spine(parts, names, lo, hi):
    """A `Chunks` pivot tree over the *subtree modules* [lo, hi), which are its leaves.

    Written with the constructors spelled out: M04 measured that anonymous-constructor notation makes
    the elaborator resolve every node against an expected type, which exhausts the heartbeat budget
    in `isDefEq` at this size.
    """
    if hi - lo == 1:
        return names[lo]
    mid = (lo + hi) // 2
    left = sum(parts[i][1] - parts[i][0] for i in range(lo, mid))
    return (f"(Chunks.node {left} " + spine(parts, names, lo, mid) + " "
            + spine(parts, names, mid, hi) + ")")


def leaf_tree(chunks, lo, hi):
    """The subtree for chunks [lo, hi), all leaves inline."""
    if hi - lo == 1:
        return f"(Chunks.leaf {chunks[lo][0]} {chunks[lo][1]})"
    mid = (lo + hi) // 2
    return (f"(Chunks.node {mid - lo} " + leaf_tree(chunks, lo, mid) + " "
            + leaf_tree(chunks, mid, hi) + ")")


def pack_cert(actions, fw, fields_per_chunk):
    """[(word, addRup count)] -- chunks hold whole actions, so a chunk boundary is a watermark."""
    out, cur, adds = [], [], 0
    for tag, hints in actions:
        blk = [2 * len(hints) + tag] + list(hints)
        if cur and len(cur) + len(blk) > fields_per_chunk:
            out.append((cur, adds))
            cur, adds = [], 0
        cur += blk
        adds += 1 - tag                     # tag 0 = addRup, which is what advances the watermark
    if cur:
        out.append((cur, adds))
    words = []
    for fs, a in out:
        w = len(fs)
        for k, v in enumerate(fs):
            w |= v << ((k + 1) * fw)
        words.append((w, a))
    return words


# ------------------------------------------------------------------ emission

HEAD = ("/-! Generated by `tools/emit_mask.py` — **untrusted**; the kernel re-derives every claim.\n"
        "If this module fails to build, the table of build faults and what to do about each is in\n"
        "`Proofs/HadwigerNelson/Sat/MaskCheck.lean`'s module docstring. -/")

# The decoder peels one field per recursion step, and a chunk holds ~2600 fields, so the reduction
# nests far deeper than the default 512. Measured: without this the segment check runs for 149 s and
# then dies, with an error message too large to print -- which is a bad way to find out.
OPTS = ["set_option maxRecDepth 1000000", "set_option maxHeartbeats 2000000"]


def emit(outdir, mod, name, base, cube, derived, chunks, field, cert, fw, nseg, cnfdef):
    os.makedirs(outdir, exist_ok=True)
    files = {}
    nchunk = len(chunks)
    m = len(base) + len(cube)

    # --- the table, in subtrees
    bounds = [round(i * nchunk / TABLE_MODULES) for i in range(TABLE_MODULES + 1)]
    bounds = sorted(set(bounds))
    parts = [(bounds[i], bounds[i + 1]) for i in range(len(bounds) - 1) if bounds[i + 1] > bounds[i]]
    for pi, (a, b) in enumerate(parts):
        files[f"Table{pi:02d}.lean"] = "\n".join([
            "import Proofs.HadwigerNelson.Sat.ClauseTable", "", HEAD, "",
            "namespace HadwigerNelson", "",
            f"/-- Clause table chunks {a}–{b - 1} ({(b - a) * PER_CHUNK} slots). -/",
            f"def {name}Chunks{pi:02d} : Chunks :=", "  " + leaf_tree(chunks, a, b), "",
            "end HadwigerNelson"]) + "\n"

    tree = spine(parts, [f"{name}Chunks{pi:02d}" for pi in range(len(parts))], 0, len(parts))
    files["Table.lean"] = "\n".join(
        [f"import {mod}.Table{pi:02d}" for pi in range(len(parts))]
        + ["import Proofs.HadwigerNelson.Instances.DeGrey.Split",
           "import Proofs.HadwigerNelson.Sat.MaskCheck", "", HEAD, ""] + OPTS + ["",
           "/-!",
           f"The emitted clause table: **{len(base)} clauses of the formula, {len(cube)} cube unit",
           f"clauses and {len(derived)} clauses the solver derived**, in {nchunk} chunks of",
           f"{PER_CHUNK} slots at {field}-bit literal fields, with each chunk's slot capacity its",
           "own.",
           "",
           "`agreesWithCNF` below is the trust boundary: it compares the table's first",
           f"{m} slots against literal sets Lean computes *from the formula*, so a wrong table is a",
           "failed check and never a false theorem. When it fails,",
           f"`#eval {name}Table.firstFault {name}Cnf` names the id and both values.",
           "-/", "",
           "namespace HadwigerNelson", "",
           f"/-- The cube: {len(cube)} pinned vertices — the shared vertex at colour 0, the joining",
           "edge's endpoint at colour 1. -/",
           f"def {name}Cube : Cube 1581 4 := ["
           + ", ".join(f"({v}, {c})" for v, c in cube_pairs(cube)) + "]", "",
           f"/-- The formula: de Grey's half graph, pinned to the cube. -/",
           f"def {name}Cnf : Std.Sat.CNF Nat := {cnfdef}", "",
           f"/-- The emitted table. -/",
           f"def {name}Table : ClauseTable :=",
           f"  {{ field := {field}, perChunk := {PER_CHUNK}",
           f"    chunks := {tree} }}", "",
           f"/-- **The table really holds the formula.** Kernel-decided; ~{m} lookups. -/",
           f"theorem {name}_agrees : {name}Table.agreesWithCNF {name}Cnf = true := by",
           "  decide +kernel", "",
           f"/-- The formula's clause count, so the segments below can name their watermarks as",
           f"literals instead of rebuilding the formula {nseg} times. -/",
           f"theorem {name}_size : {name}Cnf.clauses.size = {m} := by decide +kernel", "",
           f"/-- **The base case**: the formula's own clauses are justified. -/",
           f"theorem {name}_base : Justified {name}Table {name}Cnf {m} := by",
           f"  rw [← {name}_size]",
           f"  exact justified_of_agreesWithCNF {name}_agrees", "",
           "end HadwigerNelson"]) + "\n"

    # --- the certificate, in segments
    segs, w = [], m
    edges = [round(i * len(cert) / nseg) for i in range(nseg + 1)]
    edges = sorted(set(edges))
    for i in range(len(edges) - 1):
        a, b = edges[i], edges[i + 1]
        adds = sum(cert[k][1] for k in range(a, b))
        segs.append((a, b, w, w + adds))
        w += adds
    last = len(segs) - 1

    for si, (a, b, w0, w1) in enumerate(segs):
        nh = b - a
        final = si == last
        concl = (f"{name}Cnf.Unsat" if final else f"Justified {name}Table {name}Cnf {w1}")
        proof = (f"  unsat_of_segment {name}Table {fw} {w0} {name}Seg{si:03d} h (by decide +kernel)"
                 if final else
                 f"  justified_of_segment {name}Table {fw} {w0} {name}Seg{si:03d} {w1} h\n"
                 f"    (by decide +kernel)")
        prev = (f"{name}_base" if si == 0 else f"{name}Just{si - 1:03d}")
        files[f"Seg{si:03d}.lean"] = "\n".join([
            f"import {mod}.Table", "", HEAD, ""] + OPTS + ["",
            "namespace HadwigerNelson", "",
            f"/-- Certificate chunks {a}–{b - 1}: {nh} chunks, watermark {w0} → {w1}. -/",
            f"def {name}Seg{si:03d} : List Nat :=",
            "  [" + ",\n   ".join(str(cert[k][0]) for k in range(a, b)) + "]", "",
            (f"/-- **The last segment derives the empty clause**, so the formula is unsatisfiable. -/"
             if final else
             f"/-- Clause ids below {w1} are justified. Checked by the kernel, independently of every"
             f" other segment. -/"),
            f"theorem {name}Just{si:03d} (h : Justified {name}Table {name}Cnf {w0}) : {concl} :=",
            proof, "",
            "end HadwigerNelson"]) + "\n"

    # --- the composition
    chain = [f"import {mod}.Seg{si:03d}" for si in range(len(segs))]
    files["Cert.lean"] = "\n".join(chain + ["", HEAD, "",
        "/-!",
        f"The {len(segs)} segments composed. Each was checked by the kernel on its own, from the",
        "watermark the previous one reached — which is why the check parallelises even though a",
        "certificate is read in order.",
        "",
        "**The watermarks are checked by the elaborator, not by the emitter.** Segment *k* concludes at",
        "a watermark that segment *k+1* takes as its hypothesis, so if this generator miscounted the",
        "additions in any chunk, the composition below is a type error naming the two segments that",
        "disagree. There is no arithmetic here to get wrong quietly.",
        "-/", "",
        "namespace HadwigerNelson", "",
        f"/-- **The pinned half graph has no 4-colouring.** Kernel-checked end to end from a CaDiCaL",
        f"certificate that nothing here trusts: a wrong certificate fails a segment, and a wrong",
        f"clause table fails `{name}_agrees`. -/",
        f"theorem {name}_unsat : {name}Cnf.Unsat :=",
        # Right-associative application, one segment per line: a flat chain rather than a thousand-deep
        # parenthesis forest, so a mis-ordering is a readable type error instead of a paren count.
        "\n".join([f"  {name}Just{si:03d} <|" for si in range(last, -1, -1)])
        + f"\n  {name}_base", "",
        "end HadwigerNelson"]) + "\n"

    for fn, body in files.items():
        open(os.path.join(outdir, fn), "w").write(body)
    return files, segs


def cube_pairs(cube):
    """The cube's unit clauses back as (vertex, colour) pairs — DIMACS var = 4*v + c + 1."""
    return [((c[0] - 1) // 4, (c[0] - 1) % 4) for c in cube]


def main():
    basep, pinsp, lratp, name, outdir, mod = sys.argv[1:7]
    nseg = int(sys.argv[sys.argv.index("--segments") + 1]) if "--segments" in sys.argv else 128
    base = read_base(basep)
    pins = eval(open(pinsp).read())
    cube = [[4 * v + c + 1] for v, c in pins]

    cl, hn, ids = read_lrat(lratp)
    order = backward_trim(cl, hn, ids)
    m = len(base) + len(cube)
    remap = {ids[i]: m + k for k, i in enumerate(order[:-1])}   # the empty clause takes no slot
    derived = [cl[i] for i in order[:-1]]
    table = base + cube + derived

    field = max(fld(l) for c in table for l in c).bit_length()
    chunks = pack_table(table, field, PER_CHUNK)

    def hid(h):
        h = abs(h)
        return remap[h] if h in remap else h - 1                # input ids are 1-based in LRAT
    actions = [(1 if not cl[i] else 0, [hid(h) for h in hn[i]]) for i in order]
    nh = sum(len(a[1]) for a in actions)
    fw = max(x.bit_length() for a in actions for x in ([2 * len(a[1]) + a[0]] + a[1]))
    fpc = max(1, CERT_CHUNK_BITS // fw)
    fw = max(fw, (fpc + 1).bit_length())
    cert = pack_cert(actions, fw, fpc)

    cnfdef = (f"coloringCNF 4 1581 deGrey{name[0].upper() + name[1:]}Edges "
              f"++ cubeCNF 4 1581 {name}Cube")
    files, segs = emit(outdir, mod, name, base, cube, derived, chunks, field, cert, fw, nseg, cnfdef)
    src = sum(len(v) for v in files.values())
    print(f"{name}: {len(table)} clauses ({len(base)}+{len(cube)}+{len(derived)}), "
          f"field={field} perChunk={PER_CHUNK} chunks={len(chunks)}; "
          f"{len(actions)} actions, {nh} hints, fw={fw}, certChunks={len(cert)}, "
          f"segments={len(segs)}; {len(files)} modules, {src/1e6:.1f} MB of source; "
          f"projected kernel {nh * 1.35e-3 / 3600:.2f} h")


main()
