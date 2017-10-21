class ImportRecord < ActiveRecord::Base
  attr_accessible :timestamp, :leader_count, :upload_dates
end
