Rails.application.routes.draw do
  scope(path_names: { finish: :finalizar }) do
    resources :competitions, except: [:new, :edit], path: :competicoes, defaults: { format: :json } do
      member do
        patch :finish, as: :finish
        put :finish, as: nil
      end
    end
  end

  resources :results, only: [:show, :create], path: :resultados, defaults: { format: :json }
end
