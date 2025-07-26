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
    @payment_method = rent[:payment_method]

    @rent_changes = rent_changes.map do |change|
      {
        amount: change[:rent_amount],
        effective_date: Date.parse(change[:effective_date])
      }
    end
  end

  def generate_dates
    schedule = []
    date = @rent_start_date
    interval = FREQUENCIES[@rent_frequency]

    while date < @rent_end_date
      schedule << date.to_s

      if interval == :monthly
        date = date.next_month
      else
        date = date + interval
      end
    end

    schedule
  end

  def generate_rent_schedule
    schedule = []
    date = @rent_start_date
    interval = FREQUENCIES[@rent_frequency]
    amount = @rent_amount
    change_index = 0

    while date < @rent_end_date
      if @rent_changes[change_index] && date >= @rent_changes[change_index][:effective_date]
        amount = @rent_changes[change_index][:amount]
        change_index += 1
      end

      schedule << { date: date.to_s, amount: amount }

      if interval == :monthly
        date = date.next_month
      else
        date = date + interval
      end
    end

    schedule
    
  end

  def generate_payment_schedule
    interval = FREQUENCIES[@rent_frequency]

    schedule = []

    current_amount = @rent_amount
  
    date = @rent_start_date
  
    next_change = 0
  
    while date < @rent_end_date
      
      if @rent_changes[next_change]
        change = @rent_changes[next_change]
        if date >= change[:effective_date]
          current_amount = change[:amount]
          next_change += 1
        end
      end
  
      processing_time = PROCESSING_DAYS[@payment_method]
      if processing_time.nil?
        processing_time = 0
      end
  
      payment_date = date - processing_time
  
      schedule << {
        payment_date: payment_date.to_s,
        amount: current_amount,
        method: @payment_method
      }
  
      if interval == :monthly
        date = date.next_month
      else
        date = date + interval
      end
    end
  
    schedule
  end

end