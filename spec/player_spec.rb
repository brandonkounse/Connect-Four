# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/player'

describe Player do
  describe 'initialize' do
    context 'when a new player is created' do
      subject(:player) { described_class.new(name: 'tester', symbol: '🔴') }

      it 'assigns name to a player' do
        expect(player.name).to be('tester')
      end

      it 'assigns red circle for symbol' do
        expect(player.symbol).to be('🔴')
      end
    end
  end
end
