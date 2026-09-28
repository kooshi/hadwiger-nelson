#!/usr/bin/env python3
"""The Proof Atlas's palette review, at both themes: contrast and separation of the page's colour tokens, read from the template.

Reads `visualizations/proof-atlas/page.tmpl.html`: the light palette on bare `:root`, the dark one on `:root[data-theme="dark"]` (the build
asserts the two dark blocks agree). For each theme it prints WCAG contrast ratios and CIELAB distances for what the page draws, and it
FAILS (exit 1) on the gated floors:

- text tokens (ink, ink-2, muted) and the answer hues used as text (c7, c6, c5: the answer numbers, chips, sector names) at >= 4.5 on the
  ground and the panel;
- the graphic hues (missing, nogo, reading, external, focus) at >= 3.0 on the panel, where the map draws them;
- the pairs that meet on the map (a missing step beside a no-go, the selection ring on a seven-hued mark, ...) at CIELAB distance >= 20.

Reported, never gated: the node-fill ladder (solidity is the grade), the hatch's mean tone, the brick hub, the route-bar segments against
their track. `--self-test` plants a low-contrast text token and a confusable pair and checks that each fires, and that the faithful
template passes.
"""
import itertools, math, pathlib, re, sys

ROOT = pathlib.Path(__file__).resolve().parents[1]
TMPL = ROOT / "visualizations/proof-atlas/page.tmpl.html"

TEXT = ("ink", "ink-2", "muted")
ANSWER_HUES = ("c7", "c6", "c5")
GRAPHIC_HUES = ("missing", "nogo", "reading", "external", "focus")
PAIRS = (("missing", "nogo"), ("missing", "c5"), ("c5", "reading"), ("c7", "focus"), ("c7", "external"), ("c6", "focus"),
         ("external", "focus"), ("nogo", "external"))
# the route bar's segment opacities, as page.tmpl.html's segBar sets them
BAR = (("cert", "ink", .9), ("two minds, one blind", "ink", .66), ("two minds", "ink", .5), ("one mind", "ink", .38),
       ("in print", "external", .85), ("a reading", "reading", .85), ("missing step", "missing", .8), ("open question", "missing", 1.0))
FILL = (("kernel", 1), ("cert", .9), ("2b", .62), ("2", .38), ("1", .18), ("hollow", 0))


def palettes(src):
    def block(head):
        i = src.index(head) + len(head)
        return dict(re.findall(r"--([\w-]+):\s*([^;]+);", src[i:src.index("}", i)]))
    light = block(":root {")
    dark = dict(light)
    dark.update(block(':root[data-theme="dark"] {'))
    return {"light": light, "dark": dark}


def rgb(h):
    h = h.strip().lstrip("#")
    return tuple(int(h[i:i + 2], 16) / 255 for i in (0, 2, 4))


def _lin(c):
    return c / 12.92 if c <= 0.04045 else ((c + 0.055) / 1.055) ** 2.4


def luminance(c):
    r, g, b = map(_lin, c)
    return 0.2126 * r + 0.7152 * g + 0.0722 * b


def contrast(a, b):
    la, lb = luminance(a), luminance(b)
    return (max(la, lb) + .05) / (min(la, lb) + .05)


def mix(a, b, t):
    return tuple(t * x + (1 - t) * y for x, y in zip(a, b))


def lab(c):
    r, g, b = map(_lin, c)
    X = (0.4124 * r + 0.3576 * g + 0.1805 * b) / 0.95047
    Y = 0.2126 * r + 0.7152 * g + 0.0722 * b
    Z = (0.0193 * r + 0.1192 * g + 0.9505 * b) / 1.08883
    f = lambda t: t ** (1 / 3) if t > 0.008856 else 7.787 * t + 16 / 116
    return (116 * f(Y) - 16, 500 * (f(X) - f(Y)), 200 * (f(Y) - f(Z)))


def hexs(c):
    return "#%02x%02x%02x" % tuple(round(x * 255) for x in c)


def review(src, out=print):
    """Print the review; return the list of gated failures."""
    fails = []
    for theme, T in palettes(src).items():
        t = {k: rgb(v) for k, v in T.items() if v.strip().startswith("#")}
        out(f"== {theme}: ground {T['ground']}, panel {T['panel']}")
        for k in TEXT + ANSWER_HUES:
            cg, cp = contrast(t[k], t["ground"]), contrast(t[k], t["panel"])
            out(f"   text  {k:9} on ground {cg:5.2f}  on panel {cp:5.2f}")
            if min(cg, cp) < 4.5:
                fails.append(f"{theme}: {k} as text at {min(cg, cp):.2f} < 4.5")
        for k in GRAPHIC_HUES:
            cp = contrast(t[k], t["panel"])
            out(f"   mark  {k:9} on panel {cp:5.2f}")
            if cp < 3.0:
                fails.append(f"{theme}: {k} as a mark at {cp:.2f} < 3.0")
        for a, b in PAIRS:
            d = math.dist(lab(t[a]), lab(t[b]))
            out(f"   apart {a}/{b}: CIELAB distance {d:.0f}")
            if d < 20:
                fails.append(f"{theme}: {a} and {b} too alike (distance {d:.0f} < 20)")
        ladder = [(n, mix(t["ink"], t["panel"], a)) for n, a in FILL]
        out("   node fills, lightness L*: " + ", ".join(f"{n} {lab(c)[0]:.0f}" for n, c in ladder))
        out(f"   hatch mean {hexs(mix(t['external'], t['panel'], .44))}; halo against ink {contrast(t['ink'], t['halo']):.2f}")
        bricks = [mix(t[f"brick-{i}"], t["panel"], float(T["brick-alpha"])) for i in range(1, 8)]
        spread = [math.dist(lab(a), lab(b)) for a, b in itertools.combinations(bricks, 2)]
        out(f"   brick hub: seven tints {', '.join(hexs(b) for b in bricks)}; distances {min(spread):.0f} to {max(spread):.0f}")
        for name, k, op in BAR:
            seg = mix(t[k], t["rule-2"], op)
            out(f"   route bar, {name:21} against its track {contrast(seg, t['rule-2']):.2f}")
    return fails


def self_test():
    src = TMPL.read_text(encoding="utf-8")
    quiet = lambda *_: None
    assert review(src, quiet) == [], "the faithful template must pass"
    light_head = src.index(":root {")
    # plant 1: light muted text too pale for text
    bad1 = src[:light_head] + src[light_head:].replace("--muted: #5d6c6e;", "--muted: #9aa6a7;", 1)
    f1 = review(bad1, quiet)
    assert len(f1) == 1 and f1[0].startswith("light: muted as text"), f1
    # plant 2: dark focus moved onto the seven hue
    dark_head = src.index(':root[data-theme="dark"] {')
    bad2 = src[:dark_head] + src[dark_head:].replace("--focus: #4cceea;", "--focus: #7fb2ff;", 1)
    f2 = review(bad2, quiet)
    assert len(f2) == 1 and f2[0].startswith("dark: c7 and focus too alike"), f2
    print("SELF-TEST PASSED: the faithful palette passes; a pale text token and a confusable pair each fire once")


if __name__ == "__main__":
    if "--self-test" in sys.argv:
        self_test()
        sys.exit(0)
    fails = review(TMPL.read_text(encoding="utf-8"))
    for f in fails:
        print("FAIL", f)
    print(f"palette review: {len(fails)} failed")
    sys.exit(1 if fails else 0)
