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
      @output = @csv.read
      define_attributes
      @output.each_with_index do |x,i|
        @output[i] = new_object({:id =>"0", :first_name => 'Lindsey', :last_name => 'Austino'})
      end
      @output
    end
    
    private
    
    def define_attributes
      @attributes = @output.shift
    end
    
    def new_object(attrs)
      @object ? @object.new : object_to_create().new
    end
    
    def object_to_create()
      class_name = File.basename(@input.path).gsub('.csv','').capitalize
      @object = Object.const_set(class_name,Class.new)
    end
  end
end
