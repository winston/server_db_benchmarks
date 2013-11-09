class PostsResource < Grape::API
  format :json
  default_format :json

  namespace :posts do
    desc "Set Up Test Data"
    get :test do
      Post.delete_all

      posts = []
      100.times do |i|
        posts << Post.create(title: "Title #{i}", body: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
      end

      present posts
    end

    desc "Get a content partner"
    params do
      requires :id
    end
    route_param :id do
      get do
        present Post.myfind(params[:id])
      end
    end
  end
end
