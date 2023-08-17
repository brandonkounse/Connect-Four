# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/grid'

describe Grid do
  describe 'initialize' do
    context 'when a new grid is created' do
      subject(:new_grid) { described_class.new }
      let(:columns) { new_grid.columns }

      it 'creates a 2D array of 7 col x 6 rows' do
        grid_width = 7
        expect(columns.length).to eq(grid_width)
      end
    end
  end
end
