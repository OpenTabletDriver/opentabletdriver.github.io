require 'html-proofer'

class HrefCheck < ::HTMLProofer::Check
  def run
    @html.css("a").each do |node|
      @link = create_element(node)

      next if @link.ignore?

      add_failure("#{@link.line} has empty href") if @link.href.empty?
    end
  end
end
