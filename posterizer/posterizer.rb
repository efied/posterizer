require 'yaml'

class Posterizer

  def self.parse(html)
    settings = YAML::load(File.read('settings.yml'))

    html = parse_post_block(html, settings)

    settings.each do |key, value|
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

    html_dump = '<div class="editbox"><ul class="mini_commands posterous_edit_box posterous_edit_box_hidden"><li><a href="#">Edit</a></li><li><a href="#">Delete</a></li><li><a href="#">Tags</a></li><li><a href="#">Autopost</a></li></ul></div>'
    post_block.gsub!("{block:EditBox/}", html_dump)

    settings["Post"][0].each do |key, value|
      if key == "Timestamp"
        post_date = Time.at(value.to_i)
        post_block.gsub!("{DayOfMonth}", post_date.day.to_s)
        post_block.gsub!("{ShortMonth}", post_date.strftime("%b"))
      end
      post_block.gsub!("{#{key}}", value.to_s)
    end

    html.gsub(block_matcher, post_block)
  end
end
