require 'oystercard'
RSpec.describe Oystercard do
  subject(:oystercard) { described_class.new }
  let(:station_name){double :station_name}

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
      oystercard.touch_in(station_name)
      expect(oystercard.entry_station).to eq station_name
    end
  end

  it 'knows what station_name is' do
    expect(station_name).to eq station_name
  end

  context 'touch_in/out' do
    it 'can touch in' do
      oystercard.top_up(10)
      oystercard.touch_in(station_name)
      expect(oystercard).to be_in_journey
    end

    it 'can touch out' do
      oystercard.touch_out
      expect(oystercard).not_to be_in_journey
    end

    it 'raises an error if card does not have minimum balance' do
      expect { oystercard.touch_in(station_name) }.to raise_error 'Cannot touch in: minimum balance not met'
    end

    it 'deducts the mimimum balance from the card balance' do
      oystercard.top_up Oystercard::CARD_MIN_BALANCE
      oystercard.touch_in(station_name)
      expect { oystercard.touch_out }.to change { oystercard.balance }.by -Oystercard::CARD_MIN_BALANCE
    end
  end
end
