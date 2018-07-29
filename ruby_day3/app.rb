require 'sinatra'
require 'sinatra/reloader'
# nokogiri와 거의 같다.
require 'rest-client'
require 'nokogiri'
# post 방식으로 검색 시 한글 인코딩
require 'uri'

get '/' do
    erb :app
end

get '/calculate' do
    num1 = params[:num1].to_i
    num2 = params[:num2].to_i
    @sum = num1 + num2
    @min = num1 - num2
    @mul = num1 * num2
    @div = num1 / num2
    erb :calculate
end

get '/numbers' do
    erb :numbers
end

get '/form' do
    erb :form
end

id="multi"
pw="campus"

post '/login' do
    if id.eql?(params[:id])
        # 비밀번호를 체크하는 로직
        if pw.eql?(params[:pw])
            redirect '/complete'
        else
            @msg = "비밀번호가 틀립니다."
            redirect 'error?err_co=2'
        end
    else
        # ID가 존재하지 않습니다.
        @msg = "ID가 존재하지 않습니다."
        redirect 'error?err_co=1'
    end
end

# 계정이 존재하지 않거나, 비밀번호가 틀린 경우
get '/error' do
    # 다른 방식으로 에러메시지를 보여줘야 함
    # id가 없는 경우
    if params[:err_co].to_i == 1
        @msg = "ID가 없습니다."
    # pw가 틀린 경우
    elsif params[:err_co].to_i == 2
        @msg = "비밀번호가 틀렸습니다."
    end
    erb :error
end

# 로그인 완료된 곳
get '/complete' do
    erb :complete
end

# search 페이지 띄우기
get '/search' do
    erb :search
end

# search 페이지에서 redirect로 검색창 넘어가기
post '/search' do
    case params[:engine]
    when "naver"
        # URI로 encode 시켜주면 한글로도 검색 가능
        url = URI.encode("https://search.naver.com/search.naver?query=#{params[:query]}")
        redirect url
    when "google"
        url = URI.encode("https://www.google.co.kr/search?q=#{params[:q]}")
        redirect url
    end
end

get '/op_gg' do
    if params[:userName]
        case params[:method]
        # op.gg에서 승/패 수만 크롤링하여 보여줌
        when "self"
            # RestClient를 통해 op.gg에서 검색결과 페이지를 크롤링
            url = RestClient.get(URI.encode("http://www.op.gg/summoner/userName=#{params[:userName]}"))
            # 검색결과 페이지 중에서 win과 lose 부분을 찾음
            result = Nokogiri::HTML.parse(url)
            # nokogiri를 이용하여 원하는 부분을 골라냄
            win = result.css('span.win').first
            lose = result.css('span.lose').first
            # 검색 결과를 페이지에서 보여주기 위한 변수 선언
            @win = win.text
            @lose = lose.text
            
        # 검색결과를 op.gg에서 보여줌
        when "opgg"
            url = URI.encode("http://www.op.gg/summoner/userName=#{params[:userName]}")
            redirect url
        end
    end
    erb :op_gg
end