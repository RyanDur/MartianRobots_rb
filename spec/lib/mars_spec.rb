require 'spec_helper'
require 'mars'
require 'position'
require 'robot'

describe Mars do

  context '#setup' do
    it 'should not be wider than 50' do
      expect { subject.setup(51, 3) }.to raise_error ArgumentError
    end

    it 'should not be thinner than 0' do
      expect { subject.setup(-1, 3) }.to raise_error ArgumentError
    end

    it 'should not be taller than 50' do
      expect { subject.setup(1, 53) }.to raise_error ArgumentError
    end

    it 'should not be shorter than 0' do
      expect { subject.setup(1, -3) }.to raise_error ArgumentError
    end

    it 'should be smaller than 50' do
      expect { subject.setup(1, 3) }.not_to raise_error
    end
  end

  context '#set_robot' do
    let(:loc) { instance_double('Position') }
    let(:robot) { instance_double('Robot', location: loc) }
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
end