compiledSitePath = "./site/_site"

task :htmlproofer do
  require "html-proofer"

  raise "You must build the site before running this task" unless Dir.exist?(compiledSitePath)

  options = {
    cache: {
      timeframe: {
        external: "1w"
      }
    },
    # /Plugins.html can misbehave here in case of GitHub README.md anchors
    #     because of User-Agent handling, and changing User-Agent causes other
    #     unwanted side effects
    check_external_hash: false,
    # status code 418 is sometimes returned by webservers performing anti-scrape methods, so it
    # should assume the resource exists instead
    ignore_status_codes: [ 418 ],
  }

  HTMLProofer.check_directory(compiledSitePath, options).run
end
