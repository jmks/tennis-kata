# Simple State Machine Implementation by David Andrews (k00ka)

# The TennisGame class is required to provide the unchanged interface to the scoreboard.
class TennisGame

  def initialize(player_one_name, player_two_name)
    @player_one = player_one_name
    @player_two = player_two_name
    @score = LoveLove.new
  end

  def won_point(player_name)
    if player_name == @player_one
      @score = @score.player_one_won_point
    else
      @score = @score.player_two_won_point
    end
  end

  def say_score
    @score.say_score(@player_one, @player_two)
  end

end

# The rest of the file contains the states - each state leads to at most two other states.
# We don't need to define a base-class because:
# 1. Ruby uses duck-typing and does not require a virtual base class, and
# 2. None of the methods has an implementation used by more than one subclass (no good choice for a default implementation).
class LoveLove

  def say_score(player_one, player_two)
    "Love-All"
  end

  def player_one_won_point
    FifteenLove.new
  end

  def player_two_won_point
    LoveFifteen.new
  end

end

class LoveFifteen

  def say_score(player_one, player_two)
    "Love-Fifteen"
  end

  def player_one_won_point
    FifteenFifteen.new
  end

  def player_two_won_point
    LoveThirty.new
  end

end

class LoveThirty

  def say_score(player_one, player_two)
    "Love-Thirty"
  end

  def player_one_won_point
    FifteenThirty.new
  end

  def player_two_won_point
    LoveForty.new
  end

end

class LoveForty

  def say_score(player_one, player_two)
    "Love-Forty"
  end

  def player_one_won_point
    FifteenForty.new
  end

  def player_two_won_point
    WinPlayer2.new
  end

end

class FifteenLove

  def say_score(player_one, player_two)
    "Fifteen-Love"
  end

  def player_one_won_point
    ThirtyLove.new
  end

  def player_two_won_point
    FifteenFifteen.new
  end

end

class ThirtyLove

  def say_score(player_one, player_two)
    "Thirty-Love"
  end

  def player_one_won_point
    FortyLove.new
  end

  def player_two_won_point
    ThirtyFifteen.new
  end

end

class FortyLove

  def say_score(player_one, player_two)
    "Forty-Love"
  end

  def player_one_won_point
    WinPlayer1.new
  end

  def player_two_won_point
    FortyFifteen.new
  end

end

class FifteenFifteen

  def say_score(player_one, player_two)
    "Fifteen-All"
  end

  def player_one_won_point
    ThirtyFifteen.new
  end

  def player_two_won_point
    FifteenThirty.new
  end

end

class FifteenThirty

  def say_score(player_one, player_two)
    "Fifteen-Thirty"
  end

  def player_one_won_point
    ThirtyThirty.new
  end

  def player_two_won_point
    FifteenForty.new
  end

end

class FifteenForty

  def say_score(player_one, player_two)
    "Fifteen-Forty"
  end

  def player_one_won_point
    ThirtyForty.new
  end

  def player_two_won_point
    WinPlayer2.new
  end

end

class ThirtyFifteen

  def say_score(player_one, player_two)
    "Thirty-Fifteen"
  end

  def player_one_won_point
    FortyFifteen.new
  end

  def player_two_won_point
    ThirtyThirty.new
  end

end

class FortyFifteen

  def say_score(player_one, player_two)
    "Forty-Fifteen"
  end

  def player_one_won_point
    WinPlayer1.new
  end

  def player_two_won_point
    FortyThirty.new
  end

end

class ThirtyThirty

  def say_score(player_one, player_two)
    "Thirty-All"
  end

  def player_one_won_point
    FortyThirty.new
  end

  def player_two_won_point
    ThirtyForty.new
  end

end

class ThirtyForty

  def say_score(player_one, player_two)
    "Thirty-Forty"
  end

  def player_one_won_point
    Deuce.new
  end

  def player_two_won_point
    WinPlayer2.new
  end

end

class FortyThirty

  def say_score(player_one, player_two)
    "Forty-Thirty"
  end

  def player_one_won_point
    WinPlayer1.new
  end

  def player_two_won_point
    Deuce.new
  end

end

class Deuce

  def say_score(player_one, player_two)
    "Deuce"
  end

  def player_one_won_point
    AdvantagePlayer1.new
  end

  def player_two_won_point
    AdvantagePlayer2.new
  end

end

class AdvantagePlayer1

  def say_score(player_one, player_two)
    "Advantage #{player_one}"
  end

  def player_one_won_point
    WinPlayer1.new
  end

  def player_two_won_point
    Deuce.new
  end

end

class AdvantagePlayer2

  def say_score(player_one, player_two)
    "Advantage #{player_two}"
  end

  def player_one_won_point
    Deuce.new
  end

  def player_two_won_point
    WinPlayer2.new
  end

end

class WinPlayer1

  def say_score(player_one, player_two)
    "Win for #{player_one}"
  end

  def player_one_won_point
    self
  end

  def player_two_won_point
    self
  end

end

class WinPlayer2

  def say_score(player_one, player_two)
    "Win for #{player_two}"
  end

  def player_one_won_point
    self
  end

  def player_two_won_point
    self
  end

end
