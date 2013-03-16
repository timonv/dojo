require 'test/unit'
require './bowling_game'

class TruthTest < Test::Unit::TestCase
  def test_truth
    assert true
  end
end

class GameTest < Test::Unit::TestCase
  def test_some_simple_scores
    {
      "00000000000000000000" => 0,
      "11111111110000000000" => 10,
      "81818181810000000000" => 45,
      "45454545450000000000" => 45,
      "12121212120000000000" => 15
    }.each do |score_string, score|
      game = Game.new(score_string)
      assert_equal game.score, score, "#{game.score} did not match #{score}"
    end
  end

  def test_spare
    game = Game.new "3/00000000"
    assert_equal 10, game.score

    game = Game.new "3/21000000"

    assert_equal 15, game.score
  end

  def test_strike
    game = Game.new "XXXXX"
    assert_equal (10+10+10) * 3 + (10 * 2) + 10, game.score
  end

  def test_misses
    game = Game.new "3/1---"
    assert_equal 12, game.score
  end
end

class FrameTest < Test::Unit::TestCase
  def test_try_readers
    f = Frame.new("53")
    assert_equal 5, f.try1
    assert_equal 3, f.try2
  end

  def test_score_of_simple_frame
    { 
      "00" => 0,
      "81" => 9,
      "45" => 9
    }.each do |frame, score|
      assert_equal score, Frame.new(frame).score
    end
  end

  def test_simple_spares
    assert_equal 10, Frame.new("3/").score
    assert_equal 10, Frame.new("4/").score
    assert_equal 10, Frame.new("5/").score
    assert_equal 10, Frame.new("6/").score
    assert_equal 10, Frame.new("9/").score
    assert_equal 10, Frame.new("1/").score
  end

  def test_simple_spare
    frame2 = Frame.new("11")
    frame1 = Frame.new("9/", frame2)

    assert_equal 11, frame1.score
    assert_equal 2, frame2.score
  end

  def test_complex_spare
    frame2 = Frame.new("22")
    frame1 = Frame.new("4/", frame2)

    assert_equal 12, frame1.score
    assert_equal 4, frame2.score
  end

  def test_simple_strike
    frame2 = Frame.new("22")
    frame1 = Frame.new("X", frame2)

    assert_equal 14, frame1.score
    assert_equal 4, frame2.score
  end

  def test_complex_strike
    frame2 = Frame.new("X")
    frame1 = Frame.new("X", frame2)
    frame = Frame.new("X", frame1)
    assert_equal 30, frame.score
    assert_equal 20, frame1.score
    assert_equal 10, frame2.score
  end

  def test_lookahead_strike_score
    frame = Frame.new("21")
    assert_equal 3, frame.lookahead_strike_score

    frame = Frame.new("8/")
    assert_equal 10, frame.lookahead_strike_score

    frame1 = Frame.new("21")
    frame = Frame.new("X", frame1)
    assert_equal 12, frame.lookahead_strike_score

    frame1 = Frame.new("X")
    frame = Frame.new("X", frame1)
    assert_equal 20, frame.lookahead_strike_score
  end

  def test_miss
    frame1 = Frame.new("--")
    assert_equal 0, frame1.score

    frame1 = Frame.new("3-")
    assert_equal 3, frame1.score

    frame1 = Frame.new("-/")
    assert_equal 10, frame1.score
  end
end
