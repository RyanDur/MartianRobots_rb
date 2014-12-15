require_relative '../spec_helper'
require 'robot'
require 'position'
require 'instructions/R'

describe Robot do
  let(:position) { double('Position') }
  let(:instruction) { double('R') }
  let(:robot) { Robot.new(position) }

  it 'should be able to execute an instruction' do
    expect(instruction).to receive(:execute)
    robot.move(instruction)
  end

  it 'should return a new robot when moving' do
    allow(instruction).to receive(:execute).with(position).and_return(position)
    robot2 = robot.move(instruction)
    expect(robot2).to_not be equal? robot
  end

  it 'should report its position when printed' do
    allow(position).to receive(:to_s).and_return('wassup')
    expect("#{robot}").to eq 'wassup'
  end
end