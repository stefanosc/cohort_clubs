class Cohort < ActiveRecord::Base

  has_many :users
  has_many :connections, through: :users

  def make_clubs n_clubs
    clubs = Array.new(n_clubs) { [] }
    users.each do |user|
      connections_count = clubs.map do |club|
        club.inject(0) do |sum, club_user|
          if found_connection = user.connected?(club_user)
            sum + found_connection.count
          else
            sum
          end
        end
      end
      min_count = connections_count.min
      index = connections_count.index(min_count)
      until clubs[index].size <= (users.size / n_clubs)
        index += 1
      end
        clubs[index] << user
    end
    add_or_increase_connection_count clubs
    clubs
  end

  def add_or_increase_connection_count clubs
    clubs.each do |club|
      club.each.with_index do |user, i|
        if i < (club.size-1)
          (i+1).upto(club.size-1) do |n|
            if connection = user.connected?(club[n])
              connection.count += 1
              connection.save
            else
              user.connected_users << club[n]
            end
          end
        end
      end
    end
  end

end