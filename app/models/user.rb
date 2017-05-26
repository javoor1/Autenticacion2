

class User < ActiveRecord::Base
  include BCrypt

  validates :email, uniqueness: true
  validates :name, presence: true

  # validates :tag_desc, :presence => true
  # validates :tag_desc, :uniqueness => true


  def password #getter
    @password ||= Password.new(password_digest) #asignación condicinal, si existe sólo lee, si no lo crea
  end

  def password=(user_password) #setter
    @password = Password.create(user_password)
    self.password_digest = @password
  end

  #ej. User.authenticate('fernando@codea.mx', 'qwerty')
  def self.authenticate(email, user_password)
    # si el email y el password corresponden a un usuario valido, regresa el usuario
    # de otra manera regresa nil
    puts "dentro de self.authenticate"
    p user_password
    p user = User.find_by_email(email)
    if user #necesitamos saber si se encontró el usuario
      if user.password == user_password #Bcrypt interpreta ya el user_password.
        p "autenticación true"
        return user
      else
        nil
      end
    else
      nil
    end
  end
end


