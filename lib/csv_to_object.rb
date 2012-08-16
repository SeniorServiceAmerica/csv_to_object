require "csv_to_object/version"
require 'CSV'

module CsvToObject
  class CsvToObject

    def initialize(input)
      @input = input
    end
    
    def output
      output = []
      CSV.table(@input).each do |row|
        output << new_object(row.to_hash)
      end
      output
    end
    
    private
        
    def new_object(attrs)
      @object ? @object.new : object_to_create().new
    end
    
    def object_to_create()
      class_name = File.basename(@input.path).gsub('.csv','').capitalize
      @object = Object::const_get(class_name)
    end
  end
end
