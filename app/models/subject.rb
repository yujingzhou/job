class Subject < ActiveRecord::Base
  module Status
    INBOX   = "inbox"
    IGNORED = "ignored"
    CARED   = "cared"
    OTHER   = "other"
  end

  belongs_to :topic, :foreign_key => :url, :primary_key => :url

  def analyzed_salary
    topic.analyzed_salary
  end

  def analyzed_author
    topic.analyzed_author
  end

  def analyzed_author_url
    "http://ruby-china.org/#{analyzed_author}"
  end

  scope :inbox,   -> { where(:status => Status::INBOX) }
  scope :ignored, -> { where(:status => Status::IGNORED) }
  scope :cared,   -> { where(:status => Status::CARED) }

  def self.sort_by_field(list, field, is_asc = true)
    list.sort do |x,y|
      x_value = x.send(field).to_s
      y_value = y.send(field).to_s
      if is_asc
        y_value <=> x_value
      else
        x_value <=> y_value
      end
    end
  end

end
