module Refinery
  module Executives
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Executives

      engine_name :refinery_executives

      initializer "register refinerycms_executives plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "executives"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.executives_admin_executives_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/executives/executive',
            :title => 'name'
          }
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Executives)
      end
    end
  end
end
