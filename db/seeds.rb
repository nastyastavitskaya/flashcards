# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require "open-uri"
require "nokogiri"

doc = Nokogiri::HTML(open("http://www.languagedaily.com/learn-german/vocabulary/common-german-words"))

doc.css(".rowA, .rowB").each do |row|
  original_text = row.at_css(".bigLetter").text
  translated_text = row.at_css(".bigLetter + td").text
  Card.create(original_text: original_text, translated_text: translated_text)
end
