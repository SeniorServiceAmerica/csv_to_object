require "csv_to_object/version"
require 'CSV'

module CsvToObject
  class CsvToObject

    def initialize(input)
      @input = input
    end
    
    def to_objects
      objects = []
      CSV.table(@input).each do |row|
        objects << new_object(row.to_hash)
      end
      objects
    end
    
    private
        
    def new_object(attrs)
      @object ? @object.new(attrs) : object_to_create().new(attrs)
    end
    
    def object_to_create()
      class_name = File.basename(@input.path).gsub('.csv','').capitalize
      @object = Object::const_get(class_name)
    end
  end
end
