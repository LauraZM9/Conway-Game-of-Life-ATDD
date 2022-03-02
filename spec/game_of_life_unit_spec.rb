describe GameOfLife do
  context '#new_state_of_cell' do
    context 'when cell is dead' do
      it 'stays dead if its neighbours are all dead' do
        initial_state = :dead
        living_neighbours_count = 0

        new_state = subject.new_state_of_cell(initial_state, living_neighbours_count)

        expect(new_state).to eq(:dead)
      end

      it 'stay dead if only 1 neighbour is alive' do
        initial_state = :dead
        living_neighbours_count = 1

        new_state = subject.new_state_of_cell(initial_state, living_neighbours_count)

        expect(new_state).to eq(:dead)
      end

      it 'stay dead if 2 neighbours are alive' do
        initial_state = :dead
        living_neighbours_count = 2

        new_state = subject.new_state_of_cell(initial_state, living_neighbours_count)

        expect(new_state).to eq(:dead)
      end

      it 'become alive if 3 neighbours are alive' do
        initial_state = :dead
        living_neighbours_count = 3

        new_state = subject.new_state_of_cell(initial_state, living_neighbours_count)

        expect(new_state).to eq(:live)
      end

      alive_neighbours = [4, 5, 6, 7, 8]

      alive_neighbours.each do |living_neighbours_count|
        it 'stay dead if 4 or more neighbours are alive' do
          initial_state = :dead

          new_state = subject.new_state_of_cell(initial_state, living_neighbours_count)

          expect(new_state).to eq(:dead)
        end
      end
    end

    context 'when cell is alive' do
      context 'becomes dead because of underpopulation' do
        alive_neighbours = [0, 1]
        alive_neighbours.each do |living_neighbours_count|
          it "#{living_neighbours_count} alive neighbours" do
            initial_state = :live

            new_state = subject.new_state_of_cell(initial_state, living_neighbours_count)

            expect(new_state).to eq(:dead)
          end
        end
      end

      context 'becomes dead because of overpopulation' do
        alive_neighbours = [4, 5, 6, 7, 8]
        alive_neighbours.each do |living_neighbours_count|
          it "#{living_neighbours_count} alive neighbours" do
            initial_state = :live

            new_state = subject.new_state_of_cell(initial_state, living_neighbours_count)

            expect(new_state).to eq(:dead)
          end
        end
      end

      it 'stay alive if it has 2 alive neighbours' do
        initial_state = :live
        living_neighbours_count = 2

        new_state = subject.new_state_of_cell(initial_state, living_neighbours_count)

        expect(new_state).to eq(:live)
      end

      it 'stay alive if it has 3 alive neighbours' do
        initial_state = :live
        living_neighbours_count = 3

        new_state = subject.new_state_of_cell(initial_state, living_neighbours_count)

        expect(new_state).to eq(:live)
      end
    end
  end

  context '#number_of_living_neighbours' do
    it 'returns 0 given the middle cell in a dead grid' do
      target_cell = :dead

      dead_cells = [
        [:dead, :dead,        :dead],
        [:dead, :target_cell, :dead],
        [:dead, :dead,        :dead]
      ]

      cell_row = 1
      cell_column = 1

      expect(
        subject.number_of_living_neighbours(cell_row, cell_column, dead_cells)
      ).to eq(0)
    end

    context 'has alive cells on the same row' do
      context 'and target cell is in the middle' do
        it 'returns 1 given only one alive neighbour at the left' do
          target_cell = :dead

          dead_cells = [
            [:dead, :dead,        :dead],
            [:live, :target_cell, :dead],
            [:dead, :dead,        :dead]
          ]

          cell_row = 1
          cell_column = 1

          expect(
            subject.number_of_living_neighbours(cell_row, cell_column, dead_cells)
          ).to eq(1)
        end

        it 'returns 1 given only one alive neighbour at the right' do
          target_cell = :dead

          dead_cells = [
            [:dead, :dead,        :dead],
            [:dead, :target_cell, :live],
            [:dead, :dead,        :dead]
          ]

          cell_row = 1
          cell_column = 1

          expect(
            subject.number_of_living_neighbours(cell_row, cell_column, dead_cells)
          ).to eq(1)
        end

        it 'returns 2 given two alive neighbours at the left and right' do
          target_cell = :dead

          dead_cells = [
            [:dead, :dead,        :dead],
            [:live, :target_cell, :live],
            [:dead, :dead,        :dead]
          ]

          cell_row = 1
          cell_column = 1

          expect(
            subject.number_of_living_neighbours(cell_row, cell_column, dead_cells)
          ).to eq(2)
        end
      end

      context 'and target cell is on the first column' do
        it 'returns 1 given only one alive neighbours at the right' do
          target_cell = :dead

          dead_cells = [
            [:dead,        :dead, :dead],
            [:target_cell, :live, :live],
            [:dead,        :dead, :dead]
          ]

          cell_row = 1
          cell_column = 0

          expect(
            subject.number_of_living_neighbours(cell_row, cell_column, dead_cells)
          ).to eq(1)
        end
      end
    end
  end
end