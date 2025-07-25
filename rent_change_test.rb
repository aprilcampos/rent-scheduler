require_relative './rent_scheduler'
require 'pp'

rent = {
  rent_amount: 1000,
  rent_frequency: 'monthly',
  rent_start_date: '2024-01-01',
  rent_end_date: '2024-04-01'
}

rent_changes = [
  { rent_amount: 1200, effective_date: '2024-02-15' }
]

scheduler = RentScheduler.new(rent, rent_changes)

schedule = scheduler.generate_rent_schedule

puts "payment_dates = ["
schedule.each_with_index do |payment, i|
  if i == schedule.size - 1
    comma = ""
  else
    comma = ","
  end

  puts "  { date: \"#{payment[:date]}\", amount: #{payment[:amount]} }#{comma}"
end
puts "]"
