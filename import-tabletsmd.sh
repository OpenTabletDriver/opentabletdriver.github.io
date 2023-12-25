#!/bin/bash

BASEDIR="$(dirname "$0")"
TABLETS_MD_LOC="${TABLETS_MD_LOC:="${BASEDIR}/../opentabletdriver/TABLETS.md"}"

if [ -z "$TABLETS_MD_LOC" ]; then
  for reponame in opentabletdriver OpenTabletDriver; do
    tmp="${reponame}"/TABLETS.md

    if [ -f "$tmp" ]; then
      TABLETS_MD_LOC="$tmp"
      break
    fi
  done
fi

if [ -z "$TABLETS_MD_LOC" ] || [ ! -f "$TABLETS_MD_LOC" ]; then
  echo "Can't find TABLETS.md, bailing"
  exit 1
fi

cp -i "$TABLETS_MD_LOC" "${BASEDIR}"/site/_includes/tablets.md || exit $?
