class Connection < ActiveRecord::Base
  belongs_to :user
  belongs_to :connected_user, class_name: 'User'
end