Hello de Bruijn (`DEBRUIJN.md`). I'm the product owner of the Hadwiger–Nelson workspace `/home/kooshi/source/lean-dir`. I'd like you to
be a **prior-art reader** for one short paper: C. Tardif, *The chromatic number of the product of 5-chromatic graphs can be 4*.
- **The journal version** is Combinatorica 43(6) (2023) 1067–1073, doi 10.1007/s00493-023-00047-2.
- **The held copy** is a 6-page preprint Kooshi found: `~/source/library/pdf/Tardif2023-product-5-chromatic-graphs-can-be-4.pdf`.
  Record that it is a preprint, and anything that suggests how it differs from the journal version.

## Why it matters

This project cites `[Tardif2023]` second-hand, and has never read it. The citations are in `CLAUDE.md` G55 and G43, and in
`plans/STUB-three-colour-classification.md` (FS-46), `plans/STUB-adelic-window-colouring.md` (FS-64), `plans/FS86-C-Coxeter.md`, and the
FS-54 records (grep for `Tardif2023`). It is cited for one fact: Hedetniemi's conjecture fails at four colours, so a product argument
cannot run there. Two live questions lean on products of residue targets, and they are where this paper might bear more than that one
fact:
- **The local–global conjecture** (G48, G55, G59). Could a product of residue planes, each needing five colours, be four-colourable? That
  is G43's "a composite ideal beats its best prime only through an integrality gap `χ_f ≤ k < χ`". Could Tardif's construction occur
  among the finite unit-distance planes, or is it far from them?
- **FS-67** (`plans/STUB-tight-product-colourings.md`): when must a colouring of a product of local targets be local at one factor?

## The questions

1. **Read the paper in full.** Record each section, its main statements **quoted verbatim** with page numbers, and the construction's
   shape: which graphs, which exponential graphs or which fractional or odd-girth hypotheses it uses.
2. **Check every citation of `[Tardif2023]` in this repository** against the paper, and say whether each holds at its stated scope. Our
   bibliography row says "for any `m₁, m₂ ≥ 5` there are graphs `G, H` with `χ(G) = m₁`, `χ(H) = m₂` and `χ(G × H) < min(m₁, m₂)`";
   the abstract you hold says something different ("for any `n ≥ 4` and `m > n` … `χ(G) ≥ m`, `χ(H) > n`, `χ(G × H) ≤ n`"). Which is
   right?
3. **Does its construction bear on our products?** Our factors are the residue planes `Γ_q` (Cayley graphs of `𝔽_{q²}` on the norm-one
   circle), which are vertex-transitive with known fractional chromatic numbers (G59: `χ_f = q²/α`). Does anything in the paper say
   when a product of vertex-transitive graphs with `χ_f > n` can be `n`-colourable? Relate it to `[Zhu2011]` and `[Zhang2012]`, which
   this project uses (`BIBLIOGRAPHY.md`).
4. **Mine the reference list** into your record, marking what is held or cited here.

## What you produce

- **Your record:** `plans/PA-tardif2023.md`, with the reading log, the answers, a table of our citations checked, and a proposed
  bibliography row.
- **Do not edit `BIBLIOGRAPHY.md`, `CLAUDE.md`, `LEDGER.md` or any stub.** A close planner owns them now, and two agents editing one file
  make a commit sweep in the other's hunks. I'll hand your findings to it.

## Standing rules, each with its reason

- **No subagents.** You may not spawn subagents, forks or workflows; delegation here is one level deep (`CLAUDE.md` § "Delegation — one
  level deep").
  - The reason: staffing is Kooshi's budget decision, and I can only review work I know about.
- **Work in stages:** keep each response short, and save your record after each section.
- **State every finding at its exact scope.** Do not lean either way: Kooshi says *"All novel knowledge is a success."*
- **No search for a finite witness** before 2026-10-01; none is needed here.
- **Commit your record by explicit path:** `git commit <path> -m …` (other agents share the working tree, so never a bare `git commit`).
  - Never amend. Don't push.
  - End the message with your harness's attribution lines.
  - Report the hash.
- **Your scratch directory:** `/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/pa-tardif/`.
- **Budget:** about 100k tokens.
- **Reports** go to me by SendMessage (`to: "main"`). Keep your final turn text content-free: "reader idle; report sent to the owner by
  SendMessage".

Thank you.
