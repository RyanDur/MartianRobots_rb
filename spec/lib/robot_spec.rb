require_relative '../spec_helper'
require 'robot'
require 'position'
require 'instruction'

describe Robot do
  let(:position) { double('Position') }
  let(:instruction) { double('Instruction') }
  let(:robot) { Robot.new(position) }

  it 'should be able to execute an instruction' do
    expect(instruction).to receive(:execute)
    robot.move(instruction)
  end

  it 'should return a new robot when moving' do
    allow(instruction).to receive(:execute).and_return(position)
    robot2 = robot.move(instruction)
    expect(robot2).to_not be equal? robot
  end

  it 'should report its position when printed' do
    allow(position).to receive(:to_s).and_return('wassup')
    expect("#{robot}").to eq 'wassup'
  end

  context 'equal' do
    let(:position2) { double('Position') }
    let(:robot2) { Robot.new(position2) }

    it 'should override ==' do
      allow(position).to receive(:==).and_return(true)
      expect(robot == robot2).to be(true)
    end
  end

  context 'not equal' do
    let(:position2) { double('Position') }
    let(:robot2) { Robot.new(position2) }

    it 'should override ==' do
      expect(robot == robot2).to be(false)
    end
  end

  it 'should be able to see if a list contains a similar position' do
    s = []
    allow(instruction).to receive(:execute).and_return(position)
    allow(position).to receive(:==).and_return(true)
    other = robot.move(instruction)
    s.push(other)
    expect(s.include?(other)).to be true
  end
end