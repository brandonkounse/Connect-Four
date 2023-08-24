# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/grid'

describe Grid do
  describe 'initialize' do
    context 'when a new grid is created' do
      subject(:new_grid) { described_class.new }
      let(:columns) { new_grid.columns }

      it 'has a grid width of 7' do
        grid_width = 7
        expect(columns.length).to eq(grid_width)
      end

      it 'has a grid height of 6' do
        squares = columns[:first].squares
        grid_height = 6
        expect(squares.length).to eq(grid_height)
      end
    end
  end

  describe 'update' do
    context 'when column is not full' do
      subject(:new_grid) { described_class.new }
      let(:current_column) { new_grid.columns[:first] }
      let(:player_symbol) { '🔴' }

      it 'updates closest available spot from bottom' do
        expect { new_grid.update(current_column, player_symbol) }.to change { current_column.squares.last }.to('🔴')
      end

      it 'updates second to last spot from bottom' do
        current_column.squares[5] = '🔴'
        expect { new_grid.update(current_column, player_symbol) }.to change { current_column.squares[4] }.to('🔴')
      end

      it 'updates top squares for a full column' do
        current_column.squares = ['◯', '🔴', '🔴', '🔴', '🔴', '🔴']
        expect { new_grid.update(current_column, player_symbol) }.to change { current_column.squares.first }.to('🔴')
      end
    end

    context 'when column is full' do
      subject(:new_grid) { described_class.new }
      let(:full_column) { new_grid.columns[:second] }
      let(:player_symbol) { '⚫' }

      it 'returns full' do
        full_column.squares = ['⚫', '⚫', '⚫', '⚫', '⚫', '⚫']
        expect(new_grid.update(full_column, player_symbol)).to eq(:full)
      end
    end
  end

  describe 'rows' do
    subject(:grid) { described_class.new }

    context 'when all indices are empty' do
      it 'returns a queue of 42 ◯' do
        expect(grid.rows.count('◯')).to eq(42)
      end
    end
  end
end
