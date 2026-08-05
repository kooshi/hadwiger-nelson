# M21 — Coupled circle systems (stub)

*Carry-forward notes, written 2026-08-04 as M20 closed. Not yet subplanned.*

## 1. Why this is the forced next question

M20's one-pivot cap (`Compulsion.lean`): the centre plus both circles — one pivot's whole
system — is **exactly 4-chromatic**. So a 5th colour on a cover set (coverage 4 at k = 5,
the confinement jump the hunt needs) *cannot* arise inside one pivot's system: it requires
structure spanning **at least two pivots**. That is a theorem naming where extension
pressure must live, and M20's measurements say the same from the other side: the plain
closure's profile at pivot 630 is full (6,144/6,144 extend — zero pressure), and the
closure-flavoured gadget battery kills <SLOT: battery verdict>.

## 2. The object

Two pivots `p`, `q` at some exact distance `d`, each carrying its two circles; the joint
unit-distance graph adds **cross chords** between the systems (pairs at distance exactly 1
across). Questions, in rising order:

1. **Which `d` produce cross chords at all, and with what structure?** The cross-chord
   condition between circle (p, r₁) and circle (q, r₂) is an annulus condition on `d`;
   the *label-level* structure of the cross edges (which strip cells of p's tubes see
   which cells of q's) is a rotation by the phase of `q − p` — one new "seam" per circle
   pair, four per pivot pair.
2. **The coupled automaton.** One tube is a 1-D constraint system with exact transfer
   structure (M20: core 864, growth ×12). Two coupled tubes = a product system with
   cross constraints tied to the coupling seam's angle — when the cross-chord label map
   is periodic (rational rotation), the coupled space is again a finite-state system;
   when irrational, it is a constraint on two incommensurate strips. Classify which.
3. **The hunt question.** Does some pivot pair force χ({p, q} ∪ circles) ≥ 5 — or at
   five colours, kill 3-patterns on one pivot's cover set? The profile instrument
   (`tools/extend.py`) reads this directly: profile p's patterns in a graph containing
   q's system. The de Grey spindle pair (the known χ ≥ 5 machine) is the first `d` to
   try: its pivots' circles already coexist inside the closure.
4. **The Lean side.** The two-tube decomposition and window-extension theorem
   generalize per coupling class; the first target is the cross-chord classification
   for one exact `d` (the analogue of M19's three chord lemmas).

## 3. §0 candidates (measure before specifying)

* Census over the closure: for every pivot pair (both carrying 1/3 classes), the
  cross-chord count between their two-circle systems as a function of exact `d²` — the
  coupling-strength spectrum, exact arithmetic, no SAT.
* For the strongest-coupled pair: the joint profile (pin patterns on both cover sets
  simultaneously; verdict per pattern pair) — the 2-pivot extension profile.
* The coupled-automaton feasibility probe: is the cross-chord label map periodic for
  the closure's distances? (Exact: is the phase of `q − p` a rational multiple of π
  composed with the seam lattice? The M19 algebraic-integer machinery answers.)

## 4. Standing context

Writeups/upstreaming deferred (standing policy); the certified-6-colouring angle stays
the designated perspective shift if this thread goes flat; `lean4checker` replay stays a
publication gate. All builds via `scripts/build.sh`; segfault ⇒ halt and report; one
heavy job at a time — and the profile instrument's enumeration cap is mandatory (the
M20 OOM lesson).
