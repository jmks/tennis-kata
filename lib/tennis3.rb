class TennisGame

  def initialize(player1Name, player2Name)
    @player1_name  = player1Name
    @player2_name  = player2Name
    @player1_score = 0
    @player2_score = 0
  end
      
  def won_point(player_name)
    if player_name == @player1_name
        @player1_score += 1
    else
        @player2_score += 1
    end
  end
  
  def say_score
    if (@player1_score < 4 and @player2_score < 4) and (@player1_score + @player2_score < 6)
      p = ["Love", "Fifteen", "Thirty", "Forty"]
      s = p[@player1_score]
      @player1_score == @player2_score ? s + "-All" : s + "-" + p[@player2_score]
    else
      if (@player1_score == @player2_score)
        "Deuce"
      else
        s = @player1_score > @player2_score ? @player1_name : @player2_name
        (@player1_score-@player2_score)*(@player1_score-@player2_score) == 1 ? "Advantage " + s : "Win for " + s
      end
    end
  end
end
