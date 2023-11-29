#!/bin/bash
#
# usage:
# ./$0 "jekyll root" "html root"
#
# for use in CI to ensure some predetermined paths still exist

set -e # exit on any error

if [[ -z "$1" || -z "$2" ]]; then
  echo "Usage: $0 JEKYLL_ROOT HTML_ROOT"
  exit 127
fi

JEKYLL_ROOT="$1"
HTML_ROOT="$2"

# associative array for Jekyll -> HTML mapping
declare -A JEKYLL_FOLDERS_TO_AUTODETECT
JEKYLL_FOLDERS_TO_AUTODETECT["_wiki"]="Wiki"

# array of expected files in addition to what we'll autodetect
HARD_DEFINES=(
    "Plugins.html"
    "Tablets.html"
    "Wiki.html"
    "favicon.ico"
    "Wiki/Install/Windows.html"
    "Wiki/Install/Linux.html"
    "Wiki/Install/MacOS.html"
    "Wiki/FAQ/Windows.html"
    "Wiki/FAQ/Linux.html"
    "Wiki/FAQ/MacOS.html"
  )

# sanity checks
if [ ! -f "$JEKYLL_ROOT"/_config.yml ]; then
  echo "Missing Jekyll config in '$1'"
  exit 1
fi

if [ ! -f "$HTML_ROOT"/index.html ]; then
  echo "Missing index file in '$2'. You must build the site yourself first."
  exit 1
fi

# function definitions
fileExists() {
  local file="$1"

  if [ ! -f "$file" ]; then
    echo -e "FAIL\nFile '$file' does not exist"
    exit 1
  fi
}

# hard defines
printf "Checking ${#HARD_DEFINES[@]} hard defines... "

for file in "${HARD_DEFINES[@]}"; do
  fileExists "$HTML_ROOT"/"$file"
done

echo OK

# mapping

for folderKey in "${!JEKYLL_FOLDERS_TO_AUTODETECT[@]}"; do
  jekyllSubFolder="$folderKey"
  htmlFolder="${JEKYLL_FOLDERS_TO_AUTODETECT[$folderKey]}"

  # get new name based off old names
  cd "$JEKYLL_ROOT"/"$jekyllSubFolder"
  mapfile -t htmlFiles < <(find * -type f -iname "*.md" | sed 's/\.md$/.html/')
  cd - > /dev/null
  printf "Probing ${#htmlFiles[@]} files in Jekyll folder '$jekyllSubFolder'... "

  for file in "${htmlFiles[@]}"; do
    fileExists "$HTML_ROOT"/"$htmlFolder"/"$file"
  done
  echo "OK"
done

echo "All OK"
