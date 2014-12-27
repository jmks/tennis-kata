class TennisScoreState
  def initialize(player1, player2)
    @player1, @player2 = player1, player2
  end
end

class RallyState < TennisScoreState

  SCORE_IN_WORDS = {
    0 => "Love",
    1 => "Fifteen",
    2 => "Thirty",
    3 => "Forty"
  }

  def say_score
    if tied_game?
      "#{ SCORE_IN_WORDS[@player1.points] }-All"
    else
      "#{ SCORE_IN_WORDS[@player1.points] }-#{ SCORE_IN_WORDS[@player2.points] }"
    end
  end

  def won_point(scoring_player)
    if tied_game? && scoring_player.points > 2
      DeuceState.new(@player1, @player2)
    elsif game_won?(scoring_player)
      DoneState.new(@player1, @player2, scoring_player)
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

class DeuceState < TennisScoreState
  def say_score
    "Deuce"
  end

  def won_point(scoring_player)
    AdvantageState.new(@player1, @player2, scoring_player)
  end
end

class AdvantageState < TennisScoreState
  def initialize(player1, player2, advantage_player)
    super(player1, player2)
    @advantage_player = advantage_player
  end

  def say_score
    "Advantage #{ @advantage_player.name }"
  end

  def won_point(scoring_player)
    if scoring_player.name == @advantage_player.name
      DoneState.new(@player1, @player2, scoring_player)
    else
      DeuceState.new(@player1, @player2)
    end
  end
end

class DoneState < TennisScoreState
  def initialize(player1, player2, winning_player)
    super(player1, player2)
    @winning_player = winning_player
  end

  def say_score
    "Win for #{ @winning_player.name }"
  end

  def won_point(scoring_player)
    self
  end
end