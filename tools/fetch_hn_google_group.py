#!/usr/bin/env python3
# Run with the Playwright venv: ~/.cache/lean-dir-venvs/playwright/bin/python tools/fetch_hn_google_group.py (uv venv + uv pip install playwright; uses system Chrome).
# Kooshi authorized the fetch 2026-09-27 ("surgically download that group"; no user profile, no credentials).
# Archive the public Google group hadwiger-nelson-problem, read-only, in a fresh empty browser profile (no user data).
# Only Google Groups and the Google hosts that serve its pages and attachments are reachable; everything else is aborted.
import asyncio, re, json, hashlib, pathlib, datetime
from playwright.async_api import async_playwright
OUT = pathlib.Path.home() / "source/library/hadwiger-nelson-problem-group"
GROUP = "https://groups.google.com/g/hadwiger-nelson-problem"
ALLOW = re.compile(r'^https://(groups\.google\.com|www\.gstatic\.com|ssl\.gstatic\.com|fonts\.gstatic\.com|fonts\.googleapis\.com|[a-z0-9-]+\.googleusercontent\.com|www\.google\.com/(js|images)|apis\.google\.com)/')
async def expand(pg):
    for _ in range(12):
        clicked = 0
        for sel in ['[aria-label*="Show trimmed content"]', 'main [role="button"][aria-expanded="false"]', 'main [aria-label*="more message"]']:
            for loc in await pg.locator(sel).all():
                try:
                    if await loc.is_visible(): await loc.click(timeout=2000); clicked += 1; await pg.wait_for_timeout(300)
                except Exception: pass
        if not clicked: return
        await pg.wait_for_load_state("networkidle")
async def main():
    (OUT / "threads").mkdir(parents=True, exist_ok=True); (OUT / "attachments").mkdir(exist_ok=True)
    async with async_playwright() as p:
        b = await p.chromium.launch(channel="chrome", headless=True)
        ctx = await b.new_context()
        async def route(r):
            await (r.continue_() if ALLOW.match(r.request.url) else r.abort())
        await ctx.route("**/*", route)
        pg = await ctx.new_page()
        await pg.goto(GROUP, wait_until="networkidle")
        (OUT / "listing.html").write_text(await pg.content())
        (OUT / "listing.txt").write_text(await pg.inner_text("body"))
        ids = await pg.eval_on_selector_all('a[href*="/c/"]', 'as => [...new Set(as.map(a => a.getAttribute("href").match(/\\/c\\/([A-Za-z0-9_-]+)/)[1]))]')
        index = []
        for cid in ids:
            url = f"{GROUP}/c/{cid}"
            await pg.goto(url, wait_until="networkidle"); await expand(pg)
            title = (await pg.title()).removesuffix(" - Google Groups")
            html = await pg.content(); txt = await pg.inner_text("main") if await pg.locator("main").count() else await pg.inner_text("body")
            (OUT / "threads" / f"{cid}.html").write_text(html); (OUT / "threads" / f"{cid}.txt").write_text(f"{title}\n{url}\n\n{txt}")
            hrefs = await pg.eval_on_selector_all('a[href]', 'as => as.map(a => a.href)')
            att = sorted({h for h in hrefs if ('attach' in h or 'googleusercontent' in h) and ALLOW.match(h)})
            got = []
            for i, h in enumerate(att):
                try:
                    resp = await ctx.request.get(h)
                    if resp.ok:
                        body = await resp.body(); cd = resp.headers.get("content-disposition", "")
                        m = re.search(r'filename\*?=(?:UTF-8\'\')?"?([^";]+)', cd); name = m.group(1) if m else f"{cid}-{i}"
                        fn = f"{cid}--{re.sub(r'[^A-Za-z0-9._-]', '_', name)}"; (OUT / "attachments" / fn).write_bytes(body)
                        got.append({"url": h, "file": f"attachments/{fn}", "bytes": len(body), "sha256": hashlib.sha256(body).hexdigest()})
                except Exception as e: got.append({"url": h, "error": str(e)[:120]})
            index.append({"id": cid, "title": title, "url": url, "text_chars": len(txt), "attachments": got})
            print(cid, len(txt), len(got), title[:70], flush=True)
            await pg.wait_for_timeout(1500)
        (OUT / "index.json").write_text(json.dumps({"group": GROUP, "fetched": datetime.datetime.now().astimezone().isoformat(timespec="seconds"),
            "method": "Playwright, system Chrome headless, fresh empty profile, host allow-list", "threads": index}, indent=1, ensure_ascii=False))
        await b.close()
asyncio.run(main())
