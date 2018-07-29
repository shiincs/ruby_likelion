class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :password_digest # 암호화는 password_digest로 이름 고정
      
      t.timestamps
    end
  end
end
