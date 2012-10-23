class MailListSegment
  attr_accessor :state, :cycle

  def initialize(state, cycle)
    @state = state
    @cycle = cycle
  end

  def name
    "#{state.code}-#{cycle}"
  end

  def public_name
    "#{state.name} #{cycle} Prayer List".titlecase
  end

  def state_code
    @state.code
  end

  def create
    MailChimp.new.create_segment(name)
  end
end
