Refinery::Core::Engine.routes.append do

  # Frontend routes
  namespace :executives do
    resources :executives, :path => '', :only => [:index, :show]
  end

  # Admin routes
  namespace :executives, :path => '' do
    namespace :admin, :path => 'refinery' do
      resources :executives, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
