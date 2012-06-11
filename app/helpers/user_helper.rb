module UserHelper
  def beers_summary(num)
    "#{bottles_count_in_words(num)} of beer on the wall, #{bottles_count_in_words(num)} of beer!"
  end

  def bottles_count_in_words(num)
    "#{num} bottle#{num == 1 ? '' : 's'}"
  end
end