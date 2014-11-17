class Club < ActiveRecord::Base
  belongs_to :cohort
  has_many :users

  def add_or_increase_connection_count
    self.users.each.with_index do |user, i|
      if i < (self.users.size-1)
        (i+1).upto(self.users.size-1) do |n|
          if connection = user.connected?(self.users[n])
            connection.count += 1
            connection.save
          else
            user.connected_users << self.users[n]
          end
        end
      end
    end
  end

  def all_connections
    self.users.each_with_object([]).with_index do |(user, memo), i|
      if i < (self.users.size-1)
        (i+1).upto(self.users.size-1) do |n|
          if conn = user.connected?(self[n])
            memo << conn
          end
        end
      end
    end
  end

  def connections_value_total
    all_connections.inject(0) do |sum, conn|
      sum + conn.count
    end
  end

end