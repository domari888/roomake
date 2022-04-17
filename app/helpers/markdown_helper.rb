module MarkdownHelper
  def markdown(text)
    markdown = Redcarpet::Markdown.new(html_renderer, markdown_extentions)
    markdown.render(text).html_safe
  end

  private

  def html_renderer
    Redcarpet::Render::HTML
  end

  def markdown_extentions
    {
      no_intra_emphasis: true,
      tables: true,
      autolink: true,
      fenced_code_blocks: true,
      space_after_headers: true,
      hard_wrap: true,
      xhtml: true,
      lax_html_blocks: true,
      strikethrough: true
    }
  end
end
