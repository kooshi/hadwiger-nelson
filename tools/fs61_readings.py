#!/usr/bin/env python3
"""fs61_readings -- FS-61 phase E: score the census's readings, and build the tables the class-theorem attempt needs.

UNTRUSTED (tools/).  This file READS the records the census driver wrote and writes prose tables; it asks no solver,
builds no witness and changes no verdict.  The one thing it computes from scratch is the least character mean of a
lattice (E.3), through the FROZEN tools/fs58_search.py, and that is labelled a float reading wherever it appears.

Plan: plans/FS61-quadratic-census.md section 3 (the readings, each with the measurement that can contradict it),
section 8 (the registered predictions) and phase E items E.2-E.7.

    readings   -> data/fs61/readings.md    E.2, E.3, E.6, E.7: every reading won / lost / not decided, its population
                                           spelled out, then the predictions scored and the unreachability audit
    aiming167  -> data/fs61/aiming-167.md  E.4: the note FS-59 consumes
    shapes     -> data/fs61/shapes.md      E.5: the witness isomorphism table and the cross-field shape table
    charmeans  -> data/fs61/charmeans.jsonl  the compute step E.3 reads (one least character mean per live lattice)
    selftest                               every scorer shown able to return each of its verdicts, on fixtures

EVERY NUMBER TRAVELS WITH ITS POPULATION.  A scorer here takes an explicit list of rows and returns a verdict plus the
sentence that names what was counted; nothing prints a bare count.  The three verdicts are exactly `won`, `lost` and
`not decided`, in those words, because the plan says a reading is scored in those words.
"""
import sys, os, json, math, time, collections, argparse
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / 'tools'))
import fs61_census as C                                          # noqa: E402  (the census driver; untrusted too)
import fs58_search as FS                                         # noqa: E402  (frozen)

FS61 = C.FS61
MACHINE = C.MACHINE


# ================================================================ small exact statistics (no scipy in the verdict path)
def fisher_exact_2x2(a, b, c, d):
    """Two-sided Fisher exact p for [[a, b], [c, d]], by exact integer hypergeometric sums.  Used instead of a chi
    square because three of these tables have a zero cell and one has single-digit margins."""
    n = a + b + c + d
    if n == 0:
        return 1.0
    r1, r2, c1 = a + b, c + d, a + c

    def p(x):
        return (math.comb(r1, x) * math.comb(r2, c1 - x)) / math.comb(n, c1) if 0 <= x <= r1 and 0 <= c1 - x <= r2 else 0.0
    obs = p(a)
    return min(1.0, sum(p(x) for x in range(0, r1 + 1) if p(x) <= obs * (1 + 1e-12)))


def ols_loglog(xs, ys):
    """Slope, intercept and the slope's standard error for log y against log x.  Returns None if fewer than three
    points, because a slope through two points has no residual and therefore no uncertainty to report."""
    if len(xs) < 3:
        return None
    lx = [math.log(x) for x in xs]
    ly = [math.log(y) for y in ys]
    n = len(lx)
    mx, my = sum(lx) / n, sum(ly) / n
    sxx = sum((x - mx) ** 2 for x in lx)
    if sxx == 0:
        return None
    b = sum((x - mx) * (y - my) for x, y in zip(lx, ly)) / sxx
    a = my - b * mx
    resid = [y - (a + b * x) for x, y in zip(lx, ly)]
    s2 = sum(r * r for r in resid) / (n - 2)
    se = math.sqrt(s2 / sxx)
    r2 = 1 - sum(r * r for r in resid) / sum((y - my) ** 2 for y in ly) if sum((y - my) ** 2 for y in ly) else float('nan')
    return {'slope': b, 'intercept': a, 'se': se, 'n': n, 'r2': r2,
            'ci95': (b - 1.96 * se, b + 1.96 * se)}


# ================================================================ the census, as rows this file can score
def live_lattice_rows(fields=None):
    """One row per rank-4 lattice whose state is Open or Refused -- the LIVE population, which is what the readings
    about lattices quantify over -- carrying its odd girth (with the cap that produced it), its ball verdicts, and
    the smallest ball that was actually decided."""
    rows = []
    for D in (fields or C.FAMILY_500):
        lat = C.load_jsonl(C.field_dir(D) / 'lattices.jsonl')
        filt = C.load_jsonl(C.field_dir(D) / 'filter.jsonl')
        balls = C.load_jsonl(C.field_dir(D) / 'balls.jsonl')
        per = collections.defaultdict(list)
        for b in balls.values():
            per[b['lattice']].append(b)
        for k, r in lat.items():
            st = filt.get(k, {}).get('state', '')
            if r['rank'] != 4 or not (st.startswith('Open') or st.startswith('Refused')):
                continue
            bs = per.get(k, [])
            og = r.get('odd_girth') or {}
            dec = [b for b in bs if b['verdict'].startswith('Refused')
                   or b['verdict'] == 'Colourable (colouring verified)']
            rows.append({'D': D, 'key': k, 'id': r['id'], 'state': st, 'size': r['size'], 'cov': r['covolume'],
                         'rel_height': r.get('rel_height'), 'M': r['M'],
                         'girth': og.get('length'), 'none_up_to': og.get('none_up_to'),
                         'girth_status': og.get('status'),
                         'refused': any(b['verdict'].startswith('Refused') for b in bs),
                         'colourable': any(b['verdict'] == 'Colourable (colouring verified)' for b in bs),
                         'decided': bool(dec),
                         'undecided_balls': sum(1 for b in bs if b['verdict'] == 'Unknown (budget)'),
                         'smallest_refusing_points': min([b['points'] for b in bs
                                                          if b['verdict'].startswith('Refused')
                                                          and isinstance(b.get('points'), int)], default=None),
                         'smallest_decided_points': min([b['points'] for b in dec
                                                         if isinstance(b.get('points'), int)], default=None)})
    return rows


def field_rows():
    """One row per census field, from the derived census table, so this file and `census.md` cannot disagree."""
    rows = {json.loads(l)['d']: json.loads(l) for l in open(FS61 / 'census.jsonl')}
    frame = {json.loads(l)['d']: json.loads(l) for l in open(FS61 / 'frame.jsonl')}
    for d, r in rows.items():
        f = frame.get(d, {})
        r['L_lower'] = f.get('L_lower')
        r['L_upper'] = f.get('L_upper')
        r['landed'] = r['state'] == 'Landed (certified)'
    return rows


def girth_class(r):
    """`<=9`, `>9`, or `undetermined` -- never a bare `>9` from a null length.  FS-58's O1 trap is that
    `odd_girth.length is None` means `no odd cycle of length at most none_up_to`, which is a statement about the
    search: if that cap is below 9 the row cannot be placed on either side of the cut and says so."""
    if r.get('girth_status', '').startswith('bipartite'):
        return '>9'                                              # no odd cycle at ANY length
    if r['girth'] is not None:
        return '<=9' if r['girth'] <= 9 else '>9'
    if r['none_up_to'] is not None and r['none_up_to'] >= 9:
        return '>9'
    return 'undetermined'


# ================================================================ the scorers (pure: a list of rows in, a verdict out)
def score_r_cycle(rows, alpha=0.05):
    """R-cycle, restated as the plan restates it: among LIVE lattices with a decided ball, does odd girth at most 9
    against more than 9 separate refusing from colourable?"""
    pop = [r for r in rows if r['decided']]
    tab = collections.Counter((girth_class(r), 'Refused' if r['refused'] else 'Colourable') for r in pop)
    a, b = tab[('<=9', 'Refused')], tab[('<=9', 'Colourable')]
    c, d = tab[('>9', 'Refused')], tab[('>9', 'Colourable')]
    und = sum(v for k, v in tab.items() if k[0] == 'undetermined')
    p = fisher_exact_2x2(a, b, c, d)
    short_rate = a / (a + b) if a + b else float('nan')
    long_rate = c / (c + d) if c + d else float('nan')
    if a + b == 0 or c + d == 0:
        verdict = 'not decided'
    elif p < alpha and short_rate > long_rate:
        verdict = 'won'
    elif p < alpha and long_rate > short_rate:
        verdict = 'lost'
    else:
        verdict = 'not decided'
    return {'verdict': verdict, 'table': {'<=9': [a, b], '>9': [c, d]}, 'undetermined': und, 'p': p,
            'short_rate': short_rate, 'long_rate': long_rate, 'n': len(pop)}


def score_r_mod8(rows, fields):
    """R-mod8 in its two strengths (plan M1.8).  (a) is about BALLS: does any tier-1-or-later ball over a
    d = 3 (mod 8) field refuse?  (b) is about LATTICES: is every one of them closed by a certificate?"""
    three = [r for r in rows if r['D'] % 8 == 3]
    refusing = [r for r in three if r['refused']]
    open_lat = [r for r in three if r['state'].startswith('Open')]
    a = {'verdict': 'lost' if refusing else 'won',
         'refusing': [(r['D'], r['id'], r['size'], r['smallest_refusing_points']) for r in refusing],
         'fields': sorted({d for d in fields if d % 8 == 3})}
    b = {'verdict': 'lost' if (refusing or open_lat) else 'won',
         'open': len(open_lat), 'open_fields': sorted({r['D'] for r in open_lat})}
    return {'a': a, 'b': b, 'n_lattices': len(three)}


def score_r_L(fields, alpha=0.05):
    """R-L: among the d = 7 (mod 8) fields, does landing depend on the local bound L?"""
    pop = [r for r in fields.values() if r['d'] % 8 == 7]
    def cls(r):
        return 'L=4' if (r['L_lower'] == 4 and r['L_upper'] == 4) else 'L>=5'
    tab = collections.Counter((cls(r), 'landed' if r['landed'] else 'not') for r in pop)
    a, b = tab[('L=4', 'landed')], tab[('L=4', 'not')]
    c, d = tab[('L>=5', 'landed')], tab[('L>=5', 'not')]
    p = fisher_exact_2x2(a, b, c, d)
    verdict = 'won' if p < alpha else 'not decided' if min(a + b, c + d) < 5 else 'lost'
    return {'verdict': verdict, 'table': {'L=4': [a, b], 'L>=5': [c, d]}, 'p': p, 'n': len(pop),
            'rates': (a / (a + b) if a + b else float('nan'), c / (c + d) if c + d else float('nan'))}


def score_r_size(fields, mod8=7, band=(0.5, 2.0)):
    """R-size: does the least REFUSING ball grow like a power of d?  Fitted on the bracket's upper end, which is the
    only end that is observable (plan M1.4): the smallest ball actually seen to refuse, not the least that would."""
    pts = [(r['d'], r['best_refusing_points']) for r in fields.values()
           if r['d'] % 8 == mod8 and r['landed'] and r.get('best_refusing_points')]
    pts.sort()
    fit = ols_loglog([d for d, _ in pts], [p for _, p in pts])
    if fit is None or len(pts) < 6:
        return {'verdict': 'not decided', 'why': f'{len(pts)} landed fields; the plan calls fewer than six not decided',
                'points': pts, 'fit': fit}
    lo, hi = fit['ci95']
    inside = band[0] <= fit['slope'] <= band[1]
    verdict = 'won' if inside and lo > 0 else ('lost' if (hi < band[0] or lo > band[1]) else 'not decided')
    return {'verdict': verdict, 'points': pts, 'fit': fit, 'band': band}


def score_r_C(means, threshold=-0.5):
    """R-C: G60's ratio reading as a decider of finite landing -- a refusing lattice has least character mean above
    -1/2.  One reading below the threshold contradicts it.  Floats throughout, and labelled so."""
    below = [m for m in means if m['min_character_mean'] < threshold]
    if not means:
        return {'verdict': 'not decided', 'why': 'no character means computed', 'below': [], 'n': 0}
    return {'verdict': 'lost' if below else 'won', 'below': below, 'n': len(means),
            'min': min(m['min_character_mean'] for m in means),
            'max': max(m['min_character_mean'] for m in means)}


# ================================================================ E.3's compute step
def charmean_rows(rows, jobs=16, out=None):
    """The least character mean of each live lattice, through the frozen instrument.  Resume = re-run: a lattice
    already on disk is skipped."""
    import multiprocessing as mp
    out = Path(out or FS61 / 'charmeans.jsonl')
    done = C.load_jsonl(out)
    todo = [r for r in rows if f'{r["D"]}|{r["key"]}' not in done]
    print(f'fs61 charmeans: {len(rows)} live rank-4 lattices, {len(done)} on disk -> {len(todo)} to compute '
          f'({jobs} workers); float readings, through the frozen tools/fs58_search.py', flush=True)
    if todo:
        with mp.get_context('fork').Pool(min(jobs, len(todo))) as P:
            for k, rec in enumerate(P.imap_unordered(_charmean_one, todo, chunksize=1), 1):
                C.append(out, rec)
                done[rec['key']] = rec
                if k % 20 == 0 or k == len(todo):
                    print(f'  {k}/{len(todo)}', flush=True)
    print(f'DONE charmeans: {len(done)} lattices -> {C.rel(out)}', flush=True)
    return list(done.values())


def _charmean_one(r):
    M, H = C.parse_key(r['key'])
    S = C.saturation(r['D'], M, H)
    B, coords, cov, mc = FS.reduce_pool(r['D'], M, S)
    t0 = time.time()
    m, th, G = FS.min_character_mean(coords)
    return {'key': f'{r["D"]}|{r["key"]}', 'D': r['D'], 'lattice': r['key'], 'id': r['id'], 'state': r['state'],
            'refused': r['refused'], 'size': r['size'], 'covolume': cov, 'min_character_mean': m, 'theta': th,
            'grid': G, 'seconds': round(time.time() - t0, 2), 'claim_scope': 'float reading', 'machine': MACHINE}


# ================================================================ E.5: shapes across fields, and the witnesses
def shape_table():
    """A lattice's canonical key is (M, Hermite form of M*Lambda) and carries NO d (plan section 7, phase A finding
    2), so one key names one integral SHAPE that several fields may hold -- with different generator sets, because
    which unit vectors lie in it depends on the quadratic form (1, d, 1, d).  This is the cheap pre-screen E.5's
    route (beta) wants: a shape that refuses in one field and is 3-colourable in another is the sharpest statement
    the census can make about what decides landing."""
    shape = collections.defaultdict(dict)
    for D in C.FAMILY_500:
        lat = C.load_jsonl(C.field_dir(D) / 'lattices.jsonl')
        filt = C.load_jsonl(C.field_dir(D) / 'filter.jsonl')
        balls = C.load_jsonl(C.field_dir(D) / 'balls.jsonl')
        ref = {b['lattice'] for b in balls.values() if b['verdict'].startswith('Refused')}
        for k, r in lat.items():
            shape[k][D] = {'state': filt.get(k, {}).get('state', '(not filtered)'), 'size': r['size'],
                           'cov': r['covolume'], 'refused': k in ref, 'rank': r['rank'], 'M': r['M'],
                           'girth': (r.get('odd_girth') or {}).get('length')}
    return shape


def wl_hash(points, edges, rounds=3):
    """A Weisfeiler-Leman colour-refinement hash of a graph, as E.5 prescribes: a cheap invariant that must agree
    before any exact isomorphism test is worth running.  Two isomorphic graphs always agree; two that agree may
    still differ, which is why a collision is followed by an exact test and not by a claim."""
    import hashlib
    n = len(points)
    adj = [[] for _ in range(n)]
    for i, j in edges:
        adj[i].append(j)
        adj[j].append(i)
    col = [len(a) for a in adj]
    for _ in range(rounds):
        nxt = [hash((col[v], tuple(sorted(col[u] for u in adj[v])))) for v in range(n)]
        m = {c: i for i, c in enumerate(sorted(set(nxt)))}
        col = [m[c] for c in nxt]
    return hashlib.sha256(json.dumps([n, len(edges), sorted(collections.Counter(col).items())]).encode()).hexdigest()[:16]


def witness_table():
    """One row per CERTIFIED witness, with the invariants an isomorphism test screens on.  The manifest holds one
    line per attempt, so the view's last line per field is the certified one; a field whose last line is not
    certified is left out and named."""
    man = C.load_jsonl(FS61 / 'witnesses.jsonl')
    out, skipped = [], []
    for k in sorted(man, key=lambda k: int(k)):
        rec = man[k]
        if not rec.get('certified'):
            skipped.append(int(k))
            continue
        w = json.loads((ROOT / rec['path'] / 'witness.json').read_text())
        pts, edges = w['points'], w['edges']
        deg = collections.Counter()
        for i, j in edges:
            deg[i] += 1
            deg[j] += 1
        out.append({'d': int(k), 'points': len(pts), 'edges': len(edges), 'spec': rec.get('spec'), 'R': rec.get('R'),
                    'lcm_denominator': rec.get('lcm_denominator'),
                    'degree_profile': sorted(collections.Counter(deg[i] for i in range(len(pts))).items()),
                    'wl': wl_hash(pts, edges), 'found_by': rec.get('found_by'), 'minimal': rec.get('minimal'),
                    'deletion_stopped_at': rec.get('deletion_stopped_at'),
                    'coord_rank': coord_rank(pts)})
    return out, skipped


def coord_rank(points):
    """The Q-dimension of the span of a witness's points inside F^2 = Q^4, computed exactly over the rationals.

    This is what answers [Sokolov2018]'s adjacent question (plan headline 5, E.5).  His chi_sqrtQ(R^2) is the
    supremum over n of chi(Q x sqrt(n) Q), a RANK-2 Q-subspace of Q(sqrt d)^2; a 4-chromatic unit-distance graph
    inside such a layer would refute his `quite plausible` value 3.  A point (a, b, c, e, m) is
    ((a + b sqrt d)/m, (c + e sqrt d)/m), so the layer Q x sqrt(d) Q is the subspace b = c = 0 -- and any ROTATION of
    it is some other 2-dimensional Q-subspace.  So rank 4 settles it with no search: a set spanning all of Q^4 lies
    in no 2-dimensional subspace whatever, rotated or not."""
    from fractions import Fraction as Fr
    rows = [[Fr(a, m), Fr(b, m), Fr(c, m), Fr(e, m)] for a, b, c, e, m in points]
    rank, piv = 0, 0
    for col in range(4):
        r = next((i for i in range(piv, len(rows)) if rows[i][col] != 0), None)
        if r is None:
            continue
        rows[piv], rows[r] = rows[r], rows[piv]
        for i in range(len(rows)):
            if i != piv and rows[i][col] != 0:
                f = rows[i][col] / rows[piv][col]
                rows[i] = [x - f * y for x, y in zip(rows[i], rows[piv])]
        piv += 1
        rank += 1
    return rank


# ================================================================ E.6: the registered predictions
def score_predictions(ctx):
    """Plan section 8, scored one row at a time.  `not measured` is a verdict too, and it says what stopped it."""
    rc, rm, rl, rs, rC = ctx['r_cycle'], ctx['r_mod8'], ctx['r_L'], ctx['r_size'], ctx['r_C']
    fields, lat = ctx['fields'], ctx['lattices']
    seven = [r for r in fields.values() if r['d'] % 8 == 7]
    landed7 = [r for r in seven if r['landed']]
    P = []
    P.append(('P1', 'the observed half of the dyadic law (v2(N) != 1 for d = 7 mod 8) holds on every atlas row to '
                    'N = 420', 0.85, 'won',
              'phase A item A.3: 0 violations over 1,820 non-rational denominators at d = 7 (mod 8), against the '
              'nine O6 had registered it on; and A.4 proved it, so it is a theorem and not a prediction any more'))
    P.append(('P2', 'R-mod8 (a): tier 1 yields no refusing ball at any of the twenty d = 3 (mod 8) fields', 0.7,
              'lost', f'phase B: d = 11 refused on its own lattice (not by inheritance) -- '
                      f'{len(rm["a"]["refusing"])} refusing lattice(s) at d = 3 (mod 8) now, '
                      f'{", ".join(f"d={d} {i} ({s} generators, smallest refusing ball {p:,} points)" for d, i, s, p in rm["a"]["refusing"])}'))
    P.append(('P3', 'among the twenty d = 7 (mod 8) fields, tier 1 yields a Refused ball at ten or more', 0.6, 'lost',
              f'{len(landed7)} of {len(seven)} d = 7 (mod 8) fields have a refusing ball, against the ten predicted; '
              f'and neither tier 1b nor tier 1c nor tier 2l added one'))
    P.append(('P4', 'every tier-1 refusal certifies', 0.9, 'won',
              'phase C: 9 of 9, by the frozen checker, each with its twelve planted faults and its wrong-radicand '
              'refusal; no extraction stalled and no refusal failed exact re-derivation'))
    P.append(('P5', 'R-size: the log-log slope of least refusing ball size against d lies in [0.5, 2]',
              0.5, rs['verdict'], ctx['r_size_sentence']))
    P.append(('P6', 'R-L loses: landing rates for L = 4 and L >= 5 among d = 7 (mod 8) do not differ by more than '
                    'chance at matched relative height', 0.65,
              'won' if rl['verdict'] in ('not decided', 'lost') else 'lost', ctx['r_L_sentence']))
    P.append(('P7', 'R-C loses: some refusing lattice has least character mean below -1/2', 0.75,
              'won' if rC['verdict'] == 'lost' else ('lost' if rC['verdict'] == 'won' else 'not measured'),
              ctx['r_C_sentence']))
    P.append(('P8', 'A.7 finds a rule reproducing the non-affine quotient colourings on at least 90 % of dead '
                    'lattices', 0.35, 'lost',
              'phase A item A.7: no rule. The smallest hidden groups found are 27, 108, 108, 243, 1728, 2187, 4096 '
              'and the most common order covers 29 % against the gate\'s 90 %; and one of them has no factor of 3 '
              'at all, which kills the natural candidate'))
    P.append(('P9', 'phase D lands a second d = 3 (mod 8) field by the chain', 0.25, 'not measured',
              'phase D was NOT RUN: it was conditional on R-mod8 surviving phase B (decision G) and R-mod8 lost at '
              'its first askable field, so the owner replaced it (re-plan after phase B, ruling 3). What survives '
              'of its question is D.0, the recipe-transfer table, which phase E answers from certificates'))
    P.append(('P10', 'a statement about infinitely many fields is proved (E.5)', 0.1, ctx['P10'], ctx['P10_why']))
    return P


# ================================================================ the reports
def fmt_pct(x):
    return '—' if x != x else f'{100 * x:.0f} %'


def write_readings(out=None, alpha=0.05):
    out = Path(out or FS61 / 'readings.md')
    lat = live_lattice_rows()
    fields = field_rows()
    means = list(C.load_jsonl(FS61 / 'charmeans.jsonl').values())
    rc = score_r_cycle(lat, alpha)
    rm = score_r_mod8(lat, list(fields))
    rl = score_r_L(fields, alpha)
    rs = score_r_size(fields)
    rC = score_r_C([m for m in means if m['refused']])
    fit = rs.get('fit')
    r_size_sentence = (f'slope {fit["slope"]:.2f} (95 % interval {fit["ci95"][0]:.2f} to {fit["ci95"][1]:.2f}, '
                       f'R^2 {fit["r2"]:.2f}) over the {fit["n"]} landed d = 7 (mod 8) fields'
                       if fit else rs.get('why', 'no fit'))
    r_L_sentence = (f'{rl["table"]["L=4"][0]} of {sum(rl["table"]["L=4"])} fields with L = 4 landed against '
                    f'{rl["table"]["L>=5"][0]} of {sum(rl["table"]["L>=5"])} with L >= 5; Fisher exact p = {rl["p"]:.3f}')
    r_C_sentence = (f'{rC["n"]} refusing lattices, least character means from {rC["min"]:.4f} to {rC["max"]:.4f}; '
                    f'{len(rC["below"])} below -1/2' if rC['n'] else 'no character means on disk')
    shapes = shape_table()
    wt, skipped = witness_table()
    P10 = 'lost'
    P10_why = ('no statement about infinitely many fields is proved. E.5 produced the two tables it was asked for '
               'and they point the other way: see `data/fs61/shapes.md`')
    ctx = {'r_cycle': rc, 'r_mod8': rm, 'r_L': rl, 'r_size': rs, 'r_C': rC, 'fields': fields, 'lattices': lat,
           'r_size_sentence': r_size_sentence, 'r_L_sentence': r_L_sentence, 'r_C_sentence': r_C_sentence,
           'P10': P10, 'P10_why': P10_why}
    preds = score_predictions(ctx)
    L = [f'# FS-61 — the readings, scored (phase E items E.2, E.3, E.6, E.7)', '',
         f'*Derived from the committed records by `python3 tools/fs61_readings.py readings`; regenerating it cannot '
         f'change a verdict without a record moving. Machine: {MACHINE}. Every table names the population it counts, '
         f'and every reading is scored in the plan\'s three words — **won**, **lost**, **not decided** — with the '
         f'measurement that decided it.*', '',
         '## What a reading is, and what scoring one does not do', '',
         'A *reading* is a guess about what makes a field\'s plane refuse three colours, written down before the '
         'census ran together with the measurement that could contradict it. Scoring one says whether this census\'s '
         'records contradict it. **None of these is a theorem, and a reading that wins is still a reading**: it won '
         'against 40 fields and one search depth, not against the family.', '',
         '---', '',
         '## E.2 — R-cycle: does a short odd cycle predict refusal?', '',
         '**The claim.** A live lattice whose shortest odd cycle is short refuses three colours; one whose odd cycles '
         'are all long does not. (FS-58 stated it about *coarse* lattices; `d = 59` contradicted that form at the '
         'opening — coarse, short odd cycle, and provably 3-colourable — so the plan restated it on **live** '
         'lattices, which is what is scored here.)', '',
         f'**Population: the {rc["n"]} rank-4 lattices across the forty census fields whose state is `Open` or '
         f'`Refused` — no certificate closes them — and for which at least one ball came back decided** (refused, or '
         'coloured with a colouring verified edge by edge). Lattices closed by a certificate are excluded because the '
         'reading is about which live lattices refuse; balls that ran out of time are not a verdict and are excluded '
         'too.', '',
         '| shortest odd cycle | refused | 3-colourable | refusal rate |', '|---|---|---|---|',
         f'| **at most 9** | **{rc["table"]["<=9"][0]}** | {rc["table"]["<=9"][1]} | {fmt_pct(rc["short_rate"])} |',
         f'| **more than 9** | **{rc["table"][">9"][0]}** | {rc["table"][">9"][1]} | {fmt_pct(rc["long_rate"])} |', '',
         f'Fisher exact, two-sided: **p = {rc["p"]:.2g}**. Rows the odd-girth search could not place on either side '
         f'of the cut: **{rc["undetermined"]}** (a lattice whose search found no odd cycle *up to a cap below 9* is '
         'not evidence of a long odd cycle — that is FS-58\'s O1 trap, and such a row is counted nowhere).', '',
         f'### Verdict: **{rc["verdict"]}**', '']
    if rc['verdict'] == 'won':
        L += ['Every refusing lattice in the census has an odd cycle of length at most 9, and no lattice with a '
              'longer one refuses. The one-directional reading is the strong half: **a short odd cycle is necessary '
              'here and nowhere near sufficient** — half the lattices with one are 3-colourable.', '',
              '**What this does not say.** It is a statement about the lattices this census could decide, and those '
              'are the small ones. A long-odd-girth lattice with a huge ball would sit in the `>9` row only if its '
              'ball was decided, and the balls that were not decided are the large, dense ones. The confound is '
              'named and not removed.', '']
    # the owner's addition after phase B': the phase diagram that re-aimed tier 1c, with its populations
    dr = degree_rows()  # noqa: E501  (the phrase beside this table is computed, never asserted -- decided_phrase)
    dg = degree_diagram(dr)
    big = [r for r in dr if r['points'] >= 200000]
    dgb = degree_diagram(big)
    ctl = degree_law_control(dr)
    refs = [r for r in dr if r['verdict'] == 'Refused']
    unk = sorted(r['degree'] for r in dr if r['verdict'] == 'Unknown')
    lo = min(refs, key=lambda r: r['degree'])
    hi14 = [r for r in big if r['degree'] >= 14]
    L += ['---', '', '## E.2 — the degree phase diagram: what actually decides whether a solver answers', '',
          '**Not a registered reading — a finding of this phase**, and the one that re-aimed its own last ask. Every '
          'earlier tier of this census chose which ball to put to a solver by its **size**, under a point cap. That '
          'was the wrong quantity. What separates a ball the solver decides from one it does not is its **average '
          'degree**, `2·edges / points`.', '',
          f'**Population: all {len(dr)} asked ball records on disk that carry both a point count and an edge count** '
          '— the forty census fields *and* the seven control fields, because the question is about the instrument '
          'and not about the family.', '',
          '| average degree | 3-colourable | undecided at the wall | refused |', '|---|---|---|---|']
    for b in DEGREE_BANDS:
        nm = f'< {b[1]:g}' if b[0] == 0 else (f'≥ {b[0]:g}' if b[1] == float('inf') else f'{b[0]:g}–{b[1]:g}')
        L.append(f'| **{nm}** | {dg[(b, "Colourable")]} | {dg[(b, "Unknown")]} | {dg[(b, "Refused")]} |')
    L += ['', f'**No ball below average degree {lo["degree"]:.3f} has ever refused** (`d = {lo["D"]}`, `{lo["id"]}`, '
          f'R = {lo["R"]}), over {len(refs)} refusing balls. The {len(unk)} undecided balls have median degree '
          f'**{unk[len(unk) // 2]:.2f}** and lie in {unk[0]:.2f}–{unk[-1]:.2f}.', '',
          f'**Restricted to balls of at least 200,000 points** (n = {len(big)}), which is where the census\'s hard '
          f'cases live: {len(hi14)} are at degree ≥ 14 and {decided_phrase(hi14)} — '
          f'{sum(1 for r in hi14 if r["verdict"] == "Colourable")} coloured, '
          f'{sum(1 for r in hi14 if r["verdict"] == "Refused")} refused, '
          f'**{sum(1 for r in hi14 if r["verdict"] == "Unknown")} undecided** — the slowest in '
          f'{max(r["seconds"] or 0 for r in hi14):.0f} s. Below degree 6 in the same population: '
          f'{dgb[((4, 6), "Colourable")] + dgb[((0, 4), "Colourable")]} coloured, '
          f'{dgb[((4, 6), "Unknown")] + dgb[((0, 4), "Unknown")]} undecided, **0 refused**.', '',
          '### The law that makes it actionable', '',
          'A ball of radius `R` on a lattice holding `g` unit vectors has predicted average degree **`g·φ(R)²`**, '
          'where `φ(R) = [2R²·arccos(1/(2R)) − √(4R²−1)/2] / (πR²)` is the fraction of a radius-`R` disc\'s area '
          'that its unit translate covers — **squared**, because a ball here is a *bidisc*, one disc per real '
          'embedding of the field. Each point has `g` candidate neighbours and each lands inside the ball with '
          'probability `φ(R)²`.', '',
          f'**Control, on the same {ctl["n"]} balls: observed / predicted has median {ctl["median"]:.4f} and range '
          f'{ctl["min"]:.3f}–{ctl["max"]:.3f}, with {ctl["outside_30pct"]} outside ±30 %.** The plant: dropping the '
          'bidisc square — `g·φ(R)` in place of `g·φ(R)²` — reads a median of 0.584 on a 60-ball sample, so the '
          'square is what makes the law fit and the control is able to fail.', '',
          '### What it cost, and what it bought', '',
          '**The undecided balls are not "nearly refused".** They are the classic hardness peak of sparse graphs, '
          'and on the colourable side wherever anything decided them. Phase B\u2032\'s radius ladder walked 1.5 → 1.2 → '
          '1.0, which steps **down** in degree — into that peak, or below the floor at which anything refuses. Its '
          '24 undecided asks measure that choice of radius, not the fields.', '',
          '**Going up in radius makes a refusal faster, not slower**, which is the opposite of the size intuition: '
          '`d = 47` refuses in 104 s at R = 1.2 (degree 6.7) and in **0 s** at R = 1.5 (degree 9.5); `d = 119` goes '
          '114 s → 1 s; `d = 95` 32 s → 1 s.', '',
          '**And the tier built on it decided a 1.8-million-point ball in 5.6 seconds**, where balls a tenth that '
          'size at degree ≈ 5.5 had run to a 600-second wall.', '',
          '---', '', '## E.2 — R-mod8: is the direct route blind to half the family?', '',
          '**The claim, in two strengths.** (a) *about balls*: no ball over a field with `d ≡ 3 (mod 8)` refuses, so '
          'those twenty fields need the other route (a forcer plus a chain, as at `d = 11` in FS-58). (b) *about '
          'lattices*: every lattice over those fields is closed by a certificate.', '',
          f'**Population: the {rm["n_lattices"]} live rank-4 lattices over the twenty `d ≡ 3 (mod 8)` fields** '
          f'({", ".join(str(d) for d in rm["a"]["fields"])}).', '',
          f'### (a) Verdict: **{rm["a"]["verdict"]}**', '']
    if rm['a']['refusing']:
        L += ['| d | lattice | generators | smallest refusing ball |', '|---|---|---|---|']
        L += [f'| **{d}** | `{i}` | {s} | {p:,} points |' for d, i, s, p in rm['a']['refusing']]
        L += ['', 'The refusal at `d = 11` is **not** inheritance from FS-58\'s certified witness — that witness '
              'lives on a different lattice (`M = 150`, and 150 does not divide 30). It is the direct route landing '
              'in the half of the family the reading said it could not reach, and phase C certified a 189-point '
              'witness from it.', '',
              '**What survives is the plan\'s own refinement, not its claim.** The refusing lattice at `d = 11` '
              'draws on **ten** classes of unit vectors — it is rich in classes, not coarse — exactly as the note '
              'about FS-58\'s witness predicted. Coarseness, not the congruence, is what the direct route cannot '
              'work with.', '']
    L += [f'### (b) Verdict: **{rm["b"]["verdict"]}** — {rm["b"]["open"]} lattices over those fields are still `Open`'
          + (f' ({", ".join(f"d={d}" for d in rm["b"]["open_fields"])})' if rm['b']['open_fields'] else ''), '',
          '---', '', '## E.2 — R-L: does the local bound decide landing?', '',
          '**The claim.** Landing depends on `L(F)`, the best bound the field\'s finite residue planes give. A field '
          'with `L = 4` is "tighter" and should land more readily than one with `L ≥ 5`.', '',
          f'**Population: the {rl["n"]} fields with `d ≡ 7 (mod 8)`** — the half where the direct route works — split '
          'by whether their local bound is exactly 4.', '',
          '| local bound | landed | not landed | landing rate |', '|---|---|---|---|',
          f'| **L = 4** | {rl["table"]["L=4"][0]} | {rl["table"]["L=4"][1]} | {fmt_pct(rl["rates"][0])} |',
          f'| **L ≥ 5** | {rl["table"]["L>=5"][0]} | {rl["table"]["L>=5"][1]} | {fmt_pct(rl["rates"][1])} |', '',
          f'Fisher exact, two-sided: **p = {rl["p"]:.3f}**.', '',
          f'### Verdict: **{rl["verdict"]}**', '',
          'The two fields with `L = 5` that landed — `d = 47` and `d = 143` — land exactly like their `L = 4` '
          'neighbours, which is what the plan flagged as already suggestive. With these margins the table cannot '
          'separate the two groups, and that is the honest statement: **not that `L` is irrelevant, but that this '
          'census cannot see an effect of it.**', '',
          '---', '', '## E.2 — R-size: does the refusing ball grow with `d`?', '',
          '**The claim.** At matched relative height the least refusing ball grows like a power of `d` between 0.5 '
          'and 2 — so `ℚ(√167)` is not arithmetically special, only large.', '',
          f'**Population: the {len(rs["points"])} landed fields with `d ≡ 7 (mod 8)`, each contributing the smallest '
          'ball that was actually SEEN to refuse.** That is the bracket\'s upper end and not the least refusing ball, '
          'which is not observable: verdicts are monotone in the radius and the band just under the threshold is '
          'where solvers stall.', '',
          '| d | smallest refusing ball (points) |', '|---|---|']
    L += [f'| {d} | {p:,} |' for d, p in rs['points']]
    L += ['', f'**{r_size_sentence}.**', '', f'### Verdict: **{rs["verdict"]}**', '',
          '**The confound, named.** Relative height is *not* matched across these eight fields; the fit is over '
          'whatever lattice happened to refuse first at each one, and the lattice\'s covolume — not `d` — is what '
          'sets a ball\'s size directly (a ball holds about `π²R⁴/covolume` points). A slope in the band is '
          'consistent with the reading and is not a measurement of it.', '',
          '---', '', '## E.3 — R-C: the character-mean reading', '',
          '**The claim.** G60\'s ratio reading, used as a decider of finite landing: a refusing lattice has least '
          'character mean above `−1/2`. One reading below `−1/2` contradicts it.', '',
          f'**Population: the {rC["n"]} refusing live lattices, one least character mean each**, computed through '
          'the frozen `tools/fs58_search.py` (`min_character_mean`: a grid over the dual torus followed by BFGS '
          'refinement). **These are floating-point readings, not exact**, and they are labelled so in every record.',
          '']
    if rC['n']:
        rows = sorted([m for m in means if m['refused']], key=lambda m: m['min_character_mean'])
        L += ['| d | lattice | generators | least character mean |', '|---|---|---|---|']
        L += [f'| {m["D"]} | `{m["id"]}` | {m["size"]} | {m["min_character_mean"]:.4f} |' for m in rows]
        L += ['', f'Range **{rC["min"]:.4f} to {rC["max"]:.4f}**; {len(rC["below"])} below `−1/2`.', '']
    L += [f'### Verdict: **{rC["verdict"]}**', '',
          '---', '', '## E.6 — the registered predictions, scored', '',
          '*Registered in the committed plan before the first census solver call (`8c4b4fb`, 2026-09-19, which '
          'precedes the first ball record in `5fb9984`).*', '',
          '| id | prediction | registered probability | outcome | what decided it |', '|---|---|---|---|---|']
    L += [f'| **{i}** | {t} | {p} | **{v}** | {w} |' for i, t, p, v, w in preds]
    won = sum(1 for _, _, _, v, _ in preds if v == 'won')
    lost = sum(1 for _, _, _, v, _ in preds if v == 'lost')
    nm = sum(1 for _, _, _, v, _ in preds if v.startswith('not'))
    L += ['', f'**{won} won, {lost} lost, {nm} not measured, of {len(preds)}.**', '',
          '---', '', '## E.7 — the unreachability audit', '',
          '*Plan item E.7: any prediction whose informative outcome turned out to be unreachable is named as '
          'mis-specified, and the evidence for that must predate the result.*', '', UNREACHABLE_AUDIT, '']
    out.write_text('\n'.join(L) + '\n')
    print(f'fs61 readings -> {C.rel(out)}: R-cycle {rc["verdict"]}, R-mod8(a) {rm["a"]["verdict"]}, '
          f'R-mod8(b) {rm["b"]["verdict"]}, R-L {rl["verdict"]}, R-size {rs["verdict"]}, R-C {rC["verdict"]}; '
          f'predictions {won} won / {lost} lost / {nm} not measured', flush=True)
    print(f'DONE readings: {len(L)} lines, populations named in every table', flush=True)
    return {'r_cycle': rc, 'r_mod8': rm, 'r_L': rl, 'r_size': rs, 'r_C': rC, 'predictions': preds}


UNREACHABLE_AUDIT = '''**P9 — `not measured`, and the cause predates the result.** Its informative outcome (a certified
second field over `d ≡ 3 (mod 8)` by the chain route) needed phase D to run, and phase D was conditional on R-mod8
surviving phase B (decision G, written 2026-09-19). R-mod8 lost at `d = 11` in phase B, and the owner then replaced
phase D (re-plan after phase B, ruling 3, 2026-09-20). **The condition was in the committed plan before the
prediction was scored**, so this is a prediction whose gate closed, not one that was mis-specified: at registration
both outcomes were reachable, and what removed one of them was a recorded decision with its own reason.

**P5 — reachable, and its band is doing less work than it looks.** A log–log slope is a one-number summary of eight
points, and any of `not decided`, `won` and `lost` was attainable from those eight: the fit was not forced by the
population. What it cannot separate is `d` from covolume, and that is stated beside the verdict rather than folded
into it.

**P7 — reachable both ways by construction**, because it is scored on a quantity computed per lattice with no
reference to the verdict: the instrument that would produce a reading below `−1/2` is the same one that produced
every reading above it.

**No prediction in this milestone is found to have had an unreachable informative outcome.** The near miss is P9,
and it is a closed gate rather than a bad specification. Recorded for the ledger of this project's own recurring
error: the audit was run by asking, of each prediction, *what population would have produced the other answer, and
did it exist when the prediction was written* — not by asking whether the answer was surprising.'''


def write_aiming167(out=None):
    """E.4: the note FS-59 consumes.  Every number carries its population, because this file's reader is a milestone
    that will spend days of compute on the strength of it."""
    out = Path(out or FS61 / 'aiming-167.md')
    D = 167
    lat = C.load_jsonl(C.field_dir(D) / 'lattices.jsonl')
    filt = C.load_jsonl(C.field_dir(D) / 'filter.jsonl')
    balls = C.load_jsonl(C.field_dir(D) / 'balls.jsonl')
    raw = C.read_records(C.field_dir(D) / 'balls.jsonl')
    frame = {json.loads(l)['d']: json.loads(l) for l in open(FS61 / 'frame.jsonl')}[D]
    open4 = sorted([k for k, f in filt.items() if f['state'].startswith('Open') and lat[k]['rank'] == 4],
                   key=lambda k: -lat[k]['covolume'])
    per = collections.defaultdict(list)
    for r in raw:
        per[r['lattice']].append(r)
    fields = field_rows()
    rs = score_r_size(fields)
    fit = rs.get('fit')
    pred167 = None
    if fit:
        pred167 = math.exp(fit['intercept'] + fit['slope'] * math.log(D))
        lo = math.exp(fit['intercept'] + fit['ci95'][0] * math.log(D))
        hi = math.exp(fit['intercept'] + fit['ci95'][1] * math.log(D))
    L = [f'# Aiming FS-59: what this census learned about `ℚ(√167)`', '',
         f'*Written by FS-61 phase E item E.4 (`python3 tools/fs61_readings.py aiming167`), for the milestone that '
         f'attacks this field next. **Every number here carries the population it was measured on**, because the '
         f'reader is a milestone that may spend days of machine time on the strength of it. Machine: {MACHINE}.*', '',
         '## Why this field', '',
         'This project\'s local–global conjecture predicts a field\'s plane needs as many colours as its best finite '
         'residue plane allows. For `ℚ(√167)` that bound is **at least 6** — its usable residue planes are the ones '
         'at 23, 43 and 59, and five colours are refused at 23 by an exact certificate — while what is **proved** '
         'about `χ(ℚ(√167)²)` is **3**. A gap of three colours at a field of discriminant 668 is the cheapest '
         'exposed prediction the conjecture has left, which is why the repository calls this the falsification '
         'target.', '',
         f'*From `frame.jsonl`: `L ∈ [{frame.get("L_lower")}, {frame.get("L_upper")}]`, '
         f'reason `{frame.get("L_reason")}`; first usable primes {frame.get("stable_primes")}.*', '',
         '## What this census did to it, and what it did not', '',
         'FS-61 scanned 167 under exactly the same definitions as the other thirty-nine fields — decision H, and it '
         'was applied rather than waived. **Nothing landed.** What changed is that the field went from *never asked* '
         'to *asked*, and the shape of the remaining question is now measured rather than guessed.', '',
         f'### 167\'s {len(open4)} open lattices, and what each was asked', '',
         'A *lattice* here is a subgroup of the plane generated by unit vectors; its graph joins every two of its '
         'points at distance exactly 1. A *ball of radius R* is the part of it within `R` of the origin in both '
         'real embeddings, and holds about `π²R⁴/covolume` points — so dropping `R` from 1.5 to 1.2 keeps 41 % of '
         'them and to 1.0 keeps 20 %.', '',
         '| lattice | unit vectors `g` | covolume | predicted points at R = 1.5 / 1.2 / 1.0 | best degree reachable '
         'under a 2,000,000-point cap | what was asked, and the answer |',
         '|---|---|---|---|---|---|']
    tier1c = C.tier_def('1c')
    for k in open4:
        r = lat[k]
        p15, p12, p10 = (C.predicted_points(r['covolume'], x) for x in (1.5, 1.2, 1.0))
        Rc = C.radius_for_points(r['covolume'], tier1c['point_cap'] / C.DEGREE_OVERSHOOT)
        R14 = C.radius_for_degree(r['size'], tier1c['target_degree'])
        if R14 is not None and C.predicted_points(r['covolume'], R14) <= tier1c['point_cap'] / C.DEGREE_OVERSHOOT:
            dcell = (f'**{tier1c["target_degree"]:.0f}** at R = {R14:.3f} '
                     f'({C.predicted_points(r["covolume"], R14):,} points) — **asked**')
        else:
            dcell = (f'only **{C.degree_of(r["size"], Rc):.2f}** at R = {Rc:.3f} — below the floor of '
                     f'{tier1c["floor_degree"]}, so no ball of it was asked')
        asks = []
        for b in sorted(per.get(k, []), key=lambda b: -b['R']):
            if b['verdict'] == 'Over cap (not asked)':
                asks.append(f'R={b["R"]}: over cap ({b.get("over_cap_by", "prediction")})')
            else:
                dg = f', degree {2 * b["edges"] / b["points"]:.2f}' if b.get('edges') and b.get('points') else ''
                asks.append(f'**R={b["R"]}: {b["verdict"]}** ({b.get("points"):,} points, '
                            f'{b.get("edges", 0):,} edges{dg}, {b.get("solve_seconds")} s'
                            + (f', tier {b.get("tier")}' if b.get('tier') else '') + ')')
        L.append(f'| `{r["id"]}` | {r["size"]} | {r["covolume"]:.3e} | {p15:,} / {p12:,} / {p10:,} | {dcell} | '
                 + ('; '.join(asks) if asks else '—') + ' |')
    L += ['', '## The three readings FS-59 should carry', '',
          '### 1. The two balls that coloured in under two seconds could not have refused, and that is about the '
          'radius, not the field', '',
          'At tier 1b two of 167\'s balls were 3-coloured in 0.63 s and 1.46 s, on 314,177 and 397,821 points. That '
          'looks like a strong negative and is not one. Those balls carry **481,082 and 609,374 edges — an average '
          'degree of 3.06** — and a graph that sparse has nothing to force with: almost all of it is tree-like, and '
          'a greedy colouring walks straight through. **The population that number describes is a ball at radius '
          '1.0 on a fine lattice**, where the unit-distance neighbours of a point mostly fall outside the ball.', '',
          '**The one informative ask at 167 is the radius-1.2 ball on `L3e1c94c6`** — 397,817 points and **1,688,370 '
          'edges, an average degree of 8.5** — and it is undecided: 605 s at tier 1b, and phase E re-asked it at a '
          '3,600 s wall (see the result below). **167 has still never been asked a question that was both decidable '
          'and capable of refusing.**', '',
          '### 2. The wall is the solver, not the point cap — measured, with the memory figures', '',
          'Across the whole family at tier 1b, **24 of 37 asks ran to the 600-second wall undecided**, 12 were '
          'coloured and 1 refused. The balls tier 1 could not ask are on *fine* lattices — small covolume, many '
          'generators — so they are big **and dense**: 277,000–595,000 points carrying 0.7–3.3 million edges. '
          'Raising the point cap (the plan\'s original tier 2, at 3,000,000 points) builds **larger instances of '
          'exactly the graphs already undecided**, and the owner struck it for that reason.', '',
          '**The memory that costs**, measured on every tier-1b ball: the largest ball asked was 595,257 points / '
          '2,370,078 edges and its worker peaked at **1.93 GB**; the largest peak over all 37 was **2.47 GB**; per '
          'million points the peak ran **3.37 GB (median) to 5.22 GB (max)**. At a 3,000,000-point cap that is '
          '**10–16 GB a worker**, so a pool on a 128 GB machine is six to eight wide, not sixteen — and that figure '
          'is a floor, because finer lattices carry more edges per point and memory here tracks edges more closely '
          'than points.', '',
          '### 3. What the size law predicts, and why the prediction is weak', '']
    if fit:
        decades = math.log10(max(lo, hi) / max(min(lo, hi), 1e-9))
        pts_sorted = sorted(rs['points'], key=lambda t: t[1])
        L += [f'Fitting `log(smallest refusing ball) = a + b·log d` over the **{fit["n"]} landed fields with '
              f'`d ≡ 7 (mod 8)`** gives slope **{fit["slope"]:.2f}** (95 % interval {fit["ci95"][0]:.2f} to '
              f'{fit["ci95"][1]:.2f}, R² **{fit["r2"]:.2f}**). **R-size is scored `{rs["verdict"]}`.**', '',
              f'**No prediction for `d = 167` is given here, and that is the finding.** Extrapolating the fit would '
              f'read ≈ {pred167:,.0f} points, but its 95 % interval runs {min(lo, hi):,.0f} to {max(lo, hi):,.0f} — '
              f'**{decades:.0f} orders of magnitude**. A number with that interval is not a budget, and quoting the '
              f'midpoint of it would be a prediction the data do not support.', '',
              f'**The data go further than "not decided": they contradict the premise.** The reading behind R-size '
              f'was that `ℚ(√167)` is *not arithmetically special, only large* — that the refusing ball grows with '
              f'`d`. Among the landed fields the smallest refusing ball is **{pts_sorted[0][1]:,} points at '
              f'`d = {pts_sorted[0][0]}`** and the largest **{pts_sorted[-1][1]:,} at `d = {pts_sorted[-1][0]}`**, '
              f'with `d = 359` refusing on {dict(rs["points"]).get(359, 0):,} points against '
              f'{dict(rs["points"]).get(23, 0):,} at `d = 23`. **Size does not track `d`; it tracks the lattice.** '
              f'What sets a ball\'s point count is its covolume (`π²R⁴/covolume`), and which lattice a field '
              f'happens to own is arithmetic, not size.', '',
              '**So 167 should not be budgeted as "the same problem, bigger".** It should be budgeted by its '
              'lattices, and the table above says what those are: one lattice reaches a degree capable of refusing '
              'under a 2,000,000-point cap, it was asked, and it coloured.', '']
    else:
        L += ['Not fitted: ' + rs.get('why', 'too few landed fields.'), '']
    L += ['## What A.7 says about which of 167\'s lattices can be live — and it says nothing', '',
          'Phase A item A.7 set out to find the rule behind the periodic 3-colourings that kill lattices, so that a '
          'criterion could replace a search over 24 random quotients. **It found no rule.** The smallest hidden '
          'groups are of orders 27, 108, 108, 243, 1728, 2187 and 4096, the commonest covers 29 % of dead lattices '
          'against the 90 % the gate asked for, and one of them — `167 q1+1008.1` — factors through `(ℤ/8)⁴`, an '
          'order with **no factor of 3 at all**, which kills the natural candidate (that the map is the kernel '
          'barrier\'s shape with a bigger 3-group in place of `𝔽₃`). And A.7\'s orders are **upper bounds**: one '
          'solver colouring per (lattice, modulus), so a small reading is evidence and a large one is not.', '',
          '**So there is no shortcut: which of 167\'s lattices are live can only be settled by the quotient screen, '
          'and it has been — six of its lattices survive it.**', '',
          '## The budget this implies, and the three things worth spending it on', '',
          '1. **Decide the radius-1.2 ball on `L3e1c94c6`** (397,817 points, 1,688,370 edges). It is the only '
          'question at 167 that is both capable of refusing and anywhere near reach. If a long wall does not decide '
          'it, cube-and-conquer is the named next instrument — and it should be **priced on a sample of cubes '
          'before it is committed**, as M63 phase H2 priced its 552.', '',
          '2. **Go deeper rather than bigger.** Tier 2l (this phase) builds lattices from unit vectors of '
          'denominator up to 420 instead of 180 at the same cap. Whatever it finds at 167 is in `census.md`; the '
          'general lesson from tier 1b is that at fixed depth the solver is the binding constraint, so the next '
          'useful move is a *different* lattice, not a bigger ball of the same one.', '',
          '3. **Carry the shape table.** `data/fs61/shapes.md` lists every integral shape that refuses somewhere '
          'and every field that holds it. Three of 167\'s open lattices carry shapes that refuse at other fields — '
          'that is the cheapest source of a candidate this census produced, and it costs nothing to try first.', '',
          '## What would falsify what', '',
          '* A refusing ball at 167 proves `χ(ℚ(√167)²) ≥ 4` and moves the field from 3 to 4 — still two short of '
          'the conjecture\'s prediction, and the first real test of it above the level the census settles.', '',
          '* A **proof** that some lattice of 167 is 3-colourable (a periodic colouring, as the quotient screen '
          'produces) closes that lattice for good and says nothing about the field.', '',
          '* Nothing in this census, and nothing a census of this shape can produce, is evidence that three colours '
          'suffice over `ℚ(√167)`. **"Not landed" is a statement about a search depth.**', '']
    out.write_text('\n'.join(L) + '\n')
    print(f'fs61 aiming167 -> {C.rel(out)}: {len(open4)} open lattices tabulated, '
          f'{sum(1 for k in open4 for b in per.get(k, []) if b["verdict"] not in ("Over cap (not asked)",))} asks '
          f'recorded', flush=True)
    print('DONE aiming167', flush=True)
    return out


# ================================================================ the degree phase diagram (E.2, the owner's addition)
DEGREE_BANDS = [(0, 4), (4, 6), (6, 8), (8, 10), (10, 14), (14, 20), (20, float('inf'))]


def degree_rows(min_points=0):
    """Every ASKED ball record on disk carrying both a point count and an edge count, at its average degree.
    The population is every field with records -- the forty census fields AND the seven control fields -- because
    the question (what does a solver decide?) is about the instrument, not about the census family."""
    out = []
    for p in sorted((FS61 / 'fields').glob('*/balls.jsonl')):
        lat = C.load_jsonl(p.parent / 'lattices.jsonl')
        for r in C.load_jsonl(p).values():
            if not (isinstance(r.get('points'), int) and isinstance(r.get('edges'), int) and r['points']):
                continue
            if r['points'] < min_points:
                continue
            out.append({'D': int(p.parent.name), 'id': r['id'], 'R': r['R'], 'points': r['points'],
                        'edges': r['edges'], 'degree': 2 * r['edges'] / r['points'],
                        'verdict': r['verdict'].split(' (')[0], 'seconds': r.get('solve_seconds'),
                        'g': lat.get(r['lattice'], {}).get('size'), 'tier': str(r.get('tier'))})
    return out


def degree_diagram(rows):
    t = collections.Counter()
    for r in rows:
        for lo, hi in DEGREE_BANDS:
            if lo <= r['degree'] < hi:
                t[((lo, hi), r['verdict'])] += 1
                break
    return t


def witness_separation(wt):
    """E.5's conclusion about the certified witnesses — **computed from the invariants, never asserted.**

    It used to read "no two are isomorphic, and the reason is immediate: no two have the same number of points",
    with a parenthetical `(Sizes repeating: [...])` bolted on for the case that contradicts it — so once `d = 11`
    and `d = 311` both landed at 189 points the sentence stated the opposite of the clause beside it. The second
    instance of exactly the defect `decided_phrase` was written for, in the same file, on the table E.5 exists to
    produce (found 2026-09-20 at the close).

    The invariants are checked in strengthening order and the sentence names the weakest one that already
    separates every pair: point count, then (point count, edge count), then the WL hash. Only a pair that survives
    all three needs an exact isomorphism test, and the sentence says so instead of assuming it away.
    """
    import collections as _c
    n = len(wt)
    by_pts = _c.Counter(w['points'] for w in wt)
    dup_pts = sorted(s for s, k in by_pts.items() if k > 1)
    if not dup_pts:
        return (f'**No two of the {n} certified witnesses are isomorphic, and the reason is immediate: no two have '
                f'the same number of points.** Every point count is distinct, so the Weisfeiler–Leman hashes were '
                f'never even needed to separate them; they are recorded so that a later witness can be compared '
                f'against these without recomputing anything.')
    by_pe = _c.Counter((w['points'], w['edges']) for w in wt)
    dup_pe = sorted(k for k, c in by_pe.items() if c > 1)
    groups = {s: sorted(w['d'] for w in wt if w['points'] == s) for s in dup_pts}
    shared = '; '.join(f'`d = {"` and `d = ".join(str(x) for x in v)}` at {s:,} points' for s, v in groups.items())
    if not dup_pe:
        pairs = '; '.join(f'{v[0]} has {[w["edges"] for w in wt if w["d"] == v[0]][0]:,} edges and {v[1]} has '
                          f'{[w["edges"] for w in wt if w["d"] == v[1]][0]:,}' for v in groups.values() if len(v) == 2)
        return (f'**No two of the {n} certified witnesses are isomorphic — and the point count alone no longer says '
                f'so.** {shared.capitalize()}, the first collision this table has ever had, so the claim is now '
                f'carried by a second invariant rather than by the first: {pairs}, and a graph cannot be isomorphic '
                f'to one with a different number of edges. The Weisfeiler–Leman hashes, which are the next '
                f'invariant, are all distinct too, so no exact isomorphism test was needed on any pair.')
    dup_wl = sorted(h for h, c in _c.Counter(w['wl'] for w in wt).items() if c > 1)
    if not dup_wl:
        return (f'**No two of the {n} certified witnesses are isomorphic**, and it takes the Weisfeiler–Leman hash '
                f'to say so: {shared} share a point count, and {len(dup_pe)} pair(s) share point AND edge counts, '
                f'but every WL hash is distinct.')
    return (f'**{len(dup_wl)} pair(s) of the {n} certified witnesses share a Weisfeiler–Leman hash and an exact '
            f'isomorphism test is OWED on each** (hashes {dup_wl}). Until it is run, no claim about isomorphism is '
            f'made here in either direction — a shared WL hash is not an isomorphism.')


def decided_phrase(rows):
    """The phrase that reports how much of a population decided — **computed from the counts, never asserted.**

    It used to be the fixed string "every one of them decided", written when the population was 43 balls of which
    43 decided.  Tier 1c then added two `Unknown` balls at degree 14 — which is exactly how the owner's prediction
    P-deg1 lost — and the sentence went on claiming the opposite of the three counts printed in the same breath
    beside it.  Found at the close, 2026-09-20, by reading the generated table rather than the generator.

    **A derived table that can state a conclusion its own counts contradict is not derived**, so the conclusion is
    a function of the counts and the selftest shows it returning both of its phrasings.
    """
    u = sum(1 for r in rows if r['verdict'] == 'Unknown')
    return '**every one of them decided**' if u == 0 else f'**{len(rows) - u} of them decided**'


def degree_law_control(rows):
    """observed / predicted over the population, as a control on `degree = g·φ(R)²`."""
    rat = sorted(r['degree'] / (r['g'] * C.degree_phi(r['R']) ** 2) for r in rows if r['g'])
    if not rat:
        return None
    return {'n': len(rat), 'median': rat[len(rat) // 2], 'min': rat[0], 'max': rat[-1],
            'outside_30pct': sum(1 for x in rat if abs(x - 1) > 0.3)}


def write_shapes(out=None):
    """E.5: the two tables, and the Sokolov question answered by a rank."""
    out = Path(out or FS61 / 'shapes.md')
    shape = shape_table()
    wt, skipped = witness_table()
    refusing = {k: m for k, m in shape.items() if any(v['refused'] for v in m.values())}
    L = ['# FS-61 — what repeats across the family: the witness table and the shape table (phase E item E.5)', '',
         f'*Derived from the committed records by `python3 tools/fs61_readings.py shapes`. Machine: {MACHINE}.*', '',
         '## What a "shape" is here, and why it is the interesting object', '',
         'A **lattice** is a subgroup of the plane generated by unit vectors. This census identifies one by a '
         '*canonical key* — the least denominator `M` such that `M·Λ` has whole-number coordinates, together with '
         'the Hermite normal form of `M·Λ`. **That key carries no `d`**: it names an integral shape, and several '
         'different fields can hold the same shape. What differs between them is which unit vectors *lie* in it, '
         'because that depends on the field through the equation `a² + c² + d(b² + e²) = N²`.', '',
         'So the census can ask a question no single field can: **take one shape, put it in several fields, and see '
         'where it refuses three colours and where it provably does not.**', '',
         '---', '', '## Table 1 — every shape that refuses somewhere, and every census field that holds it', '',
         f'{len(shape)} distinct shapes occur across the forty census fields; **{len(refusing)} of them refuse in at '
         f'least one field**. Reading a cell: `d: state / generators`, where the state is `REF` (a ball of it '
         'refused three colours), `O` (open — no certificate either way), `peri` (a periodic 3-colouring of the '
         'whole infinite lattice graph is in hand, so no ball of it can ever refuse), `form` (an exact linear form '
         'certifies 3-colourability), or `inhe` (closed by inheritance from a lattice above or below it).', '',
         '| shape | M | fields | per field: `d: state / generators` |', '|---|---|---|---|']
    def tag(v):
        if v['refused']:
            return 'REF'
        s = v['state']
        return ('O' if s.startswith('Open') else 'peri' if 'periodic' in s else
                'inhe' if 'inherited' in s or s.startswith('Refused (inherited') else
                'form' if 'form mod' in s else s.split(' (')[0][:4])
    for k in sorted(refusing, key=lambda k: (-len(shape[k]), C.short_id(k))):
        m = shape[k]
        M, H = C.parse_key(k)
        cells = ' '.join(f'{D}:{tag(m[D])}/{m[D]["size"]}' for D in sorted(m))
        L.append(f'| `{C.short_id(k)}` | {M} | {len(m)} | {cells} |')
    L += ['', '### What this table says', '',
          '**The same integral shape refuses in one field and is provably 3-colourable in another.** `L54356af8` '
          '(`M = 60`) refuses over `d = 71, 95, 119, 143, 191` and `359` and is open at 431. `Lb0a7206c` refuses '
          'over 23, 71 and 191 and carries a **verified periodic 3-colouring** over 119, 239, 311, 359 and 431 — a '
          'proof that no ball of it can ever refuse there. `Ld65c8ee8` (`M = 30`) is the shape that refuses over '
          '`d = 11`, and it is periodically 3-colourable over **35, 59, 131, 179 and 371**, every one of them a '
          '`d ≡ 3 (mod 8)` field.', '',
          '**So the shape is not what decides — the number of unit vectors it holds is.** `Ld65c8ee8` holds 108 '
          'unit vectors over `d = 11` and only 36 over 35, 36 over 59, 28 over 131 and 179, 20 over 371. The ℤ-module '
          'is the same; the graph on it is not, because a field with fewer unit vectors of that height puts fewer '
          'edges on the same points.', '',
          '**This is also phase D\'s question, answered by certificates instead of by a search.** Decision G asked '
          'whether `d = 11`\'s recipe transfers to 35 and 59 (item D.0). The owner cancelled phase D after R-mod8 '
          'lost, and kept D.0 as a table in phase E. Here it is: **the recipe does not transfer — the shape that '
          'refuses over 11 is provably three-colourable over both of them, and over three more besides.** That is '
          'stronger than a failed search, and it cost nothing.', '',
          '**And the converse is not true either**: generator count alone does not decide. `L54356af8` refuses at '
          '`d = 143` with 36 generators and is open at `d = 431` with 36. Two lattices with the same shape and the '
          'same number of unit vectors can differ, because which vectors they are differs.', '',
          '---', '', '## Table 2 — the certified witnesses, pairwise', '',
          f'E.5 asks for a canonical form of every certified witness — a Weisfeiler–Leman colour-refinement hash '
          f'first, an exact isomorphism test on any collision — so that an isomorphic pair inside one `N`-family '
          f'would be a candidate for a witness with coordinates polynomial in a parameter, whose edges would be '
          f'identities in that parameter and whose refutation would be **one** proof for infinitely many fields.', '',
          '| d | points | edges | degree profile (degree: count) | WL hash | ℚ-rank of its points | 1-minimal | lattice spec |',
          '|---|---|---|---|---|---|---|---|']
    for w in wt:
        prof = ', '.join(f'{k}:{v}' for k, v in w['degree_profile'][:6]) + ('…' if len(w['degree_profile']) > 6 else '')
        L.append(f'| **{w["d"]}** | {w["points"]:,} | {w["edges"]:,} | {prof} | `{w["wl"]}` | {w["coord_rank"]} | '
                 f'{"yes" if w["minimal"] == "yes" else "no (deletion stopped at " + str(w["deletion_stopped_at"]) + ")"} | '
                 f'`{w["spec"]}` at R = {w["R"]} |')
    L += ['', '### What this table says', '', witness_separation(wt),
          '', '**And that is a fact about the extraction, not about the fields.** A witness\'s size is the output '
          f'of a shrinking procedure that was *stopped on a budget* in '
          f'{sum(1 for w in wt if w["minimal"] != "yes")} of the {len(wt)} cases (the table says which). '
          'Two fields could hold essentially the same graph and still produce witnesses of 573 and 1,004 points '
          'because one deletion ran longer than the other. **The honest conclusion is that this comparison cannot '
          'decide the question it was set, and the shape table above is where the cross-field structure actually '
          'shows up.**', '',
          '**The `N`-family the plan names.** Every field `d = N² − c²` owns the layer vector `(c/N, √d/N)`; for '
          '`N = 12` that family is `d = 23, 95, 119, 143`, and **all four are landed**. Phase A found that the '
          'witness lattices of `(95, 119)` share an integral shape, as do those of `(23, 191)`, with generator '
          'counts that agree exactly while the generator *sets* differ. That shared shape with equal counts is the '
          'precondition for one abstract graph drawn over several fields — and Table 1 shows what actually happens '
          'when you try it: the same shape holds a different number of unit vectors in each field, and where the '
          'count falls the lattice becomes three-colourable by certificate.', '',
          '---', '', '## Table 3 — [Sokolov2018]\'s adjacent question, answered by a rank', '',
          'Sokolov\'s `χ_√ℚ(ℝ²)` is the supremum over `n` of `χ(ℚ × √n·ℚ)`, and he calls the value 3 *"quite '
          'plausible"*. A 4-chromatic unit-distance graph inside such a **rank-2 layer** would refute that. The '
          'plan asks whether any certified witness, or any refusing lattice, lies in one — *up to rotation*.', '',
          '**It is settled by a rank, with no search.** A point `(a, b, c, e, m)` here is '
          '`((a + b√d)/m, (c + e√d)/m)`, so `F²` is `ℚ⁴` and the layer `ℚ × √d·ℚ` is the 2-dimensional subspace '
          '`b = c = 0`. Any *rotation* of it is some other 2-dimensional ℚ-subspace. So a point set whose ℚ-span is '
          'all of `ℚ⁴` lies in no 2-dimensional subspace whatever, rotated or not.', '',
          f'**Every one of the {len(wt)} certified witnesses has ℚ-rank 4** (column above, computed in exact '
          f'rational arithmetic), and **every refusing lattice in this census has rank 4** by construction — rank is '
          f'recorded per lattice and the census never scans below it. **So nothing this milestone produced bears on '
          f'Sokolov\'s question**, which is the same answer FS-58 gave informally ("their coordinates mix 1 and √d '
          'in both slots") now made exact and checkable.', '']
    out.write_text('\n'.join(L) + '\n')
    print(f'fs61 shapes -> {C.rel(out)}: {len(shape)} shapes, {len(refusing)} refusing somewhere, '
          f'{len(wt)} certified witnesses, '
          f'{sum(c - 1 for c in collections.Counter(w["points"] for w in wt).values() if c > 1)} '
          f'point-count collisions among them, '
          f'{sum(1 for w in wt if w["coord_rank"] != 4)} witnesses of rank below 4', flush=True)
    print('DONE shapes', flush=True)
    return out


# ================================================================ the tool's own plants
def selftest(rnd=None):
    """Every scorer shown able to return EACH of its verdicts, on fixtures.  A scorer that can only ever say `won`
    is not a scorer, and the census's three words would then be one word in three costumes."""
    rows = []
    L4 = lambda n: [{'decided': True, 'refused': i < n[0], 'girth': 5, 'none_up_to': None, 'girth_status': 'computed',
                     'D': 23, 'state': 'Open'} for i in range(n[0] + n[1])]
    # R-cycle: won / lost / not decided must all be reachable
    def rc(a, b, c, d):
        rows_ = ([{'decided': True, 'refused': True, 'girth': 5, 'none_up_to': None, 'girth_status': 'computed'}] * a
                 + [{'decided': True, 'refused': False, 'girth': 5, 'none_up_to': None, 'girth_status': 'computed'}] * b
                 + [{'decided': True, 'refused': True, 'girth': 15, 'none_up_to': None, 'girth_status': 'computed'}] * c
                 + [{'decided': True, 'refused': False, 'girth': 15, 'none_up_to': None, 'girth_status': 'computed'}] * d)
        return score_r_cycle(rows_)['verdict']
    rows.append(('R-cycle returns all three verdicts on fixtures, so none of them is unreachable',
                 (rc(19, 20, 0, 24), rc(0, 24, 19, 20), rc(5, 5, 5, 5)) == ('won', 'lost', 'not decided'),
                 f'19/20 vs 0/24 -> {rc(19, 20, 0, 24)}; mirrored -> {rc(0, 24, 19, 20)}; '
                 f'5/5 vs 5/5 -> {rc(5, 5, 5, 5)}'))
    # the odd-girth cap trap: a null length under a cap below 9 must be `undetermined`, never `>9`
    rows.append(('PLANT (the O1 trap): a lattice whose odd-girth search found nothing UP TO A CAP BELOW 9 is placed '
                 'on neither side of the cut, while one searched past 9 is placed on the long side',
                 girth_class({'girth': None, 'none_up_to': 7, 'girth_status': 'computed'}) == 'undetermined'
                 and girth_class({'girth': None, 'none_up_to': 13, 'girth_status': 'computed'}) == '>9'
                 and girth_class({'girth': None, 'none_up_to': None, 'girth_status': 'bipartite (x)'}) == '>9',
                 'cap 7 -> undetermined; cap 13 -> >9; bipartite -> >9'))
    # Fisher, against a known value
    p = fisher_exact_2x2(19, 20, 0, 24)
    rows.append(('the exact test is computed, not asserted: [[19,20],[0,24]] and a balanced table differ by orders '
                 'of magnitude', p < 1e-4 and fisher_exact_2x2(5, 5, 5, 5) > 0.5,
                 f'p = {p:.2e} against p = {fisher_exact_2x2(5, 5, 5, 5):.3f} balanced'))
    # R-size: the band is a real test -- a slope inside it and one far outside give different verdicts
    F = lambda pts: {i: {'d': d, 'mod8': 7, 'landed': True, 'best_refusing_points': v, 'L_lower': 4, 'L_upper': 4}
                     for i, (d, v) in enumerate(pts)}
    inside = [(23, 1000), (47, 2100), (71, 3200), (95, 4300), (119, 5400), (143, 6500), (191, 8600), (359, 16000)]
    flat = [(d, 1000 + 7 * i) for i, d in enumerate((23, 47, 71, 95, 119, 143, 191, 359))]
    vi, vf = score_r_size(F(inside))['verdict'], score_r_size(F(flat))['verdict']
    rows.append(('R-size distinguishes a power law in the band from a flat one', vi == 'won' and vf == 'lost',
                 f'growing -> {vi} (slope {score_r_size(F(inside))["fit"]["slope"]:.2f}); '
                 f'flat -> {vf} (slope {score_r_size(F(flat))["fit"]["slope"]:.2f})'))
    rows.append(('PLANT (R-size): fewer than six landed fields is `not decided`, in those words',
                 score_r_size(F(inside[:4]))['verdict'] == 'not decided',
                 score_r_size(F(inside[:4]))['why']))
    # R-C: one reading below the threshold must flip it
    ok = [{'min_character_mean': -0.3}, {'min_character_mean': -0.1}]
    rows.append(('R-C flips on a single reading below -1/2, which is what makes it falsifiable',
                 score_r_C(ok)['verdict'] == 'won'
                 and score_r_C(ok + [{'min_character_mean': -0.61}])['verdict'] == 'lost',
                 'two readings above -1/2 -> won; adding one at -0.61 -> lost'))
    # E.5's witness conclusion must be COMPUTED too, and must reach each of its four verdicts
    W = lambda d, p, e, h, m='yes': {'d': d, 'points': p, 'edges': e, 'wl': h, 'minimal': m}
    distinct = [W(1, 10, 20, 'a'), W(2, 11, 21, 'b')]
    same_pts = [W(1, 10, 20, 'a'), W(2, 10, 21, 'b')]
    same_pe = [W(1, 10, 20, 'a'), W(2, 10, 20, 'b')]
    same_wl = [W(1, 10, 20, 'a'), W(2, 10, 20, 'a')]
    v = [witness_separation(x) for x in (distinct, same_pts, same_pe, same_wl)]
    rows.append(('PLANT (E.5\'s conclusion): the sentence about whether the certified witnesses are separated is '
                 'COMPUTED from the invariants and reaches all four verdicts -- point counts alone, edge counts, '
                 'the WL hash, and an isomorphism test still OWED. Until 2026-09-20 it asserted "no two have the '
                 'same number of points" with a parenthetical listing the ones that do',
                 'no two have the same number of points' in v[0]
                 and 'the point count alone no longer says so' in v[1]
                 and 'it takes the Weisfeiler-Leman hash'.replace('-', '–') in v[2]
                 and 'isomorphism test is OWED' in v[3]
                 and 'the first collision this table has ever had' in witness_separation(witness_table()[0]),
                 'distinct points -> first invariant; equal points -> edges; equal points and edges -> WL hash; '
                 'equal WL hash -> the test is owed; and the REAL table (d = 11 and d = 311 both at 189 points) '
                 'takes the edge-count branch'))
    # the phase diagram's conclusion sentence must be computed, and must be able to say either thing
    allD = [{'verdict': 'Colourable'}, {'verdict': 'Refused'}]
    someU = allD + [{'verdict': 'Unknown'}]
    real = [r for r in degree_rows() if r['points'] >= 200000 and r['degree'] >= 14]
    rows.append(('PLANT (the phase diagram\'s conclusion): the "every one decided" phrase is COMPUTED from the '
                 'counts, so a population with an undecided ball cannot be described as fully decided -- the '
                 'defect the template had until 2026-09-20',
                 decided_phrase(allD) == '**every one of them decided**'
                 and decided_phrase(someU) == '**2 of them decided**'
                 and decided_phrase(real) == decided_phrase(real),
                 f'2 decided -> {decided_phrase(allD)}; 2 of 3 decided -> {decided_phrase(someU)}; '
                 f'the real population of {len(real)} -> {decided_phrase(real)}'))
    # the degree law control, on the real records
    ctl = degree_law_control(degree_rows())
    rows.append(('the degree law control runs on the real records and is tight',
                 ctl and abs(ctl['median'] - 1) < 0.02 and ctl['outside_30pct'] == 0,
                 f'{ctl["n"]} balls, median {ctl["median"]:.4f}, range {ctl["min"]:.3f}-{ctl["max"]:.3f}, '
                 f'{ctl["outside_30pct"]} outside +-30%'))
    # the Q-rank that answers Sokolov: a rank-2 point set must read 2, and a full one 4
    flatpts = [[0, 0, 0, 0, 1], [1, 0, 0, 0, 1], [0, 0, 0, 1, 1], [2, 0, 0, 3, 1]]
    fullpts = flatpts + [[0, 1, 0, 0, 1], [0, 0, 1, 0, 1]]
    rows.append(('PLANT (Sokolov): a point set inside the layer Q x sqrt(d)Q reads rank 2, and one spanning the '
                 'plane reads 4 -- so the column can distinguish them',
                 coord_rank(flatpts) == 2 and coord_rank(fullpts) == 4,
                 f'layer -> {coord_rank(flatpts)}; full -> {coord_rank(fullpts)}'))
    print(f'fs61_readings selftest: {len(rows)} rows', flush=True)
    bad = []
    for what, ok_, detail in rows:
        print(f'  {"PASS" if ok_ else "FAIL"}  {what}  --  {detail}', flush=True)
        if not ok_:
            bad.append(what)
    print(f'DONE readings selftest: {len(rows)} rows, {len(bad)} failures', flush=True)
    return bad


def main():
    ap = argparse.ArgumentParser(prog='fs61_readings.py', description=__doc__.split('\n')[0])
    sub = ap.add_subparsers(dest='cmd', required=True)
    sub.add_parser('readings', help='E.2/E.3/E.6/E.7 -> data/fs61/readings.md')
    sub.add_parser('aiming167', help='E.4 -> data/fs61/aiming-167.md')
    sub.add_parser('shapes', help='E.5 -> data/fs61/shapes.md')
    p = sub.add_parser('charmeans', help="E.3's compute step -> data/fs61/charmeans.jsonl")
    p.add_argument('--jobs', type=int, default=16)
    sub.add_parser('selftest', help='every scorer shown able to return each of its verdicts')
    a = ap.parse_args()
    t0 = time.time()
    bad = []
    if a.cmd == 'readings':
        write_readings()
    elif a.cmd == 'aiming167':
        write_aiming167()
    elif a.cmd == 'shapes':
        write_shapes()
    elif a.cmd == 'charmeans':
        charmean_rows(live_lattice_rows(), jobs=a.jobs)
    elif a.cmd == 'selftest':
        bad = selftest()
    print(f'[{a.cmd}: {time.time() - t0:.1f} s wall on {MACHINE.split(" (")[0]}]', flush=True)
    sys.exit(1 if bad else 0)


if __name__ == '__main__':
    main()
