class Slugifier
  def self.construct(title, first_name, last_name, state_code)
    [construct_chamber(title), state_code, first_name.downcase, last_name.downcase].join('-')
  end

  def self.construct_chamber(title)
    pieces = title.split(" ")
    us = pieces.first[0] == "U" ? "us" : "state"
    sen = pieces.last[0..2].downcase
    "#{us}-#{sen}"
  end

  def self.deconstruct(string)
    raise ArgumentError if string.nil?


    {
      chamber: chamber(string),
      state: state(string),
      know_who_id: know_who_id(string)
    }
  end

  def self.chamber(string)
    array = get_array(string)
    if array[0..1] == ["us", "rep"]
      "US House"
    elsif array[0..1] == ["us", "sen"]
      "US Senate"
    elsif array[0..1] == ["state", "sen"]
      "State Senate"
    elsif array[0..1] == ["state", "rep"]
      "State House"
    end
  end

  def self.state(string)
    get_array(string)[2]
  end

  def self.know_who_id(string)
    slugged = Slug.find_by_path(string)
    if slugged.nil?
      LeaderFinder.send(snake_case(chamber(string)), state(string))
    end
    slugged = Slug.find_by_path(string)
    return slugged.know_who_id if !slugged.nil?
  end

  def self.snake_case(string)
    string.delete(" ").snakecase
  end

  def self.get_array(string)
    string.split("-")
  end
end
