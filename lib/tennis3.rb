class TennisGame

  attr_reader :player1_name, :player2_name, :player1_score, :player2_score

  def initialize(player1Name, player2Name)
    @player1_name  = player1Name
    @player2_name  = player2Name
    @player1_score = 0
    @player2_score = 0

    @default_visitor = ScoreSayerVisitor.new
  end
      
  def won_point(player_name)
    if player_name == @player1_name
        @player1_score += 1
    else
        @player2_score += 1
    end
  end
  
  def say_score visitor=nil
    visitor ||= @default_visitor
    visitor.say_score(self)
  end
end

class ScoreSayerVisitor
  def say_score game
    if (game.player1_score < 4 and game.player2_score < 4) and (game.player1_score + game.player2_score < 6)
      p = ["Love", "Fifteen", "Thirty", "Forty"]
      s = p[game.player1_score]
      game.player1_score == game.player2_score ? s + "-All" : s + "-" + p[game.player2_score]
    else
      if (game.player1_score == game.player2_score)
        "Deuce"
      else
        s = game.player1_score > game.player2_score ? game.player1_name : game.player2_name
        (game.player1_score-game.player2_score)*(game.player1_score-game.player2_score) == 1 ? "Advantage " + s : "Win for " + s
      end
    end
  end
end