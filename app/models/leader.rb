class Leader < Hashie::Mash

  def setup(data)
    data.each do |key, value|
      self[key] = value
    end
  end

  def state
    UsState.new('in')
  end

  def birthday
    if born_on
      born_on.strftime("#B %e")
    end
  end

  def district_residence
    [district, residence].reject{|i|i.blank?}.join(" - ")
  end

  def name
    self['name'] || ""
  end

  def title 
    self['title'] || ""
  end

  def email 
    self['email'] || ""
  end

  def photo_src
    self['photo_src'] || "placeholder.jpg"
  end

end

