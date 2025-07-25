require_relative './rent_scheduler'
require 'pp'

rent = {
  rent_amount: 1000,
  rent_frequency: 'monthly',
  rent_start_date: '2024-01-01',
  rent_end_date: '2024-04-01',
  payment_method: 'credit_card'
}

scheduler = RentScheduler.new(rent)
payment_dates = scheduler.generate_payment_schedule

puts "payment_dates = ["
payment_dates.each_with_index do |payment, i|
  comma = i == payment_dates.size - 1 ? "" : ","
  puts "  { payment_date: \"#{payment[:payment_date]}\", amount: #{payment[:amount]}, method: \"#{payment[:method]}\" }#{comma}"
end
puts "]"