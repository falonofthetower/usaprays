class Leader < ActiveRecord::Base
  attr_accessible :uid, :legalname, :firstname, :lastname, :prefix, :photofile,  :statecode, :district, :spouse, :website, :twitter, :email, :facebook, :webform, :chamber, :legtype, :birthyear, :birthmonth, :birthdate, :residence, :district, :midname, :import_timestamp

  def before_save
    slug_map = (Slug.find_by_know_who_id self.uid or Slug.new)
    slug_map.path = slug
    slug_map.know_who_id = know_who_id
    slug_map.save
  end

  def slug
    Slugifier.construct(title, chamber, firstname, lastname, statecode)
  end

  def state
    UsState.new(statecode)
  end

  def birthday
    "#{birthmonth}-#{birthdate}-#{birthyear}"
  end

  def district_residence
    [district, residence].reject{|i|i.blank?}.join(" - ")
  end

  def shortname
    if legalname.length <= 19
      legalname
    elsif lastname.length <= 19
      "#{firstname.first}. #{lastname}"
    else
      "#{firstname} #{lastname.first}."
    end
  end

  def name
    CGI.unescapeHTML self.legalname || ""
  end

  def title
    self.prefix || ""
  end

  def photo_src
    path =
      case legtype
      when "SL"
        "photos/#{legtype}/#{statecode}/#{chamber}/#{photofile}"
      when "FL"
        "photos/#{legtype}/#{chamber}/#{photofile}"
      end

    return path if path.end_with?("jpg")
    return "placeholder.jpg"
  end
end
