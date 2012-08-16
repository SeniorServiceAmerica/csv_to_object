require 'spec_helper'
require_relative '../test/lib/person.rb'

describe CsvToObject do

  before(:each) do
    @test_csv_path = 'test/csv/person.csv'
    @source_file = File.open(@test_csv_path)
    @c2o = CsvToObject::CsvToObject.new(File.open(@test_csv_path))
  end
    
  it "creates a csv object from the source file" do
    @c2o.csv.class.should == CSV.new(@source_file).class
    @c2o.csv.path.should == CSV.new(@source_file).path
  end
  
  it "returns an array as output" do
    @c2o.output.class.should == [].class
  end
  
  it "populates the output array with objects defined by the source file name" do
    @c2o.output.first.class.to_s.should == File.basename(@source_file.path).gsub('.csv','').capitalize
  end
  
  it "returns as many objects as there are data lines in the csv file" do
    @c2o.output.count.should == (@source_file.count - 1)
  end
  
  it "instantiate objects defined by its source file name and pass in a data line as a hash to the object it creates" do
    expected_results = CSV.new(File.open(@test_csv_path)).read
    attributes = expected_results.shift
    expected_results.each do |x|
      object_attributes = {}
      attributes.each_with_index do |a,i|
        object_attributes[a.to_sym] = x[i]
      end
      @c2o.should_receive(:new_object).with(object_attributes)
    end
    @c2o.output
  end
end