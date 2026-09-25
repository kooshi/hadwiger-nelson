import sys,re,subprocess,urllib.parse
q=sys.argv[1]; n=sys.argv[2] if len(sys.argv)>2 else '4'; L=int(sys.argv[3]) if len(sys.argv)>3 else 900
t=subprocess.run(['curl','-sL','https://export.arxiv.org/api/query?search_query='+urllib.parse.quote(q)+'&max_results='+n],capture_output=True,text=True).stdout
es=t.split('<entry>')[1:]
print(f'ARXIV {q!r}: {len(es)} shown')
for e in es:
    ti=re.search(r'<title>(.*?)</title>',e,re.S).group(1).replace('\n',' ')
    idd=re.search(r'<id>(.*?)</id>',e).group(1)
    au=', '.join(re.findall(r'<name>(.*?)</name>',e)[:3])
    ab=re.search(r'<summary>(.*?)</summary>',e,re.S).group(1).replace('\n',' ')
    print(idd, '|', au, '|', ti); print('   ', ab[:L])
