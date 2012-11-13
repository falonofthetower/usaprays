module Refinery
  module Justices
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Justices

      engine_name :refinery_justices

      initializer "register refinerycms_justices plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "justices"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.justices_admin_justices_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/justices/justice',
            :title => 'name'
          }
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Justices)
      end
    end
  end
end
