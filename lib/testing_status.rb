class TestingStatus
  def initialize(hashtag, status)
    @hashtag = hashtag
    @status = status
  end

  def color
    case @status[:text]
    when /^green .* #{@hashtag}$/
      :green
    when /^red .* #{@hashtag}$/
      :red
    when /.* #{@hashtag}/
      :gray
    else
      nil
    end
  end

  def past_hour
    (Time.now - @status[:created_at])/(60*60)
  end

  def next_color
    if color == :green && past_hour > 36
      return :red
    elsif color == :gray
      return :green
    end

    return nil
  end
end