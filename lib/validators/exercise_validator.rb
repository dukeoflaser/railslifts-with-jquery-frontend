module ExerciseValidator

  def reps_format
    unless correct_format?(reps)
      errors.add(:reps, "must be between 1 and something reasonable as well as being seperated by a space. Ex: 8 8 8")
    end
  end

  def correct_format?(reps)
    reps.split(' ').each do |rep|
      return false if /\A[\d]+\z/.match(rep).nil?
      return (1...100) === rep.to_i
    end
  end

end
