class RallyState

  SCORE_IN_WORDS = {
    0 => "Love",
    1 => "Fifteen",
    2 => "Thirty",
    3 => "Forty"
  }

  def initialize(player1, player2)
    @player1, @player2 = player1, player2
  end

  def say_score
    if tied_game?
      "#{ SCORE_IN_WORDS[@player1.points] }-All"
    else
      "#{ SCORE_IN_WORDS[@player1.points] }-#{ SCORE_IN_WORDS[@player2.points] }"
    end
  end

  def transition(scoring_player)
    if tied_game? && scoring_player.points > 2
      DeuceState.new(@player1, @player2)
    elsif game_won?(scoring_player)
      DoneState.new(scoring_player)
    else
      self
    end
  end

  private

  def tied_game?
    @player1.points == @player2.points
  end

  def game_won? scoring_player
    scoring_player.points >= 4 && (@player1.points - @player2.points).abs >= 2
  end
end

class DeuceState
  def initialize(player1, player2)
    @player1, @player2 = player1, player2
  end

  def say_score
    "Deuce"
  end

  def transition(scoring_player)
    AdvantageState.new(@player1, @player2, scoring_player)
  end
end

class AdvantageState
  def initialize(player1, player2, advantage_player)
    @player1, @player2, @advantage_player = player1, player2, advantage_player
  end

  def say_score
    "Advantage #{ @advantage_player.name }"
  end

  def transition(scoring_player)
    if scoring_player.name == @advantage_player.name
      DoneState.new(scoring_player)
    else
      DeuceState.new(@player1, @player2)
    end
  end
end

class DoneState
  def initialize(winning_player)
    @winning_player = winning_player
  end

  def say_score
    "Win for #{ @winning_player.name }"
  end

  def transition(scoring_player)
    self
  end
end