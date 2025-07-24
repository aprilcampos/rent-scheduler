require 'date'

class RentScheduler
  FREQUENCIES = {
    'weekly' => 7,
    'fortnightly' => 14,
    'monthly' => :monthly
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

end