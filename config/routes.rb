Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'application#main'

  # User Authorization Routes .................................................
  scope '/api/v1' do
    devise_for :users, {
      # custom routes here
      controllers: {
        registrations: 'api/v1/users/registrations',
        sessions: 'api/v1/users/sessions',
      },
      skip: [:passwords, :confirmations, :unlocks]
    }
  end

  # API - V1 ..................................................................
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resource :user, except: [:index, :new, :edit]

      match '*path', to: 'users#show', via: [:options]
    end
  end

  # All other routes should be sent to the SPA. No Page Found errors are handled on the client
  get '*path', to: 'application#main'
end
