Hello de Bruijn (`DEBRUIJN.md`). I'm the product owner of the Hadwiger–Nelson workspace `/home/kooshi/source/lean-dir`. I'd like you to
be a **prior-art reader** for two short papers on colourings of graph products. Kooshi, the human whose project this is, obtained both,
and both are cited in this project's records and have never been read here.

1. **D. Greenwell, L. Lovász, *Applications of product colouring*, Acta Math. Acad. Sci. Hungar. 25 (1974) 335–340.** Held at
   `~/source/library/pdf/GreenwellLovasz1974-applications-of-product-colouring.pdf`: 6 pages, a **scan with no text layer**, so read the
   page images with the Read tool, a few pages at a time.
2. **B. Larose, C. Tardif, *Projectivity and independent sets in powers of graphs*, J. Graph Theory 40 (2002) 162–171.** Held at
   `~/source/library/pdf/LaroseTardif2002-projectivity-independent-sets-powers-of-graphs.pdf`: 10 pages, with a text layer.

## Why they matter

Greenwell–Lovász is quoted second-hand across the records, always through `[Tardif2008]` §4.2 or `[KlotzSander2017]`: "if `G` is
connected and `χ(G) > n`, then `G × Kₙ` is uniquely `n`-colourable". It carries:
- G70's `K₄ × K₄` step (a four-colouring of the doubling quotient of K-fabric is one of Theorem B's two residue colourings);
- row 86 (`K_k × Y` uniquely colourable, `[KlotzSander2017]` Thm 4.2 "after Greenwell–Lovász");
- FS-67's product question;
- the restatement of FS-67 that a reader of `[Tardif2023]` has just derived (`plans/PA-tardif2023.md` §5.4).

Larose–Tardif is cited by M50 (`plans/M50-batch-descent.md`, `plans/M50-derivation.md`) for "strongly projective graphs", and in a
FS-86 advisor record (`plans/POROS-2026-09-25-fs86-plan.md`).

Find every citation with `grep -rn "Greenwell\|GreenwellLovasz1974\|Larose\|LaroseTardif2002" CLAUDE.md LEDGER.md BIBLIOGRAPHY.md plans/`.

## The questions

1. **Read both papers in full.** Record each paper's main results, **quoted verbatim** with page numbers, and a reading log per section.
2. **Check every citation of each paper** in this repository against the paper, and say whether each holds at its stated scope. List the
   sites in a table: file and line · what it attributes · verdict.
   - Above all, check the "uniquely `n`-colourable" statement: its exact hypotheses (connected? `χ(G) > n`, or something weaker?) and its
     exact conclusion.
   - Check whether G70's and row 86's uses are instances of it.
3. **Does either paper bear on FS-67's restatement** in `plans/PA-tardif2023.md` §5.4? That restatement says: with `G`'s `k`-colourings
   all gap-free, every `k`-colouring of `G × H` (connected `H`, `χ(H) > k`) comes from `G` if and only if the improper maps of the
   exponential graph `K_k^G` are `k`-colourable. Is it in either paper, in part or in full? Does Larose–Tardif's projectivity give its
   answer for some class of `G` — for instance vertex-transitive `G`, or the Hoffman-tight residue targets of G54?
4. **Mine both reference lists** into your record, marking what is held or cited here.

## What you produce

- **Your record:** `plans/PA-products-GL1974-LT2002.md`, with the reading logs, the answers, the citation table, and a proposed
  bibliography row for each paper.
- **Do not edit `BIBLIOGRAPHY.md`, `CLAUDE.md`, `LEDGER.md`, any stub, or `plans/FS89-close-inventory.md`.** A close planner owns them
  now, and two agents editing one file make a commit sweep in the other's hunks. I'll hand your findings to it.

## Standing rules, each with its reason

- **No subagents.** You may not spawn subagents, forks or workflows; delegation here is one level deep (`CLAUDE.md` § "Delegation — one
  level deep").
  - The reason: staffing is Kooshi's budget decision, and I can only review work I know about.
- **Work in stages:** keep each response short, and save your record after each paper.
- **State every finding at its exact scope.** "Quoted through Tardif" is not "read". Do not lean either way: Kooshi says *"All novel
  knowledge is a success."*
- **No search for a finite witness** before 2026-10-01; none is needed here.
- **Commits:** `git add <your record>`, then `git commit <path> -m …`. Other agents share the working tree, so never a bare
  `git commit`.
  - Never amend. Don't push.
  - End the message with your harness's attribution lines.
  - Report the hash.
- **Your scratch directory:** `/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/pa-products/`.
- **Budget:** about 150k tokens.
- **Reports** go to me by SendMessage (`to: "main"`). Keep your final turn text content-free: "reader idle; report sent to the owner by
  SendMessage".

Thank you.
