class TennisGame

  SCORE_IN_WORDS = {
    0 => "Love",
    1 => "Fifteen",
    2 => "Thirty",
    3 => "Forty"
  }

  def initialize(player1Name, player2Name)
    @player1Name, @player2Name = player1Name, player2Name
    @p1points = @p2points = 0
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

    if tie_game?
      result = if @p1points >= 3
        "Deuce"
      else
        "#{SCORE_IN_WORDS[@p1points]}-All"
      end
    elsif advantage?
      minusResult = @p1points-@p2points
      if (minusResult==1)
        result ="Advantage " + @player1Name
      elsif (minusResult ==-1)
        result ="Advantage " + @player2Name
      end
    elsif game_over?
      minusResult = @p1points-@p2points
      if (minusResult>=2)
        result = "Win for " + @player1Name
      else
        result ="Win for " + @player2Name
      end
    else
      result = "#{SCORE_IN_WORDS[@p1points]}-#{SCORE_IN_WORDS[@p2points]}"
    end

    result
  end

  private

  def tie_game?
    @p1points == @p2points
  end

  def advantage?
    endgame? && score_diff == 1
  end

  def game_over?
    endgame? && score_diff >= 2
  end

  def endgame?
    [@p1points, @p2points].any? {|score| score >= 4}
  end

  def score_diff
    (@p1points-@p2points).abs
  end
end
