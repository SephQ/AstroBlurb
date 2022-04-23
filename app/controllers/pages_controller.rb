class PagesController < ApplicationController
  def about
  end
  def home
    load_params
  end
  def roast
    load_params
  end
  def reading
    load_params
    load_readings
  end
  def quiz
    # Test your ability to recognize your own astrology reading from a false control.
    # Uses more obscure readings and doesn't tell you which planet is being tested (optional?).
  end
  # Moved functions to application controller so blurbs_controller can use them too. i.e. 'load_params' etc
end
