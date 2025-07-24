require_relative './rent_scheduler'
require 'pp'

rent = {
  rent_amount: 1000,
  rent_frequency: 'monthly',
  rent_start_date: '2024-01-01',
  rent_end_date: '2024-04-01'
}

scheduler = RentScheduler.new(rent)
payment_dates = scheduler.generate_dates

puts "payment_dates = #{payment_dates.inspect}"