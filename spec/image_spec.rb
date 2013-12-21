require 'spec_helper'
require 'image'

describe Image do

  context 'new objects' do
    it 'should be initialized with column and row dimensions' do
      Image.new(2,3)
    end

  context 'string representation'
    it "should be an 'm' by 'n' grid of 'O's" do
      Image.new(2,3).to_s.should eq("OO\nOO\nOO")
    end
  end

end # of describe
