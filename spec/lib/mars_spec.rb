require 'spec_helper'
require 'mars'
require 'position'
require 'robot'
require 'lang/max'
include Max

describe Mars do
  context '#setup' do
    it 'should not be wider than 50' do
      expect { subject.setup(MAX_GRID_SIZE + 1, 3) }.to raise_error ArgumentError
    end

    it 'should not be thinner than 0' do
      expect { subject.setup(-1, 3) }.to raise_error ArgumentError
    end

    it 'should not be taller than 50' do
      expect { subject.setup(1, MAX_GRID_SIZE + 3) }.to raise_error ArgumentError
    end

    it 'should not be shorter than 0' do
      expect { subject.setup(1, -3) }.to raise_error ArgumentError
    end

    it 'should be smaller than 50' do
      expect { subject.setup(1, 3) }.not_to raise_error
    end
  end

  context '#set_robot' do
    let(:loc) { double('Position') }
    let(:robot) { double('Robot', location: loc) }
    before(:each) { subject.setup(5, 3) }

    it 'should not allow a robot to be larger than the width of the boundary' do
      allow(loc).to receive_messages(x: 20, y: 1)
      expect { subject.set_robot(robot) }.to raise_error ArgumentError
    end

    it 'should not allow a robot to be less than the minimum width of the boundary' do
      allow(loc).to receive_messages(x: -1, y: 1)
      expect { subject.set_robot(robot) }.to raise_error ArgumentError
    end

    it 'should not allow a robot to be larger than the height of the boundary' do
      allow(loc).to receive_messages(x: 1, y: 10)
      expect { subject.set_robot(robot) }.to raise_error ArgumentError
    end

    it 'should not allow a robot to be less than the minimum height of the boundary' do
      allow(loc).to receive_messages(x: -1, y: 1)
      expect { subject.set_robot(robot) }.to raise_error ArgumentError
    end

    it 'should allow a robot to be set' do
      allow(loc).to receive_messages(x: 1, y: 1)
      expect { subject.set_robot(robot) }.to_not raise_error
    end
  end

  context 'should be able to move a robot' do
    let(:loc) { double('Position', x: 1, y: 1) }
    let(:robot) { double('Robot', location: loc) }
    before(:each) {
      allow(robot).to receive(:move).with('F')
      allow(robot).to receive(:move).with('R')
      allow(robot).to receive(:to_s).and_return('hello')
      subject.setup(5, 3)
      subject.set_robot(robot)
    }

    it 'should be able to execute instructions' do
      expect(robot).to receive(:move).ordered.with('F').twice
      expect(robot).to receive(:move).ordered.with('R')
      subject.move('FFR')
    end

    it 'should be able to tell if a robot is lost' do
      allow(loc).to receive(:x).and_return(1, -1)
      subject.move('FFR')
      expect(subject.get_robot_position).to eq('hello LOST')
    end

    context 'instructions' do
      it 'should not be able to input an invalid instruction size' do
        expect {subject.move('F' * MAX_INSTRUCTION_SIZE) }.to raise_error ArgumentError
      end
    end
  end
end