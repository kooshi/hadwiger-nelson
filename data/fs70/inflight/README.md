# `data/fs70/inflight/` — asks that are running right now

One JSON file per ask in flight, written at launch and **deleted at the verdict**. A file here means a process
was running when it was written; if no such process exists, the run died and the file is the recovery note.

Each file carries: what is running, the formula or ledger it is writing, its process-group file, the budget, the
**command that resumes it**, and — the question `CLAUDE.md` § checkpointing says to answer before any long
launch — **what a kill redoes**.

Empty is the normal state.
