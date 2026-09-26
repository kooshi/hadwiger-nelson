*Brief for crunch job **J40**: FS-67's close-time prior-art gate (WORKFLOW 3.2's eight questions run on the theorems FS-67 filed). Opus
5.5, 2026-09-25. Written by the product owner.*

Hello. You are de Bruijn (`DEBRUIJN.md`), working as **FS-67's prior-art reader** in the Lean 4 Hadwiger–Nelson workspace
`/home/kooshi/source/lean-dir`. Read `CLAUDE.md` (G49, G50), `WORKFLOW.md` (step 3.2, all eight items) and `DEBRUIJN.md` from disk.
**`data/crunch-2026-09-25/briefs/STANDING-RULES.md` is part of this brief; read it in full.** I'm the product owner.

**If your record already exists, you are resuming:** check the last SAVED stage against `git log -- plans/FS67-PA-close.md` and continue at
the first stage not SAVED.

## The question

FS-67 asks: when `G` is `k`-gap-free or Hoffman-tight and `χ(H) > k`, must every `k`-colouring of the categorical product `G × H` be pulled
back from `G`? (Stub `plans/STUB-tight-product-colourings.md`; plan `plans/FS67-tight-products.md`, with §PA — J27's opening gate — read
first.) The derivation job J27D proved the results below, by hand; their record is `plans/FS67-J27D-derivation.md`. **Read each statement
there, verbatim and at exact scope, before searching**. Its "Theorems this phase proved" heading lists them. They are:

1. **DA-3 and DA-4** (Stage 2): the gap-free form fails at every `k ≥ 4`, by a transfer from a Hedetniemi counterexample (`[Tardif2023]`
   Thm 1). Is the transfer (Hedetniemi pair to non-pulled-back colouring) in print? It is Duffus–Sands–Woodrow's `B(k)` direction, per J27.
2. **DC-2** (Stage 3): every `k`-colouring of `G × Cay(A, T)` is pulled back from `G` when `G` is `k`-gap-free and `λ* < 1/(k−1)`, with no
   other condition on `G`. J27D flags this as unsearched, in the words "uniquely colorable" × "expander". Known neighbours:
   - Pak–Vilenchik 2013 Thm 3 (a complete first factor);
   - Burr–Erdős–Lovász 1976;
   - `[GodsilEtAl2020]` (GRRSV) Results 1, 4 and 5;
   - `[GodsilRobersonRooney2017]` Thm 4.9;
   - `[Zhang2012]` Thm 1.8;
   - `plans/M3-PA-mixing.md` (the gate on M3's mixing selection).
3. **DC-1, DD-1** (conditional on GRRSV) and **DB-2**: check whether each is already in GRRSV or its citing works.
4. **Lemma W and DB-1's partial** (Stage 4): the two-step winding as a component invariant of the exponential graph `K_3^G`, and `B(3)`
   generalised to gap-free `G`. Disciplines:
   - exponential graphs and Hom complexes;
   - El-Zahar–Sauer 1985 (Hedetniemi at 4 colours);
   - Duffus–Sands–Woodrow 1985;
   - Tardif's surveys;
   - "multiplicative graphs" and "strongly multiplicative graphs" (`[TardifWrochna2019]`);
   - the winding and height invariants of 3-colourings (`[CGHO2025coh]`; Chandgotia).
5. **DC-3** (Stage 3): the residue planes `Γ_p` as the factor `H` — a table, probably not a theorem to gate; say so if so.

The debts J27 and J27D name as not held are Duffus–Sands–Woodrow 1985, El-Zahar–Sauer 1985, Tardif 2006 (algorithmic), Tardif 2022
(fractional counterexamples), Larose–Tardif 2000 and Sauer 1992. Fetch what you can, and list the rest for Kooshi.

## What to do

For each result, work through WORKFLOW 3.2's items:
- name the object in its discipline's words, and search under two disciplines;
- search for the QUESTION as well as the method, and look outside arXiv;
- walk the citation graph of the paper that posed it — for the product question, Hedetniemi 1966, Greenwell–Lovász 1974 and
  Duffus–Sands–Woodrow;
- open every citing work whose title is in the neighbourhood;
- use two databases, and **the zbMATH Open API for discovery**
  (`https://api.zbmath.org/v1/document/_search?search_string=…&results_per_page=100`, URL-encoded; fields `au:`, `ti:`, `ab:`, `py:`, `cc:`,
  `so:`), including each poser's complete author listing.

If the API returns HTTP 502, retry after a pause and record the outage; a query left unanswered is recorded as unanswered, never as a
negative. Read what you find: an abstract is not a reading (G50). For a paper you cannot fetch, record the exact reference and DOI for Kooshi.

**Verdict per result, at exact scope.** Use one of four:
- *in print*: say where, exactly;
- *partly in print*: say which part;
- *not found*: give the queries, the databases and the date;
- *undecided*: name the unread paper that could decide it.

Never write "new"; write "not found by these searches".

## Output

`plans/FS67-PA-close.md` holds:
- one section per result, with each query and its hit count, and each paper opened with what was read per section;
- the verdict;
- papers for Kooshi to fetch;
- proposed `BIBLIOGRAPHY.md` entries (proposals only);
- `CLOSED-QUESTIONS.md` candidates.

Save after each result (`Stage n — SAVED`). Save the papers you download to `~/source/library/pdf/` as `Author<year>-<short-title>.pdf`.

## Rules

- **No subagents.** You may not spawn subagents, forks or workflows — delegation here is one level deep (`CLAUDE.md` § Delegation).
  Reason: staffing is Kooshi's budget decision, and I can only review work I know about. If the work outgrows your context, stop at a
  saved result and tell me what is left.
- **A blind verifier (J27V) is checking J27D's claims right now.** Never contact it, and never write anything outside your two paths. Touch
  only `plans/FS67-PA-close.md` and `data/fs67/j40/`.
- **All novel knowledge is a success** (Kooshi): a clean attribution to print is as valuable as a "not found". Lean toward neither.
- **No finite-witness search** (the ban runs to 2026-10-01). Keep the "would have searched here" log; it will probably be empty, and if so,
  say so.
- **Commits by explicit path**, subjects "J40: result n". End commit messages with your harness's attribution lines. Push after each
  commit; never force-push.
- **Budget:** about 250k by the harness's count; hand back by 350k.
- **Report** in the fixed ≤ 12-line form (standing rule 9) to `data/crunch-2026-09-25/reports/J40.md`, committed, and by SendMessage
  `to: "main"`, with one verdict line per result. Keep your turn's final text content-free: "J40 idle; report sent to the owner by
  SendMessage".

Thank you.
