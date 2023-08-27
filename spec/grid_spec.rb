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

      it 'returns :full' do
        expect(grid.drop_piece(column, symbol)).to be :full
      end
    end
  end
end
