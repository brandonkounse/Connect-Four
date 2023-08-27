# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/grid'

describe Grid do
  describe 'drop_piece' do
    subject(:grid) { described_class.new }
    let(:column) { 6 }
    let(:symbol) { '⚫' }

    context 'when column is empty' do
      it 'drops piece to bottom spot' do
        expect { grid.drop_piece(column, symbol) }.to change { grid.spots[6][5] }.to(symbol)
      end
    end
  end
end
