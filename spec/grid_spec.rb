# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/grid'

describe Grid do
  describe 'drop_piece' do
    subject(:grid) { described_class.new }
    let(:column) { 6 }
    let(:symbol) { '⚫' }

    context 'when column is empty' do
      let(:index) { 5 }

      it 'drops piece to bottom spot' do
        expect { grid.drop_piece(column, symbol) }.to change { grid.spots[column][index] }.to(symbol)
      end
    end

    context 'when same column has one piece' do
      let(:next_index) { 4 }

      it 'drops piece on top of last one' do
        grid.drop_piece(column, symbol)
        expect { grid.drop_piece(column, symbol) }.to change { grid.spots[column][next_index] }.to(symbol)
      end
    end

    context 'when column is full' do
      before do
        6.times { grid.drop_piece(column, symbol) }
      end

      it 'returns false' do
        expect(grid.drop_piece(column, symbol)).to be false
      end
    end
  end

  describe 'four_in_column?' do
    subject(:grid) { described_class.new }
    let(:column_index) { 5 }
    let(:red_symbol) { '🔴' }
    let(:black_symbol) { '⚫' }

    context 'when four pieces match vertically' do
      context 'when last four spots match' do
        before do
          4.times { grid.drop_piece(column_index, red_symbol) }
        end

        it 'returns true' do
          expect(grid.four_in_column?(column_index, red_symbol)).to be true
        end
      end

      context 'when middle four spots match' do
        before do
          grid.drop_piece(column_index, black_symbol)
          4.times { grid.drop_piece(column_index, red_symbol) }
        end

        it 'returns true' do
          expect(grid.four_in_column?(column_index, red_symbol)).to be true
        end
      end

      context 'when top four spots match' do
        before do
          2.times { grid.drop_piece(column_index, black_symbol) }
          4.times { grid.drop_piece(column_index, red_symbol) }
        end

        it 'returns true' do
          expect(grid.four_in_column?(column_index, red_symbol)).to be true
        end
      end
    end

    context 'when four pieces are not contiguous' do
      before do
        2.times { grid.drop_piece(column_index, black_symbol) }
        2.times { grid.drop_piece(column_index, red_symbol) }
        2.times { grid.drop_piece(column_index, black_symbol) }
      end

      it 'returns false' do
        expect(grid.four_in_column?(column_index, black_symbol)).to be false
      end
    end
  end

  describe 'four_in_row?' do
    subject(:grid) { described_class.new }
    let(:last_row) { grid.spots.transpose[5] }
    let(:row_index) { 5 }
    let(:red_symbol) { '🔴' }
    let(:black_symbol) { '⚫' }

    context 'when first four match' do
      before do
        grid.drop_piece(0, red_symbol)
        grid.drop_piece(1, red_symbol)
        grid.drop_piece(2, red_symbol)
        grid.drop_piece(3, red_symbol)
      end

      it 'returns true' do
        expect(grid.four_in_row?(row_index, red_symbol)).to be true
      end
    end
  end
end
