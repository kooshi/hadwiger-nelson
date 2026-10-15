# data/

The jobs' inputs and outputs, one directory per milestone (`fs124/`, `fs131/`, …; older work under `m*`, `crunch-*` and
named directories). Inside a milestone's directory:

- `claims.md` (and `claims-*.md`): the statements a job was given, fixed before it started;
- `briefs/`: each job's brief; `reports/`: each job's hand-back;
- one directory per job (`k1/`, `i2/`, `l1/`, …, named by the job's id) with its scripts, inputs, outputs and logs.

Nothing here is trusted by the kernel. Certificate data that a Lean module checks is emitted into `Proofs/` and checked there;
the generator's inputs stay here. The logs of the last full gate are in `fs131/lgt1/gate/`.

Other authors' documents that jobs once kept here (papers' PDFs and their transcriptions, saved web pages, de Grey's arXiv
source) and the material of the journal *Geombinatorics* are not in this repository or its history. They are in the
project's document library, outside the repository, under a manifest; the records that cite them keep their old paths.

**Checksums made stale by the publication.** Before the repository was published, a scripted privacy pass rewrote some files, by lists kept privately. Files whose sha256 is recorded elsewhere changed that way:

- the two `data/fs131/ip23/generator-change*.diff` files;
- two `witness.json` certificates under `data/fs73/` and `data/fs81/`;
- `data/m62/m63-D1b-A412-rung1.json`;
- `tools/fs66_tower.py`.

Their recorded sums predate the rewrite. Two frozen tools, `tools/fs61_census.py` and `tools/fs66_tower.py`, differ from their frozen text in one label only.
