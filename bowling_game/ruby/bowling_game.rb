require 'pry'
class Game
  def initialize(score_string)
    @score_string = score_string
  end

  def score
    frame_list.inject(0) { |acc,f| acc + f.score  }
  end

  private

  def normalized_score_string
    @score_string.gsub(/X/, "X0")
  end

  def frame_list
    memo = nil
    normalized_score_string.scan(/.{2}/).reverse.map { |f|
      memo = Frame.new(f, memo)
    }.reverse
  end
end

class Frame
  attr_reader :try1, :try2

  def initialize(frame_string, next_frame = nil)
    @frame_string = frame_string
    @next_frame = next_frame

    normalize_scores
  end

  def score
    if spare?
      @try1 + @try2  + next_frame_spare_score
    elsif strike?
      @try1 + next_frame_strike_score
    else
      @try1 + @try2
    end
  end

  def lookahead_strike_score
    if strike?
      10 + (@next_frame ? @next_frame.try1 : 0)
    else
      @try1 + @try2
    end
  end

  private

  def spare?
    @spare == true
  end

  def strike?
    @strike == true
  end

  def next_frame_spare_score
    if @next_frame != nil
      @next_frame.try1
    else
      0
    end
  end

  def next_frame_strike_score
    if @next_frame != nil
      @next_frame.lookahead_strike_score
    else
      0
    end
  end

  def normalize_scores
    @try1, @try2 = @frame_string.split('').map.with_index do |i,index|
      case i
      when /\d/
        i.to_i
      when "/"
        @spare = true
        10 - @frame_string.split('')[index-1].to_i
      when "X"
        @strike = true
        10
      else
        0
      end
    end
  end
end
