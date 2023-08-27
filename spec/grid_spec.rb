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
        spots = columns[:first].spots
        grid_height = 6
        expect(spots.length).to eq(grid_height)
      end
    end
  end

  describe 'update' do
    subject(:grid) { described_class.new }
    let(:column) { grid.columns[:first] }
    let(:symbol) { '🔴' }

    context 'when a column is successfully updated' do
      it 'returns :success' do
        expect(grid.update(column, symbol)).to eq(:success)
      end
    end

    context 'when a column fails to update' do
      before do
        6.times { grid.update(column, symbol) }
      end

      it 'returns :full' do
        expect(grid.update(column, symbol)).to eq(:full)
      end
    end
  end

  describe 'rows' do
    subject(:grid) { described_class.new }

    context 'when all indices are empty' do
      it 'returns a queue of 42 ⚪' do
        expect(grid.rows.count('⚪')).to eq(42)
      end
    end
  end

  describe 'full?' do
    subject(:full_grid) { described_class.new }

    context 'when grid is full' do
      before do
        full_grid.columns.each_pair do |_key, value|
          value.spots.map! { '⚫' }
        end
      end

      it 'returns true' do
        expect(full_grid.full?).to be true
      end
    end
  end
end
