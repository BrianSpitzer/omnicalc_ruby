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

    @monthly_payment = @principal * monthly_rate * (1 + monthly_rate)**number_of_payments / (((1+monthly_rate)**number_of_payments)-1)  #this isn't right yet.
    
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
    
    #sorted_numbers = @numbers.sort
    
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
    mean = 0
    variance = 0
    standard_deviation = 0
    
    @sorted_numbers.each do |number|
      sum = sum + number
    end
    
    @sum = sum

    @mean = sum/@count

    @variance = "Replace this string with your answer."

    @standard_deviation = "Replace this string with your answer."

    @mode = "Replace this string with your answer."

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
