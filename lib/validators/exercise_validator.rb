module ExerciseValidator

  def reps_format
    unless correct_format?(reps)
      errors.add(:reps, "must be a number from 1 to 20 and seperated by a space. Ex: 8 8 8")
    end
  end

  def correct_format?(reps)
    reps.split(' ').each do |rep|
      return false if /\A[1-9]+\z/.match(rep).nil?
      return false unless (1...21) === rep.to_i
      true
    end
  end

end
