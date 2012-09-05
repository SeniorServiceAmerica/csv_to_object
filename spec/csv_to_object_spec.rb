require 'spec_helper'

class Person
  attr_reader :id, :first_name, :last_name

  def initialize(args={})
    @id,@first_name, @last_name = args["id"], args["first_name"],args["last_name"]
  end
end

describe CsvToObject do
  before(:each) do
    @test_csv_path = 'test/csv/person.csv'
    @source_file = File.open(@test_csv_path)
    @c2o = CsvToObject::CsvToObject.new(@test_csv_path)
    @number_of_data_lines = (@source_file.count - 1)
    @source_file.rewind
    @attribute_names = @source_file.first
    @source_file.rewind
  end

  it "returns an array" do
    @c2o.to_objects.class.should == [].class
  end
  
  it "populates the objects array with objects defined by the source file name" do
    @c2o.to_objects.first.class.to_s.should == File.basename(@source_file.path).gsub('.csv','').capitalize
  end
  
  it "returns as many objects as there are data lines in the csv file" do
    @c2o.to_objects.count.should == @number_of_data_lines
  end
  
  it "instantiate objects defined by its source file name, using the data line as parameters" do
    expected_paramaters = CSV.table(File.open(@test_csv_path),{header_converters: lambda { |h| h.encode(CSV::ConverterEncoding).downcase.gsub(/\s+/, "_") }})
    expected_paramaters.each do |object_attributes|
      @c2o.should_receive(:new_object).with(object_attributes.to_hash)
    end
    @c2o.to_objects
  end
  
  it "should use the data line to populate attributes" do
    @c2o.to_objects.first.id.should == 0    
    @c2o.to_objects.first.first_name.should == "Billie Lindsey"
    @c2o.to_objects.first.last_name.should == "Austino"
  end
  
  it "replaces spaces in attribute names with underscores" do
    @attribute_names.include?('last name').should == true
    @c2o.should_receive(:new_object).with(include_key('last_name')).exactly(@number_of_data_lines).times
    @c2o.to_objects
  end

  it "downcases attribute names and does not remove non-word characters" do
    @attribute_names.include?('SCORE_[person_id|date]').should == true
    @c2o.should_receive(:new_object).with(include_key('score_[person_id|date]')).exactly(@number_of_data_lines).times
    @c2o.to_objects
  end
end
