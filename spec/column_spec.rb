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
        expect(new_column.count).to be_zero
      end

      it 'is not full' do
        expect(new_column.full?).to be false
      end
    end
  end

  describe 'count' do
    context 'when three spots are occupied' do
      subject(:three_column) { described_class.new }

      before do
        three_column.spots.map!.with_index do |_spot, index|
          index.odd? ? '⚫' : '⚪'
        end
      end

      it 'returns 3' do
        three = 3
        expect(three_column.count).to eq(three)
      end
    end

    context 'when five spots are occupied' do
      subject(:five_column) { described_class.new }

      before do
        five_column.spots.map!.with_index do |_spot, index|
          index.zero? ? '⚪' : '⚫'
        end
      end

      it 'returns 5' do
        five = 5
        expect(five_column.count).to eq(five)
      end
    end
  end

  describe 'full?' do
    subject(:column) { described_class.new }

    context 'when column is not full' do
      it 'returns false' do
        expect(column.full?).to be false
      end
    end

    context 'when column is full' do
      it 'returns true' do
        column.spots.map! { |_spot| '⚫' }
        expect(column.full?).to be true
      end
    end
  end

  describe 'update' do
    subject(:column) { described_class.new }
    let(:symbol) { '⚫' }

    context 'when column is empty' do
      it 'updates the bottom spot' do
        expect { column.update(symbol) }.to change { column.spots.last }.to(symbol)
      end
    end

    context 'when column has two player pieces' do
      third_from_bottom = 3

      before do
        2.times { column.update(symbol) }
      end

      it 'updates the 3rd spot from the bottom' do
        expect { column.update(symbol) }.to change { column.spots[third_from_bottom] }.to(symbol)
      end
    end

    context 'when column has one empty space' do
      before do
        5.times { column.update(symbol) }
      end

      it 'updates the top column row' do
        expect { column.update(symbol) }.to change { column.spots.first }.to(symbol)
      end
    end

    context 'when column is full' do
      before do
        6.times { column.update(symbol) }
      end

      it 'does not update column' do
        expect(column.update(symbol)).to be nil
      end
    end
  end
end
