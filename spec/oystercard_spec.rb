require 'oystercard'

RSpec.describe Oystercard do
  subject(:oystercard) { described_class.new }
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }

  it { is_expected.to(respond_to(:top_up).with(1).argument) }

  context 'Balance' do
    it 'the balance is zero' do
      expect(oystercard.balance).to eq(0)
    end

    it 'can top up the balance' do
      expect { oystercard.top_up 1 }.to change { oystercard.balance }.by 1
    end

    it 'raises an error if the maximum balance is exceeded' do
      oystercard.top_up(Oystercard::MAXIMUM_BALANCE)
      expect { oystercard.top_up(1) }.to raise_exception "Error: maximum balance of #{Oystercard::MAXIMUM_BALANCE} exceeded"
    end
  end

  context 'journey' do
    it 'is initially not in a journey' do
      expect(oystercard).not_to be_in_journey
    end

    it 'remembers the entry station' do
      oystercard.top_up(10)
      oystercard.touch_in(entry_station)
      expect(oystercard.entry_station).to eq entry_station
    end

    it 'oystercard has an initial blank journey history' do
      expect(oystercard.journey_history).to eq []
    end

    it 'has a journey history' do
      oystercard.top_up(10)
      oystercard.touch_in(entry_station)
      oystercard.touch_out(exit_station)
      current_journey = { entry_station: entry_station, exit_station: exit_station }
      expect(oystercard.journey_history).to include current_journey
    end
  end

  context 'touch_in/out' do
    it 'can touch in' do
      oystercard.top_up(10)
      oystercard.touch_in(entry_station)
      expect(oystercard).to be_in_journey
    end

    it 'can touch out' do
      oystercard.touch_out(exit_station)
      expect(oystercard).not_to be_in_journey
    end

    it 'raises an error if card does not have minimum balance' do
      expect { oystercard.touch_in(entry_station) }.to raise_error 'Cannot touch in: minimum balance not met'
    end

    it 'deducts the mimimum balance from the card balance' do
      oystercard.top_up Oystercard::CARD_MIN_BALANCE
      oystercard.touch_in(entry_station)
      expect { oystercard.touch_out(exit_station) }.to change { oystercard.balance }.by -Oystercard::CARD_MIN_BALANCE
    end
  end
end
