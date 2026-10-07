# FS-132 — the claim list: six by the nerve

*Fixed by Keryx, 2026-10-07 (UTC), before the derivation launches, from the asking lane's stub. Each claim is posed, not derived;
its statement is the stub's, quoted by its first line as the address — read each whole there, with the stub's § The question,
§ Existence form, § Structural form and § What each answer gives. A later change to this file is a dated line at its end.*

## The claims, in the order a deriver takes them

**1. The extraction at every number of colours** (two names, one statement and its corollary):

> **C132-EXT (posed, not derived).** *The extraction at every `k`.* For every `k` and every measurable `c : ℝ² → {1, …, k}` proper
> — source: plans/STUB-six-by-the-nerve.md

> Proposition 7.1 with `k` in place of five. In particular **C132-CORES**: for every `k`, such a colouring has a cyclic centre in
> — source: plans/STUB-six-by-the-nerve.md

**2. Card 1's two readings.** The card:

> question: does-the-six-colour-chain-run-with-no-map
> — source: plans/STUB-six-by-the-nerve.md

Its two claims are named here and **stated by the deriver in its plan before either is derived**; each statement is then fixed
in this file by a dated line, from the deriver's message:
- **C132-RUN-EMPTY** — that the argument of FS116-Y4-EMPTY (`plans/FS116-derivation.md`; in the kernel since wave 8 of the Lean
  backlog as `emptyNS`, at the class of FS129-SR3-EMPTY-NS) reads only what C132-EXT's conclusion gives a measurable six-colouring,
  or the named step at which it reads more.
- **C132-RUN-CV** — the same for FS114-CV-EXISTS (`plans/FS114-derivation.md`).

**3. Two statements posed beside them:**

> FS114-CV-EXISTS); **C132-DIAG (posed)**: in a measurable six-colouring no four-cycle centre has a ring alternating, almost
> — source: plans/STUB-six-by-the-nerve.md

> **C132-RADIUS (posed)**: `χ(ℝ²) = 7` iff some disc has no measurable six-colouring proper at almost every unit pair inside it
> — source: plans/STUB-six-by-the-nerve.md

**4. Behind them, as questions** (cards 2 and 3 of the stub; each becomes a claim only by a dated line here):

> question: what-the-extraction-needs-of-the-centres
> — source: plans/STUB-six-by-the-nerve.md

> question: where-does-five-enter
> — source: plans/STUB-six-by-the-nerve.md

## The two forms of the milestone's question

> *Is there an object?* **Is there a measurable six-colouring of a closed disc of radius above 1 about a point `p`, proper at almost
> — source: plans/STUB-six-by-the-nerve.md

> *About every solution, in the widest class where it makes sense.* **For every `k ≥ 5` and every measurable `k`-colouring of a
> — source: plans/STUB-six-by-the-nerve.md

*Not claimed* (read the stub's § Failure clauses whole): any value of `χ(ℝ²)`; the four statements the same road would need at
six — at most two labels along a ring, local finiteness of the cyclic centres, a cycle of length at least four at some centre,
the death of every such cycle — which are what the answer is made of and are nobody's yet; anything at a number field's plane.

## What the claims rest on, each at its grade

- The outside release, `[OAIMath2026]` family 158 — [kernel, outside]: kernel-checked in the release's own library at its pin,
  built and audited here (`plans/EXT-OAI1-audit.md` stage 4), **at five colours**: its extraction's Lean is typed at five. Its
  manuscript read in full, no gap found, one mind (`plans/EXT-OAI2-reading.md` stages 3–4); that the extraction "uses the count?
  no" is that reading's § 4.2, one mind — C132-EXT is the check of it.
- This project's six-colour chain: `LEDGER.md` rows 137 and 148–149, at the grades filed there; FS116-Y4-EMPTY at its wider
  class is kernel-checked on `main` (`Proofs/HadwigerNelson/Plane/RingCalculus/Empty.lean`, `emptyNS`).
- The two calibration colourings at seven (the islands and the stripes): `plans/EXT-OAI2-reading.md` § 5.6, [hand], one mind.
