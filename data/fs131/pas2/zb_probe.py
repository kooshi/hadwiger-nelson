"""FS131-PAS2: probe which phrases a zbMATH record's withheld abstract contains (the search engine indexes text the
API will not print).  usage: zb_probe.py Zbl phrase [phrase ...]   Appends {zbl, phrase: hit} to probes.jsonl beside this script."""
import json, sys, subprocess, pathlib, datetime
zbl, phrases = sys.argv[1], sys.argv[2:]
res = {}
for p in phrases:
    out = subprocess.run(['curl', '-s', '-G', '-m', '60', 'https://api.zbmath.org/v1/document/_search', '--data-urlencode',
                          f'search_string=an:{zbl} & ab:"{p}"', '--data-urlencode', 'results_per_page=1'], capture_output=True, text=True)
    try:
        n = json.loads(out.stdout)['status'].get('nr_total_results')
    except Exception:
        n = 'ERR'
    res[p] = bool(n == 1) if n != 'ERR' else 'ERR'
    print(('HIT ' if res[p] is True else '    ') + p)
with pathlib.Path(__file__).with_name('probes.jsonl').open('a') as f:
    f.write(json.dumps(dict(zbl=zbl, when=datetime.datetime.now(datetime.UTC).isoformat(timespec='seconds'), result=res), ensure_ascii=False) + '\n')
