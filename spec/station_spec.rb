require 'station'

RSpec.describe Station do
  subject(:station) { described_class.new('London Bridge', 1) }

  it 'knows its name' do
    expect(station.name).to eq 'London Bridge'
  end

  it 'knows its zone' do
    expect(station.zone).to eq(1)
  end
end
