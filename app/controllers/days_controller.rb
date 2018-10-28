# Day class
class DaysController < ApplicationController
  skip_before_filter :verify_authenticity_token

end
