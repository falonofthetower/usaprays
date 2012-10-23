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

  def family_info
    "#{spouse}\n#{family}".strip
  end

end

