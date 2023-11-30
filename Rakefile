compiledSite = "./_site"

task :htmlproofer do
  require "html-proofer"

  raise "You must build the site before running this task" unless Dir.exist?(compiledSite)

  options = {
    cache: {
      timeframe: {
        external: "1w"
      }
    }
  }

  HTMLProofer.check_directory(compiledSite, options).run
end
