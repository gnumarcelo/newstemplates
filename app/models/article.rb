class Article < ActiveRecord::Base
  is_indexed :fields => ['title', 'content'], :include => [{:association_name => 'edition', :field => 'published_on', :as => 'published_on'}], :delta => true
  
  belongs_to :edition
  belongs_to :author
  
  acts_as_list :scope => 'edition_id'
  
  validates_presence_of :author
  validates_length_of :title, :in => 1..100
  
  def slug
    title.to_slug
  end
  
  def slug_link
    %{#{title} <a href="##{slug}"><span class="small">&gt;&gt;</span></a>}
  end
  
  def first_sentence
    content.split("\n")[0].gsub("*", "")
  end
  
  def clean_content
    content.gsub("€", "&euro;")
  end
  
  def to_html
    RedCloth.new(clean_content).to_html
  end
end
