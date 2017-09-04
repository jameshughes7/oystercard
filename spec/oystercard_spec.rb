require 'oystercard'

RSpec.describe Oystercard do
#subject {described_class.new(balance: 0) }

    it { is_expected.to(respond_to(:top_up).with(1).argument) }
    it { is_expected.to(respond_to(:deduct).with(1).argument) }

  describe '#starting_balance' do
    it "the balance is zero" do
      expect(subject.balance).to eq(0)
    end
  end

  describe '#top_up' do
    it "can top up the balance" do
      expect{ subject.top_up (1) }.to change{ subject.balance }.by (1)
    end

    it "raises an error if the maximum balance is exceeded" do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      subject.top_up(maximum_balance)
      expect{ subject.top_up(1) }.to raise_exception "Error: maximum balance of #{maximum_balance} exceeded"
    end
  end

  describe '#deduct_fare' do
    it "can deduct money from the balance" do
      expect{ subject.deduct (1) }.to change{ subject.balance }.by (-1)
    end
  end

end




  #it "add money to my card" do
  #  expect(subject.top_up).to change(subject, :balance).by value
  #end
