# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/connect_four'

describe ConnectFour do
  describe 'take_turn' do
    context 'when player picks a column' do
      subject(:connect_four) { described_class.new }
      let(:player_red) { connect_four.player_red }
      let(:player_black) { connect_four.player_black }
      let(:grid) { connect_four.grid }
      let(:last_spot) { 5 }

      context 'when the column in not full' do
        it 'drops piece at selected column' do
          column = grid.columns[:seventh]
          allow(player_red).to receive(:input).and_return('7')
          expect { connect_four.take_turn(player_red) }.to change { column.spots[last_spot] }.to('🔴')
        end

        it 'drop another piece at same column' do
          column = grid.columns[:seventh]
          allow(player_red).to receive(:input).and_return('7')
          allow(player_black).to receive(:input).and_return('7')
          connect_four.take_turn(player_red)
          expect { connect_four.take_turn(player_black) }.to change { column.spots[last_spot - 1] }.to('⚫')
        end
      end

      context 'when the column is full' do
        let(:full_column) { grid.columns[:seventh] }

        before do
          full_column.spots = ['🔴', '⚫', '🔴', '⚫', '🔴', '⚫']
        end

        it 'fails once, then succeeds when another column is chosen' do
          column = grid.columns[:sixth]
          allow(player_red).to receive(:input).and_return('7', '6')
          expect { connect_four.take_turn(player_red) }.to change { column.spots[last_spot] }.to('🔴')
        end

        it 'fails three times, then succeeds when another column is chosen' do
          column = grid.columns[:fourth]
          allow(player_red).to receive(:input).and_return('0', '7', '7', '4')
          expect { connect_four.take_turn(player_red) }.to change { column.spots[last_spot] }.to('🔴')
        end
      end
    end
  end
end
