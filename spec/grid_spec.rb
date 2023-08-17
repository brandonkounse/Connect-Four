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
        first_row = 0
        grid_height = 6
        expect(columns[first_row].length).to eq(grid_height)
      end
    end
  end
end
