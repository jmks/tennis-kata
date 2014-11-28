class RallyState
  def initialize(player1, player2)
  end

  def say_score
  end

  def transition!(scoring_player)
  end
end

class DeuceState
  def initialize(player1, player2)
  end

  def say_score
  end

  def transition!(scoring_player)
  end
end

class AdvantageState
  def initialize(player1, player2, advantage_player)
  end

  def say_score
  end

  def transition!(scoring_player)
  end
end

class DoneState
  def initialize(player1, player2, winning_player)
  end

  def say_score
  end

  def transition!(scoring_player)
  end
end