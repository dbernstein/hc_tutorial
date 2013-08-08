require 'spec_helper'

describe 'tags related changes' do


  it 'should have a tags field' do

    gf = GenericFile.new
    gf.tags = ["tag1", "tag2", "tag3"]
  end

  it 'should makes tags available' do
    gf = GenericFile.new
     gf.terms_for_display.include?(:tags).should be_true
  end

  it 'should make tag unavailable' do
    gf = GenericFile.new
    gf.terms_for_display.include?(:tag).should be_false
  end

end