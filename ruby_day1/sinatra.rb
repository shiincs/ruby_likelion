require 'sinatra'
require 'sinatra/reloader'  # 서버를 재시작 하지 않고도 변경사항 반영 가능
require 'httparty'
require 'nokogiri'
require 'json'

get '/menu' do
    # 점심에는 ? 을 먹고 저녁에는 ? 을 드세요
    # 조건: .sample 함수는 1번만 사용가능
    menu = ['양자강', '20층', '순남시래기', '시골집']
    selected = menu.sample(2)
    
    '점심에는 ' + selected[0] + ' 드시고' + '<br>' +
    '저녁에는 '  + selected[1] + ' 드세요'
end

get '/lotto' do
    # 로또
    # 출력: 이번주 추천 로또 숫자는 n1, n2, n3, n4, n5, n6 입니다.
    num = *(1..45)
    result = num.sample(6).sort
    
    "이번주 추천 로또 숫자는 " + result.to_s + " 입니다."
end

get '/check_lotto' do
    url = "http://m.nlotto.co.kr/common.do?method=getLottoNumber&drwNo=809"
    lotto = HTTParty.get(url)
    result = JSON.parse(lotto)
    numbers = []
    bonus = result["bnusNo"]
    result.each do |k, v|
        if k.include?("drwtNo")
            numbers << v
            numbers = numbers.sort
        end
    end
    my_numbers = *(1..45)
    my_lotto =my_numbers.sample(6).sort
    
    count = 0
    numbers.each do |num|
        count += 1 if my_lotto.include?(num)    #실행문이 한줄일 때에는 뒤에 if문을 붙여도 된다.    
    end
    puts "보너스는 #{bonus}"
    puts "당첨번호는 #{numbers}"
    puts "내 번호는 #{my_lotto}"
    puts "당첨개수는 #{count} 개"
    if count == 6
        puts "1등 입니다!"
    elsif count == 5 and numbers.include?(bonus)
        puts "2등 입니다~"
    elsif count == 5
        puts "3등 입니다"
    elsif count == 4
        puts "4등 입니다"
    elsif count == 3
        puts "5등 입니다"
    else
        puts "꽝입니다 ㅠㅠ"
    end
end

get '/kospi' do
    response = HTTParty.get("http://finance.daum.net/quote/kospi.daum?nil_stock=refresh")
    kospi = Nokogiri::HTML(response)
    result = kospi.css("#hyenCost > b")
    
    "현재 코스피 지수는 #{result.text} 입니다."
end

get '/html' do
    "<html>
        <head>
            <title>html test</title>
        </head>
        <body>
            <h1>안녕하세요?</h1>
        </body>
    <html>"
end

get '/html_file' do
    # 모든 파라미터가 params에 담긴다
    @name = params[:name]   #parameter가 name인 key의 value를 @name에 저장해서 views로 넘긴다.
    # send_file 'views/my_first_html.html'  #html에서만 send_file을 사용한다.
    erb :my_first_html
end

get '/calculate' do
    #parameter는 default가 string 이기 때문에 .to_i 로 integer로 바꿔줘야함.
    num1 = params[:num1].to_i
    num2 = params[:num2].to_i
    @plus = (num1 + num2)
    @minus = (num1 - num2)
    @multiply = (num1 * num2)
    @divide = (num1 / num2) 
    
    erb :calculator
end