require "csv_to_object/version"
require 'CSV'

module CsvToObject
  class CsvToObject

    # Requires the path to the csv file.
    def initialize(input_path)
      @input_path = File.open(input_path)
    end
    
    # Converts the data lines of the csv file to objects.
    # Objects have the class of the name of the csv file.
    # The first line of the csv file defines the attribute names for the data lines.
    #   person.csv => [person objects]
    #   attribute names are downcased and have spaces replaced with _.
    #   attribute names are strings. 
    def to_objects
      objects = []
      file = File.open(@input_path)
      CSV.table(file, {header_converters: header_converter}).each do |row|
        objects << new_object(row.to_hash)
      end
      objects
    end
    
    private
    
    def header_converter
      lambda { |h| h.encode(CSV::ConverterEncoding).downcase.gsub(/\s+/, "_") }
    end
    
    def new_object(attrs)
      @object ? @object.new(attrs) : object_to_create().new(attrs)
    end
    
    def object_to_create()
      class_name = File.basename(@input_path).gsub('.csv','').capitalize
      @object = Object::const_get(class_name)
    end
  end
end
