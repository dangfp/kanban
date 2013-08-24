class User < ActiveRecord::Base
  include RoleModel
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name
  # attr_accessible :title, :body

  roles :root, :admin, :developer, :tester

  def to_s
    name
  end

  def can_access_admin?
     self.has_role?(:root) || self.has_role?(:admin)
   end

  def can_access_developer?
    self.has_role?(:developer)
  end

  def can_access_tester?
    self.has_role?(:tester)
  end
end
