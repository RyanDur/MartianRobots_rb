require_relative '../../spec_helper'
require 'instructions/R'

describe R do

  it 'should go from North to East' do
    position = double('Position', x: 1, y: 2, orientation: 'N')
    expect(position).to receive(:set).with(1, 2, 'E')
    subject.execute(position)
  end

  it 'should go from East to South' do
    position = double('Position', x: 1, y: 2, orientation: 'E')
    expect(position).to receive(:set).with(1, 2, 'S')
    subject.execute(position)
  end

  it 'should go from South to West' do
    position = double('Position', x: 1, y: 2, orientation: 'S')
    expect(position).to receive(:set).with(1, 2, 'W')
    subject.execute(position)
  end

  it 'should go from West to North' do
    position = double('Position', x: 1, y: 2, orientation: 'W')
    expect(position).to receive(:set).with(1, 2, 'N')
    subject.execute(position)
  end
end