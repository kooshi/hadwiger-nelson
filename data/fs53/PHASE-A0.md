# FS-53 phase A0 — the instruments (the implementing engineer's record, 2026-09-15)

The phase's three items, what each ships, and every number with what it measures. Items A0.1, A0.2 and A0.4 are here;
A0.3 (two work orders to the Rust engineer) is a different writer's.

Commands are runnable from the repository root. Where a run needs a semidefinite solver it is written
`build/venv-sdp/bin/python3` — the default `python3` has no `cvxpy`, and everything in `tools/fplane_cert_check.py`
runs on the standard library alone, as it must.

---

## A0.1 — the q = 27 plane's producer, restored

**The defect.** `tools/fplane.py chi --q 27` called `field_q27()`, which commit `a3adc46` deleted, so the eighth
window member had no working graph builder on `main` and `data/fplane/chi-q27.json` could not be reproduced.

**What shipped.** `field_q27()` restored verbatim from `.claude/worktrees/fs38-stubs-paper/tools/fplane.py:887`; the
edge build factored out of `chi_q` into `graph_q27()` so the self-test asserts on the graph the tool *ships*, not on a
second copy of the edge rule; the record carries `edges_sha256` and `conflict_budget`.

**The graph's identity, from three independent builds.** 729 vertices, a 28-point circle, 10,206 edges,
`edges_sha256 = b15ae514ce55dddda7e21f8923ae86c678f032421914fc91e138ca0f24e7ff3d` — reproduced by `tools/fplane.py`'s
`graph_q27`, by `tools/fplane_periodic_subgroups.py`'s `edges_sha256`, and (A0.4) by `tools/fplane_cert_check.py`'s
`graph_sha256`, which rebuilds the field from the number 27 and the modulus and shares no code with either.

**The carried rows, and why.** Regenerating the record with `chi --q 27 --k 4` alone would have dropped the
`k = 5 unknown at 2,327.6 s` row that `plans/STUB-sixth-colour.md` §S0 and `data/fs53/window.md` both cite, and which
costs 39 minutes of one core to reproduce. `carry_prior_rows` carries the rows this run did not ask, loudly, each
stamped with its provenance, under three guards: the previous record must be the **same graph** (by `edges_sha256`, or
— for a record written before the hash existed — structurally, since k-colourability is isomorphism-invariant); a
`sat` row is **never** carried (a colouring claim must arrive with the colouring that was verified); and `chi`/`exact`
are not recomputed over the union, so a carried refusal cannot turn an inexact verdict exact.

**Plants, and the message each produced.**

| plant | where | what it broke |
|---|---|---|
| the shipped reduction changed to `t³ = t − 1` (the wrong modulus) | `field_q27`, in the file, restored and the restore verified by sha256 | three rows RED, exit 1: `[RED] q=27: UD(F_27,2) is 729 vertices, degree 28, 10,206 edges, edges_sha256 b15ae514ce55dddd… (got 729, 28, 10206, 2a2b007041d2f7ee…)`, the mutation row (it can no longer discriminate), and the restore row |
| one character of a previous record's `edges_sha256` | a scratch copy of the record | `[carry] chi-q27-planted.json is a different graph (q, edges_sha256 or shape differ): nothing carried` — 3 carried rows became 0 |

**Reproduce:** `python3 tools/fplane.py chi --q 27 --k 4` (6.9 s), `python3 tools/fplane.py self-test` (0.9 s, ALL GREEN).

---

## A0.2 — the subgroup sweep's record

**What shipped.** One record writer: `emit`, called by `sweep` after every dimension (`partial: true`) and once at the
end; `main` no longer writes a second time. The write is atomic (`mkstemp` in the same directory, `chmod 644`,
`os.replace`), so a kill during the write leaves the previous checkpoint whole. Every witness now carries the quotient
colouring **and** its pullback to the plane — 729 entries under the same vertex index as `data/fplane/chi-q27.json` —
verified on all 10,206 plane edges before it is written, so `best_k_found` is a ceiling a stranger can re-check from
the file.

**The sweep, re-run** (234 s → 238 s of one core, desktop): counts reproduce the committed survey exactly —
11,011 subspaces / 2,100 usable at dimension 4, 33,880 / 20,216 at 3, 11,011 / 9,408 at 2, 364 / 350 at 1; best k
9 / 7 / 9 / 11. All four witnesses verified independently through `tools/fplane.py`'s separately built edge list:
**0 monochromatic edges of 10,206** each. The dimension-3 witness sits on the same basis the product owner's own
7-colouring used, `[[1,0,0,0,0,2],[0,1,0,0,1,1],[0,0,1,0,2,2]]`, and carries a different, equally proper colouring on
it — so `χ(UD(𝔽₂₇,2)) ≤ 7` now rests on three separately built colourings over two bases.

**Plants, and the message each produced.**

| plant | what it broke |
|---|---|
| one vertex of a witness repainted to its neighbour's colour | `[control 6b] … monochromatic plane edge (0, 9) at colour 8` |
| the self-test writing anywhere but scratch | control 7 hashes `data/fs53/periodic-q27.json` at entry and exit and asserts they agree (31,369 bytes) — the *positive signal for the thing that did not happen*, which is the defect this item existed for |
| a truncated enumeration claiming exactness | `limit` forces `exact` off and stamps the row, the record and the `claim_scope`; reported at two values of the parameter — **3 usable subspaces against 2,100 unlimited** |

**Reproduce:** `python3 tools/fplane_periodic_subgroups.py --self-test` (1.9 s; `git status` clean afterwards),
`python3 tools/fplane_periodic_subgroups.py --q 27 --k 6 --out data/fs53/periodic-q27.json` (238 s).

---

## A0.4 — the certificate stack over prime powers (ruling R-1)

**The shape of the change.** The prime assumption lived in the scalar arithmetic of two functions
(`build_orbits`, `build_orbits_fast`). It is lifted into one `Field` object rather than duplicated into a second code
path: for a prime, the element **is** the residue and every operation is the same `% q` it always was, which is why
the prime path's numbers cannot move. The field is **read, never inferred**: `parse_modulus` reads the polynomial,
requires it monic, and proves it irreducible by trial division before any plane is built.

**Element naming.** At a prime power the element `c₀ + c₁t + …` is named by the integer whose base-p digits are
`(c₀, c₁, …)` **most significant first** — the convention of `field_q27` and of every committed q = 27 artifact. So at
q = 27 the element 1 is named 9 and the id 1 is `t²`, no literal 1 survives in the plane's arithmetic, and
`Field.elt` writes elements as polynomials wherever a message shows one to a human.

**The prime path, byte-identical.** Captured before any edit and re-captured after everything
(`capture-checker.sh` in the job's scratch): `data/fs50/cert-p11-N29.json` and `data/fs50/cert-p23-real-N108.json`,
plain and at two values of `--k`, are **byte-identical on all six invocations**; the self-test's output gained lines
and lost **none** (0 removed); `--help` gained the two new flags. Also byte-identical, though not in the acceptance:
the project's tightest certificate, `data/fs50/p83-refusal/cert-p83-N1059-polish-134500.json --k 6`. Cost: 15.30 s
against 15.15 s at p = 83, 0.176 s against 0.163 s at p = 23 (one run each, wall clock, desktop) — about 1 %.

**The ten new controls, each seen to fire** (numbers 21–30 of `python3 tools/fplane_cert_check.py --self-test`, 27 s):

| # | control | outcome |
|---|---|---|
| 21 | the 𝔽₂₇ plane rebuilt from 27 and the modulus | hashes to `b15ae514…`, A0.1's graph |
| 22 | the circle edge rule against the quadrance table, and the O(n²) reference orbit construction against the fast one | the same 10,206 edges; 1,847 orbits with every representative, killed set, `t` and `g_orbit` equal |
| 23 | a faithful 𝔽₂₇ certificate | CERTIFIED end to end |
| 24 | the modulus removed | `q = 27 = 3^3 is a prime power and no modulus was given. Z/27 is NOT F_27 …` |
| 25 | the file labelled `"p": 27` | `certificate.p: 27 = 3^3 is a prime POWER, not a prime …` |
| 26 | the other irreducible cubic `t³ − t + 1` | `certificate.orbits[17]: representative (0, 39), but orbit 17 … is represented by (0, 40)` |
| 27 | a reducible modulus `t³ − t` | `modulus: 't^3-t' is REDUCIBLE modulo 3 -- it is divisible by 1t^1 …` |
| 28 | the graph hash altered in one character | `certificate.edges_sha256: the file says '015ae514…', but the plane rebuilt from q = 27 … hashes to 'b15ae51…'` |
| 29 | `q = 9` (1 mod 4) | `certificate.q: 9 is not 3 mod 4 -- the plane then has isotropic vectors …` |
| 30 | `q = 27` with `p = 5` | `certificate: q = 27 = 3^3, so its characteristic is 3, but the file says p = 5` |

**The producer's own controls, re-run.** `tools/fplane_sdp_blocks.py` reproduces its pinned values —
**29.1769 at p = 11** and **108.5467 at p = 23** — and `tools/fplane_cert_round.py --check-real` is green at 11 **and**
at 27, with both plants reachable at both (the planted reflection angle moves the doubling identity by 30.609 at 27,
the flipped phase sign by 65.218).

**End to end at a prime power**, 62 s of one core:

```
build/venv-sdp/bin/python3 tools/fplane_cert_round.py --q 27 --modulus t^3-t-1 --blocks --real \
    --out <file> --ckpt <file>
```

CERTIFIED: **α(UD(𝔽₂₇,2)) ≤ 147**, N = 368945166004872794530764081061/2500000000000000000000000000 = 147.578066…,
the file's `edges_sha256` verified against the plane the checker rebuilds from 27 and the modulus. The first exact
independence bound at q = 27. *(Not filed as a record: phase B owns the q = 27 certificate and the plan requires it
rounded from a fresh short continuation's own dual. This one is a smoke test of the stack, reproducible in a minute.)*

**Two defects of my own, both caught by a control rather than by reading**, recorded because the class matters:

1. `parse_modulus` returned the polynomial's own low coefficients where the reduction needs them **negated**
   (`t³ − t − 1` means `t³ = t + 1`, not `t³ = 2 + 2t`). The wrong sign builds a well-formed field with the wrong
   multiplication — every downstream check would have passed on the wrong graph. What named it was the edge hash
   refusing to match A0.1's.
2. `check_real` compared its argument to the integer 23 and got a `Field`, and at a prime power a plant message read
   "quadrance 1" for the element `t²`.

---

## The three findings for the plan (details in the report to the product owner)

1. **The triple-level SDP cannot refuse five at q = 27.** Its optimum there is **147.578** — measured twice,
   through two formulations that share only the field: 147.5779 by the real block reduction (79 s) and 147.5780 by the
   unreduced Hermitian embedding (398 s). Refusing five needs `⌊N⌋ ≤ 145` (five needs α ≥ ⌈729/5⌉ = 146); the exact
   rounding of this dual gives ⌊N⌋ = 147. As fractions with the denominators spelled out: the relaxation's optimum is
   **147.578 / 162.000 = 0.9110 of the ratio bound**, against the **146 / 162 = 0.9012** a five-refusal must get below.
   Plan §S2 nominates 27 as a "refuse five" target on an interpolated *reach* of 0.82–0.90; the instrument's actual
   value at 27 is 0.9110, which is on the wrong side. What the certificate does give at 27 is χ ≥ ⌈729/147⌉ = 5 — the
   floor the ratio bound already holds.
2. **The question at 27 is now three integers wide.** α(UD(𝔽₂₇,2)) ≤ 147 exactly, and five needs α ≥ 146: a search
   finding 146 or 147 leaves five open, and α ≤ 145 refuses five outright. That is a cheaper ask than it was.
3. **`plans/STUB-sixth-colour.md` §S13.2's A0.2 premise is false against the code on `main`:** the sweep tool's
   `--self-test` writes nothing and leaves `git status` clean (verified by md5 before and after, on the committed
   tool, before any edit of mine). The real defect in that file was the **two record writers**, which is what A0.2
   fixed. The self-test now writes — but only under a scratch directory, and asserts the committed record is
   untouched.
