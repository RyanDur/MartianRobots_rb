require_relative '../spec_helper'
require 'instructions'
require 'lang/messages'

describe Instructions do
  include Messages

  it 'should create a list of instructions' do
    ins = subject.create('FLR')
    expect(ins.size).to eq 3
    ins.each {|instruction| expect(instruction).to respond_to(:execute)}
  end

  it 'should complain if instruction does not exist' do
    expect{subject.create('FLG')}.to raise_error ArgumentError, not_exist('G')
  end
end