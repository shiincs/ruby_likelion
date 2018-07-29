require 'sinatra'
require 'sinatra/reloader'
require 'csv'

get '/' do
    erb :index
end

# get '/board/:id' do
#     @id = params[:id]
#     erb :board
# end

get '/new' do
    erb :new
end

post '/create' do
    # 사용자가 입력한 정보를 받아서
    # CSV 파일 가장 마지막에 등록
    # => 이 글의 글번호도 같이 저장해야 함
    # => 기존의 글 개수를 파악해서
    # => 글 개수 + 1 해서 저장
    title = params[:title]
    contents = params[:contents]
    id = CSV.read('./boards.csv').count + 1
    puts id
    CSV.open('./boards.csv', 'a+') do |row|
        row << [id, title, contents]
    end
    redirect "/board/#{id}"
end

get '/boards' do
    # 파일을 읽기 모드로 열고
    # 각 줄마다 순회하면서
    # @가 붙어있는 변수에 넣어줌
    @boards = []
    CSV.open('./boards.csv', 'r+').each do |row|
        @boards << row
    end
    erb :boards
end

get '/board/:id' do
    # CSV 파일에서 params[:id]로 넘어온 친구와
    # 같은 글번호를 가진 row를 선택
    # => CSV 파일을 전체 순회합니다.
    # => 순회 하다가 첫번째 column이 id와 같은
    # => 값을 만나면 순회를 정지하고 값을
    # => 변수에다가 담아줍니다.
    @board = []
    CSV.read('./boards.csv').each do |row|
        if row[0].eql?(params[:id])
            @board = row
            break
        end
    end
    erb :board
end

########################################################

get '/user/new' do
    erb :new_user
end

post '/user/create' do
    if params[:pw].eql?(params[:pwcf])
        users = []
        file = CSV.read('./users.csv', 'r+')
        file.each do |row|
            users << row[1]
        end
        unless users.include?(params[:id])
            index = file.size + 1
            #정상적인 가입로직
            id = params[:id]
            pw = params[:pw]
            CSV.open('./users.csv', 'a+') do |row|
                row << [index, id, pw]
            end
            redirect "/user/#{index}"
        else
            erb :error
        end
    else 
        erb :error
    end
end

get '/users' do
    @users = []
    CSV.open('./users.csv', 'r+').each do |row|
        @users << row
    end
    erb :users
end

get '/user/:idx' do
    @user = []
    CSV.open('./users.csv', 'r+').each do |row|
        if row[0].eql?(params[:idx])
            @user = row
            break
        end
    end
    erb :user
end


