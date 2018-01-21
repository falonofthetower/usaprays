module Refinery
  module Executives
    class Executive < Refinery::Core::BaseModel
      self.table_name = 'refinery_executives'

      attr_accessible :name, :photo_id, :title, :spouse, :website, :webform, :email, :twitter, :facebook, :state_code, :position

      acts_as_indexed :fields => [:name, :title, :spouse, :website, :webform, :email, :twitter, :facebook, :state_code]

      validates :name, :presence => true, :uniqueness => true

      belongs_to :photo, :class_name => '::Refinery::Image'

      def photo_src
        if photo && photo.image_uid
          dragonfly = Dragonfly[:images].fetch(photo.image_uid)
          "http://#{ENV['CDN_URL']}/system/images/#{dragonfly.url}/#{photo.image_name}"
        else
          'http://www.pray1tim2.org/images/placeholder.jpg'
        end
      end

      def district_residence
        ""
      end
    end
  end
end
