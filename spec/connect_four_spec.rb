# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/connect_four'

describe ConnectFour do
  describe 'take_turn' do
    context 'when player picks a column' do
      subject(:connect_four) { described_class.new }
      let(:player_red) { connect_four.player_red }
      let(:grid) { connect_four.grid }

      context 'when the column in not full' do
        it 'drops piece at selected column' do
          allow(player_red).to receive(:input).and_return('7')
          expect(connect_four.take_turn(player_red)).to eq(:success)
        end
      end

      context 'when the column is full' do
        let(:full_column) { grid.columns[:seventh] }

        before do
          full_column.row = ['🔴', '⚫', '🔴', '⚫', '🔴', '⚫']
        end

        it 'fails once, then succeeds when another column is chosen' do
          allow(player_red).to receive(:input).and_return('7', '6')
          expect(connect_four.take_turn(player_red)).to eq(:success)
        end

        it 'fails three times, then succeeds when another column is chosen' do
          allow(player_red).to receive(:input).and_return('0', '7', '7', '4')
          expect(connect_four.take_turn(player_red)).to eq(:success)
        end
      end
    end
  end
end
