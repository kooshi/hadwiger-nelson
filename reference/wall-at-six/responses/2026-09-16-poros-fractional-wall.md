# Poros — the fractional wall

2026-09-16. A question card and evidence record for `WALL-AT-SIX.md.txt`.

The useful connection is between the independence bounds already being computed and **fractional chromatic number**. It changes the treatment of composite ideals: an independence obstruction to six colours survives every finite categorical product of factors having that obstruction.

The conjectural independence inequalities already appear in the supplied record. The additional deduction here is their consequence for products, and the resulting separation of two possible mechanisms for the wall.

## Arrival survey

**Goal, as stated in the supplied research note:** “We would like the theorem — or the counterexample” (§0.1), for W: none of the specified norm-one Cayley graphs has chromatic number exactly six. The motivation is Hadwiger–Nelson through an additional local–global conjecture.

**Provenance:** I read the supplied 177-line Poros core and all 601 lines of the research note. The first combined tool output was truncated; subsequent numbered reads covered both files completely. Expectations were recorded before those complete rereads, after partial exposure to the contents; this was not a blind prediction. The Lean development, independent-set witnesses, SAT proofs, certificate checker, and raw search logs were not supplied. Their results retain the note's stated trust levels; I have not independently checked those artifacts.

The core is self-contained. Its named companion `poros-anomaly-hunt` and `poros_gate.py` were not found in the available skill catalogs, local search, or a Library title search. No companion procedure or automated Poros gate is claimed to have run.

| Frame axis | Frame in the record | Consequence for this reading |
|---|---|---|
| Object | The finite targets U_Q (§1.2), with field planes in §1.5 | A result about a target is not automatically a lower bound on a field plane. |
| Question | Exclude χ = 6 (§2); explain the independence plateaus (§§4–5) | Separate χ > 6 from the stronger inequality Q²/α > 6. |
| Discipline | Finite geometry, character sums, spectral bounds, exact optimization | Fractional graph colouring and products supply an applicable theorem. |
| Audience | An outside reader, explicitly invited to read cold (opening paragraph) | State the graph invariant and theorem in their standard vocabulary. |
| Product | A theorem or counterexample (§0.1), with mechanisms preferred over further null searches | Produce one discriminating question and a checked consequence; retain the open cases. |

The instruments are well described: Rust local search, KaMIS, subgroup and equivariance restrictions, SAT/CP-SAT, and exact rational SDP certificates. The converged SDP bounds at four odd window members cannot be improved merely by running that same relaxation longer (§4.2). The searches provide lower bounds on α. Their failure to improve those bounds remains inconclusive. In particular, the measured four-neighbour rigidity at 27 (§4.3) explains a local-search barrier without proving global optimality.

## The connection and its consequence

Write n = |V(G)|. A fractional colouring assigns nonnegative weights to independent sets so that every vertex receives total weight at least one; its cost is the sum of the weights. For a finite Cayley graph,

\[
\chi_f(G)=\frac{n}{\alpha(G)}.
\]

Here is a direct proof. Summing the covering constraints over vertices gives n ≤ α times the total weight. Conversely, translate a maximum independent set through the group and give each of the n indexed translates weight 1/α. Each vertex belongs to α translates, so this is a fractional colouring of cost n/α. Repeated translates can have their weights combined.

Thus the record's “reading”

\[
\chi(G)=\left\lceil n/\alpha(G)\right\rceil
\]

is an **additional rounding assertion** about ordinary colourings. The always-valid relation is

\[
\chi(G)\geq\lceil\chi_f(G)\rceil.
\]

Zhang's Theorem 1.8 states, for finite vertex-transitive graphs G and H,

\[
\frac{\alpha(G\times H)}{|V(G\times H)|}
=\max\!\left\{\frac{\alpha(G)}{|V(G)|},
                 \frac{\alpha(H)}{|V(H)|}\right\}.
\]

The theorem does not require the factors to be identical or their maximum independent sets to be primitive. I checked the statement and the independence-bound argument in §2. [Huajun Zhang, *Independent Sets in Direct Products of Vertex-transitive Graphs*, Theorem 1.8](https://arxiv.org/pdf/1007.0797).

The corresponding equality for fractional chromatic number holds even without vertex-transitivity, by Zhu's fractional Hedetniemi theorem. His 2025 survey restates it as Theorem 2.4. [Xuding Zhu, *A survey on Hedetniemi's conjecture*](https://arxiv.org/pdf/2502.16078).

**Application derived here.** Every U_Q is vertex-transitive, and so are finite products of them. Iterating the identity gives

\[
\chi_f\!\left(\prod_i U_{Q_i}\right)
=\min_i\chi_f(U_{Q_i}).
\]

Consequently, if every factor satisfies α(U_Q) < Q²/6, the product also has independence ratio below 1/6 and cannot be six-coloured. No general integral form of Hedetniemi is needed for this conclusion.

This already applies to all products made exclusively from the targets excluded by the reported independence certificates and spectral bounds: 59, 67, 71, 79, 83 and the large-Q range. This application is conditional on the correctness of the supplied computational certificates; the product theorem itself is published prior art.

For the square-free CRT targets in §6.3, there are therefore three cases:

| Factors | Conclusion about the full product target |
|---|---|
| Some factor is at most five-chromatic | Projection gives a colouring with at most five colours. |
| Every factor has fractional chromatic number greater than six | The product needs at least seven colours. |
| Every factor needs at least seven ordinary colours, but the product is six-colourable | At least one factor must satisfy χ_f ≤ 6 < χ. |

So a composite escape through high-chromatic prime targets requires an integrality gap in at least one factor. Under the supplied bounds, that factor must come from the six unresolved targets. Arbitrary prime-power tower levels are not covered by this deduction: a projection from a tower to its residue graph does not supply the needed lower bound in the reverse direction.

## The one question

**Do all six unresolved targets satisfy χ_f(U_Q) > 6?**

Equivalently, the requested upper bounds are:

| Q | Reported lower bound on α | Reported upper bound on α | Upper bound sufficient to settle this case | Witness that would falsify the stronger claim |
|---|---:|---:|---:|---:|
| 23 | 87 | 108 | 88 | 89 independent vertices |
| 27 | 117 | 147 | 121 | 122 independent vertices |
| 31 | 146 | 200 | 160 | 161 independent vertices |
| 43 | 258 | 365 | 308 | 309 independent vertices |
| 47 | 265 | 371 | 368 | 369 independent vertices |
| 64 | 512* | 768 | 682 | 683 independent vertices |

*512 follows already from the reported eight-colouring on 4,096 vertices; it is not a claim about a completed maximum-independent-set search at 64. All thresholds were checked by exact integer arithmetic in this session.*

```text
question: is-the-wall-already-fractional
  evidence: WALL-AT-SIX.md.txt §§4.1, 4.4, 5.1, and 6.3; Zhang Theorem 1.8.
  expected: independence obstructions and integral colouring obstructions may have different consequences for composite targets.
  ask: Do all six unresolved targets satisfy χ_f(U_Q) > 6, equivalently α(U_Q) < Q²/6?
  if all six satisfy the inequality: combine the bounds with the proven ends to settle W and exclude exactly six for every square-free product target; remove that product escape from the project plan.
  if one violates the inequality: retain the witness and abandon the stronger fractional claim; determine that target's ordinary chromatic number using constraints on whole partitions. A value at most five preserves W, a value six refutes W, and a value at least seven identifies the integrality-gap case relevant to products.
  if the first bounded attempt is inconclusive: record the unresolved threshold and solver progress; do not promote another timeout into evidence of impossibility or automatically repeat the same search.
  answered by: derivation or run — exact independence upper bounds, or independently verified threshold witnesses.
  cost: the literature check and deduction are complete; solving the six cases has unknown cost. First proposed experiment is one 30-minute proof-logging threshold run at Q = 23 after a small known control, with no promise of completion.
  rank: 1
  fate:
```

**First concrete dispatch:** ask the existing exact-search machinery for an independent set of size 89 in Γ₂₃, with all 529 vertices represented and no restriction to symmetric solutions. The Boolean problem is one variable x_v per vertex, the constraints x_u + x_v ≤ 1 on each of the 6,348 edges, and Σ_v x_v ≥ 89. A witness is checked directly against squared distance one. An infeasibility conclusion requires a checkable proof, not an unverified solver status. The exact encoding and checker should first reproduce the known 28/29 threshold at Γ₁₁, or reuse an already validated implementation of that same encoding.

The choice is between this threshold decision, another heuristic plateau search, and initial exploration at U₆₄. I recommend the threshold decision because Γ₂₃ is the smallest unresolved target and either decisive outcome changes the mechanism under consideration. This recommendation is provisional: documented failure of an equivalent proof-producing run, or useful existing U₆₄ data not in the note, would change the priority. Default for the next computational research step: this bounded Γ₂₃ decision, without constructing product graphs. No such search was run in this session.

## Corrections that matter to the dispatch

1. **The six-window is conditional.** In §5.1, χ = 6 necessarily gives α ≥ n/6. It does not generally give α < n/5. The latter follows only with the unproved rounding assertion. Conversely, finding an independent set with n/α ≤ 6 does not provide a six-colouring. The question above is deliberately stronger than W.

2. **The product literature is out of date in §6.3.** Wrochna's Corollary 4.3 already gives failure of multiplicativity for K₆: take c = 6, k = 2, n = 4 in its conditions. Thus general graphs G and H can both have χ > 6 while their product is six-colourable. This is not a counterexample among the norm-one targets. [Marcin Wrochna, *Smaller counterexamples to Hedetniemi's conjecture*, §4, Corollary 4.3](https://arxiv.org/html/2012.13558v1).

3. **The q = 67 rounding sentence needs correction or clarification.** If 748.8 in §3.2 is a valid upper bound on α, then integrality gives α ≤ 748 and 6·748 = 4,488 < 4,489 = 67². It already excludes six. If that number was merely an uncertified numerical iterate, the problem was its certification status, not its value.

4. **The field objective remains separate.** In §2, containing a finite six-chromatic graph does not make the entire field plane six-chromatic; it could have chromatic number seven. Thus L ≥ 7 is not by itself a local–global gap for a field merely containing such a graph. Moreover, the note already reports L ≥ 7 for F₀ = Q(√3,√7,√11): the bold local–global conjecture would give seven there independently of W. The deduction in this note settles no missing lower bound for G(F₀).

5. **The forcer conclusion is not supplied by Hoffman slackness alone.** The divisibility observation in §7.3 rules out equality in that spectral bound. It does not, by itself, prove that every distinct nonadjacent pair can receive different colours in a six-colouring. A separate graph-specific result would be needed for the stated conclusion about absence of forced pairs. If no six-colouring exists, universal assertions about its colour pairs are vacuous.

## Evidence inventory

- `SKILL.md.txt`, all 177 lines — read against: the core should specify an arrival survey, an evidence-derived question, distinct branches, and a falsifier — surprised: no. Companion and gate references are present, but their files were unavailable.
- `WALL-AT-SIX.md.txt`, §§0–2 — read against: field and finite-target claims should be linked only by the stated directions of implication — surprised: yes. The distinction between a finite six-chromatic subgraph and an exactly six-chromatic field plane is lost in one sentence.
- `WALL-AT-SIX.md.txt`, §§3–4 and Appendix A — read against: threshold arithmetic should agree and search plateaus should remain lower bounds — surprised: yes. The 748.8 sentence conflicts with the integer threshold; most trust distinctions are explicit and useful.
- `WALL-AT-SIX.md.txt`, §§5–8 and Appendices B–C — read against: an independence-to-colouring equivalence needs justification, and product claims should use the applicable literature — surprised: yes. The fractional invariant is unnamed and its product theorem is missing.
- Zhang, Theorem 1.8 and its independence-bound proof — read against: the identity should cover arbitrary finite vertex-transitive factors — surprised: no. It applies directly to the supplied targets.
- Wrochna, §4 and Corollary 4.3 — read against: the reported small-colour status might have changed since Shitov — surprised: yes. The relevant six-colour counterexample theorem was already available in 2020.
- Shi–Li–Helleseth–Özbudak, introduction to arXiv:2411.14087 — read against: the norm-one columns may identify the graphs with a coding-theory object — surprised: no. The parity-check construction supplies a useful name, but the read result concerns covering radius, not the needed independence or colouring bound. [Source](https://arxiv.org/html/2411.14087v1).
- Underlying project witnesses, certificates, proof logs, and Lean files — read against: the stated upper and lower bounds should be reproducible at their marked trust levels — surprised: unread. Not included among the attachments.

## Hunch ledger

```text
hunch: the-counting-obstruction-survives-products
  claim: categorical products of the vertex-transitive targets with independence ratio below one sixth also have independence ratio below one sixth.
  basis: derived from the published product theorem
  falsifier: a missing hypothesis in Zhang Theorem 1.8, or an error in applying its ratio identity to these finite Cayley graphs.
  registered: 2026-09-16
  status: confirmed by checking Theorem 1.8 and applying it inductively; no reliance on the unproved rounding assertion.

hunch: all-six-open-targets-have-a-fractional-obstruction
  claim: α(U_Q) < Q²/6 for Q in {23,27,31,43,47,64}.
  basis: measured lower-bound plateaus in the supplied note motivate this for the odd targets; the dyadic member has much less evidence.
  falsifier: an independently verified independent set at any of the six threshold sizes in the table.
  registered: 2026-09-16
  status: open; neither search failure nor the product theorem confirms it.

hunch: small-colour-hedetniemi-is-still-open
  claim: general Hedetniemi counterexamples cannot yet reach a six-colour product of factors requiring more than six colours.
  basis: read from the supplied note §6.3, provisionally held during the audit
  falsifier: a primary theorem constructing such factors and a six-colourable product.
  registered: 2026-09-16
  status: killed by Wrochna Corollary 4.3, instantiated with c = 6, k = 2, n = 4. The restricted norm-one-target question remains open.
```

The dispatch is to exact extremal graph theory and the project's proof-checking machinery. The product consequence is established; the six independence decisions remain open. No new colouring, optimal independent set, or proof of W is claimed.
