class User < ApplicationRecord
  has_many :posts # 반드시 복수로 써야함
end
