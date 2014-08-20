class String

  def to_t9
    case downcase
    when 'a'..'c'
      return 2
    when 'd'..'f'
      return 3
    when 'g'..'i'
      return 4
    when 'j'..'l'
      return 5
    when 'm'..'o'
      return 6
    when 'p'..'s'
      return 7
    when 't'..'v'
      return 8
    when 'w'..'z'
      return 9
    end
  end

end