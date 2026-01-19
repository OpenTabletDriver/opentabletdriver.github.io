#!/bin/bash
#
# usage:
# ./$0 "jekyll root" "html root"
#
# for use in CI to ensure absolute links aren't being written to html files
#
set -e # exit on any error

if [[ -z "$1" ]]; then
  echo "Usage: $0 HTML_ROOT"
  exit 127
fi

HTML_ROOT="$1"

! grep -REi 'https?://(www.)?opentabletdriver.net' \
  --exclude=sitemap.xml \
  "${HTML_ROOT}" \
  | grep -vE 'canonical'

rv="$?"

if [ "$rv" -eq 0 ]; then
  echo "OK"
else
  echo "FAIL"
fi
