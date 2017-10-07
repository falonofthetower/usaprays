module ApplicationHelper
  def glyph_link_to(glyph, link, title="")
    return "" if link.blank?
    glyph_path = "http://www.pray1tim2.org/assets/glyph/glyphicons_#{glyph}.png" 
    link_to(image_tag(glyph_path), link, title: title)
  end

  def state_nav_li(text, path, icon, active)
    icon_class = active ? "icon-#{icon} icon-white" : "icon-#{icon}"
    li_class = active ? "active" : ""
    i = content_tag('i', '', class: icon_class)
    link = link_to(path) do
      concat(i)
      concat(" ")
      concat(text)
    end
    content_tag('li', link, class: li_class)
  end

  def asset_url asset
    "#{request.protocol}#{request.host_with_port}#{asset_path(asset)}"
  end
end
