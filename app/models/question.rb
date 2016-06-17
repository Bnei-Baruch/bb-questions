require 'bing_translator'

class Question < ActiveRecord::Base
  @@client_id = 'bb-questions'
  @@client_secret = '3uGhHaJxcvy4iTL2dkvqbzG4n72XJwYH+uQO1L9nlFU='
  @@translator = BingTranslator.new(@@client_id, @@client_secret)

  before_validation(on: :create) do
    translate
  end

  after_create :send_notify
  after_update :send_notification_after_change

  validates :name, presence: true, length: { maximum: 255 }
  validates :question, presence: true
    # validates :ip, presence: true


  scope :selected,  -> { where(selected: [true]) }
  scope :unselected,  -> { where(selected: [false, nil]) }
  scope :approved,  -> { where(approved: [true]) }


  def get_trans_hide_show_class
    translation.blank?? "hide": "show"
  end

  def self.get_trgt_trans_dir
    target_trans_lang = ApplicationSetup.target_trans_lang()
    target_trans_lang.is_rtl?? "rtl": "ltr"
  end


  private
  def send_notify
    # Escape single quoted strings by inserting 2 of them
    self.class.connection.execute %Q(NOTIFY #{AsyncEvents::CHANNEL}, '#{to_json.gsub("'", "''")}')
    true
  end

  def send_notification_after_change
    # if (self.approved? && self.approved == true)
    self.class.connection.execute %Q(NOTIFY #{AsyncEvents::CHANNEL}, '#{to_json.gsub("'", "''")}')
    # end
  end


  def translate
    question_language = @@translator.detect(question)
    tgt_language = ApplicationSetup.target_trans_lang
    print "================= TARGET LANG: #{tgt_language}"
    #if (question_language.downcase != ApplicationSetup.target_trans_lang.downcase)
      self.translation = @@translator.translate(question, :to => 'he')
    #end
  end

end
