# data/fs54/symmetric — resume notes

`prime-order-alpha.jsonl` is the checkpoint: one line per finished subgroup class. A killed run loses at most the class
in progress. Resume (skips finished classes):

    cd ~/source/lean-dir && .venv/bin/python tools/fs54_symmetric_alpha.py --seconds 180 --workers 24

Regenerate the classes first if `prime-order-classes.json` is missing:
`python3 tools/fs54_aut_gap.py && gap -q -b data/fs54/symmetric/aut.g < /dev/null`.
