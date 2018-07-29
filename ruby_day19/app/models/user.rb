class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many :admissions
  # admissions를 통해 chat_rooms를 갖는다. (1:n 관계)
  has_many :chat_rooms, through: :admissions
  has_many :chats
  
  def joined_room?(room)
    self.chat_rooms.include?(room)
  end
end
