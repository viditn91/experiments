class Frame
  #each frame consists of a next_frame and a prevoius_frame
  #they are being implemented in the form of a linked-list
  attr_reader :score, :previous_frame
  attr_accessor :next_frame

  def initialize(start_point, offset, game)
    #@start refers to the position of frame in the score_sequence of the game
    @start = start_point
    #@offset is the length of the frame from the starting_point in the score_sequence of the game
    @offset = offset
    #@game is the game to which the frame belongs
    @game = game
  end

  def previous_frame=(frame)
    @previous_frame = frame
    set_score
  end

  private
    def strike?
      @game.score_sequence[@start] == Game::PIN_COUNT
    end

    def spare?
      !strike? && @game.score_sequence[@start..(@start + 1)].reduce(:+) == Game::PIN_COUNT
    end

    def open?
      !strike? && @game.score_sequence[@start..(@start + 1)].reduce(:+) < Game::PIN_COUNT
    end

    def set_score
      if strike? || spare?
        @score = @game.score_sequence[@start..(@start + 2)].reduce(:+)
      elsif open?
        @score = @game.score_sequence[@start..(@start + 1)].reduce(:+)
      end
      @score += previous_frame.nil? ? 0 : previous_frame.score
    end
end