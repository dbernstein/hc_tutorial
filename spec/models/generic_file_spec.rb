require 'spec_helper'

describe 'tags related changes' do

  it 'should have a tags field' do

    gf = GenericFile.new
    gf.tags = ["tag1", "tag2", "tag3"]
  end

  it 'should makes tags available' do
    gf = GenericFile.new
    true.should == gf.terms_for_display.include?(:tags)
 end

  it 'should make tag unavailable' do
    gf = GenericFile.new
    false.should == gf.terms_for_display.include?(:tag)
  end

end