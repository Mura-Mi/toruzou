class Activity < ActiveRecord::Base
  belongs_to :organization
  belongs_to :deal
  has_many :participants, :dependent => :destroy
  has_many :users, :through => :participants, :source => :participable, :source_type => 'User', :dependent => :delete_all
  has_many :people, :through => :participants, :source => :participable, :source_type => 'Contact', :dependent => :delete_all
end
