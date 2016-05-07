module SyntaxHelper

  # For Syntax Highlight Function
  # create a custom renderer that allows highlighting of code blocks
  class HTMLwithPygments < Redcarpet::Render::HTML

    def initialize(extensions = {})
      super extensions.merge(link_attributes: { target: "_blank" } )
    end

    # def block_code(code, language)
    #   sha = Digest::SHA1.hexdigest(code)

    #   # fetchは code-[language]-[sha]がキャッシュに保存されていた場合
    #   Rails.cache.fetch ["code", language, sha].join('-') do
    #     Pygments.highlight(code, lexer: language, options: {class: "code", linespans: "line"})
    #   end
    # end

    def block_code(code, language)
      sha = Digest::SHA1.hexdigest(code)
      # fetchは code-[language]-[sha]がキャッシュに保存されていた場合
      Rails.cache.fetch ["code", language, sha].join('-') do
        if language=="mathjax"
          code = "<script type=\"math/tex; mode=display\">\n#{code}\n</script>"
        end
        Pygments.highlight(code, lexer: language, options: {class: "code", linespans: "line"})
      end
    end

  def codespan(code)
    if code[0] == "$" && code[-1] == "$"
      "<script type=\"math/tex\">#{code[1...-1]}</script>"
    elsif code[0..1] == "\\(" && code[-2..-1] == "\\)"
      "<script type=\"math/tex\">#{code[2...-2]}</script>"
    else
      "<code>#{code}</code>"
    end
  end

end

  def markdown(text)
    renderer = HTMLwithPygments.new(hard_wrap: true, filter_html: false)
    options = {
      autolink: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      lax_html_blocks: true,
      strikethrough: true,
      superscript: true,
      underline: true,
      highlight: true,
      footnotes: true,
      tables: true
    }
    Redcarpet::Markdown.new(renderer, options).render(text).html_safe
  end

end
