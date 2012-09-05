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

  ```ruby
    csv_path = 'tmp/person.csv'
    CsvToObject::CsvToObject.new(csv.path).to_objects =>[#<Person:0x000001021a8148 @id=0, @first_name="Lindsey", @last_name="Austino">, #<Person:0x000001021a8030 @id=1, @first_name="Dodie", @last_name="Egnor">]
  ```

### Attribute Names

CSV_to_object does not use the default header converter options provided by Ruby's CSV module. When converting the first line of the csv file into attribute names, the following conversions are applied:

* Encoded using CSV::CharacterEncoding
* Downcased
* Spaces are replaced with underscores

If this behavior is not desired, overwrite the `header_converter` method of `CsvToObject`.

When passed to the target object.new() method, attribute names are strings, not symbols. For example, the instantiation of the Person object above would be:

  ```ruby
    Person.new({"id" => 0, "first_name" => "Lindsey", "last_name" => "Austino"})
  ```
So if you are looking for specific hash keys in `initialize()`, use strings not symbols.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request