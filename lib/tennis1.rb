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
    if tie_game?
      deuce? ? "Deuce" : "#{SCORE_IN_WORDS[@player1Points]}-All"
    elsif advantage?
      "Advantage #{leading_player_name}"
    elsif game_over?
      "Win for #{leading_player_name}"
    else
      "#{SCORE_IN_WORDS[@player1Points]}-#{SCORE_IN_WORDS[@player2Points]}"
    end
  end

  private

  def tie_game?
    @player1Points == @player2Points
  end

  def deuce?
    tie_game? && @player1Points >= 3
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

  def leading_player_name
    if @player1Points > @player2Points
      @player1Name
    elsif @player1Points < @player2Points
      @player2Name
    else
      nil
    end
  end
end
