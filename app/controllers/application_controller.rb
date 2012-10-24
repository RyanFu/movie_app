class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def separate_array_by_num (array_val,num)
    array_size = array_val.length / num +1;
    return_array = Array.new(array_size)
    i = 0
    array = Array.new
    array_val.each_with_index {|element, index|
        array << element
        i += 1
        if i%4 == 0
          return_array[i/num-1] = array
          array = Array.new
        end
    }
    return_array[array_size-1] = array
    return_array
  end
end
