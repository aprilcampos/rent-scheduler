require 'date'

class RentScheduler
  FREQUENCIES = {
    'weekly' => 7,
    'fortnightly' => 14,
    'monthly' => :monthly
  }

  PROCESSING_DAYS = {
    'credit_card' => 2,
    'bank_transfer' => 3,
    'instant' => 0
  }

  def initialize(rent, rent_changes = [])
    @rent_amount = rent[:rent_amount]
    @rent_frequency = rent[:rent_frequency]
    @rent_start_date = Date.parse(rent[:rent_start_date])
    @rent_end_date = Date.parse(rent[:rent_end_date])

    @rent_changes = rent_changes.map do |rc|
      {
        amount: rc[:rent_amount],
        effective_date: Date.parse(rc[:effective_date])
      }
    end
    @payment_method = rent[:payment_method]
  end

  def generate_dates
    interval = FREQUENCIES[@rent_frequency]
  
    payment_dates = []
  
    date = @rent_start_date
  
    while date < @rent_end_date
      payment_dates << date.to_s
  
      if interval == :monthly
        date = date.next_month
      else
        date = date + interval
      end
    end
  
    payment_dates
  end

  def generate_rent_schedule
    interval = FREQUENCIES[@rent_frequency]

    schedule = []
  
    current_amount = @rent_amount
  
    date = @rent_start_date
  
    change_index = 0
  
    while date < @rent_end_date
      next_change = @rent_changes[change_index]
  
      if next_change && date >= next_change[:effective_date]
        current_amount = next_change[:amount]
        change_index += 1
      end
  
      schedule << { date: date.to_s, amount: current_amount }
  
      if interval == :monthly
        date = date.next_month
      else
        date = date + interval
      end
    end
  
    schedule
  end

end