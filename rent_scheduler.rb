require 'date'

class RentScheduler
  FREQUENCIES = {
    'weekly' => 7,
    'fortnightly' => 14,
    'monthly' => 30
  }

  def initialize(rent)
    @rent = rent
  end

end

