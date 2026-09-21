# The owner's plants against Phase 2A's checker (2026-09-21) — all refused by name; the twin certifies

Made from `data/fs66/b1/proto-cert-p7.json`; three of the four **preserve the identity (★)**, which is the dangerous kind — a checker
that verified only the identity would pass them.

| plant | what it does | checker's last line |
|---|---|---|
| A | one box row given multiplier `lam + k` and a second copy of it `−k`: (★) unchanged, one multiplier negative | `REFUSED NEGATIVE_MULTIPLIER: rows[519] has multiplier −3963735136946606463427040 < 0 …` |
| B | every sign flipped — scale, `U_num`, every block, every multiplier: (★) unchanged coefficient by coefficient | `REFUSED NONPOSITIVE_SCALE: "scale" is −10³⁰ … with scale <= 0 that division flips the inequality …` |
| C | block 0 split as `(R − D) + D` with the same weights: (★) unchanged, the first block indefinite | `REFUSED BLOCK_NOT_POSITIVE_DEFINITE: blocks[0] … leading principal minor 1 = −14015019457606000000000000000001 …` |
| D | the certificate for 7 relabelled `p = 11` | `REFUSED MALFORMED: weights[0] has 50 entries; a weight vector … has 1 + n = 122 … Is the file's "p" = 11 the prime it was made for?` |
| twin | the unmodified file through the same scaffolding | `CERTIFIED … U = 14.017576… ; 3*U = 42.052730… < 49 …` |

Scoring commands of the plan's §H run by the owner: `CERTIFIED` at (3, 2), (7, 3), (11, 4) with exit 0; `BOUND ONLY`, exit 3, at
(11, 5); `ERROR CANNOT_READ`, exit 2, on a missing path; `git status` unchanged by all of them; imports standard library only.
**Phase 2A ACCEPTED.**

**A conjecture the phase's sweep surfaced, to be minted as a stub at the close (not declined):** at 7 the tightened relaxation reads
`α` exactly (14.0000), so *the tower never rises at 7* — `α(UD(ℤ/7^k, 2)) = 14·49^{k−1}` for every `k`, i.e. the supremum of the Haar
measure of a measurable independent set of `ℤ₇²` is exactly `2/7` — may be provable by an exact certificate at the optimal face.
That needs positive-SEMIdefinite blocks and rational recovery of the face: a format change to the checker, deliberately outside
this milestone. An exact value of a `p`-adic analogue of `m₁(ℝ²)` would be worth a milestone of its own.
