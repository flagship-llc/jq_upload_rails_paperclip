module ActionDispatch::Routing

  class Mapper
    def background_upload_routes
      scope module: 'jq_upload_rails_paperclip' do
        resources :uploads, only: [ :create ]
      end
    end
  end
end
