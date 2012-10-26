class Leader < Hashie::Mash

  def setup(data)
    data.each do |key, value|
      self[key] = value
    end
  end

  # A leader that doesnt hit the network for testing
  def self.ron_paul
    dr_paul = Leader.new
    dr_paul.setup(JSON.parse('{"slug":"us-rep-ron-paul","name":"Ron Paul","title":"US Representative","href":"http://localhost:8081/states/tx/leaders/us-rep-ron-paul","photo_src":"Paul_Ron_159084.jpg","prefix_name":"US Rep. Ron Paul","state_code":"tx","born_on":null,"district":"14","residence":"Lake Jackson, TX","spouse":"Carol Wells","family":"5 children; 18 grandchildren","website":"http://paul.house.gov/","email":"rep.paul@mail.house.gov","twitter":"http://twitter.com/repronpaul","facebook":"http://www.facebook.com/pages/Congressman-Ron-Paul/181620931870421","webform":"http://forms.house.gov/paul/webforms/issue_subscribe.html"}'))
    dr_paul
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

