require_relative 'frame'
require_relative 'game_exception'

class Game
  #constants
  FRAME_COUNT = 10
  PIN_COUNT = 10
  attr_reader :score_sequence

  #initializes game with the score_sequence in the form of an array
  def initialize(score_string)
    @score_sequence = score_string.split(' ').map(&:to_i)
    generate_frames
  end

  #prints the scorecard on the screen
  def print_score_card
    frame, i = @first_frame, 1
    while(frame) do
      puts "Frame #{ i } --> Score #{ frame.score }"
      frame = frame.next_frame
      i += 1
    end
  end

  private
    #method to generate frames from the score_sequence
    def generate_frames
      i, frame_count = 0, 1
      while(i < @score_sequence.size) do
        if frame_count <= FRAME_COUNT
          offset = get_frame_size(i, frame_count == FRAME_COUNT)
          add_frame(i, offset)
          i += offset + 1
          frame_count += 1
        else
          #raising error if number of scores on the line is invalid
          raise GameException.new, "Invalid Input: More than #{ FRAME_COUNT } frames"
        end
      end
    end

    #add a new frame which is the next_frame to the last_frame of the game
    def add_frame(start_point, offset)
      if @first_frame
        new_frame = Frame.new(start_point, offset, self)
        @last_frame.next_frame, new_frame.previous_frame = new_frame, @last_frame
        @last_frame = new_frame
      else
        @first_frame = Frame.new(start_point, offset, self)
        @last_frame, @first_frame.previous_frame = @first_frame, nil
      end
    end

    #method to receive the size of the frame from its starting_point in the score_sequence
    #different behavour of the last frame is taken into account
    def get_frame_size(start_point, is_last_frame)
      validate_single_throw(start_point)
      case @score_sequence[start_point]
      when PIN_COUNT
        if is_last_frame
          validate_single_throw(start_point + 1)
          if @score_sequence[start_point + 1] == PIN_COUNT
            validate_single_throw(start_point + 2)
          else
            validate_double_throw(start_point + 1)
          end
          2
        else; 0;
        end
      when (0..(PIN_COUNT - 1))
        validate_double_throw(start_point)
        pins_count = @score_sequence[start_point..(start_point + 1)].reduce(:+)
        if pins_count < PIN_COUNT; 1;
        elsif pins_count == PIN_COUNT
          if is_last_frame
            validate_single_throw(start_point + 2); 2;
          else; 1;
          end
        end
      end
    end

    #validations run on a single throw in the game
    def validate_single_throw(start_point)
      if @score_sequence[start_point] > PIN_COUNT
        raise GameException.new, "Invalid Input: No more than #{ PIN_COUNT } pins in one throw"
      end
    end

    #validations run on a spare or an open-frame -- esentially a double throw
    def validate_double_throw(start_point)
      pins_count = @score_sequence[start_point..(start_point+1)].reduce(:+)
      if pins_count > PIN_COUNT
        raise GameException.new, "Invalid Input: No more than #{ PIN_COUNT } pins in a double throw"
      end
    end
end