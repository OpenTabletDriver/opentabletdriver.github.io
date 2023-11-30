compiledSitePath = "./_site"

task :htmlproofer do
  require "html-proofer"
  require_relative "rubylib/hrefcheck"

  raise "You must build the site before running this task" unless Dir.exist?(compiledSitePath)

  options = {
    cache: {
      timeframe: {
        external: "1w"
      }
    }
  }

  options = HTMLProofer::Configuration.generate_defaults(options)
  options[:checks] = options[:checks].dup.append("HrefCheck")

  HTMLProofer.check_directory(compiledSitePath, options).run
end
