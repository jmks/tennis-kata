class TennisGame

  SCORE_IN_WORDS = {
    0 => "Love",
    1 => "Fifteen",
    2 => "Thirty",
    3 => "Forty"
  }

  def initialize(player1Name, player2Name)
    @player1Name = player1Name
    @player2Name = player2Name
    @p1points = 0
    @p2points = 0
  end
        
  def won_point(playerName)
    if playerName == @player1Name
      @p1points += 1
    else
      @p2points += 1
    end
  end
  
  def say_score
    result    = ""
    tempScore = 0

    if (@p1points==@p2points)
      result = {
          0 => "Love-All",
          1 => "Fifteen-All",
          2 => "Thirty-All",
      }.fetch(@p1points, "Deuce")
    elsif (@p1points>=4 or @p2points>=4)
      minusResult = @p1points-@p2points
      if (minusResult==1)
        result ="Advantage " + @player1Name
      elsif (minusResult ==-1)
        result ="Advantage " + @player2Name
      elsif (minusResult>=2)
        result = "Win for " + @player1Name
      else
        result ="Win for " + @player2Name
      end
    else
      result = "#{SCORE_IN_WORDS[@p1points]}-#{SCORE_IN_WORDS[@p2points]}"
    end
    
    result
  end
end
