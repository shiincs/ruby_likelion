require 'sinatra'
require 'sinatra/reloader'
require 'rest-client'
require 'json'
require 'nokogiri'
require 'csv'

get '/' do
    erb :index
end

get '/webtoon' do
    # 내가 받아온 웹툰 데이터를 저장할 배열 생성
    toons = []
    # 웹툰 데이터를 받아올 url 파악 및 요청 보내기
    daum_url = "http://webtoon.daum.net/data/pc/webtoon/list_serialized/mon"
    result = RestClient.get(daum_url)
    # 응답으로 온 내용을 hash 형태로 바꾸기
    webtoons = JSON.parse(result)
    # hash 내에서 웹툰 리스트에 해당하는 부분 순환하기
    webtoons["data"].each do |toon|
        # 웹툰 제목
        title = toon["title"]
        # 썸네일 이미지 주소
        thumb = toon["thumbnailImage2"]["url"]
        # 웹툰 링크
        link = "http://webtoon.daum.net/webtoon/view/#{toon['nickname']}"
        # 필요한 부분을 분리해서 처음 만든 배열에 push
        toons << { "title" => title,
                   "thumb" => thumb,
                   "link"  => link
                 }
    end
    # 완성된 배열 중에서 3개의 웹툰만 랜덤 추출
    @daum_webtoon = toons.sample(3)
    erb :webtoon
end

get '/check_file' do
    # unless == if not (조건문이 false면 내부 로직 실행)
    unless File.file?('./webtoon.csv')
    # 내가받아온 웹툰 데이터를 저장할 배열 생성
        toons = []
        # 웹툰 데이터를 받아올 url 파악 및 요청 보내기
        daum_url = "http://webtoon.daum.net/data/pc/webtoon/list_serialized/mon"
        result = RestClient.get(daum_url)
        # 응답으로 온 내용을 hash 형태로 바꾸기
        webtoons = JSON.parse(result)
        # hash 내에서 웹툰 리스트에 해당하는 부분 순환하기
        webtoons["data"].each do |toon|
            # 웹툰 제목
            title = toon["title"]
            # 썸네일 이미지 주소
            thumb = toon["thumbnailImage2"]["url"]
            # 웹툰 링크
            link = "http://webtoon.daum.net/webtoon/view/#{toon['nickname']}"
            # 필요한 부분을 분리해서 처음 만든 배열에 push
            toons << [title, thumb, link]
        end
        # CSV 파일을 새로 생성하는 코드
        CSV.open('./webtoon.csv', 'w+') do |row|
            # 크롤링한 웹툰 데이터를 CSV에 삽입
            index = 0
            toons.each_with_index do |toon, index|
                row << [index+1, toon[0], toon[1], toon[2]]
            end
        end
        erb :check_file
    else
        # 존재하는 CSV 파일을 불러오는 코드
        @webtoons = []
        CSV.open('./webtoon.csv', 'r+').each do |row|
        @webtoons << row
    end
    erb :webtoons
    end
end

get '/board/:name' do
    puts params[:name]
end