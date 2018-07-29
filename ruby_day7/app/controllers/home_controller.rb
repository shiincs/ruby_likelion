class HomeController < ApplicationController
    def index
        @msg = "나의 첫 레일즈 앱에 오신 것을 환영합니다."
    end
    
    def lotto
        @lotto = (1..45).to_a.sample(6).sort
    end
    
    def lunch
        @menu = {
            "순남시래기" => "http://pds.joins.com/news/component/htmlphoto_mmdata/201507/10/htm_201507106658a010a012.jpg",
            "멀티캠퍼스" => "http://kimhyunjung.kr/web/upload/NNEditor/20180308/EBA980ED8BB0ECBAA0ED8DBCEC8AA4_EBA19CEAB3A0.jpg",
            "시골집" => "http://cfile230.uf.daum.net/image/2401804257C5479A2616DC"
        }
        # {type1: "text1"}
        @lunch = @menu.keys.sample
        
    end
end
