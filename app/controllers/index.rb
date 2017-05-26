enable :sessions

get '/' do
  # La siguiente linea hace render de la vista 
  # que esta en app/views/index.erb
  erb :index
end


post '/login' do
  puts 'dentro de post login'
  email = params[:email]
  password = params[:password]
  user = User.authenticate(email, password) #-> buscar cómo serán las variables
  if user
    puts '*'*50
    p session[:user_id] = user.id
    p session[:user_message] = user.name
    puts '*'*50
    redirect ('/users/vip')
    # redirect to ("/user/#{user.id}") #interpolaciones siempre en comillas dobles
  else
    redirect to ('/error')
  end
end


get '/registration' do
  puts 'dentro de registration'
  erb :registration
end


post '/user_registration' do
  puts 'dentro de post create_user'
  name = params[:user_name]
  email = params[:user_email]
  password = params[:user_password]
  if User.authenticate(email, password) == nil
    puts "*"*50
    puts 'dentro de authenticate'
    p @user = User.create(name: name, email: email, password: password) #en vez de guardar directo el password_digest, guardamos password. WTF right?!!!
    puts @user_id
    redirect to("/user/#{@user.id}")
  else
    puts "J"*50
    redirect to('/')
  end
end

get '/user/:id' do
  p params[:id]
  p @user = User.find(params[:id])
  p @user.name
  erb :user
end

get '/error' do
  erb :error
end

get '/user_session' do
  p "user session inspect #{session[:user_id].inspect}"
  session.delete(:user_id)
  p "user session inspect #{session[:user_id].inspect}"
  erb :index
end

before '/users/vip' do
  puts "W"*50
  p session[:user_id]
  unless session[:user_id] #== nil
    p session[:user_id]
    p session[:error_message] = "Favor de iniciar sesión"
    redirect to ('/')
  end
end

get '/users/vip' do
  p 'X'*50
  p @a = session[:user_message].upcase
  erb :vip
end