# FS-100 close inventory (opened by the product owner, 2026-09-26, with the plan; WORKFLOW 5 — the owner is its only writer until the close)

*Milestone: FS-100's in-ban stages (`plans/FS100-three-field-lemma.md`). Planner J51; derivation J51D and blind verifier J51V in parallel. One line per item with its source; the close planner ticks each done or declined with its reason and reads every number from the source.*

## Items

| # | kind | item | source | status |
|---|---|---|---|---|
| 1 | result | J51-T1: real quadratic ℚ(√d) is in T-C(A)'s class ⟺ d ≡ 47, 143, 167 (mod 168) ⟺ L ≥ 5; ℚ(√143), ℚ(√311), ℚ(√335), ℚ(√167) in class [hand + tools exact, one mind; rests on J28D's class form, Lemma P, FS-66] | plan §1.4; tools/j51_tca_class.py (plant fired) | open |
| 2 | result | J51-T2: for every finitely generated Γ ⊂ U_F, ann(ℤ[Γ]) is a proper infinite closed invariant subgroup of R̂, so EL's Thm 1.2 never applies [hand, one mind] | plan §PA.3 | open |
| 3 | result | J51-T3: KS-sat ⟹ Kronecker selection, by fibre colour sets, no measure [hand, one mind, sketch; J51D/J51V check it as KS-2] | plan §PA.3 | open |
| 4 | result | the card answered: branch "first yes (EL2021 Thm 1.3, modulo PE-lim), second no/open" [reading, one mind] | plan §PA.3 | open |
| 5 | prior-art debt | EL2021 (arXiv 2101.11120v1) §§2–9 unread; copy at data/fs100/j51/el2021.pdf | plan §PA.2 | open |
| 6 | prior-art debt | EL2003 ERA-AMS: author summary only (AMS PDF bot-blocked) | plan §PA.2 | open |
| 7 | prior-art debt | Rudolph 1990, Johnson 1992, Host 1995: zbMATH reviews only | plan §PA.2 | open |
| 8 | prior-art debt | Z. Wang 2012 (non-hyperbolic) and Lindenstrauss–Wang 2012 (topological self-joinings): KS-3's nearest literature, unread | plan §PA.2 | open |
| 9 | prior-art debt | Bekka–Francini 2022 (characters of algebraic groups over number fields via solenoid rigidity): possibly the closest in print to MR; unread | plan §PA.2 | open |
| 10 | correction owed | stub §5 item 5 "not checked here" → J51-T1; stub §2.3/§7 "probably includes ℚ(√167) (not checked)" → checked, yes | plan §S proposed edits | open |
| 11 | correction owed | J43's facts file: ℚ(√143), ℚ(√311), ℚ(√335) untagged though in row 113's class form | plan §S proposed edits | open |
| 12 | correction owed | Kronecker selection's "closure of the image of Θ's (T + A)-part" is ill-defined as a subgroup of Tⁿ; read as the factor K/K₀ with K̂′ = {m : m·Θ ∈ T + A} | plan §S | open |
| 13 | prediction scored | J50's hunch mr-is-open-measure-rigidity: supported by a read citation (EL2021 Thm 1.2's dichotomy; total irreducibility fails here) | plan §PA.3 | open |
| 14 | prediction scored | J50's card: hunch "first yes, second no" — met, with the first yes conditional on PE-lim | plan §PA.3 | open |
| 15 | prediction registered | X-MR 0.7 true / 0.02 decided here (a belief, not scoreable in-ban) | plan §P | open |
| 16 | prediction registered | X-KS 0.50 TRUE / 0.15 FALSE / 0.35 GAP; P-sat 0.85; P-sat1 0.70; P-K0 0.75; P-EL 0.80; P-ent 0.05 | plan §P | open |
| 17 | prediction registered | X-R1's killing test written: a U-invariant E-null τ, weak* limit of Fin_S-carried measures, not Haar | plan §P | open |
| 18 | stub to mint or re-aim | PE-lim (from EL2021 Thm 1.3 at finitely generated Γ to U-invariance: positive entropy ⟹ Haar on R̂) — stage 5's derivation | plan §PA.3, §S | open |
| 19 | stub to mint or re-aim | FS-64: Kronecker selection + T-C(A) would close four-colour adelic windows over every class field, not only ℚ(√47) | plan §IQ item 5 | open |
| 20 | bears | G21: route-dependence audit; controls of the right shape (KS-5 added) | §G.1 | open |
| 21 | bears | G27: Galois-averaged τ allowed in MR | §G.1 | open |
| 22 | bears | G30, G46, G49, G50: the recognition (R̂ an EL solenoid, U by automorphisms; self-joinings) and the gate | §G.1 | open |
| 23 | bears | G35, G43, G44, G66: the class check's inputs | §G.1 | open |
| 24 | bears | G48, G64: targets as values of L; S and W apart | §G.1 | open |
| 25 | bears | G54, G55: no tight place → a count; R = O′ makes R̂ S-adic with S infinite | §G.1 | open |
| 26 | bears | G60: P1's finite H route (post-ban) | §G.1 | open |
| 27 | bears | G71, G72, G73, G79: §IQ — pair-level carrier, structural form, averaged certificates, the example invariant | §G.1 | open |
| 28 | bears | G74, G76, G77: Kronecker's rank one is band rigidity; Berend with the rotated plane set aside; C9 the control | §G.1 | open |
| 29 | bears | G51, G67: one derivation + one blind verifier; the terse form | §G.1 | open |
| 30 | owner ruling | §M (the two modeling skills) left by J51 is run by J51D at its stage 1, fresh with the Skill tool, before any derivation — accepted (WORKFLOW 6 needs it before implementing, and J51 was at its budget) | owner, launch of J51D (handoff §7) | open |
| 31 | owner ruling | KS-2 stays in J51V's fixed list — dropping it would hide nothing, since KS-3 states KS-sat itself, and J51-T3 (one mind, a sketch) is what the reduction rests on | owner, launch of J51V (handoff §7) | open |
| 32 | agent slip | J51 read LEDGER § A by row heads (~240 characters), with the consumed rows read deeper, not in full as briefed — declared; accepted for this milestone | plans/FS100-three-field-lemma.md §G.2; data/crunch-2026-09-25/reports/J51.md held item 3 | open |
| 33 | file to move | EL2021's PDF committed at data/fs100/j51/el2021.pdf (567 KB); the house copy belongs in ~/source/library/ with a BIBLIOGRAPHY.md entry and its per-section reading status | 47d0106f | open |
| 34 | owner error | J51V's fence 'the bodies of commits whose subjects start "J51"' and 'reports J51*.md' literally include J51V's own — clarified at launch: its own commits and report are excepted | data/crunch-2026-09-25/briefs/J51V-FS100-kronecker-verifier.md | open |
| 35 | result | J51V-X1: over ℚ, Θ = (θ + ψ_w, θ + ψ_w̄) (θ the dyadic parity character, ψ_w, ψ_w̄ the two primes above 5) with W = 2⌊2t₁⌋ + ⌊2t₂⌋ meets KS-1's hypothesis while K̂′ = 0, so K′ = {0} and no W′ exists: KS-1 and KS-3 FALSE [hand + tools exact] | record §2.4–§2.5; tools/j51v_cross.py; data/fs100/j51v/cross-*.out | open |
| 36 | result | J51V-X2: the same over every real number field with a stable dyadic place ramified in L/F; the k²-colour analogue of KS-1 fails over every real number field; 0 ∉ cl Θ(U) forces no non-zero m·Θ into T + A (no naive vector band rigidity) [hand] | record §2.4 | open |
| 37 | result | J51V-KS2: KS-2 TRUE (Fubini over K₀-cosets; any measurable selection works) [hand] | record §2.3 | open |
| 38 | result | J51V-N1: KS-1 TRUE at n = 1 over every real number field, given row 98 [hand] | record §2.4 | open |
| 39 | result | J51V-EQ: where T-C(A)@∅ holds, KS-1 at F ⟺ X at F; X holds for Θ ∈ Eⁿ (T-C(A) at a finite S) and at n = 1; open for n ≥ 2 with a combination outside E [hand] | record §2.6 | open |
| 40 | result | J51V-K0: J45's SP-Cor and A⁺@∅ hold with J45's proofs wherever T-C(A)@∅ holds (any real number field); ℚ(√143), ℚ(√311), ℚ(√335) are in T-C(A)'s class [hand; membership tools exact, not blind] | record §2.7; tools/j51v_class.py | open |
| 41 | result | the mechanism [reading]: at a split place Cay(R, U) maps into the co-normal product Cay(T, I) ∗ Cay(T, I), which is χ(G)²-colourable | record §3.2 | open |
| 42 | correction owed | stub §2.3 cell "Kronecker selection finishes the pure-point layer" (ℚ(√47)): the E-part is finished by T-C(A) at finite S, rank one by row 98; the rank ≥ 2 non-E part is open and equivalent to the selection there | record §3.4 item 1 | open |
| 43 | correction owed | row 98 "Not claimed" could add: no naive vector form of band rigidity (J51V-X2 (c)) | record §3.4 item 3 | open |
| 44 | correction owed | KS-5 wording "the image of θ_{C9}" → "the closure of the image, via the first coordinate"; K0's A⁺ scope; brief input list (SP-oi not in J45 §5.4; row 105 does not state R = O′) | record §3.4 items 4–6 | open |
| 45 | prediction scored | C0 first-read: KS-1 (TRUE 0.55) lost; KS-3 (tied 0.35/0.35) FALSE; the other five met | record §3.3 | open |
| 46 | slip | fence breach: a broad `grep -rn "Lemma P" plans/*.md` printed 8 lines of plans/FS100-three-field-lemma.md and 1 of plans/FS100-close-inventory.md (J51-T1, the class membership); contaminates only K0's parenthetical | record §1.2 | open |
| 47 | tool defect | two plants that could not fire (c9-shift as (2x+4y)/7: 8 of 49 forms work; forget-seven aimed at ℚ(√11), already out via its dyadic place); both replaced by firing plants, kept in docstrings | record §2.9 | open |
| 48 | result | Owner check of J51V-X1 [hand, a second mind, not blind]: at w = (2+i) and w̄, a unit vector has v_w(u) = −v_w̄(u), so one of ψ_w(u), ψ_w̄(u) is 0; θ(U) = {1/2}; so cl Θ(U) ⊆ cross and W is proper (a half-shift flips one bit of W); ψ_w, ψ_w̄ are independent split-place characters outside T + A, so K̂′ = 0 and K′ = {0}. Agrees. tools/j51v_cross.py re-run by the owner: ALL CHECKS PASS, exit 0 | owner, 2026-09-26; data/crunch-2026-09-25/reports/J51V.md | open |
| 49 | owner ruling | J51V's fence breach (a `grep … plans/*.md`) accepted: it touches only K0's class-membership sub-verdict, which is J51-T1 (one mind + tools exact) plus a partly blind check; graded so at the close | plans/FS100-J51V-verification.md §1.2 | open |
| 50 | owner ruling | J51D fenced by message from J51V's record, files, report, this inventory and the handoff until its stage 4 commits (routine independence fence; no verdict disclosed) | owner message to J51D, 2026-09-26 | open |
| 51 | owner ruling | HELD until J51D reports: whether FS-100 stage 4 is re-aimed (selection onto the E-part / X at ℚ(√47), J51V-EQ) or closed as a no-go — decided from the divergence table | data/crunch-2026-09-25/reports/J51V.md held item 1 | open |
| 52 | owner error | The owner's commit 3648d3a5 carried a non-neutral subject ("… the owner's check of its counterexample …"), visible to J51D through `git log` subjects, while J51D was at stage 1 (its C0 priors were committed at 2654b675, before it). So any FALSE verdict J51D commits after 3648d3a5 is independent in its derivation but possibly informed that the verifier refuted some claim; grade it so. Neutral subjects from here on (G51's standing rule). | 3648d3a5; 2654b675 | open |
