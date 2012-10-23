class Subscription
  include ActiveModel::Validations

  validates_presence_of :email
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i

  attr_accessor :email, :name, :state_code, :cycle

  def initialize(attributes = {})
    attributes.each do |key, value|
      send("#{key}=", value)
    end
  end

  def mail_chimp
    @mail_chimp ||= MailChimp.new
  end

  def state
    @state ||= UsState.new(state_code)
  end

  def segment
    @segment ||= MailListSegment.new(state, cycle)
  end

  def save
    if valid?
      mail_chimp.subscribe_to_segment(email, segment.name, name: name)
    else
      false
    end
  end

  def to_model
    self
  end

  def to_key
    new_record? ? nil : [ self.send(self.class.primary_key) ]
  end

  def new_record?() true end
  def destroyed?()  true end
  def persisted?()  false end
end
