Jekyll::Hooks.register :site, :pre_render do |site|
  require "rouge"

  class MoreJSLexer < Rouge::RegexLexer
    title "OTD Output"
    desc "Used for wrapping OpenTabletDriver log output"
    tag 'otdlog'

    state :root do
      rule %r/#.*$/, Comment
      rule %r/.+/, Text
    end
  end
end
