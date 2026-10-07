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

## Dated lines

- **2026-10-07 (after FS132-E1's Stage 1, commit `373d06fa`; FS-132 inventory item 2): card 1's two readings are fixed as the
  deriver's plan states them** — each read whole at its address, with the data and the dictionary it is stated over:

> **The data.** For a weak measurable six-colouring `c`, an **extracted centre** is what C132-EXT's conclusion gives: a point `x`
> — source: plans/FS132-six-by-the-nerve.md § The readings, stated

> **The dictionary** (map → measurable): a vertex `p` of at least four colours → an extracted centre `p` with `ℓ = 4`; a tile of `p`
> — source: plans/FS132-six-by-the-nerve.md § The readings, stated

> **C132-RUN-EMPTY.** *Statement:* each step of the route FS116-V6 § 2.2 (`plans/FS116-V6-verification.md`: V6-DIAM, V6-E1, V6-DICH,
> — source: plans/FS132-six-by-the-nerve.md § The readings, stated

> **C132-RUN-CV.** *Statement:* each input of the route to FS114-CV-EXISTS (`plans/FS114-CVB-verification.md` § 1.4, by the entry's
> — source: plans/FS132-six-by-the-nerve.md § The readings, stated

  **Two statements enter the list with them, each named inside its reading's statement and read there**: **C132-M-EMPTY** — that
  no colouring of the class C132-RUN-EMPTY names exists (the existence form's NO, in the measurable class); **C132-M-CV** — that
  the class C132-RUN-CV names has an extracted centre whose label cycle has length at least four. They are named apart from the
  readings because "the argument runs" and "the statement is true" come apart: a stall of a reading says nothing of its
  statement, and either statement may be derived by another route. *Not claimed*: each reading's own line, as its statement
  gives it. **One reading of the stub, the deriver's, adopted**: the existence form's "cyclic centre whose label cycle has length
  four" is read as an extracted centre with a cycle of length four — the extraction returns some centre, not a prescribed one,
  and its cycle need not consist of edges of that centre's own transition graph.

