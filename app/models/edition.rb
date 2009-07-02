class Edition < ActiveRecord::Base
  belongs_to :newsletter
  has_many :articles, :dependent => :destroy, :order => 'position'
  validates_presence_of :newsletter
  
  acts_as_state_machine :initial => :open
  state :open
  state :uploaded
  state :sent
  state :closed
  
  event :upload_draft do
    transitions :from => :open, :to => :uploaded
  end
  
  event :upload_and_send do
    transitions :from => :open, :to => :sent
  end
  
  event :reopen do
    #transitions :from => [:uploaded, :closed, :sent], :to => :open 
    transitions :from => :uploaded, :to => :open
    transitions :from => :closed, :to => :open
    transitions :from => :sent, :to => :open
  end
  
  event :close do
    transitions :from => :open, :to => :closed
  end
  
  def before_destroy
    raise "Cannot destroy a published edition" unless open?
  end
  
  def to_label
    newsletter.title + published_on.strftime(" %Y-%m-%d %a") rescue "Untitled"
  end
  
  def pdf_filename
    newsletter.title.downcase.gsub(" ", "-") + "-" + published_on.strftime("%Y-%m-%d.pdf")
  end
  
  def pdf_version(link_text = nil)
    directory = newsletter.url + "/pdf/" + published_on.strftime("%Y")
    pdf_version_url = directory + "/" + pdf_filename
    
    %{<a href="#{pdf_version_url}">#{link_text || pdf_version_url}</a>}
  end
  
  def web_version(link_text = "View it in your browser")
    %{<a href="#{html_url}">#{link_text}</a>}
  end
  
  def html_url
    newsletter.url + published_on.strftime("/%Y/%m/%d/")
  end
  
  def campaign_name
    newsletter.short_name + published_on.strftime(" %Y-%m-%d")
  end
  
  def cm_client
    Campaigning::Client.find_by_name(CAMPAIGN_MONITOR_CLIENT_NAME)
  end
  
  def create_campaign
    cm_campaign = Campaigning::Campaign.create(
      :clientID => cm_client.clientID,
      :campaignName => campaign_name,
      :campaignSubject => newsletter.email_subject,
      :fromName => newsletter.from_name,
      :fromEmail => newsletter.from_email,
      :replyTo => newsletter.reply_to_email,
      :htmlUrl => html_url,
      :textUrl => html_url,
      :subscriberListIDs => newsletter.lists.collect {|l| l.cm_list_id }
    )
    if newsletter.send_automatically?
      cm_campaign.send(
        :confirmation_email => newsletter.confirmation_email,
        :send_date => "Immediately"
      )
      self.upload_and_send!
    else
      self.upload_draft!
    end
  end
end
