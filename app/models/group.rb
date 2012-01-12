class Group < ActiveRecord::Base
  attr_accessible :name, :description, :gid

  has_many :user_group_links
  has_many :user, :through => :user_group_links
end
