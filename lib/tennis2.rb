class TennisGame

  SCORE_IN_WORDS = {
    0 => "Love",
    1 => "Fifteen",
    2 => "Thirty",
    3 => "Forty",
    4 => "" # placeholder
  }

  def initialize(player1Name, player2Name)
    @player1Name = player1Name
    @player2Name = player2Name
    @p1points = 0
    @p2points = 0
  end
      
  def won_point(playerName)
    if playerName == @player1Name
      p1Score()
    else
      p2Score()
    end
  end

  def say_score
    result = ""
    
    if (@p1points == @p2points and @p1points < 3)
      result = SCORE_IN_WORDS[@p1points] + "-All"
    end
    if (@p1points==@p2points and @p1points>2)
        result = "Deuce"
    end
    
    p1res = p2res = "Love"
    if (@p1points > 0 and @p2points==0)
      # p1res needed below (overlapping conditions)
      p1res = SCORE_IN_WORDS[@p1points]
      result = p1res + "-Love"
    end

    if (@p2points > 0 and @p1points==0)
      p2res = SCORE_IN_WORDS[@p2points]
      result = p1res + "-" + p2res
    end
    
    if (@p1points>@p2points and @p1points < 4)
      if [2, 3].include? @p1points
        p1res = SCORE_IN_WORDS[@p1points]
      end

      if [1,2].include? @p2points
        p2res = SCORE_IN_WORDS[@p2points]
      end
      
      result = p1res + "-" + p2res
    end

    if (@p2points>@p1points and @p2points < 4)
      if [2, 3].include? @p2points
        p2res = SCORE_IN_WORDS[@p2points]
      end

      if [1,2].include? @p1points
        p1res = SCORE_IN_WORDS[@p1points]
      end

      result = p1res + "-" + p2res
    end

    if (@p1points > @p2points and @p2points >= 3)
      result = "Advantage " + @player1Name
    end
    if (@p2points > @p1points and @p1points >= 3)
      result = "Advantage " + @player2Name
    end
    if (@p1points>=4 and @p2points>=0 and (@p1points-@p2points)>=2)
      result = "Win for " + @player1Name
    end
    if (@p2points>=4 and @p1points>=0 and (@p2points-@p1points)>=2)
      result = "Win for " + @player2Name
    end

    result
  end

  def setp1Score(number)
    (0..number).each do |i|
        p1Score()
    end
  end

  def setp2Score(number)
    (0..number).each do |i|
      p2Score()
    end
  end

  def p1Score
    @p1points +=1
  end
  
  def p2Score
    @p2points +=1
  end
end
