require 'yaml'

class Posterizer

  def self.parse(html)
    settings = YAML::load(File.read('settings.yml'))

    html = parse_post_block(html, settings)

    settings.each do |key, value|
      #next if key == "Posts"
      html.gsub!("{#{key}}", value.to_s)
    end

    html.gsub!("{PostViews}", (rand(100)+1).to_s)
    html.gsub!("{block:Pagination/}", %Q{<div class="pagination"><span class="disabled prev_page">&laquo; Previous</span> <span class="current">1</span> <a href="http://jessmartin.posterous.com?page=2" rel="next">2</a> <a href="http://jessmartin.posterous.com?page=2" class="next_page" rel="next">Next &raquo;</a></div>})
    html
  end

  def self.parse_post_block(html, settings)
    block_matcher = /\{block:Posts\}(.*)\{\/block:Posts\}/m
    return html unless html.match(block_matcher)
    post_block = html.match(block_matcher)[1]

    settings["Post"][0].each do |key, value|
      post_block.gsub!("{#{key}}", value.to_s)
    end

    html.gsub(block_matcher, post_block)
  end
end
