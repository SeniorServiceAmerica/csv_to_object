# CsvToObject

Given the path to a CSV file, will return a collection of objects. The csv file name must match the name of an object the gem can instantiate. The first line of the csv file must define attribute names. The following lines contain the data that will be assigned to those attributes

## Installation

Add this line to your application's Gemfile:

    gem 'csv_to_object'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install csv_to_object

## Usage

Given a file person.csv with the contents

  `id,first_name,last_name`  
  `0,Lindsey,Austino`  
  `1,Dodie,Egnor`

  `CsvToObject::CsvToObject.new('[path to person.csv]').to_objects` will return 

  `[#<Person:0x000001021a8148 @id=0, @first_name="Lindsey", @last_name="Austino">, #<Person:0x000001021a8030 @id=1, @first_name="Dodie", @last_name="Egnor">`]

### Attribute Names

When converting the first line of the csv file into attribute names, the following conversions are applied:

* Encoded using CSV::Character Encoding
* Downcased
* Spaces are replaced with underscores

When passed to the target object.new() method, attribute names are strings, not symbols. For example, the instantiation of the Person object above would be:

  `Person.new({"id" => 0, "first_name" => "Lindsey", "last_name" => "Austino"})`

So if you are looking for specific hash keys in `initialize()`, use strings not symbols.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request