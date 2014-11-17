class Cohort < ActiveRecord::Base

  has_many :users
  has_many :connections, through: :users
  has_many :clubs

  USERS_ITERATORS = %i(from_begin reverse from_middle).cycle

  def make_clubs n_clubs
    Club.delete_all
    n_clubs.times { self.clubs.create(name: Faker::Team.creature) }
    self.send(USERS_ITERATORS.next).each do |user|
      connections_count = clubs.map do |club|
        club.users.inject(0) do |sum, club_user|
          if found_connection = user.connected?(club_user)
            # sum + found_connection.count
            sum + 1
          else
            sum
          end
        end
      end
      min_count = connections_count.min
      index = connections_count.index(min_count)
      until clubs[index].users.size <= (users.size / n_clubs)
        index += 1
      end
        clubs[index].users << user
    end
    clubs.each(&:add_or_increase_connection_count)
  end

  def from_middle
    mid_index = users.count / 2
    users.offset(mid_index) + users.limit(mid_index)
  end

  def reverse
    users.order(id: :desc)
  end

  def from_begin
    users
  end
end