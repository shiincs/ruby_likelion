class LottoController < ApplicationController
    def index
        @new_number = Lotto.last
        @numbers = Lotto.all
        
        # @lotto = (1..45).to_a.sample(6).sort
        # l1= Lotto.new
        # l1.lotto_number = @lotto
        # l1.save
    end

    def new
        number = (1..45).to_a.sample(6).sort.to_s
        lotto = Lotto.new
        lotto.lotto_number = number
        lotto.save
        redirect_to "/lotto"
        
        # @lotto = (1..45).to_a.sample(6).sort
        # redirect_to "/lotto"
    end
end
