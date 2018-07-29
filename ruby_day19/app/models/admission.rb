class Admission < ApplicationRecord
  belongs_to :user
  # counter_cache를 통해 자동으로 admissions_count가 update 된다.
  belongs_to :chat_room, counter_cache: true
  
  # 참가할 때 인원수 update
  after_commit :user_joined_chat_room_notification, on: :create
  
  # 채팅방 나갔을 때
  after_commit :user_exit_chat_room_notification, on: :destroy
  
  def user_joined_chat_room_notification
    Pusher.trigger("chat_room_#{self.chat_room_id}", 'join', self.as_json.merge({email: self.user.email}))
    Pusher.trigger("chat_room", 'join', self.as_json)
  end
  
  def user_exit_chat_room_notification
    Pusher.trigger("chat_room_#{self.chat_room_id}", 'exit', self.as_json.merge({email: self.user.email}))
    Pusher.trigger("chat_room", 'exit', self.as_json)
  end
end
