class GetOTDExecutableTag < Liquid::Tag
  @@EXTENSIONS = {
    "windows" => ".exe",
    "linux" => "",
    "macos" => ".app"
  }

  def initialize(tag_name, hybrid, tokens)
    super
    # hybrid is in the form of ${OS}-${exeBase}
    hybridTmp = hybrid.strip.split('-', 2)
    # windows/linux/macos
    @os = hybridTmp[0]
    @extension = @@EXTENSIONS[@os]
    raise "Unspecified extension for OS: %s" % @os if @extension == nil

    # nil/console/daemon/ui, the OpenTabletDriver executable without extension
    @exeBase = hybridTmp[1]
    if (@exeBase == nil || @exeBase == "") && @os != "macos"
      raise "exebase-less not supported for Windows and Linux"
    end
    if @exeBase != nil && @exeBase != "" && @os == "macos"
      raise "exebase is not supported for MacOS"
    end
  end

  def render(context)
    executables = context.registers[:site].data["executables"]

    return getName(executables)
  end

  def getName(executables)
    base = executables["_base"]

    rv = base
    rv += getMiddle(executables)
    rv += @extension

    return rv
  end

  def getMiddle(executables)
    rv = ""

    if @exeBase != nil and @exeBase != ""
      # check if we have an override for @os-@exebase
      if (overrides = executables["_overrides"]).has_key?(@os) &&
          overrides[@os].has_key?(@exeBase)
        rv = ".%s" % overrides[@os][@exeBase]
      else
        unless executables.has_key?(@exeBase)
          raise "Missing key '%s' in executables data" % @exeBase
        end
        rv = ".%s" % executables[@exeBase]
      end
    end

    return rv
  end
end

Liquid::Template.register_tag('otdexe', GetOTDExecutableTag)
