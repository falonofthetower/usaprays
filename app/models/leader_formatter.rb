class LeaderFormatter
  def initialize(leader)
    raise ArgumentError if leader.nil?

    @leader = leader
    save
  end

  def save
    slug_map = (Slug.find_by_know_who_id know_who_id or Slug.new)
    slug_map.path = slug
    slug_map.know_who_id = know_who_id
    slug_map.save
  end

  def to_hash
    {
      "name" => name,
      "title" => title,
      "href" => href,
      "photo_src" => photo_src,
      "prefix_name" => prefix_name,
      "state_code" => state_code,
      "district" => district,
      "spouse" => spouse,
      "website" => website,
      # "email" => email,
      "twitter" => twitter,
      "facebook" => facebook,
      "webform" => webform,
      "slug" => slug
    }
  end

  def slug
    Slugifier.construct(title, first_name, last_name, state_code)
    # pieces = title.split(" ")
    # us = pieces.first.downcase
    # sen = pieces.last[0..2].downcase
    # [us, sen, first_name.downcase, last_name.downcase].join('-')
  end

  def know_who_id
    @leader["PersonInformation"]["PersonID"]
  end

  def name
    "#{first_name} #{last_name}"
  end

  def first_name
    @leader["PersonInformation"]["FirstName"] || ""
  end

  def last_name
    @leader["PersonInformation"]["LastName"] || ""
  end

  def title
    case @leader["PositionInformation"]["Title"]
    when "State Senator"
      "#{@leader["PositionInformation"]["State"]} Senator"
    when "State Representative"
      "#{@leader["PositionInformation"]["State"]} Representative"
    else
      @leader["PositionInformation"]["Title"]
    end
  end

  def href
    "//states/#{state_code.downcase}/leaders/#{slug}"
  end

  def photo_src
    @leader["PersonInformation"]["PhotoUrl"]
  end

  def prefix_name
    "#{title} #{first_name} #{last_name}"
  end

  def state_code
    @leader["PositionInformation"]["StateCode"].downcase
  end

  def district_code
    @leader["PositionInformation"]["DistrictCode"][2..-1]
  end

  def district
    "#{district_code} - #{state_code}"
  end

  def spouse
    begin
      @leader["Biography"].gsub(/[\r]/, " XMEN").match(/Spouse Name:(.*)[ XMEN]/)[0].to_s.split("XMEN").first[13..-1]
    rescue NoMethodError
      nil
    end
  end

  def website
    @leader["WebSocialMedia"]["Website"]
  end

  def email
    @leader["WebSocialMedia"]["Email"]
  end

  def twitter
    @leader["WebSocialMedia"]["Twitter"]
  end

  def facebook
    @leader["WebSocialMedia"]["Facebook"]
  end

  def webform
    @leader["WebSocialMedia"]["Webform"]
  end
end
