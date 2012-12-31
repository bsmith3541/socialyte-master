module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Socialyte"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

   def facebook_like
     #content_tag :iframe, nil, :src => "http://www.facebook.com/plugins/like.php?href=#{CGI::escape(request.url)}&layout=standard&show_faces=false&width=50&action=like&font=arial&colorscheme=light&height=80", :scrolling => 'no', :frameborder => '10', :allowtransparency => true, :id => :facebook_like
     content_tag :iframe, nil, :src => "http://www.facebook.com/plugins/like.php?app_id=212715052108961&amp;href=PAGEURL;send=false&amp;layout=button_count&amp;width=50&amp;show_faces=false&amp;action=like&amp;colorscheme=light&amp;font&amp;height=21", :scrolling => "no", :frameborder => "0", :style => "border: solid white; overflow:hidden; width:100px; height:30px;", :allowTransparency => "true", :id => :facebook_like
   end
end