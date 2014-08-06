require_relative '../lib/grid.rb'

# 2 or 3 live neighbors => stay alive
# < 2 live neighbors => die of loneliness
# > 3 live neighbors => die of overcrowding
# dead cell with == 3 live neighbors => come alive

# Assignment: create grid that returns new state with tick() is called
# 1) start with dead -> dead
# 2) still life (2x2)
# 3) another still life (6x5)
# 4) oscillator (5x5)
# 5) another oscillator (6x6)
# 6) add recursion to visualize the grid changing

describe Grid do

  it 'should be' do
    expect(Grid.new([])).to_not be(nil)
  end

  context 'when all cells are dead' do
    it 'should return grid with all cells still dead' do
      dead_grid = [
        [0, 0, 0],
        [0, 0, 0],
        [0, 0, 0]
      ]
      expect(Grid.new(dead_grid).tick).to eq(dead_grid)
    end
  end

  context 'when one cell is alive' do
    it 'should return grid with all cells dead' do
      lonely_grid = [
        [0, 0, 0],
        [0, 1, 0],
        [0, 0, 0]
      ]
      expect(Grid.new(lonely_grid).tick).to eq([
                                               [0, 0, 0],
                                               [0, 0, 0],
                                               [0, 0, 0]
                                             ])
    end
  end

  context 'when cells should stay alive' do
    it 'should return the same grid' do
      still_live_grid = [
        [0, 0, 0, 0],
        [0, 1, 1, 0],
        [0, 1, 1, 0],
        [0, 0, 0, 0]
      ]

      expect(Grid.new(still_live_grid).tick).to eq(still_live_grid)
    end
  end

  context 'when cells should should stay alive' do
    it 'should return the same grid' do
      still_live_grid = [
        [0, 0, 0, 0, 0, 0],
        [0, 0, 1, 1, 0, 0],
        [0, 1, 0, 0, 1, 0],
        [0, 0, 1, 1, 0, 0],
        [0, 0, 0, 0, 0, 0]
      ]
      expect(Grid.new(still_live_grid).tick).to eq(still_live_grid)
    end
  end

  context 'when cells should oscillate -- live, die, and be reborn repeatedly' do
    it 'should return an oscillating grid' do
      first_grid = [
        [0, 0, 0, 0, 0],
        [0, 0, 1, 0, 0],
        [0, 0, 1, 0, 0],
        [0, 0, 1, 0, 0],
        [0, 0, 0, 0, 0]
      ]
      expect(Grid.new(first_grid).tick).to eq([
                                                     [0, 0, 0, 0, 0],
                                                     [0, 0, 0, 0, 0],
                                                     [0, 1, 1, 1, 0],
                                                     [0, 0, 0, 0, 0],
                                                     [0, 0, 0, 0, 0]
                                                   ])
    end
  end

  context 'when cells should oscillate -- live, die, and be reborn repeatedly' do
    it 'should return an oscillating grid' do
      first_grid = [
        [0, 0, 0, 0, 0, 0],
        [0, 1, 1, 0, 0, 0],
        [0, 1, 0, 0, 0, 0],
        [0, 0, 0, 0, 1, 0],
        [0, 0, 0, 1, 1, 0],
        [0, 0, 0, 0, 0, 0]
      ]
      expect(Grid.new(first_grid).tick).to eq([
                                                [0, 0, 0, 0, 0, 0],
                                                [0, 1, 1, 0, 0, 0],
                                                [0, 1, 1, 0, 0, 0],
                                                [0, 0, 0, 1, 1, 0],
                                                [0, 0, 0, 1, 1, 0],
                                                [0, 0, 0, 0, 0, 0]
                                              ])
    end
  end
end
