FS131-LGT1's first full pass, on de877ff21c16c860933120b3ead834b355e3432a (2026-10-15 00:51-01:15 UTC): every step green
but `axioms-selftest` (exit 1: the two controls that read the library's state, `baseline` and `imported_declared`, still
expected 26 imported records and 2 declared imports). The controls were moved by scripts/axioms-controls.txt's own rule
(commit eee71c74c) and the whole pass was run again: data/fs131/lgt1/gate/. This pass's 27 MB self-test receipt
(build/gate/axioms-self-test/20261015T010106Z-1245832.log) is not committed: axioms-selftest-final.log holds its verdict
lines. One tracked file was modified at this pass's end: scripts/axioms-controls.txt, edited after the self-test had run.
