compiledSite = "./_site"

task :htmlproofer do
  require "html-proofer"

  raise "You must build the site before running this task" unless Dir.exist?(compiledSite)

  HTMLProofer.check_directory(compiledSite, {}).run
end
