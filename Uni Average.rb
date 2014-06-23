#!/usr/bin/env ruby

# Anastasios Andronidis <anastasis90@yahoo.gr>
# Nikolaos Petros Triantafyllidis <ntrianta90@gmail.com>

require 'rubygems'
require 'nokogiri'

doc = Nokogiri::HTML(File.open("UNIVERSITY STUDENTS SYSTEM.html"))

weights = 0.0
parts = 0.0


doc.xpath("//table/tr/td/table")[2].children.each do |line| 
    # Get only lines that have some information
    unless line.children[1]==nil 
        # Get only lines that contain lessons
        if line.children[1].text.start_with?("(")
            # Keep only valid lessons (no - or mark greater that 4)
            unless line.children[3].text.strip == "0" or line.children[6].text.strip.to_i < 5
                p line.children[1].text + " " + line.children[3].text + " " + line.children[6].text
                weight = if line.children[3].text.strip.to_i == 6 then 2.0 else 1.5 end
                parts += line.children[6].text.strip.to_i * weight
                weights += weight
            end 
        end
    end
end

p parts/weights
