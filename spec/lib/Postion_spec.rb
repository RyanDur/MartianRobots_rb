require_relative '../spec_helper'
require 'position'

describe Position do
  let(:position) { Position.new(1, 2, 'N') }
  subject { position }

  its(:x) {should eq 1}
  its(:y) {should eq 2}
  its(:orientation) {should eq 'N'}
end