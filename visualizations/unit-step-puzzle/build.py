#!/usr/bin/env python3
"""Wrap page.html (the page as it is published: content only, no document skeleton) into index.html, a standalone local copy."""
import pathlib
d=pathlib.Path(__file__).parent; body=(d/"page.html").read_text()
(d/"index.html").write_text('<!doctype html>\n<html lang="en">\n<head>\n<meta charset="utf-8">\n<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">\n<style>body{margin:0}[hidden]{display:none!important}</style>\n</head>\n<body>\n'+body+'</body>\n</html>\n')
print("wrote index.html", (d/"index.html").stat().st_size, "bytes")
