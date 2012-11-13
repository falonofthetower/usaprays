Refinery::Core::Engine.routes.append do

  # Frontend routes
  namespace :justices do
    resources :justices, :path => '', :only => [:index, :show]
  end

  # Admin routes
  namespace :justices, :path => '' do
    namespace :admin, :path => 'refinery' do
      resources :justices, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
