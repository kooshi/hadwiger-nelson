import json, sys
path = sys.argv[1]
for l in open(path):
    r = json.loads(l)
    st = r.get('stats', {})
    print(r['tag'], 'N', r['N'], 'D', r.get('D'), r['verdict'], (r.get('finder') or '')[:40], r.get('check', ''), r.get('check2', ''),
          'nodes', st.get('nodes', ''), 's', st.get('wall_s', ''))
