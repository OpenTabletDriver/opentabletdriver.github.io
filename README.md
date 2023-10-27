# opentabletdriver.github.io
The next version of OpenTabletDriver.Web

# Local Development

## Requirements

- `rubygems`

## Steps

```bash
$ gem install jekyll bundler
$ cd <website root> # (currently git root)
$ git submodule init # submodules contain plugin data
$ git submodule update
$ bundle install
$ bundle exec jekyll serve --livereload
```

# FAQ

## How do I add an wiki entry?

Add or edit the appropriate markdown file in the appropriate `_wiki/` folder.

## I can't find the "index" page for a page! (e.g. site/Wiki)

Single-path URL's are permalinked to files in `_sections`
