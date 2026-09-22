# M48 — the derivation file: every theorem this milestone stated outside the kernel

*Written 2026-09-22 by the FS-71 batch-2a implementer. Enumeration: `plans/M48-from-below-arity.md` read in full
(§0a D1–D4, §0c, §R0–R9). Grades are `CLAUDE.md` § Notation's. Three of the four §0a derivations (D1, D3, D4)
landed fully in the kernel the same milestone (`Arity.lean`, `Homogeneous.lean`, `Instances/HexShell.lean`) and are
already row 43's content — D1 in particular is the kernel correction of an error CLAUDE.md's grokking G26 once
carried ("one gadget at √3 or 2"), matching what this audit's own M41 entry flagged independently on re-reading
before finding this milestone's explicit correction. One derivation, D2, stayed hand-only and is uncaptured.*

## The theorems

**M48-T1 — No arity-3 pigeonhole exists in the hex-shell's own distance vocabulary. [hand; the M48 implementer]**
A point set all of whose mutual distances lie in `{1, √3, 2}` has diameter `≤ 2` and minimum distance `≥ 1`, hence
(Jung's theorem bounding it in a closed disc of radius `≤ 2/√3`, then a disjoint-open-disc packing argument: the
`n` disjoint open discs of radius `1/2` about the points all lie in a disc of radius `2/√3 + 1/2`, so by area
`n·(1/2)² ≤ (2/√3+1/2)²`) **at most `⌊4(2/√3+1/2)²⌋ = 10` points**. Since forcing a monochromatic *triple* by
pigeonhole at five colours needs `⌈n/5⌉ ≥ 3`, i.e. `n ≥ 11`, **no configuration drawn from `{1, √3, 2}` alone can
force a monochromatic triple at five colours by counting** — an arity-3 analogue of the hex-shell's Act One (which
uses `n = 7 ≥ 6` for a pair) cannot exist in this vocabulary. Widening to diameter `3` (radicands `4·7−1 = 27`,
`4·9−1 = 35`, neither a square, hence non-spindleable) admits up to `19` points, still short of the growth the kill
burden would need. *Proof:* `plans/M48-from-below-arity.md` §0a D2, a complete two-step argument (Jung's theorem,
textbook; a disjoint-disc packing/area comparison, elementary). *Proof verdict:* closes (both steps are standard
and stated in full; the arithmetic `4(2/√3+1/2)² ≈ 10.95` is a direct computation). *Rests on it:* §0c's registered
interpretation clause, honoured at the close — "a compulsion found at arity 3 from below is a statement about
mechanism... and NOT a rung toward χ(ℝ²) ≥ 6" — which is exactly how M45's arity-3 compulsions (`plans/M45-
derivation.md` T1, on a *different*, richer-vocabulary stage) and this milestone's own arity-3/4 zeros on the 1581
were read; without D2 a from-below arity-3 hit could have been mis-sold as a second route to the from-below reduction
D1 formalizes. *Prior art:* Jung's theorem (covering radius of a bounded-diameter set) is textbook convex geometry,
not itself cited here; the disjoint-disc packing bound on a bounded-diameter, bounded-minimum-distance point set is
a standard technique (a relative of the kissing-number / sphere-packing family of arguments), not searched as a
citable source for this exact application. zbMATH: `ti:"Jung theorem" & ab:"packing" & ab:"pigeonhole"` (0 hits,
2026-09-22), `ab:"monochromatic" & ab:"diameter" & ab:"pigeonhole" & ab:"coloring"` (0 hits). Nearest held key: none
on point. *Kernel:* declined — no module states this bound; it functions as an interpretive guardrail for arity-3
findings (M45, and this milestone's own §R), never as a hypothesis or conclusion any Lean statement needs.

## Readings and measurements that were called theorems

- **D1, the correction of G26's wording, and D3, D4 (the ladder theorem, plane homogeneity).** All three landed
  fully in the kernel this same milestone (`Arity.lean`'s `arityFloor_le_of_embedding`, `Homogeneous.lean`'s
  `exists_isometry_map_pair`/`forced_pair_of_forced`, `Instances/HexShell.lean`'s
  `six_le_chromaticNumber_plane_of_forced_pairs`) and are already row 43's content verbatim ("the six-target:
  χ(ℝ²) ≥ k + 1 from k-colour virtual edges at √3 AND at 2, neither sufficing alone on the hex-shell host"). Not
  filed here. This audit notes, cross-referencing `plans/M41-derivation.md`'s "Conjectures surfaced" entry: M48's
  §R1 records this correction as fixing *"the Frontier [that] had carried, since 2026-08-14, the reading that
  χ(ℝ²) ≥ 6 needs 'one gadget at √3 or 2'"* — i.e. M48 itself is where G26's "AND, never alone" wording comes
  from, independently confirming this audit's own finding (reached by reading M41's remark against the *current*
  G26 text, before this file was opened) that M41's original "or" framing was an error, not a rounding.
- **The arity-2/3/4 complete sweeps on de Grey's 1581 and gen-1** (0 compulsions throughout, `arityFloor ∈ {4,5}`,
  the 1-minimality corollary, the effort/pool-sampling findings of P6): all [tools] measurement, already correctly
  captured by row 43 ("[tools] The 1581's arity floor at five colours is 4 or 5, by complete sweeps (G31)") and by
  G31 in `CLAUDE.md`.
- **§R8's "P6's second half," the sampler-artifact argument** (an induced subgraph's achievable colour-pattern set
  on shared vertices is necessarily a *subset* of the supergraph's, so a *lower* observed-pattern count on the
  bigger object cannot be structural): a short, correct, elementary argument diagnosing why a registered prediction
  was "wrong a priori" — method/instrument diagnosis (the M19 lesson recurring), not a theorem about the chromatic
  problem; not filed.
- The crash-resumption/instrument-correctness findings of §R6–R7 are engineering, not mathematics; not filed.

## Conjectures surfaced, not claimed

(none)

## Prior art re-attributed

(none)

## Kernel decisions, summarised

| theorem | decision |
|---|---|
| M48-T1 | declined — functions only as an interpretive guardrail, never a Lean hypothesis or conclusion |
