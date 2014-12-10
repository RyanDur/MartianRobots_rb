require_relative '../spec_helper'
require 'mars'
require 'position'
require 'robot'
require 'instruction'
require 'lang/max'
include Max

describe Mars do
  context '#setup' do
    it "should not be wider than #{MAX_GRID_SIZE}" do
      expect { subject.setup(MAX_GRID_SIZE + 1, 3) }.to raise_error ArgumentError
    end

    it 'should not be thinner than 0' do
      expect { subject.setup(-1, 3) }.to raise_error ArgumentError
    end

    it "should not be taller than #{MAX_GRID_SIZE}" do
      expect { subject.setup(1, MAX_GRID_SIZE + 3) }.to raise_error ArgumentError
    end

    it 'should not be shorter than 0' do
      expect { subject.setup(1, -3) }.to raise_error ArgumentError
    end

    context 'when resetting mars' do
      before {subject.setup(7, 5)}

      it "should allow to reset and maintain a size smaller than #{MAX_GRID_SIZE}" do
        expect { subject.setup(8, 3) }.not_to raise_error
      end

      it "should not be wider than #{MAX_GRID_SIZE}" do
        expect { subject.setup(MAX_GRID_SIZE + 1, 3) }.to raise_error ArgumentError
      end

      it 'should not be thinner than 0' do
        expect { subject.setup(-1, 3) }.to raise_error ArgumentError
      end

      it "should not be taller than #{MAX_GRID_SIZE}" do
        expect { subject.setup(1, MAX_GRID_SIZE + 3) }.to raise_error ArgumentError
      end

      it 'should not be shorter than 0' do
        expect { subject.setup(1, -3) }.to raise_error ArgumentError
      end
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
  end

  context 'moving a robot' do
    context 'instructions' do
      let(:loc) { double('Position', x: 1, y: 1) }
      let(:robot) { double('Robot', location: loc) }
      let(:ins1) {double('Instruction')}
      let(:ins2) {double('Instruction')}
      let(:ins3) {double('Instruction')}
      let(:instructions) {[ins1, ins2, ins3]}

      before(:each) {
        allow(robot).to receive(:move).with(any_args).and_return(robot)
        allow(robot).to receive(:to_s).and_return('hello')
        subject.setup(5, 3)
        subject.set_robot(robot)
      }

      it 'should be able to execute' do
        expect(robot).to receive(:move).ordered.with(ins1)
        expect(robot).to receive(:move).ordered.with(ins2)
        expect(robot).to receive(:move).ordered.with(ins3)
        subject.move(instructions)
      end

      context 'when lost' do
        let(:loc2) { double('Position', x: -1, y: 1) }
        let(:robot2) { double('Robot', location: loc2) }

        it 'should be able to tell if a robot is lost' do
          allow(loc).to receive(:x).and_return(1, -1)
          subject.move(instructions)
          expect(subject.report_position).to eq('hello LOST')
        end

        it 'should report the last position before lost' do
          allow(robot2).to receive(:move).with('F')
          allow(robot).to receive(:move).and_return(robot2)
          allow(robot2).to receive(:to_s).and_return('goodbye')
          subject.move(instructions)
          expect(subject.report_position).to eq('hello LOST')
        end
      end
    end

    context '#set_robot' do
      it 'should not be able to input an invalid instruction size' do
        expect { subject.move('F' * MAX_INSTRUCTION_SIZE) }.to raise_error ArgumentError
      end
    end
  end
end