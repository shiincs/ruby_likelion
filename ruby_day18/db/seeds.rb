# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

genres = ["Horror", "Thriller", "Action", "Drama", "Comedy", "Romance", "SF", "Adventure"]
images = %w( http://img.movist.com/?img=/x00/04/78/00_p1.jpg
             http://imgmovie.naver.com/mdi/mi/0733/73372_P31_161237.jpg
             http://file.thisisgame.com/upload/tboard/user/2016/07/08/20160708061954_5657.jpg
             http://imgmovie.naver.com/mdi/mi/0398/39841_P03_231710.jpg
             http://thumbnail.egloos.net/600x0/http://pds20.egloos.com/pds/201005/11/46/a0051346_4be92c57351fa.jpg
             http://image.chosun.com/sitedata/image/201007/09/2010070900758_1.jpg
             http://file3.instiz.net/data/file3/2018/02/27/a/d/e/ade8128f38907ca4f8637056e90b0465.jpg
             http://img.tf.co.kr/article/home/2014/11/05/20146890141518637900.jpg
             https://cwmelodotcom1.files.wordpress.com/2013/08/ec9ea1ec8aa4ec9881ed9994eab09cebb489.jpg
             http://www.dvd.co.kr/shopimages/dvdcokr/0020060001662.jpg
             http://garmuri.com/files/attach/images/169/556/064/bfc0ecdb63cf82970a4c379ef1eec757.jpeg
             http://ph.spotvnews.co.kr/news/photo/201711/177218_212912_4250.jpg
             http://www.topstarnews.net/news/photo/201804/387349_32457_433.jpg)

User.create(email: "cs@cs", password: "12341234", password_confirmation: "12341234")

30.times do
  Movie.create(title: Faker::OnePiece.island, genre: genres.sample, director: Faker::Name.name, actor: Faker::FunnyName.two_word_name, remote_image_path_url: images.sample, description: Faker::Lorem.paragraph, user_id: 1)
end