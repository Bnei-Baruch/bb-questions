class ApplicationSetup < ActiveRecord::Base
  after_save :reset_cache_references
  
  belongs_to :app_setup_type
  belongs_to :language
  
  attr_readonly :id, :app_setup_type_id, :language_code_id, :code_id, :description
  
  def self.app_setup_cach
    @@app_setup_cach ||= Hash.new
  end
   
  def setup_type_array
    if defined?(@@setup_tyep_array).nil? || @@setup_type_array.nil?
      @@setup_type_array = Hash.new
      AppSetupType.all.map do |setupType| 
        @@setup_type_array[setupType.id] = setupType.name
      end
    end
    @@setup_type_array
  end 

  def self.reset_setup_type_array
    @@setup_type_array = nil
  end  
  
  def setup_type_name_by_hash
    setup_type_array[app_setup_type_id] 
  end
  
  def self.get_app_setup_value(codeId, lng = nil)
      lng ||= I18n.default_locale
      appSetupCol = where(code_id: codeId, language_id: lng).take
      appSetupCol = where(code_id: codeId).take if appSetupCol.nil?
      return  (appSetupCol.nil?)? nil : appSetupCol.str_value
  end
  
  def self.get_organization_name
    keyName = "organization_name_#{I18n.locale}"
    app_setup_cach[keyName] ||= 
        get_app_setup_value("organization_name", I18n.locale) || I18n.t('house_name')
  end
   
  def self.target_trans_lang
    if defined?(@@target_language).nil? || @@target_language.nil?
      keyName = "target_trans_lang"
      lang_id = app_setup_cach[keyName] ||= get_app_setup_value(keyName, nil) || Language::HEBREW
      @@target_language = Language.find(lang_id)
    end
    @@target_language
  end
  
  def self.questions_session_date
    keyName = "questions_session_date"
    app_setup_cach[keyName] ||= 
        get_app_setup_value(keyName, I18n.locale) || I18n.t('house_name')
  end
  
  def self.update_questions_session_date
    questionsSessionDate = ApplicationSetup.find_by(code_id: 'questions_session_date')
    questionsSessionDate.update_attribute('str_value', DateTime.now.to_s)
  end
  
  private
  def reset_cache_references
    @@app_setup_cach = nil 
    @@target_language = nil
  end
  
end
