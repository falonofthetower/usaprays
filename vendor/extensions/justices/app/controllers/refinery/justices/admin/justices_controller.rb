module Refinery
  module Justices
    module Admin
      class JusticesController < ::Refinery::AdminController

        crudify :'refinery/justices/justice',
                :title_attribute => 'name', :xhr_paging => true

      end
    end
  end
end
