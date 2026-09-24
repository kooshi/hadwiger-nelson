Hello. You are this project's Lean engineer and mathematician (`/home/kooshi/source/lean-dir/DEBRUIJN.md`); for this task, call yourself **"the auditor"**. I'm the product owner. Kooshi, the human whose project this is, has asked me to coordinate and review rather than do the mathematics, so the verdicts are yours. I'll score them by artifact.

## Why this audit

FS-85 today derived that **every proper four-colouring of de Grey's lattice is periodic**: `F ⊇ 1680Λ`, `P = F`. There are three derivations: two independent and verified blind (`plans/FS85-V-verification.md`), and a third by a different mechanism, giving `120Λ` (`plans/FS85-C-Coxeter.md`). **All three rest on one published input, input (S): Parts's stripes.** (S) says every four-colouring has no monochromatic √3-triple in the five inner orientations, and so is striped. It comes from `[Parts2020hv]`: a 481-vertex graph G481, plus case-analysis trees his program found and a human can check.

The blind verifier checked two things:
- G481's transcription, by eye against the degree column;
- its membership in `Λ`, and one tree ("S", 11 nodes).

**It could not walk the other eight trees, L1–L8** (776 non-root nodes). They appear in the paper only as raster images in Table 4. It also left unchecked **the completeness of his root case split (Table 1)**, which is a hand claim. Until both are checked, the headline's grade is "proved given (S)", with (S) checked only in part.

The same day also left prior-art debts on two claims. Those claims can't be called new until the debts are read.

## The tasks

**A1: walk Parts's trees L1–L8 as a fixed certificate.**
- Read Table 4's images directly. The PDF is `~/source/library/pdf/arXiv-2010.12661-parts-human-verifiable.pdf`. Your Read tool renders PDF pages and images; render the pages, or crop them with `pdftoppm` into your scratch.
- Transcribe every node: its coordinates, its colour, and the neighbour behind each blocked colour.
- Then walk each tree with a checker. The verifier's `data/fs85/verifier/treeS.py` walks tree S and is your template.
- **This is checking a published certificate, not a search:** walk the given trees, and never search for alternatives.
- Plant one transcription fault per tree and confirm the walker refuses it.
- If an image cell is unreadable, record exactly which, and don't guess.

**A2: Table 1's root case split.** Check by hand that Parts's root case split is exhaustive, and that each branch is the root of one of S, L1–L8. State the claim exactly and prove it or name the gap.

**A3: the prior-art debts.** Record each negative as a finding about where the unworked ground is (WORKFLOW 3.2).
1. **The Polymath16 wiki's "Algebraic formulation" page** (not held). Fetch it from the Polymath wiki, save a copy to `~/source/library/notes/`, read it in full, and say whether it proves, or claims, that every four-colouring of `R₂` (the Moser ring) or of de Grey's lattice is periodic.
   - Also check the held threads, `~/source/library/notes/polymath16-threads-1-18-text.txt`. Look at Mixon's June 2018 question ("Is Tamas's result that every 4-coloring of ℤ[ω₁,ω₃] is 8-periodic human-provable?"), Gibbs's 3 June 2018 route ("no monochromatic triangle" to periodicity 16 on `R₂`), and anything later that answers either.
2. **zbMATH** (API as in WORKFLOW 3.2 item 8), in the discipline's words: periodic colourings of lattice graphs; "every 4-coloring … periodic"; frozen colourings of `ℤ^d` Cayley graphs; Hubai; Parts; Mixon. Record the queries and the hits.
3. **The by-product claim:** triangle-free, uniquely `k`-colourable circulants for every `k ≥ 3`. Both FS-85 competitors found it: FS85-dB3 in `plans/FS85-C-deBruijn.md`, and C2 in `plans/FS85-C-Coxeter.md`.
   - Read `[Basic2026]` §4 (held at `~/source/library/pdf/arXiv-2609.03184-basic-uniquely-colorable-cayley.pdf`) and `[KlotzSander2017]` (now held at `~/source/library/pdf/KlotzSander2017-uniquely-colorable-cayley.pdf`).
   - Walk the citing works of both in OpenAlex and Semantic Scholar, comparing identifiers, not counts (G49).
   - Also look at Nešetřil 1973's line of uniquely colourable graphs without short cycles, and whether any of it is circulant.
   - Say whether "every `k`" is in print.
4. **The abstract "yes"** (FS85-dB2 / Coxeter's C1: a triangle-free distance graph on ℤ with χ = 4 and `F₄ = 4ℤ`, built from a Mycielskian embedded by a B₃ set). Is a triangle-free distance graph or circulant with a forced pair, or with a unique colouring up to period, in print? Search in the discipline's words: distance graphs, circulants, unique colourability, frozen colourings.

## The ban (the finite-witness-free week, `CLAUDE.md` § Toolchain)

- No SAT, colouring search, finder or sweep.
- Walking a published tree is checking a fixed certificate, which is in.
- Keep a "would have searched here" log anyway.

## Mechanics

- **Your record:** `plans/FS85-input-audit.md`, with a "Theorems this phase proved" heading if anything is proved, and your search log. Commit it by explicit path after each task.
- **Tools:** under `data/fs85/audit/`. Transcriptions of the trees go there too, as text files; they're facts from the paper, not its prose.
- **Don't commit** page renders, PDFs or extracted paper text; keep those in scratch.
- **Scratch:** `/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs85-audit/`. Don't list or read the other directories beside it.
- **Library:** add anything you fetch to `BIBLIOGRAPHY.md` the same day, with its read status, and run `tools/bib_audit.py`.
- **Commits:** by explicit path. Run `git diff --cached` and confirm every hunk is yours; another agent is committing concurrently. Never amend. End each message with the attribution lines your harness supplies. Don't push; I push. Report each hash.
- **No subagents.** You may not spawn subagents, forks or workflows; delegation here is one level deep.
  - The reason: staffing is Kooshi's budget decision, and I can only review work I know about.
  - If the work outgrows your context, stop at a committed boundary and tell me what is left.
- **Contacting anyone outside** (authors, the wiki's editors) is Kooshi's call, never an agent's. If Parts's data files would settle A1, say so and I'll ask Kooshi.
- **Budget:** about 300k tokens. Past about 500k I replace rather than reuse.
- **Messages:** reach me by SendMessage with `to: "main"`. Keep your turn's final text content-free ("auditor idle; report sent to the owner by SendMessage").
- **Report points:** after A1, A2, A3, and at the end. Each report carries commit hashes and your token count.

Thank you. This is the check the week's main result stands on.
