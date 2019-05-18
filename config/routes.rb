Rails.application.routes.draw do
  namespace 'api' do
  	namespace 'v1' do
			resources :dns_records, only: [:create] do
				collection do
					get :search
				end
			end
  	end
  end
end
