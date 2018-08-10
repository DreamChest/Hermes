namespace :user do
  desc 'Create a new user for the API'
  task :create, %i[email password] => [:environment] do |_t, args|
    User.create(
      email: args[:email],
      password: args[:password],
      password_confirmation: args[:password]
    )
  end
end
