class LeaderFormatter
  def initialize(leader)
    raise ArgumentError if leader.nil?

    @leader = leader
    save
  end

  def save
    require 'pry'; binding.pry;
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
    @leader["UID"]
  end

  def name
    @leader["LEGALNAME"]
  end

  def first_name
    @leader["FIRSTNAME"]
  end

  def last_name
    @leader["LASTNAME"]
  end

  def title
    @leader["PREFIX"]
  end

  def href
    "//states/#{state_code.downcase}/leaders/#{slug}"
  end

  def photo_src
    @leader["PHOTOFILE"]
  end

  def prefix_name
    "#{title} #{name}"
  end

  def state_code
    @leader["STATECODE"]
  end

  def district_code
    @leader["DISTRICT"]
  end

  def district
    "#{district_code} - #{state_code}"
  end

  def spouse
    @leader["SPOUSE"]
  end

  def website
    @leader["WEBSITE"]
  end

  def email
    @leader["EMAIL"]
  end

  def twitter
    @leader["FACEBOOK"]
  end

  def facebook
    @leader["FACEBOOK"]
  end

  def webform
    @leader["WEBFORM"]
  end
end
