module Refinery
  module Justices
    class Justice < Refinery::Core::BaseModel
      self.table_name = 'refinery_justices'

      attr_accessible :name, :photo_id, :title, :spouse, :position

      acts_as_indexed :fields => [:name, :title, :spouse]

      validates :name, :presence => true, :uniqueness => true

      belongs_to :photo, :class_name => '::Refinery::Image'

      def photo_src
        if self.photo.url
          logger.info "[[[ In photo_src for Justices - #{self.photo.url} ]]]"
          #'http://' + Psp::Application.config.host_name + self.photo.url if self.photo
          self.photo.url
        else
          "placeholder.jpg"
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
