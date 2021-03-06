module Refinery
  module Justices
    class Justice < Refinery::Core::BaseModel
      self.table_name = 'refinery_justices'

      attr_accessible :name, :photo_id, :title, :spouse, :position

      acts_as_indexed :fields => [:name, :title, :spouse]

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

      def district_residence; ""; end
      def website; ""; end
      def webform; ""; end
      def twitter; ""; end
      def facebook; ""; end
      def email; ""; end
    end
  end
end
