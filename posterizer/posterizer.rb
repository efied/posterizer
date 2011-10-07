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

      if key["Comments"]
        html_dump = ""
        html_dump << '<div id="post_commentarea_71944530"><div class="posterousListComments"><div class="commentunit"><div class="comment_spacer">&nbsp;</div><div class="comment"><div class="comment_hide_button"><a>&laquo;&nbsp;Hide</a></div><h4>Recent comments</h4></div></div><div id="pcomment_comments_71944530">'
        value.each do |comment|
          html_dump << '<div class="commentunit" id="comment_9722302"><a name="pcomment_commentunit_9722302"></a><div class="comment_spacer">&nbsp;</div><div class="comment"><div class="comment_avatar"><a href="http://posterous.com/people/gthkGokKm"><img src="http://files.posterous.com/user_profile_pics/1467464/jess_field_thumb.jpg" class="profile_border" /></a></div><div class="commentname"><a href="#">' + comment["OwnerName"] + '</a> said...</div>' + comment["Content"] + '<ul class="mini_commands" id="mini_commands2_9722302"><li><a href="#">Remove comment</a></li></ul></div></div>'
        end
        html_dump << '<div id="pcomment_comments_new_71944530"></div></div></div><div class="posterousAddNewComment"><div class="commentunit"><div class="comment_spacer">&nbsp;</div><div class="comment"><h4>Leave a comment</h4></div></div><form id="pcomment_form_71944530" method="post"><div style="margin:0;padding:0;display:inline"><input name="authenticity_token" type="hidden" value="/u1+uzXxIAR7A4Ef9LBgRYe1UJ5LQoZrvKJPD16pD3A=" /></div><div class="commentunit"><div class="comment_spacer">&nbsp;</div><div class="comment_value"><div><textarea class="comment_body" cols="38" id="pcomment_newbody_71944530" name="comment[body]" rows="2"></textarea></div><input id="push_fbfeed_71944530" name="push_fbfeed_71944530" type="checkbox" /><label for="push_fbfeed_71944530" class="posterous_external_site_label">Post comment to Facebook</label><br/></div></div><div class="commentunit"><div class="comment_spacer">&nbsp;</div><div class="comment_value"><input id="comment_concise" name="comment[concise]" type="hidden" value="true" /><input id="posterous_submit_71944530" name="commit" type="submit" value="Comment" /><img alt="Loading..." height="14" id="pcomment_submit_loading_71944530" src="http://assets3.posterous.com/images/loading.gif?1317938903" style="display:none" width="14" /></div></div></form></div></div>'
        post_block.gsub!("{block:Comments/}", html_dump)
      end

      post_block.gsub!("{#{key}}", value.to_s)
    end

    html.gsub(block_matcher, post_block)
  end
end
