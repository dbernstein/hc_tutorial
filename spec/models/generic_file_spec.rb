require 'spec_helper'

describe 'tags related changes' do

  before(:each) do
    @gf = GenericFile.new
    @gf.tags = ["tag1", "tag2", "tag3"]
  end

  it 'should have a tags field' do
    @gf.respond_to?(:tags).should be_true
  end

  it 'should makes tags available' do
    @gf.terms_for_display.include?(:tags).should be_true
  end

  it 'should make tag unavailable' do
    @gf.terms_for_display.include?(:tag).should be_false
  end

  it 'should solrize tags field into array of words' do
    solrdocs = {}
    @gf.tags = ["one two three four five six seven"]
    @gf.to_solr(solrdocs);

    [
        "fields_tags_tesim",
        "fields_tags_sim",
        "tags_tesim",
        "tags_sim"
    ].each { |x|
        solrdocs.keys.include?(x).should be_true
    }

    solrdocs["fields_tags_tesim"].count.should eq(7)
  end

end
