require 'digest'

# renders the requested path with a hash appended to the query string to help bust caches

class GetCacheBustedAsset < Liquid::Tag
  @@BASEPATH = "assets"
  @@HASHLENGTH = 16
  @@COMPATIBLE_TAGS = [ "scssasset", "asset" ]

  def initialize(tag_name, assetPath, tokens)
    super

    raise "Relative paths are not supported" unless assetPath[0] == "/"

    assetPath = assetPath.strip # remove trailing space

    @assetPath = File.join(@@BASEPATH,assetPath)
    raise "Invalid file '%s'" % @assetPath unless File.exist? @assetPath

    @hash = Digest::SHA256.hexdigest(File.read(@assetPath))[0,@@HASHLENGTH]

    if tag_name == "scssasset"
      @assetPath = @assetPath.strip.gsub(/\.scss$/, ".css")
    end

    raise "Unknown tag '%s'" % tag_name unless @@COMPATIBLE_TAGS.include? tag_name
  end

  def render(context)
    return "/%s?%s" % [@assetPath, @hash]
  end

  def self.get_tags()
    return @@COMPATIBLE_TAGS
  end
end

GetCacheBustedAsset.get_tags().each do |tag|
  Liquid::Template.register_tag(tag, GetCacheBustedAsset)
end
