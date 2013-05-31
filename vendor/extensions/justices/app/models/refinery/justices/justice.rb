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
          # Ex: http://pray1tim2.org/system/refinery/images/2013/01/27/08_37_46_241_220px_File_Official_roberts_CJ_cropped.jpg
          'http://pray1tim2.org/system/refinery/images/' + photo.image_uid
        else
          'http://pray1tim2.org/images/placeholder.jpg'
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
