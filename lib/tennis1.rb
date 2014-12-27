class TennisGame

  SCORE_IN_WORDS = {
    0 => "Love",
    1 => "Fifteen",
    2 => "Thirty",
    3 => "Forty"
  }

  def initialize(player1Name, player2Name)
    @player1Name, @player2Name = player1Name, player2Name
    @player1Points = @player2Points = 0
  end
        
  def won_point(playerName)
    if playerName == @player1Name
      @player1Points += 1
    else
      @player2Points += 1
    end
  end
  
  def say_score
    result    = ""
    tempScore = 0

    if tie_game?
      result = if @player1Points >= 3
        "Deuce"
      else
        "#{SCORE_IN_WORDS[@player1Points]}-All"
      end
    elsif advantage?
      minusResult = @player1Points-@player2Points
      if (minusResult==1)
        result ="Advantage " + @player1Name
      elsif (minusResult ==-1)
        result ="Advantage " + @player2Name
      end
    elsif game_over?
      minusResult = @player1Points-@player2Points
      if (minusResult>=2)
        result = "Win for " + @player1Name
      else
        result ="Win for " + @player2Name
      end
    else
      result = "#{SCORE_IN_WORDS[@player1Points]}-#{SCORE_IN_WORDS[@player2Points]}"
    end

    result
  end

  private

  def tie_game?
    @player1Points == @player2Points
  end

  def advantage?
    endgame? && score_diff == 1
  end

  def game_over?
    endgame? && score_diff >= 2
  end

  def endgame?
    [@player1Points, @player2Points].any? {|score| score >= 4}
  end

  def score_diff
    (@player1Points - @player2Points).abs
  end
end
