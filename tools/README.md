# tools/

Python generators and instruments: the programs that emit certificate data for Lean, check exact computations outside the
kernel, and measure. **Nothing in `tools/` is trusted.** Every claim the library makes is re-derived in Lean from emitted data,
so a bug here can only produce data the kernel refuses (`../LEAN.md` § The shape of the proof). A result graded `[tools]` or
`[cert]` in `../LEDGER.md` rests on a tool here and is not kernel-checked; `../ROADMAP.md` lists those results.

Most files are named by the job that wrote them (`fs131_lgt1_*.py` is job FS131-LGT1's). Some are frozen, because a recorded
result depends on their exact text: `fs58_*`, `fs61_*`, `fs66_*`, `fs73_*check*.py`, `fs73v2_check.py`.
