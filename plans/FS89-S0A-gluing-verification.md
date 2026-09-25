# FS-89 Stage 0A — blind verification of the gluing (verifier G)

Brief: `data/fs89/briefs/S0A-gluing-verifier-brief.md` (commit 0a346e98). Verifier G, Opus 5.5, 2026-09-25.
Closed until every C1 verdict is saved: the advisor's record, the FS-89 stub's banner, the close inventory, the S0B record and
`data/fs89/s0b/`, `git log` from 052707ac on. None opened.

## C0 — predictions (written before any file other than the brief was read and before any derivation was written)

Honesty note: these were written after reading the brief and a first mental pass over the statements (a few minutes of thought,
nothing written, no file read). They are priors of that moment, not of a blank mind.

| statement | predicted verdict | probability |
|---|---|---|
| G0 (setup: the rational ring, the layers, restriction is a band character) | true, elementary | 0.97 |
| G1 (the gluing), as stated with a fixed `N` | true | 0.85 |
| G1 without a fixed `N` (only `⊆ T + A`) | true, because the band condition itself bounds the torsion order on `ℤ[U_ℚ]` | 0.6 |
| G1's "hence HD1 for ℚ(√59), ℚ(√83), ℚ(√131)" via FS86-dB-Theta | true, if dB-Theta's hypothesis is exactly `T + A` | 0.7 |
| G2 (ℚ(√47): `Θ₄(R) = ∅` under the hypothesis) | true conditionally; needs a per-place argument that the gluing does not supply | 0.7 |
| G3 (ℚ(√167): `Θ₅(R) = ∅` under the five-band rational statement) | true conditionally, but the per-place and product (several places at once) facts it needs are real work | 0.55 |
| the four-band rational statement `Θ₄(ℤ[U_ℚ]) ⊆ T + A` itself | open; it carries the same "infinitely many split places" difficulty as HD1 | 0.5 true |

Where I expect the weight to sit: the gluing step itself should be easy because `ℤ[U_ℚ]` is 5-divisible, which makes the
archimedean part of a character canonical; the real content is (a) whether the fixed `N` is automatic and (b) whether the
rational statement moves the infinitely-many-places difficulty rather than removing it.

## Would-have-searched-here log

(none yet)
