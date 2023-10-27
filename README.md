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
