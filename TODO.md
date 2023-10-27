# Roadmap (rough order)

- [x] Tablets
- [x] GitHub link
- [x] Discord link
- [x] Changelog (implemented as link)
- [x] Plugins
- [x] Wiki
- [ ] Discuss whether changelog needs to be local, or if the current link is fine
- [x] Front Page
- [ ] Implement OpenTabletDriver/OpenTabletDriver.Web PR's
- [ ] Fix issues on our own repo
- [ ] Ensure feature parity on most pages
  - [x] `/Framework` path (use JS?)
  - [x] `/Release/Download/` path (used in wiki windows install)
  - [x] Code blocks
  - [ ] "Driver Version" text clarity on `/Plugins`
  - [ ] table on /Wiki/Documentation/Logs
- [x] Fix absolute links to use Jekyll syntax (`/Tablets` -> `{% link /Tablets %}` or similar)
  - [x] `_sections/Wiki.md`
- [ ] Hide any "Work in progress" decoration (if any)
- [ ] Ensure local dev env documentation is usable
- [ ] Move DNS
- [ ] Close OpenTabletDriver.Web
- [ ] Write more documentation
- [ ] Move this file to GitHub issues
- [x] Auto-generate links for /Wiki
- [ ] Add linting
-- Stuff like avoiding absolute links (`/Tablets` as opposed to `{% link _section/Tablets.md %}`)
--- input on this welcome
-- lint `<table>` to have `{:.table}`

# Important things to also finalize:

- Auto deploy of TABLETS.md (or change to submodule?)
- Auto update submodules on submodule remote being updated (currently just plugin repo) (via github action?)
- Auto-versioning of latest release of OTD used on frontpage

# Other stuff:

- [ ] Bus factor
- [ ] Discuss Github auto-merge

- Using `{% link %}` for the Release archives results in .html being appended (e.g. Wiki/Install/Linux.md Debian instructions, also MacOS)

