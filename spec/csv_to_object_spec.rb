require 'spec_helper'
require_relative '../test/lib/person.rb'

describe CsvToObject do

  before(:each) do
    @test_csv_path = 'test/csv/person.csv'
    @source_file = File.open(@test_csv_path)
    @c2o = CsvToObject::CsvToObject.new(File.open(@test_csv_path))
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
  
  it "instantiate objects defined by its source file name, using the data line as parameters" do
    expected_paramaters = CSV.table(File.open(@test_csv_path))
    expected_paramaters.each do |x|
      @c2o.should_receive(:new_object).with(x.to_hash)
    end
    @c2o.output
  end
end