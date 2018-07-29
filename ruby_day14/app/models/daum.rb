class Daum < ApplicationRecord
  has_many :memberships
  has_many :users, through: :memberships
  has_many :posts
  
  # def self.메서드명 -> 클래스 메서드
  #   로직 안에서 self를 쓸 수 없음
  # end
  
  # def 메서드명 -> 인스턴스 메서드
  #   로직 안에서 self를 쓸 수 있음
  #   self == 현재 자신 객체
  # end
  
  def is_member?(user) # () 안에서 파라미터를 받는다
    self.users.include?(user) # TF 리턴
  end
end
