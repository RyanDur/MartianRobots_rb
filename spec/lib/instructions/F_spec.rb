require_relative '../../spec_helper'
require 'instructions/F'

describe F do
  it 'should be able to move north' do
    position = double('Position', x: 1, y: 2, orientation: 'N')
    expect(position).to receive(:set).with(1, 3, 'N')
    subject.execute(position)
  end

  it 'should be able to move west' do
    position = double('Position', x: 1, y: 2, orientation: 'W')
    expect(position).to receive(:set).with(0, 2, 'W')
    subject.execute(position)
  end

  it 'should be able to move south' do
    position = double('Position', x: 1, y: 2, orientation: 'S')
    expect(position).to receive(:set).with(1, 1, 'S')
    subject.execute(position)
  end

  it 'should be able to move east' do
    position = double('Position', x: 1, y: 2, orientation: 'E')
    expect(position).to receive(:set).with(2, 2, 'E')
    subject.execute(position)
  end
end