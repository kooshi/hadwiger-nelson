# data/fs54/ladder — resume notes (written before launch, 2026-09-16)

Run from a snapshot copy (never edit a running script): `cp data/fs54/ladder/ladder.sh build/fs54-ladder-snapshot.sh`,
then `setsid nohup bash build/fs54-ladder-snapshot.sh > data/fs54/ladder/ladder.out 2>&1 &`.

A finished stage leaves `<stage>.done`; a relaunch skips it. A killed stage's partial record is `<stage>.json`, rewritten
every 30 s; to resume that stage by hand: the same arguments plus `--start data/fs54/ladder/<stage>.json --out
data/fs54/ladder/<stage>.json`. Stop by pid only (the snapshot shell's pid, then the plane-independent child found by
`ps --ppid`), verify by the pid absent and the .json static.
