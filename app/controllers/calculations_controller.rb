class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================


    @word_count = @text.split.count

    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text.gsub(" ","").length
    
    occurred = 0
    
    @text.split.each do |word|
      if word.downcase.gsub(/[^a-z0-9\s]/i, "") == @special_word.downcase
        occurred = occurred + 1
      end
    end

    @occurrences = occurred

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    monthly_rate = @apr / 12 / 100
    
    number_of_payments = @years * 12

    @monthly_payment = @principal * monthly_rate * (1 + monthly_rate)**number_of_payments / (((1+monthly_rate)**number_of_payments)-1)
    
    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending - @starting
    @minutes = @seconds / 60
    @hours = @minutes / 60
    @days = @hours/24
    @weeks = @days/7
    @years = @days/365

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================
    
    @sorted_numbers = @numbers.sort
    
    @count = @sorted_numbers.count

    @minimum = @sorted_numbers[0]
    
    @maximum = @sorted_numbers[@count-1]

    @range = @maximum - @minimum

    if @count.odd?
      @median = @sorted_numbers[@count/2]
      elsif
      @median = (@sorted_numbers[@count/2-1] + @sorted_numbers[@count/2])/2
    end
    
    sum = 0

    @sorted_numbers.each do |number|
      sum = sum + number
    end
    
    @sum = sum

    @mean = sum/@count

    x_bar_squared = 0
    x_bar_squared_sum = 0

    @sorted_numbers.each do |number|
      x_bar_squared = (number - @mean)**2
      x_bar_squared_sum += x_bar_squared
    end
    
    @variance = x_bar_squared_sum / (@count)

    @standard_deviation = @variance**0.5


    #count the number of occurrences of each number    
    mode_array = []
    loop_count = 0
    prev_number = 0
    
    @sorted_numbers.each do |number|
      if loop_count == 0
        number_hash = { :value => number, :count => 1 }
        mode_array.push(number_hash)
        prev_number = number
      elsif number == prev_number
          mode_array.last[:count] += 1
      else
        number_hash = { :value => number, :count => 1 }
        mode_array.push(number_hash)
        prev_number = number
      end
    
      loop_count += 1
    end

    #determine the maximum number of occurrences of any value
    maximum_count = 0

    mode_array.each do |contender|
      if contender[:count] > maximum_count
        maximum_count = contender[:count]
      end
    end 
    
    # Figure out how many values have the maximum count. if there's only one, it
    # is the mode. Otherwise, any value with the maximum count is a mode.
    
    modes = []
    
    mode_array.each do |contender|
      if contender[:count] == maximum_count
        modes.push(contender[:value])
      end
    end
  
    if modes.count == 1
      @mode = modes.first
    else
      @mode = modes
    end

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
