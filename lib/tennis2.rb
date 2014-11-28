require_relative "tennis_score_states"

Player = Struct.new :name, :points

class TennisGame

  SCORE_IN_WORDS = {
    0 => "Love",
    1 => "Fifteen",
    2 => "Thirty",
    3 => "Forty",
    4 => "" # placeholder
  }

  def initialize(player1Name, player2Name)
    @player1 = Player.new(player1Name, 0)
    @player2 = Player.new(player2Name, 0)
    @state   = RallyState.new(@player1, @player2)
  end
      
  def won_point(playerName)
    if playerName == @player1.name
      p1Score()
    else
      p2Score()
    end
  end

  def say_score
    result = ""
    
    if @player1.points == @player2.points && @player1.points < 3
      result = SCORE_IN_WORDS[@player1.points] + "-All"
    end
    
    if @player1.points == @player2.points && @player1.points > 2
        result = "Deuce"
    end
    
    p1res = p2res = "Love"
    if @player1.points > 0 && @player2.points.zero?
      # p1res needed below (overlapping conditions)
      p1res = SCORE_IN_WORDS[@player1.points]
      result = p1res + "-" + p2res
    end

    if @player2.points > 0 && @player1.points.zero?
      p2res = SCORE_IN_WORDS[@player2.points]
      result = p1res + "-" + p2res
    end
    
    if @player1.points > @player2.points && @player1.points < 4
      if [2, 3].include? @player1.points
        p1res = SCORE_IN_WORDS[@player1.points]
      end

      if [1,2].include? @player2.points
        p2res = SCORE_IN_WORDS[@player2.points]
      end
      
      result = p1res + "-" + p2res
    end

    if @player2.points > @player1.points && @player2.points < 4
      if [2, 3].include? @player2.points
        p2res = SCORE_IN_WORDS[@player2.points]
      end

      if [1,2].include? @player1.points
        p1res = SCORE_IN_WORDS[@player1.points]
      end

      result = p1res + "-" + p2res
    end

    if @player1.points > @player2.points && @player2.points >= 3
      result = "Advantage " + @player1.name
    end
    if @player2.points > @player1.points && @player1.points >= 3
      result = "Advantage " + @player2.name
    end

    if @player1.points >= 4 && @player2.points >= 0 && (@player1.points - @player2.points) >= 2
      result = "Win for " + @player1.name
    end
    if @player2.points >= 4 && @player1.points>=0 && (@player2.points - @player1.points) >= 2
      result = "Win for " + @player2.name
    end

    result
  end

  def setp1Score(number)
    number.times { p1Score }
  end

  def setp2Score(number)
    number.times { p2Score }
  end

  # deprecated
  def p1Score
    @player1.points += 1
  end
  
  def p2Score
    @player2.points += 1
  end
end
