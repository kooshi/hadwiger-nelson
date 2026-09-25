import sys
sys.path.insert(0, sys.argv[1])
from rep import apply
P = "BIBLIOGRAPHY.md"
s = open(P, encoding="utf-8").read().split("\n")
def line_starting(prefix):
    hits = [i for i, l in enumerate(s) if l.startswith(prefix)]
    assert len(hits) == 1, (prefix, hits)
    return hits[0]

GL = ("| **[GreenwellLovasz1974]** | D. Greenwell, L. Lovász, *Applications of product colouring*, Acta Math. Acad. Sci. Hungar. 25(3–4) "
"(1974) 335–340, doi 10.1007/BF01886093, zbMATH 0294.05108 (received 14 May 1973) — uniquely colourable products | "
"**Thm 1 (p. 335):** *\"Suppose G is a connected graph such that any two n-colourings of G differ in at least two points. Then each "
"n-colouring of K_n × G is induced by an n-colouring of one of the factors\"* — the hypothesis on `G` is exactly gap-freedom (G68; "
"`plans/PA-products-GL1974-LT2002.md` PA-P1), placed on the factor that is not `K_n`. **Cor. 1 (p. 336):** *\"If χ(G) > n and G is "
"connected then K_n × G is uniquely n-colourable\"* — the statement `[Tardif2008]` §4.2 and Godsil–Roberson–Rooney–Šámal–Varvitsiotis "
"(arXiv:1801.08243 §1.3) quote, no finiteness assumed; the base of `[KlotzSander2017]` Thm 4.2 and of row 86's circulants, which need "
"`Y` connected. **Cor. 3 (p. 336; `n ≥ 3` in the sentence before):** *\"(K_n)^k has exactly k n-colourings\"*, counted up to "
"relabelling — G70's `K₄ × K₄` (two, 48 labelled; not Cor. 1, since `χ(K₄) = 4`) and M50's `K₅` projectivity (`n = 5`: "
"`plans/M50-batch-descent.md` §Sⁱᵛ-adv, `plans/M50-derivation.md`, `plans/STANDING-QUESTIONS.md` T6 — the derivation § D task 2 "
"asked for). **Thm 2:** `α(K_n^k) = n^{k−1}`, the maximum sets fixing one component. Thm 3: line- and point-critical extensions. "
"**Thm 4:** every `n`-colouring of an infinite power of `K_n` (`n ≥ 3`) is induced by factor colourings and a 0–1 measure (Pósa's "
"observation; Lempert independently). Question (b), p. 335, is Hedetniemi's conjecture, \"as far as we know, unanswered\" in 1974. "
"**FS-67 holds for `G = K_k^s`** (Thm 1 iterated, PA-P3; among the tight residue targets `Γ₃ ≅ K₃ × K₃` and `U₂ = K₄` with their "
"powers, PA-P4), and Case 2 of Thm 1's proof is the `k`-colouring of `E_k(K_k)` FS-67's restatement asks for (PA-P2). It does not "
"carry FS-58 D3.4: that `S₁` (81 vertices, degree 8) is no direct power of `K₃`; the general-factor form is Duffus–Sands–Woodrow's "
"conjectural B(n). Every repository citation checked (record §3); references mined (record §5) | "
"`pdf/GreenwellLovasz1974-applications-of-product-colouring.pdf` (Kooshi's save, 2026-09-25; a 6-page scan with no text layer, "
"pp. 335–340) | **read in full** (2026-09-25, the products reader, from 300 dpi page images; `plans/PA-products-GL1974-LT2002.md` §1) |")

LT = ("| **[LaroseTardif2002]** | B. Larose, C. Tardif, *Projectivity and independent sets in powers of graphs*, J. Graph Theory 40(3) "
"(2002) 162–171, doi 10.1002/jgt.10041; zbMATH 1003.05077 (confirmed 2026-09-22, FS-71 batch 2b); received 5 Feb 2000, revised "
"15 Jan 2002 | A paper about **powers**: projectivity (the only idempotent homomorphisms `G^n → G` are the projections) against "
"canonical maximum independent sets of `G^n`. States `K_m` (`m ≥ 3`) projective (p. 163) without proof — the proof in print is "
"`[GreenwellLovasz1974]` Cor. 3. Lemma 1.1: Albertson–Collins's no-homomorphism lemma with its equality case (the printed form of "
"`[HahnTardif1997]`'s recalled ratio statement). Cor. 1.1: `α(G^n) = α(G)·|V(G)|^{n−1}` for vertex-transitive `G`. Circular "
"graphs projective, with only canonical maximum independent sets in every power (Thms 3.1, 3.2); Kneser graphs likewise (Fact 4.1, "
"Cor. 4.1); truncated simplices projective, yet `T_s²` has non-canonical ones (Thm 5.1), so projective does not give canonical. "
"Problem 6.1 (answered by Ku–McMillan, J. Graph Theory 60 (2009) 295–301, and by `[Zhang2012]`, per Zhang's introduction). Thm 6.2: "
"a circular analogue of Duffus–Sands–Woodrow. **No statement about colourings of `G × H` with distinct factors, so it does not bear "
"on FS-67 directly** (a power's cofactor has `χ ≤ χ(G)`); its descendant `[Zhang2012]` does. **Not the source of \"strongly "
"projective\"**, a phrase it never uses: M50's §Sⁱᵛ-adv citation of it, and `plans/STANDING-QUESTIONS.md` T6's under the wrong "
"authors, mean `[Larose2002]`; M50's consequence (every `S₅`-invariant relation pp-definable from ≠) is the general Galois "
"correspondence given GL Cor. 3, in neither paper, and \"trivial polymorphism clone\" is inexact — `Pol(K₅)` is the permuted "
"projections, only its idempotent part trivial (record §0 item 6). References mined (record §5) | "
"`pdf/LaroseTardif2002-projectivity-independent-sets-powers-of-graphs.pdf` (Kooshi's save, 2026-09-25; 10 pp., text layer) | "
"**read in full** (2026-09-25, the products reader; every displayed formula checked against the page image; "
"`plans/PA-products-GL1974-LT2002.md` §2) |")

L2 = ("| **[Larose2002]** | B. Larose, *Strongly projective graphs*, Can. J. Math. 54(4) (2002) 757–768, zbMATH 1020.05029 | The "
"\"strongly projective\" source that M50 (`plans/M50-batch-descent.md` §Sⁱᵛ-adv, `plans/M50-derivation.md`) and "
"`plans/STANDING-QUESTIONS.md` T6 meant and cited as `[LaroseTardif2002]`. By its reviewer's review (M. Frick): if a connected `G` "
"has no homomorphism to `K`, an odd cycle or a complete graph of order at least 3, then for every `s ≥ 1` the graph `G × K^s` has "
"exactly `s` homomorphisms to `K` up to automorphisms of `K`, via exponential graphs `E_s(K) = K^{K^s}` — FS-67 for `G = K_k^s` "
"(`plans/PA-products-GL1974-LT2002.md` PA-P3, which derives it from `[GreenwellLovasz1974]` Thm 1). The review's definition of `K^G` "
"has an `f`/`g` slip. Companion, listing only: B. Larose, *Families of strongly projective graphs*, Discuss. Math. Graph Theory "
"22(2) (2002) 271–292, zbMATH 1029.05133. § R.4 item 14 | not held | **review only** (the zbMATH reviewer's review, read "
"2026-09-25 by the products reader; the paper unread) |")

i = line_starting("| **[GreenwellLovasz1974]** |"); s[i] = GL
i = line_starting("| **[LaroseTardif2002]** |"); s[i] = LT; s.insert(i + 1, L2)
i = line_starting("| `pdf/GreenwellLovasz1974-applications-of-product-colouring.pdf` |")
s[i] = "| `pdf/GreenwellLovasz1974-applications-of-product-colouring.pdf` | `[GreenwellLovasz1974]` | read in full (2026-09-25, the products reader; scan, no text layer) |"
i = line_starting("| `pdf/LaroseTardif2002-projectivity-independent-sets-powers-of-graphs.pdf` |")
s[i] = "| `pdf/LaroseTardif2002-projectivity-independent-sets-powers-of-graphs.pdf` | `[LaroseTardif2002]` | read in full (2026-09-25, the products reader) |"
open(P, "w", encoding="utf-8").write("\n".join(s))

apply(P, [
 ("FS-58's product-colouring debt: FS-61's gate found the measured statement is not Greenwell–Lovász's theorem and is false in general "
  "(a 5-cycle times `K₄`), true under a tightness hypothesis our object has; the general-factor form is Duffus–Sands–Woodrow's "
  "conjectural B(n). No § A rows yet",
  "FS-58's product-colouring debt: FS-61's gate found the measured statement is not Greenwell–Lovász's theorem and is false in general "
  "(a 5-cycle times `K₄`); the repair, gap-freedom, is a hypothesis our tight object has, but the repaired statement is FS-67's open "
  "question, proved in print only for a tight factor `K_k^s` (`[GreenwellLovasz1974]` Thm 1; `[Larose2002]`), which FS-58's `S₁` is "
  "not (`plans/PA-products-GL1974-LT2002.md` §3–§4); the general-factor form is Duffus–Sands–Woodrow's conjectural B(n). No § A rows yet"),
 ("| 10 | **[DeNeve2025]** — J. De Neve,",
  "| 14 | **[Larose2002]** — B. Larose, *Strongly projective graphs*, Can. J. Math. 54(4) (2002) 757–768 | zbMATH 1020.05029 (the "
  "reviewer's review read, 2026-09-25) | The paper M50 and `plans/STANDING-QUESTIONS.md` T6 meant by \"strongly projective\"; by its "
  "review, FS-67 for `G = K_k^s` in exponential-graph form, which `[GreenwellLovasz1974]` Thm 1 already gives (PA-P3). Nothing rests on "
  "it alone | not held; review only |\n| 10 | **[DeNeve2025]** — J. De Neve,"),
 ("Later the same day `[GreenwellLovasz1974]` (item 9, whose two companions stay) and `[LaroseTardif2002]` (item 11) arrived; a reader "
  "is on both (`plans/PA-products-GL1974-LT2002.md`).",
  "Later the same day `[GreenwellLovasz1974]` (item 9, whose two companions stay) and `[LaroseTardif2002]` (item 11) arrived, and "
  "both were read in full (`plans/PA-products-GL1974-LT2002.md`); item 14, `[Larose2002]`, is the paper the records' \"strongly "
  "projective\" meant."),
 ("**second-hand: §4.1–4.3 read by FS-61's sweep agent; the originals (Greenwell–Lovász, DSW, El-Zahar–Sauer, HHMN 1988) not reached "
  "by anyone**",
  "**second-hand: §4.1–4.3 read by FS-61's sweep agent**; of the originals, Greenwell–Lovász is read in full (2026-09-25), and its "
  "§4.2 quotation is verbatim its Cor. 1 (p. 336); DSW, El-Zahar–Sauer and HHMN 1988 not reached by anyone"),
 ("*Recalled, not read*: the core of a vertex-transitive graph is vertex-transitive and its order divides the graph's; "
  "`α(H)/\\|H\\| ≥ α(G)/\\|G\\|` whenever `H → G` with `G` vertex-transitive.",
  "*Recalled, not read*: the core of a vertex-transitive graph is vertex-transitive and its order divides the graph's; "
  "`α(H)/\\|H\\| ≥ α(G)/\\|G\\|` whenever `H → G` with `G` vertex-transitive. The second is printed, with its equality case, as "
  "`[LaroseTardif2002]` Lemma 1.1, credited to Albertson–Collins (checked 2026-09-25, `plans/PA-products-GL1974-LT2002.md` §0 item 7); "
  "the first remains unchecked."),
 ("2. Re-find where `[GreenwellLovasz1974]` / arXiv:2604.01408 were used and record the plan section.",
  "2. Re-find where arXiv:2604.01408 was used and record the plan section. (`[GreenwellLovasz1974]`'s use is found: M50's "
  "projective-graph derivation, `plans/M50-batch-descent.md` §Sⁱᵛ-adv and `plans/M50-derivation.md`, and `plans/STANDING-QUESTIONS.md` "
  "T6, resting on its Cor. 3 at `n = 5` — `plans/PA-products-GL1974-LT2002.md` §3.)"),
])
