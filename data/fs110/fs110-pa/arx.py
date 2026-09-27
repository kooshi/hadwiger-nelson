import sys,re,urllib.request,urllib.parse
q=sys.argv[1]
url='https://export.arxiv.org/api/query?'+urllib.parse.urlencode({'search_query':q,'max_results':100,'sortBy':'submittedDate'})
t=urllib.request.urlopen(url,timeout=60).read().decode()
tot=re.findall(r'<opensearch:totalResults[^>]*>(\d+)<',t)
print('Q:',q,'| total',tot[0] if tot else '?')
for e in re.findall(r'<entry>(.*?)</entry>',t,re.S):
    i=re.findall(r'<id>http://arxiv.org/abs/(.*?)</id>',e)[0]; ti=re.sub(r'\s+',' ',re.findall(r'<title>(.*?)</title>',e,re.S)[0]); pd=re.findall(r'<published>(.*?)T',e)[0]
    print(' ',i,pd,ti[:100])
