class Channel < ActiveRecord::Base

  validates_presence_of :name

  has_many :broadcasts, :dependent => :destroy

end
