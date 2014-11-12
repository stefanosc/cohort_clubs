class Cohort
  def initialize(args)
    @name = args[:name]
    @users = []
  end

  def self.make_clubs n_clubs
    clubs = [Array.new(n_clubs)]
    @users.each do |user|
      connections_count = clubs.map do |club|
        club.inject(0) do |sum, club_user|
          sum += user.connections.find {|connection| connection.user == club_user }.count
        end
      end
      min_count = connections_count.min
      index = connections_count.index(min_count)
      clubs[index] << user
    end


  end

  def add_new_connections clubs
    clubs.each do |club|


    end
  end

end