require_relative '../spec_helper'
require 'position'
require 'set'


describe Position do
  let(:position) { Position.new(1, 2, 'N') }
  subject { position }

  its(:x) { should eq 1 }
  its(:y) { should eq 2 }
  its(:orientation) { should eq 'N' }
  its(:to_s) {should eq '1 2 N'}

  it 'should produce a new position when set' do
    position2 = position.set(3, 6, 'S')
    expect(position2.to_s).to eq '3 6 S'
    expect(position.to_s).to eq '1 2 N'
    expect(position).not_to be equal? position2
  end

  context 'equal' do
    let(:position2) { position.set(1, 2, 'S') }

    it 'should override ==' do
      expect(subject == position2).to be(true)
    end
  end

  context 'not equal' do
    let(:position2) { position.set(3, 2, 'S') }

    it 'should override ==' do
      expect(subject == position2).to_not be(true)
    end
  end

  it 'should be able to see if a list contains a similar position' do
    s = []
    other = subject.set(1, 2, 'N')
    s.push(other)
    expect(s.include?(subject)).to be true
  end
end