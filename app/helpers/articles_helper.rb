module ArticlesHelper
  def options_for_association(association)
    return super unless association.active_record.name === "Article"

    case association.name
    when :edition
      available_records = Edition.find(:all, :conditions => "state = 'open'")
      available_records.sort{|a,b| a.to_label <=> b.to_label}.collect { |model| [ model.to_label, model.id ] }
    when :author
      available_records = Author.find(:all, :conditions => "inactive IS NULL OR inactive = 0")
      available_records.sort{|a,b| a.to_label <=> b.to_label}.collect { |model| [ model.to_label, model.id ] }
    else
      raise "unknown association.name #{association.name}"
    end
  end
  
  def title_form_column(record, input_name)
    text_field :record, :title, :size => 100
  end
  
  def content_form_column(record, input_name)
    text_area :record, :content, :style => "width:700px;height:400px;"
  end
  
  def content_column(record)
    truncate(record.content, 100)
  end
end


