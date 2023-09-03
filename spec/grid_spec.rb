# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/grid'

describe Grid do
  subject(:grid) { described_class.new }
  let(:red_symbol) { '🔴' }
  let(:black_symbol) { '⚫' }

  describe 'update_column' do
    let(:index) { 6 }
    let(:black_symbol) { '⚫' }

    context 'when column is empty' do
      let(:position) { 5 }

      it 'drops piece to bottom spot' do
        expect { grid.update_column(index, black_symbol) }.to change { grid.columns[index][position] }.to(black_symbol)
      end
    end

    context 'when same column has one piece' do
      let(:next_position) { 4 }

      it 'drops piece on top of last one' do
        grid.update_column(index, black_symbol)
        expect { grid.update_column(index, black_symbol) }.to change { grid.columns[index][next_position] }.to(black_symbol)
      end
    end

    context 'when column is full' do
      before do
        6.times { grid.update_column(index, black_symbol) }
      end

      it 'returns false' do
        expect(grid.update_column(index, black_symbol)).to be false
      end
    end
  end

  describe 'four_in_column?' do
    let(:column_index) { 5 }

    context 'when four pieces match vertically' do
      context 'when last four spots match' do
        before do
          4.times { grid.update_column(column_index, red_symbol) }
        end

        it 'returns true' do
          expect(grid.four_in_column?(column_index, red_symbol)).to be true
        end
      end

      context 'when middle four spots match' do
        before do
          grid.update_column(column_index, black_symbol)
          4.times { grid.update_column(column_index, red_symbol) }
        end

        it 'returns true' do
          expect(grid.four_in_column?(column_index, red_symbol)).to be true
        end
      end

      context 'when top four spots match' do
        before do
          2.times { grid.update_column(column_index, black_symbol) }
          4.times { grid.update_column(column_index, red_symbol) }
        end

        it 'returns true' do
          expect(grid.four_in_column?(column_index, red_symbol)).to be true
        end
      end
    end

    context 'when four pieces are not contiguous' do
      before do
        2.times { grid.update_column(column_index, black_symbol) }
        2.times { grid.update_column(column_index, red_symbol) }
        2.times { grid.update_column(column_index, black_symbol) }
      end

      it 'returns false' do
        expect(grid.four_in_column?(column_index, black_symbol)).to be false
      end
    end
  end

  describe 'four_in_row?' do
    let(:last_row) { grid.rows[5] }
    let(:row_index) { 5 }

    context 'when first four match' do
      before do
        grid.update_column(0, red_symbol)
        grid.update_column(1, red_symbol)
        grid.update_column(2, red_symbol)
        grid.update_column(3, red_symbol)
      end

      it 'returns true' do
        expect(grid.four_in_row?(row_index, red_symbol)).to be true
      end
    end

    context 'when second four match' do
      before do
        grid.update_column(1, red_symbol)
        grid.update_column(2, red_symbol)
        grid.update_column(3, red_symbol)
        grid.update_column(4, red_symbol)
      end

      it 'returns true' do
        expect(grid.four_in_row?(row_index, red_symbol)).to be true
      end
    end

    context 'when third four match' do
      before do
        grid.update_column(2, red_symbol)
        grid.update_column(3, red_symbol)
        grid.update_column(4, red_symbol)
        grid.update_column(5, red_symbol)
      end

      it 'returns true' do
        expect(grid.four_in_row?(row_index, red_symbol)).to be true
      end
    end

    context 'when last four match' do
      before do
        grid.update_column(3, red_symbol)
        grid.update_column(4, red_symbol)
        grid.update_column(5, red_symbol)
        grid.update_column(6, red_symbol)
      end

      it 'returns true' do
        expect(grid.four_in_row?(row_index, red_symbol)).to be true
      end
    end

    context 'when four pieces are not contiguous' do
      before do
        grid.update_column(0, red_symbol)
        grid.update_column(1, red_symbol)
        grid.update_column(2, red_symbol)
        grid.update_column(3, black_symbol)
        grid.update_column(4, red_symbol)
        grid.update_column(5, black_symbol)
        grid.update_column(6, red_symbol)
      end

      it 'returns false' do
        expect(grid.four_in_row?(row_index, red_symbol)).to be false
      end
    end
  end

  describe 'four_in_diagonal?' do
    context 'when four pieces are in upright diagonal' do
      before do
        grid.update_column(0, black_symbol)
        2.times { grid.update_column(1, black_symbol) }
        3.times { grid.update_column(2, black_symbol) }
        grid.update_column(3, red_symbol)
        3.times { grid.update_column(3, black_symbol) }
      end

      it 'returns true' do
        expect(grid.four_in_diagonal?(3, black_symbol)).to be true
      end
    end
  end
end
