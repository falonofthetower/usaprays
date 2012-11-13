module Refinery
  module Executives
    module Admin
      class ExecutivesController < ::Refinery::AdminController

        crudify :'refinery/executives/executive',
                :title_attribute => 'name', :xhr_paging => true

      end
    end
  end
end
