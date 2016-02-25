class SuperMemo2
  attr_accessor :result

  def initialize(efactor, repetition, interval, quality_timer, user_translated_text, translated_text)
    @result = translation_distance(user_translated_text, translated_text)
    @quality = assess_quality quality_timer
    @repetition = repetition
    @efactor = efactor
    @interval = interval
    reset_repetition if @quality < 3
  end
  # If the quality response was lower than 3
  # then start repetitions for the item from the beginning
  # without changing the E-Factor (i.e. use intervals I(1), I(2) etc.)
  # After each repetition session of a given day repeat again all items
  # that scored below four in the quality assessment.
  # Continue the repetitions until all of these items score at least four.
  def repetition_session
    interval = set_interval
    calculate_efactor if @repetition > 0
    {
      quality: @quality,
      repetition: @repetition + 1,
      efactor: @efactor.round(1),
      interval: interval,
      review_date: DateTime.current + interval.days
    }
  end

  def translation_distance(user_translated_text, translated_text)
    distance = Levenshtein.distance(user_translated_text, translated_text)
    if distance == 0
      :correct
    elsif distance == 1 || distance == 2
      :typo
    else
      :wrong
    end
  end
  # After each repetition assess the quality of repetition:
  # 5 - perfect response
  # 4 - correct response after a hesitation
  # 3 - correct response recalled with serious difficulty
  # 2 - incorrect response; where the correct one seemed easy to recall
  # 1 - incorrect response; the correct one remembered
  # 0 - complete blackout.
  def assess_quality(quality_timer)
    quality_timer = quality_timer.to_i
    if @result == :wrong
      return 0
    elsif @result == :typo
      quality_timer += 6000
    end
    case quality_timer / 1000
    when 1..5 then 5
    when 6..11 then 4
    when 12..17 then 3
    when 18..23 then 2
    when 24..31 then 1
    else
      0
    end
  end
  # Split the knowledge into smallest possible items.
  # With all items associate an E-Factor equal to 2.5.
  # Repeat items using the following intervals:
  # I(1):=1
  # I(2):=6
  # for n>2: I(n):=I(n-1)*EF
  # where:
  # I(n) - inter-repetition interval after the n-th repetition (in days),
  # EF - E-Factor of a given item
  # If interval is a fraction, round it up to the nearest integer.
  def set_interval
    case @repetition
    when 0 then 1
    when 1 then 6
    else
      (@interval * @efactor).round
    end
  end

  def reset_repetition
    @repetition = 0
  end
  # After each repetition modify the E-Factor
  # of the recently repeated item according to the formula:
  # EF':=EF+(0.1-(5-q)*(0.08+(5-q)*0.02))
  # where:
  # EF' - new value of the E-Factor,
  # EF - old value of the E-Factor,
  # q - quality of the response in the 0-5 grade scale.
  # If EF is less than 1.3 then let EF be 1.3.
  def calculate_efactor
    @efactor += 0.1 - (5 - @quality) * (0.08 + (5 - @quality) * 0.02)
    [@efactor, 1.3].max
  end
end
