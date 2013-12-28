require 'spec_helper'
require 'image'

describe Image do

  let(:image_3_4) { Image.new(3,4) }

  context 'initialization' do
    it 'should include column and row dimensions' do
      image_3_4.m.should eq(3)
      image_3_4.n.should eq(4)
    end
  end # of context

  context 'internal knowledge' do
    it 'should include what colour a given pixel is' do
      image = image_3_4
      image.colour_pixel([2, 3], 'A')
      image.pixel_colour([2,3]).should eq('A')
    end

    it 'should include whether provided coordinates are contained' do
      image = image_3_4
      image.contains?([2, 4]).should be_true
      image.contains?([4, 3]).should_not be_true
    end
  end # of context

  context 'string representation' do
    it "should be an 'm' by 'n' grid of 'O's" do
      image_3_4.to_s.should eq("OOO\nOOO\nOOO\nOOO\n")
    end
  end

  context 'colouring pixels' do
    it "should colour a single pixel at the coordnates given" do
      image = image_3_4
      image.colour_pixel([2,3], 'A')
      image.to_s.should eq("OOO\nOOO\nOAO\nOOO\n")
    end

    it "will colour-fill should determine adjacent pixels of same colour" do
      image = image_3_4
      image.adjacent_pixels_same_colour([3,1], 'O').should eq([[2,1],[3,2]])
      image.colour_pixel([3, 3], 'C')
      image.adjacent_pixels_same_colour([3,4], 'O').should eq([[2,4]])
    end

    it "should colour-fill an area from a given pixel coordinates" do
      image = image_3_4
      image.colour_pixel([2,3],'A')
      image.colour_pixel([2,4],'A')
      image.colour_fill([3,4], 'K')
      image.to_s.should eq("KKK\nKKK\nKAK\nKAK\n")
    end
  end # of context

end # of describe
