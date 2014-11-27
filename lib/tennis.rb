# Hybrid State Machine by lidlanca
class TennisGame

  def initialize(player1Name, player2Name)

    @player1 = {
      "name"  => player1Name,
      "score" => 0
    }
    @player2 = {
      "name"  => player2Name,
      "score" => 0
    }

    @players = nil
    initilize_players_lookup()
    
    # @player1Name = player1Name
    # @player2Name = player2Name

    @current_state = Rally.new(self)
  end

  # Create a lookup table so we can retrive player property by either name or index(1|2)
  def initilize_players_lookup()
    @players = {
      1 => @player1,
      2 => @player2,
      @player1['name'] => @player1,
      @player2['name'] => @player2
    }
  end
  
  # The game state is maintained in @current_state
  # when a player score( win a point ) we invoke next() on the current state object
  # Based on the new score, the state object will determain if it need to transition
  # to a new state or stay on the current state.
  def advanceState()
    @current_state = @current_state.next
  end

  def get_player_name(player_id)
    return get_player_by_name_or_id(player_id)['name']
  end

  def get_player_score(player_id = nil)
    if player_id == nil
      return @players[1]['score'],@players[2]['score'] # return multi value of both players score 
    else
      return get_player_by_name_or_id(player_id)['score']
    end
  end

  def won_point(playerName)
    setPlayerScore(playerName, +1)
    advanceState()
  end

  def say_score
    return @current_state.say_score
  end

  # Return a player by name or index(1 or 2)
  def get_player_by_name_or_id(name_or_id)
    return @players[name_or_id]
  end

  # Increment a player score
  def setPlayerScore(player_name_or_id,number)
    @players[player_name_or_id]['score'] += number
  end


  # setp1Score, setp2Score are not covered by the specs, and are not being called
  # no point refactoring without "expected behviour" to follow
  # p1Score, p2Score are also not being used anymore due to refactoring
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
    # @p1points +=1
  end
  def p2Score
    # @p2points +=1
  end
end


class Rally 
  def initialize(game)
    @game = game  
  end

  def say_score()
    score_in_words = {
            0 => "Love",
            1 => "Fifteen",
            2 => "Thirty",
            3 => "Forty"}

    p1_score, p2_score = @game.get_player_score()

    if p1_score == p2_score
      score_in_words[p1_score] + "-" + "All"
    else
      score_in_words[p1_score] + "-" + score_in_words[p2_score]
    end
  end

  def next()
    p1_score, p2_score = @game.get_player_score()
    
    if p1_score == p2_score and p1_score >= 3
      return Deuce.new(@game)
    elsif  (p1_score-p2_score).abs >= 2 and (p1_score >= 4 or p2_score >= 4)
      return Winning.new(@game)
    else
      return self
    end
  end

end


class Deuce
  def initialize(game)
    @game = game
  end

  def say_score()
    "Deuce"
  end

  def next()
    p1_score,p2_score = @game.get_player_score()
    if (p1_score-p2_score).abs == 1
      return Advanatge.new(@game)
    else
      return self  
    end
  end
end


class Advanatge 
  def initialize(game)
    @game = game
  end

  def say_score()
    p1_score,p2_score = @game.get_player_score()

    if p1_score > p2_score
      "Advantage " + @game.get_player_name(1)
    elsif p1_score < p2_score
      "Advantage " + @game.get_player_name(2)
    end
  end

  def next()
    p1_score,p2_score = @game.get_player_score()
    if (p1_score-p2_score).abs == 2
      return Winning.new(@game)
    else (p1_score-p2_score).abs == 0
      return Deuce.new(@game)
    end
  end
end



class Winning 
  def initialize(game)
    @game = game
  end

  def say_score()
    p1_score,p2_score = @game.get_player_score()
    if p1_score > p2_score
      "Win for " + @game.get_player_name(1)
    else
      "Win for " + @game.get_player_name(2)
    end
  end

  def next()
    return self
  end
end 
