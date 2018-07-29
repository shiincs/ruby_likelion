class ChatRoom < ApplicationRecord
  has_many :admissions
  # admissions를 통해 users를 갖는다. (1:n 관계)
  has_many :users, through: :admissions
  has_many :chats
  
  # chat_room을 create 할 때, chat room이 생성되었음을 알리는 메서드를 수행한다.
  after_commit :create_chat_room_notification, on: :create
  
  # chat_room을 destroy 할 때, chat room이 삭제되었음을 알리는 메서드를 수행한다.
  after_commit :destroy_chat_room_notification, on: :destroy
  
  # chat_room을 update 할 때, chat room이 수정되었음을 알리는 메서드를 수행한다.
  after_commit :update_chat_room_notification, on: :update
  
  def create_chat_room_notification
    Pusher.trigger('chat_room', 'create', self.as_json)
    # (channel_name, event_name, json_data)
  end
  
  def destroy_chat_room_notification
    Pusher.trigger('chat_room', 'destroy', self.as_json)
    # (channel_name, event_name, json_data)
  end
  
  def update_chat_room_notification
    Pusher.trigger('chat_room', 'update', self.as_json)
    # (channel_name, event_name, json_data)
  end
  
  # 채팅방이 만들어 질 때, 현재 이 채팅방을 만든 유저가
  # 이 채팅방의 마스터가 되고, 현재 방에 참가한 것으로 된다.
  # 파라미터 user에 current_user를 넘겨서 사용한다.
  # 모델 단에서는 current_user를 사용할 수 없기 때문이다.
  # current_user는 기본적으로 controller 단 까지만 사용할 수 있다.
  def user_admit_room(user)
    # ChatRoom이 하나 만들어지고 나면 메서드를 같이 실행한다.
    Admission.create(user_id: user.id, chat_room_id: self.id)
  end
  
  def user_exit_room(user)
    Admission.where(user_id: user.id, chat_room_id: self.id)[0].destroy
  end
end
