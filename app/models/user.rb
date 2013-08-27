#encoding: utf-8
class User < ActiveRecord::Base
  include RoleModel
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :roles_mask, :roles
  # attr_accessible :title, :body

  # validates name, presence: true

  roles :root, :admin, :developer, :tester



  def to_s
    name
  end

  def self.role_name(name)
    case name
    when :root || :admin
      "管理员"
    when :developer
      "开发人员"
    when :tester
      "测试人员"
    else
      "其它"
    end
  end

  def self.name_mapping
    User.valid_roles.map {|sym| [User.role_name(sym), sym] }
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
