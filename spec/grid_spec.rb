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
        row = columns[:first].row
        grid_height = 6
        expect(row.length).to eq(grid_height)
      end
    end
  end

  describe 'update' do
    context 'when column is not full' do
      subject(:new_grid) { described_class.new }
      let(:current_column) { new_grid.columns[:first] }
      let(:player_symbol) { '🔴' }

      it 'updates closest available spot from bottom' do
        expect { new_grid.update(current_column, player_symbol) }.to change { current_column.row.last }.to('🔴')
      end

      it 'updates second to last spot from bottom' do
        current_column.row[5] = '🔴'
        expect { new_grid.update(current_column, player_symbol) }.to change { current_column.row[4] }.to('🔴')
      end

      it 'updates top row for a full column' do
        current_column.row = [nil, '🔴', '🔴', '🔴', '🔴', '🔴']
        expect { new_grid.update(current_column, player_symbol) }.to change { current_column.row.first }.to('🔴')
      end
    end

    context 'when column is full' do
      subject(:new_grid) { described_class.new }
      let(:full_column) { new_grid.columns[:second] }
      let(:player_symbol) { '⚫' }

      it 'returns full' do
        full_column.row = ['⚫', '⚫', '⚫', '⚫', '⚫', '⚫']
        expect(new_grid.update(full_column, player_symbol)).to eq(:full)
      end
    end
  end

  describe 'list' do
    subject(:new_grid) { described_class.new }
    let(:element_array) { [] }
    let(:block) { proc { |x| element_array << 'x' if x.nil? } }

    context 'when block is given that stores elements' do
      it 'returns correct length of array' do
        new_grid.list(&block)
        expect(element_array.length).to eq(42)
      end
    end

    context 'when no block is provided' do
      it 'does not yield elements' do
        expect(new_grid.list).to be nil
      end
    end
  end
end
