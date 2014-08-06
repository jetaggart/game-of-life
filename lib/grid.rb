class Grid

  def initialize(original_grid)
    @grid = []
    original_grid.each_with_index do |row, x|
      new_row = []

      row.each_with_index do |cell, y|
        new_row.push(
          Cell.new(cell, Neighbors.new(x, y, original_grid))
        )
      end

      @grid.push(new_row)
    end
  end

  def tick
    format_grid(@grid)
  end

  private

  def format_grid(grid)
    @grid.map do |row|
      row.map do |cell|
        cell.alive? ? 1 : 0
      end
    end
  end

  class Cell
    def initialize(aliveness, neighbors)
      @aliveness = aliveness
      @neighbors = neighbors
    end

    def alive?
      if dead?
        should_live?
      else
        !should_die?
      end
    end

    private

    def dead?
      @aliveness == 0
    end

    def should_live?
      if @neighbors.alive == 3
        true
      else
        false
      end
    end

    def should_die?
      if @neighbors.alive < 2
        true
      elsif @neighbors.alive > 3
        true
      else
        false
      end
    end
  end

  class Neighbors
    attr_reader :x, :y, :grid

    def initialize(x, y, grid)
      @x = x
      @y = y
      @grid = grid
    end

    def alive
      neighbors.select { |neighbor| neighbor == 1 }.length
    end

    private

    def max_x
      @grid.length - 1
    end

    def max_y
      @grid.first.length - 1
    end

    def neighbors
      all_possible_neighbors
        .select { |pos| valid_pos?(pos) }
        .map { |pos| @grid[pos[:x]][pos[:y]] }
    end

    def valid_pos?(pos)
      pos[:x] >= 0 && pos[:y] >= 0 && pos[:x] <= max_x && pos[:y] <= max_y
    end

    def all_possible_neighbors
      [
        {:x => x - 1, :y => y - 1},
        {:x => x - 1, :y => y},
        {:x => x - 1, :y => y + 1},
        {:x => x, :y => y - 1},
        {:x => x, :y => y + 1},
        {:x => x + 1, :y => y - 1},
        {:x => x + 1, :y => y},
        {:x => x + 1, :y => y + 1}
      ]
    end
  end
end

