# Takes an input token and extracts information based off of Jekyll's site.data.@@COLLECTION_NAME
#
# Data structure expected, all values are strings:
# {
#   @@BASE, # basename
#   @@OVERRIDES: {
#     os: { exebases }, # anything here is optional
#   },
#   exebases # (e.g. `"console": "Console"`)
# }
#
# Missing keys or empty values (unless in overrides) will throw an exception
# The input must match the regex "(.+?)-(.+)"
# where \1 is your operating system
#   and \2 is your exebase
#
### Example input vs outputs with reference data:
# windows-ui      => "OpenTabletDriver.UX.Wpf.exe"
# linux-daemon    => "OpenTabletDriver.Daemon"
# macos-extractor => "OpenTabletDriver.app"

class GetOTDExecutableTag < Liquid::Tag
  @@EXTENSIONS = {
    "windows" => ".exe",
    "linux" => "",
    "macos" => ""
  }

  @@BASE            = "_base"
  @@OVERRIDES       = "_overrides"
  @@COLLECTION_NAME = "executables"

  def initialize(tag_name, input, tokens)
    super

    # hybrid is in the form of ${OS}-${exeBase}
    inputTokens = input.strip.split('-', 2)

    # windows/linux/macos
    @os = inputTokens[0]
    @extension = @@EXTENSIONS[@os]
    raise "Incompatible OS: %s" % @os if @extension == nil

    # console/daemon/ui/extractor, the OpenTabletDriver executable without extension
    @exeBase = inputTokens[1]
    raise "Must define an exeBase ('${os}-${exebase}')" if (@exeBase == nil || @exeBase == "")
  end

  def render(context)
    executables = context.registers[:site].data[@@COLLECTION_NAME]

    return getName(executables)
  end

  def getName(executables)
    base = executables[@@BASE]

    rv = base
    rv += getMiddle(executables)
    rv += @extension

    return rv
  end

  def getMiddle(executables)
    rv = ""

    if @exeBase != nil and @exeBase != ""
      # check if we have an override for @os-@exebase
      if (overrides = executables[@@OVERRIDES]).has_key?(@os) &&
          overrides[@os].has_key?(@exeBase)
        rv = ".%s" % overrides[@os][@exeBase]
      else
        unless executables.has_key?(@exeBase) && executables[@exeBase] != ""
          raise "Invalid key '%s' in executables data" % @exeBase
        end

        rv = ".%s" % executables[@exeBase]
      end
    end

    return rv
  end
end

Liquid::Template.register_tag('otdexe', GetOTDExecutableTag)
