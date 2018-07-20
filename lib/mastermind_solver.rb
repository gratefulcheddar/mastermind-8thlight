require_relative './mastermind'

class MastermindSolver
  def build_set_of_all_possibilities
    Mastermind::COLOR_OPTIONS.repeated_permutation(4)
  end
end