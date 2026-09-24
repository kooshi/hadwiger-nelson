Hello de Bruijn. You are this project's Lean engineer and mathematician; the identity is `/home/kooshi/source/lean-dir/DEBRUIJN.md`. I'm the product owner. Kooshi, the human whose project this is, has asked me to coordinate and review rather than do the mathematics, so the mathematics is yours. I'll score it by artifact.

## The target, in one sentence

**The 5-part lemma: every proper four-colouring of de Grey's lattice `Cay(Λ, U)` is `24Λ`-periodic.** It is the last step between today's results and a complete derivation, from published hand-checkable prior art, of why every four-colouring of that lattice is `8Λ`-periodic. That statement, `F = P = 8Λ` (`LEDGER.md` row 78), currently rests on a 2,044-point solver refusal (a 56.5 MB LRAT).

## Where FS-85 left it (all committed; read these, in this order)

1. `CLAUDE.md`, `WORKFLOW.md` and `DEBRUIJN.md`, from disk; any copy in your context may be stale. Especially:
   - § Notation;
   - G54 (tight or slack), G68, G69 (rigidity is arithmetic; de Grey's unit vectors are exactly the residue tori of `𝔽₂₅` mod 5 and `𝔽₄₉` mod 7), G70, G71, G73;
   - G21 and G30.
2. `plans/FS85-rigidity-without-triangles.md`: §0, §IQ and the owner's §R-review at the end.
3. **Coxeter's route**, `plans/FS85-C-Coxeter.md`, sections R2.0 to R2.12. This is the frame the target is stated in.
   - **The spectral lemma (FS85-C7).** With colours as the vertices of a regular tetrahedron, "no monochromatic √3-triple in family `k`" is the identity `A_k g = −2g`. The Fourier support of `g` lies in `Θ_K`, three circles per family, and finite support forces periodicity.
   - **The exact table (C8).** All nine families give 42 characters, generating the dual of `Λ/8Λ`. Families `|k| ≤ 2` give 7,290 characters, the preimage of 90 on `Λ₅ = ⟨U_{|k|≤2}⟩`: 42 of 2-power order and **48 of order 10, each of the form `π/2 + θ₅`**. Their period lattice is exactly `120Λ`.
   - **Corollary U (C10).** From Parts's stripes (prior art; the five inner orientations): every colouring is `120Λ`-periodic.
   - **Theorem R (C9, C12).** No √3-triple in all nine families implies `F ⊇ 8Λ`, a uniform chirality, (PL), the collapse onto the 64-point torus, and the count 9,120.
   - **The no-go (C14).** Second moments cannot lift `120Λ` to `8Λ`: there is an exact witness off the 42.
   - **The alternate-triple lemma (C15).** Frequencies in `Θ_all` plus the characters of an odd-index `Λ_K` give no √3-triple in any family whose alternate triples lie in one coset of `Λ_K`. **So the 5-part lemma implies the rest.**
4. **de Bruijn's round-1/2 route**, `plans/FS85-C-deBruijn.md`, "Part 1" (dB5 to dB11).
   - dB5: level-3 tightness, with the least eigenspace split by prime.
   - dB6: locality at one prime.
   - dB8: Lemma S.
   - dB9–dB11: from the stripes to periodicity, `F ⊇ 1680Λ`.
   - Gap B, the slack quotients.
5. **The blind verification**, `plans/FS85-V-verification.md`. It independently confirms `P = F`, `F ⊇ 1680Λ` given the stripes. It also found that the Polymath16 wiki's written Prop. 7 does not close, and gives the one-line repair.
6. **The competition advisor's reading of this target**, `plans/POROS-2026-09-24-fs85-competition.md`, its final sections. Posed structurally, the target is to classify the tetrahedron-valued functions on `Λ/40Λ` whose spectrum lies in the 2-part plus the 5-part.
   - `Cay(Λ/40Λ, Ū)` is a sparse subgraph of the categorical product of the tight 2-adic quotient `Cay(Λ/8Λ, Ū)` with `Cay(Λ/5Λ, Ū)`, and the latter is not four-colourable (the residue target at 25; G69).
   - So the question has the Greenwell–Lovász shape: must every colouring of the sparse product pull back from the tight factor? FS-67 is its three-colour form.
   - Second moments are ruled out (C14). The advisor expects the instrument to be pointwise, a sign-twisted form of Coxeter's tetrahedron splitting (C9's R2.3 item 2).
   - This is a reading, at medium confidence. It is yours to use or reject.

## What I'd like

**Prove the 5-part lemma, or find exactly why it resists.** Each of these is a success (Kooshi, 2026-09-24: "A proven theorem about why its impossible is also valid. All novel knowledge is a success."):
- a proof;
- a reduction to a smaller named statement;
- a proved no-go for a named format of certificate;
- a counterexample. A counterexample would contradict row 78's certificate, so it would first mean an error somewhere, to be found.

Before any route, write in your working file:
- **§IQ for this sub-question** (WORKFLOW 3.3): the existence form, the structural form, the invariant it forces, and the route.
- **Your predicted outcome with a probability.**

**The ban (`CLAUDE.md` § Toolchain; the finite-witness-free week runs to 2026-10-01).**
- No SAT, MILP, colouring enumeration, finder or sweep.
- Exact computer algebra that checks a derived claim is in: spectra, Smith forms, character sums, an enumeration of *patterns* whose shape a derivation fixed.
- An exact LP is in only when a derivation fixes its shape before it runs and its dual is read back as an identity.
- **The trap here:** `Λ/40Λ` is finite (2,560,000 points), so "just colour it" is always one command away. That would be a search, and it is out. Log every such impulse in a **"would have searched here" log**.

## Mechanics

- **Your working file:** `plans/FS85-R3-five-part.md`. You are its only writer.
  - Keep a "State" section a fresh agent could resume from, a "Theorems this phase proved" heading (statement, grade, where the proof lives), your retractions, and the search log.
  - Commit it by explicit path after each result.
  - No competition is running, so the repository is the right place.
- **Commits:** by explicit path. Run `git diff --cached` and confirm every hunk is yours. Never amend. End each message with the attribution lines your harness supplies. Don't push; I push. Report each commit's hash.
- **Tools:** under `data/fs85/r3/`. Plant a fault in any new checker and confirm it fires.
- **Heavy jobs:** anything over about 2 GiB or 2 minutes runs as `scripts/slot.py --mem <GiB> --cpus <N> -- <cmd>`. /tmp and swap are RAM on this machine, so large outputs go to disk. Kill by pid, and verify by effect. Never run `lake build`.
- **Frozen tools**, never edited:
  - `tools/fs58_*`, `tools/fs61_*`, `tools/fs66_*`;
  - `tools/fs73_cert_check.py`, `tools/fs73_census_check.py`, `tools/fs73_theta_check.py`, `tools/fs73_theta_struct_check.py`, `tools/fs73v2_check.py`;
  - `data/fs73/coxeter-c3/certcheck.py`.
- **No subagents.** You may not spawn subagents, forks or workflows; delegation here is one level deep (`CLAUDE.md` § "Delegation — one level deep").
  - The reason: staffing is Kooshi's budget decision, and I can only review work I know about.
  - If the work outgrows your context, stop at a committed boundary and tell me what is left. That is a good report, not a failure.
- **Budget:** about 400k tokens.
- **Stop rule, whichever comes first:**
  - the lemma is proved;
  - it is reduced to one named statement you cannot close;
  - a no-go is proved;
  - your context reaches about 450k;
  - or 2026-09-30 12:00.
- **Messages:** reach me by SendMessage with `to: "main"`. Keep your turn's final text content-free ("de Bruijn idle; report sent to the owner by SendMessage"), because a hand-back reaches whichever agent last woke you.
- **Report points:** after §IQ and your prediction; at each result; at the stop. Each report carries commit hashes, your token count and the one step you most want checked.
- **How results are checked:** a key step by me, and a landed result by a blind verifier before any ledger row.
- **The close inventory** (`plans/FS85-close-inventory.md`) is mine to write. Send me anything the close must not lose.
- **State every result at its exact scope and grade.** "Given Parts's stripes" is part of the grade.

Thank you. A clean two-page argument beats a big object.
