#!/usr/bin/env python3
"""FS131-IM2: the ruled amendments to Contact's text at d4f946ae, applied by the IM tools on top of their source.

Each amendment is (inventory item, old text, new text): the old text must occur exactly once in the source, or `apply` raises.
`tools/fs131_im_move_cone.py` applies them to the regenerated `Contact.lean`, and `tools/fs131_im_statements.py` to the source
statements, so both tools keep checking byte for byte against d4f946ae plus exactly these ruled changes.
"""

AMENDMENTS = [
    # Item 269 (ruling on item 268, FS131-QA3's statement defect): exists_merge's off-rim colour clause is unsatisfiable; the vertex
    # clause the sibling moves carry replaces it, in the statement and in the docstring.
    ("269",
     "`c` has `n` sectors at `v`, no point off the disc's rim gains a colour, the new points on the rim carry at most three colours",
     "`c` has `n` sectors at `v`, `v` gains no colour, the new points on the rim carry at most three colours"),
    ("269",
     "(F.Condition5 → F'.Condition5) ∧ F'.HasSectors v c n ∧ (∀ x ∉ sphere v ρ, F'.coloursAt x ⊆ F.coloursAt x) ∧",
     "(F.Condition5 → F'.Condition5) ∧ F'.HasSectors v c n ∧ F'.coloursAt v ⊆ F.coloursAt v ∧"),
]


def apply(text, only_statement_lines=False):
    """Apply every amendment whose old text occurs in `text`; with `only_statement_lines`, skip the docstring ones absent from it."""
    for item, old, new in AMENDMENTS:
        n = text.count(old)
        if n == 1:
            text = text.replace(old, new)
        elif n == 0 and only_statement_lines:
            continue
        else:
            raise ValueError(f"amendment of item {item}: old text occurs {n} times (expected 1): {old[:70]!r}")
    return text
