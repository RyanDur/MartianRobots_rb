require 'spec_helper'
require 'mars'

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
end