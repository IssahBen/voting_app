require "csv"

table = CSV.read("voters1.csv")

cleared_csv = table.map{|row| row.compact }.reject{|row| row.empty?}

array =[]
cleared_csv.each_with_index do |row,i|
    if i == 0
        next 
    end 
    array << row 
end

p array

