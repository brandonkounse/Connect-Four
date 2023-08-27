# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/column'

describe Column do
  describe 'initialize' do
    context 'when a new column in created' do
      subject(:new_column) { described_class.new }

      it 'has a length of 6' do
        spots = new_column.spots
        column_length = 6
        expect(spots.length).to eq(column_length)
      end

      it 'has a count of zero' do
        expect(new_column.current_count).to be_zero
      end

      it 'is not full' do
        expect(new_column.full?).to be false
      end
    end
  end

  describe 'full?' do
    subject(:new_column) { described_class.new }

    context 'when column is not full' do
      it 'returns false' do
        expect(new_column.full?).to be false
      end
    end

    context 'when column is full' do
      it 'returns true' do
        new_column.spots.map! { |_spot| '⚫' }
        expect(new_column.full?).to be true
      end
    end
  end
end
