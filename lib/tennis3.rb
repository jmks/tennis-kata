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
  SCORES_IN_WORDS = ["Love", "Fifteen", "Thirty", "Forty"]

  def say_score game
    early_game?(game) ? say_early_game_score(game) : say_late_game_score(game)
  end

  private

  def say_early_game_score game
    if tied?(game)
      SCORES_IN_WORDS[game.player1_score] + "-All"
    else
      SCORES_IN_WORDS[game.player1_score] + "-" + SCORES_IN_WORDS[game.player2_score]
    end
  end

  def say_late_game_score game
    if tied?(game)
      "Deuce"
    elsif advantage?(game)
      "Advantage #{ leader_name(game) }"
    else # Win
      "Win for #{ leader_name(game) }"
    end
  end

  def leader_name game
    game.player1_score > game.player2_score ? game.player1_name : game.player2_name
  end

  def score_diff game
    (game.player1_score - game.player2_score).abs
  end

  def tied? game
    game.player1_score == game.player2_score
  end

  def early_game? game
    (game.player1_score < 4 && game.player2_score < 4) && (game.player1_score + game.player2_score < 6)
  end

  def advantage? game
    score_diff(game) == 1
  end
end