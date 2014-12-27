require_relative "tennis_score_states"

Player = Struct.new :name, :points

class TennisGame

  def initialize(player1Name, player2Name)
    @player1 = Player.new(player1Name, 0)
    @player2 = Player.new(player2Name, 0)
    @state   = RallyState.new(@player1, @player2)
  end
      
  def won_point(playerName)
    # TODO small CQS issue?
    @state = @state.won_point(playerName)
  end

  def say_score
    @state.say_score
  end

  def setp1Score(score)
    score.times { p1Score }
  end

  def setp2Score(score)
    score.times { p2Score }
  end

  def p1Score
    @player1.points += 1
  end
  
  def p2Score
    @player2.points += 1
  end
end
