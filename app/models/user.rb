class User < ActiveRecord::Base
  belongs_to :cohort
  has_many :connections
  has_many :connected_users, through: :connections

  has_many :connecting_connections, class_name: 'Connection', foreign_key: :connected_user_id
  has_many :connecting_users, through: :connecting_connections, source: :user

  def connected? other_user
    connections.find_by(connected_user: other_user) or
    connecting_connections.find_by(user: other_user)
  end

end
