require 'mastermind_solver'

RSpec.describe "MastermindSolver" do
  describe '#build_set_of_all_possibilities' do
    let(:solver) { MastermindSolver.new }
    let(:combination_set) { solver.build_set_of_all_possibilities }

    it 'creates a set of that is the same size as all possible code combinations' do
      solver = MastermindSolver.new
      all_combinations_count = Mastermind::COLOR_OPTIONS.count ** Mastermind::SECRET_LENGTH
      combination_set = solver.build_set_of_all_possibilities
      expect(combination_set.count).to eq(all_combinations_count)
    end

    it 'creates a set of combinations that only include valid color options' do
      are_valid = true
      combination_set.each do |combination|
        unless combination.all? { |color| Mastermind::COLOR_OPTIONS.include? color }
          are_valid = false
          break
        end
      end
      expect(are_valid).to be true
    end
  end 
end