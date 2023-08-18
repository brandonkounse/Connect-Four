# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/connect_four'

describe ConnectFour do
  describe 'take_turn' do
    context 'when player takes a turn' do
      subject(:connect_four) { described_class.new }
      let(:player_red) { connect_four.player_red }

      context 'when receiving invalid input' do

        before do
          allow(player_red).to receive(:gets).and_return('37', '7')
        end

        it 'advises to pick a column 1 thru 7' do
          expect { connect_four.take_turn(player_red) }.to output("Please pick a column from 1 thru 7\n").to_stdout
        end

        it 'returns false' do
          expect(connect_four.take_turn(player_red)).to be false
        end
      end

      context 'when receiving valid input' do
        it 'returns true' do
          allow(player_red).to receive(:gets).and_return('7')
          expect(connect_four.take_turn(player_red)).to be true
        end
      end
    end
  end
end
