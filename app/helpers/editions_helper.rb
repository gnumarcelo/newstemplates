module EditionsHelper
  def articles_column(record)
    record.articles[0,4].collect {|a| a.title }.join(", ")
  end
end
