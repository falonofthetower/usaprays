module ApplicationHelper
  def glyph_link_to(glyph, link)
    return "" if link.blank?
    glyph_path = "glyph/glyphicons_#{glyph}.png" 
    link_to(image_tag(glyph_path), link)
  end
end
