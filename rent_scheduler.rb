require 'date'

class RentScheduler
  FREQUENCIES = {
    'weekly' => 7,
    'fortnightly' => 14,
    'monthly' => :monthly
  }

  def initialize(rent)
    @rent_amount = rent[:rent_amount]
    @rent_frequency = rent[:rent_frequency]
  end



end

