require 'oystercard'
RSpec.describe Oystercard do
  subject(:oystercard) { described_class.new }

    it { is_expected.to(respond_to(:top_up).with(1).argument) }
    it { is_expected.to(respond_to(:deduct).with(1).argument) }

  context 'Balance' do
    it "the balance is zero" do
      expect(oystercard.balance).to eq(0)
    end

    it "can top up the balance" do
      expect{ oystercard.top_up (1) }.to change{ oystercard.balance }.by (1)
    end

    it "raises an error if the maximum balance is exceeded" do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      oystercard.top_up(maximum_balance)
      expect{ oystercard.top_up(1) }.to raise_exception "Error: maximum balance of #{maximum_balance} exceeded"
    end

    it "can deduct money from the balance" do
      expect{ oystercard.deduct (1) }.to change{ oystercard.balance }.by (-1)
    end
  end

  context 'journey' do
    it 'is initially not in a journey' do
      expect(oystercard).not_to be_in_journey
    end

    it 'can touch in' do
      oystercard.touch_in
      expect(oystercard).to be_in_journey
    end

    it 'can touch out' do
      oystercard.touch_out
      expect(oystercard).not_to be_in_journey
    end

    it 'will not touch in if below minimum balance' do
      expect{ oystercard.touch_in }.to raise_error "Insufficient balance to touch in"
    end
  end
end
=begin
   it 'raises an error if card does not have minimum balance' do
      card_min_balance = Oystercard::CARD_LIMIT
      oystercard.touch_in
      expect{ oystercard.touch_in}.to raise_error 'Cannot touch in: minimum balance not met'
    end
=end
