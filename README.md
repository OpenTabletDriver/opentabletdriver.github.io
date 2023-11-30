# [opentabletdriver.github.io](https://opentabletdriver.github.io)
*The next version of OpenTabletDriver.Web*

## Local Development

### Requirements

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

### **How do I add a wiki entry?**

To add or edit a wiki entry, modify the appropriate markdown file in the `_wiki/` folder.

### **I can't find the "index" page for a page! (e.g., site/Wiki)**

For pages with single-path URLs (e.g., site/Wiki), they are permalinked to files in the `_sections` folder.

### **How do I update the Rouge highlighter style?**

To update the Rouge highlighter style, use the following command:

```bash
bundle exec rougify style > assets/css/rougehl.css
```

# Contributors to Old OpenTabletDriver.Web

[View Contributors](https://github.com/OpenTabletDriver/OpenTabletDriver.Web/graphs/contributors)

This site has been ported directly from the old repository to Jekyll and may contain code, assets, information, or other contributions by the following individuals:

- [@InfinityGhost](https://github.com/InfinityGhost)
- [@jamesbt365](https://github.com/jamesbt365)
- [@gonX](https://github.com/gonX)
- [@vedxyz](https://github.com/vedxyz)
- [@Hypfer](https://github.com/Hypfer)
- [@TakanashiDavi](https://github.com/TakanashiDavi)
- [@Sublimelime](https://github.com/Sublimelime)
- [@nerd](https://github.com/nerd)
- [@FlafyDev](https://github.com/FlafyDev)
- [@DanisDGK](https://github.com/DanisDGK)
- [@Zyfarok](https://github.com/Zyfarok)
- [@X9VoiD](https://github.com/X9VoiD)
- [@MicrochipQ](https://github.com/MicrochipQ)
- [@vgf89](https://github.com/vgf89)
