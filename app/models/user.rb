class User < ApplicationRecord
  has_many :todos
  validates :username, :presence => true,
                        :uniqueness => true,
                        :format => {
                          :with => /\A[a-zA-Z0-9_-]+\z/,
                          :message => "can only contain [a-zA-Z0-9_-]"
                        },
                        :length => {:within => 6..40}
  validates :password, :presence => true,
                        :confirmation => true,
                        :length => {:within => 6..40},
                        :on => :create
  validates :password_confirmation, :presence => true
end
