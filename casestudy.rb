require 'csv'
puts 'Started Processing'
customers = CSV.read('Customers.csv')
customers.shift
customers_and_sales = {}
customers.each do |row|
  if !customers_and_sales.key?(row[10].to_s)
    customers_and_sales[row[10].to_s] = row[4].to_f
  else
    customers_and_sales[row[10].to_s] += row[4].to_f
  end
end

sorted_customers_and_sales = customers_and_sales.sort_by { |_key, value| value }
                                                .reverse!
# puts sorted_customers_and_sales.inspect
sorted_customers_and_sales.inject(1) do |ranking, element|
  element << ranking
  ranking += 1
end
sorted_customers_and_sales.unshift(%w[Customer TotalSales Rank])
# puts sorted_customers_and_sales.inspect
CSV.open('output.csv', 'w') do |csv_object|
  sorted_customers_and_sales.each do |row|
    csv_object << row
  end
end

puts 'Successfully Processed'