require "csv_to_object/version"
require 'CSV'

module CsvToObject
  class CsvToObject
    attr_reader :csv

    def initialize(input)
      @input = input
      @csv = CSV.new(@input)
    end
    
    def output
      table = CSV.table(@input)
      @output = []
      table.each do |row|
        @output << new_object(row.to_hash)
      end
      @output
    end
    
    private
        
    def new_object(attrs)
      @object ? @object.new : object_to_create().new
    end
    
    def object_to_create()
      class_name = File.basename(@input.path).gsub('.csv','').capitalize
      @object = Object.const_set(class_name,Class.new)
    end
  end
end
