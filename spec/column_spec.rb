# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/column'

describe Column do
  describe 'initialize' do
    context 'when a new column in created' do
      subject(:new_column) { described_class.new }

      it 'has a row length of 6' do
        row = new_column.row
        column_length = 6
        expect(row.length).to eq(column_length)
      end

      it 'has a count of zero' do
        expect(new_column.count).to be_zero
      end

      it 'is not full' do
        expect(new_column.full?).to be false
      end
    end
  end

  describe 'full?' do
    subject(:new_column) { described_class.new }

    context 'when row is not full' do
      it 'returns false' do
        expect(new_column.full?).to be false
      end
    end

    context 'when row is full' do
      it 'returns true' do
        new_column.row.map! { |spot| spot = '⚫' }
        expect(new_column.full?).to be true
      end
    end
  end
end
