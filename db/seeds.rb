#encoding: utf-8

@connection = ActiveRecord::Base.connection

def random_string(length = 8)
  rand(32**length).to_s(32)
end

def create_app_setup_types
  unless AppSetupType.exists?(id: 1) 
    AppSetupType.create id: 1, name: 'String'
  end
  
  unless AppSetupType.exists?(id: 2) 
    AppSetupType.create id: 2, name: 'Integer'
  end
  
  unless AppSetupType.exists?(id: 3) 
    AppSetupType.create id: 3, name: 'Float'
  end
  
  unless AppSetupType.exists?(id: 4) 
    AppSetupType.create id: 4, name: 'Attachment'
  end
  
  unless AppSetupType.exists?(id: 5) 
    AppSetupType.create id: 5, name: 'DateTime'
  end
end

def create_languages
  unless Language.exists?(id: 1) 
    Language.create id: 1, code: 'en', name: 'English'
  end
  
  unless Language.exists?(id: 2) 
    Language.create id: 2, code: 'he', is_rtl: true, name: 'עברית'
  end
  
  unless Language.exists?(id: 3) 
    Language.create id: 3, code: 'ru', name: 'Русский'
  end
  
  unless Language.exists?(id: 4) 
    Language.create id: 4, code: 'es', name: 'Español'
  end
end

def create_application_setups
  unless ApplicationSetup.exists?(code_id: 'organization_name', language_id: 1)
    ApplicationSetup.create app_setup_type_id: AppSetupType::STRING, language_id: Language::ENGLISH, 
      code_id: 'organization_name', description: 'Organization name', 
      str_value: 'BB Questions'
  end
  
  unless ApplicationSetup.exists?(code_id: 'organization_name', language_id: 2)  
    ApplicationSetup.create app_setup_type_id: AppSetupType::STRING, language_id: Language::HEBREW, 
      code_id: 'organization_name', description: 'Organization name', 
      str_value: 'בב שאלות'
  end
  
  unless ApplicationSetup.exists?(code_id: 'organization_name', language_id: 3)    
    ApplicationSetup.create app_setup_type_id: AppSetupType::STRING, language_id: Language::RUSSIAN, 
      code_id: 'organization_name', description: 'Organization name', 
      str_value: 'ББ Вопросы'
  end
  
  if ApplicationSetup.where(code_id: 'target_trans_lang').count > 1
    ApplicationSetup.where(code_id: 'target_trans_lang').destroy_all(['id NOT IN (?)', 
      ApplicationSetup.where(code_id: 'target_trans_lang').first(1).collect(&:id)])
  end
  
  unless ApplicationSetup.exists?(code_id: 'target_trans_lang')
    ApplicationSetup.create app_setup_type_id: AppSetupType::INTEGER,  
      code_id: 'target_trans_lang', description: 'Target Translation Language', 
      str_value: '2'
  end 
   
  unless ApplicationSetup.exists?(code_id: 'questions_session_date')
    ApplicationSetup.create app_setup_type_id: AppSetupType::DATETIME,  
      code_id: 'questions_session_date', description: 'Questions Session Date. 
       Has been used to retrieve last questions in Moderation and Question Monitors', 
      str_value: DateTime.now.to_s 
  end 
  
  #Morning Lesson message - morning_lesson_message (English, Spanish, Hebrew, Russian) 
  # Selected questions related to the theme of the lesson will be asked during broadcast.
  unless ApplicationSetup.exists?(code_id: 'morning_lesson_message', language_id: Language::ENGLISH)
    ApplicationSetup.create app_setup_type_id: AppSetupType::STRING, language_id: Language::ENGLISH,  
      code_id: 'morning_lesson_message', description: 'Morning Lesson message', 
      str_value: 'Selected questions related to the theme of the lesson will be asked during broadcast.' 
  end 
  
  
  # Las preguntas relacionadas con los temas de estudio, serán seleccionadas y se interrogarán durante la transmisión en vivo.
  unless ApplicationSetup.exists?(code_id: 'morning_lesson_message', language_id: Language::SPANISH)
    ApplicationSetup.create app_setup_type_id: AppSetupType::STRING, language_id: Language::SPANISH,  
      code_id: 'morning_lesson_message', description: 'Morning Lesson message', 
      str_value: 'Las preguntas relacionadas con los temas de estudio, serán seleccionadas y se interrogarán durante la transmisión en vivo.' 
  end 
  
  #שאלות נבחרות הקשורות לחומר הנלמד תישאלנה בשידור חי
  unless ApplicationSetup.exists?(code_id: 'morning_lesson_message', language_id: Language::HEBREW)
    ApplicationSetup.create app_setup_type_id: AppSetupType::STRING, language_id: Language::HEBREW,  
      code_id: 'morning_lesson_message', description: 'Morning Lesson message', 
      str_value: 'שאלות נבחרות הקשורות לחומר הנלמד תישאלנה בשידור חי' 
  end 
  
  #Самые интересные вопросы по теме урока будут заданы в прямом эфире.
  # Las preguntas relacionadas con los temas de estudio, serán seleccionadas y se interrogarán durante la transmisión en vivo.
  unless ApplicationSetup.exists?(code_id: 'morning_lesson_message', language_id: Language::RUSSIAN)
    ApplicationSetup.create app_setup_type_id: AppSetupType::STRING, language_id: Language::RUSSIAN,  
      code_id: 'morning_lesson_message', description: 'Morning Lesson message', 
      str_value: 'Самые интересные вопросы по теме урока будут заданы в прямом эфире.' 
  end 
  
  
  #Technical Problems message -technical_problems_message (English, Spanish, Hebrew, Russian)
  unless ApplicationSetup.exists?(code_id: 'technical_problems_message', language_id: Language::ENGLISH)
    ApplicationSetup.create app_setup_type_id: AppSetupType::STRING, language_id: Language::ENGLISH,  
      code_id: 'technical_problems_message', description: 'Technical Problems message', 
      str_value: 'If you are experiencing problems with slow connections during broadcast, please email SUPPORT@KAB.TV with the details of the city and country from which you are watching.' 
  end 
  
  unless ApplicationSetup.exists?(code_id: 'technical_problems_message', language_id: Language::SPANISH)
    ApplicationSetup.create app_setup_type_id: AppSetupType::STRING, language_id: Language::SPANISH,  
      code_id: 'technical_problems_message', description: 'Technical Problems message', 
      str_value: 'Se están experimentando problemas de conexión lenta, por favor, envíen un correo a SUPPORT@KAB.TV con la información de ciudad y país de donde están viendo el programa.' 
  end 
  
  unless ApplicationSetup.exists?(code_id: 'technical_problems_message', language_id: Language::HEBREW)
    ApplicationSetup.create app_setup_type_id: AppSetupType::STRING, language_id: Language::HEBREW,  
      code_id: 'technical_problems_message', description: 'Technical Problems message', 
      str_value: 'במידה ונתקלתם בבעיה של חיבור איטי וכדומה במהלך הצפיה, אנא שלחו מייל בצירוף המדינה ועיר שממנה אתם מתחברים לכתובת – SUPPORT@KAB.TV' 
  end 
  
  unless ApplicationSetup.exists?(code_id: 'technical_problems_message', language_id: Language::RUSSIAN)
    ApplicationSetup.create app_setup_type_id: AppSetupType::STRING, language_id: Language::RUSSIAN,  
      code_id: 'technical_problems_message', description: 'Technical Problems message', 
      str_value: 'Если у вас есть проблемы с медленным подключением во время трансляции, обратитесь по адресу SUPPORT@KAB.TV с указанием города и страны из которого вы смотрите.' 
  end 
  
  #Yeshivat Haverim message -yeshivat_haverim_message (English, Spanish, Hebrew, Russian)
  unless ApplicationSetup.exists?(code_id: 'yeshivat_haverim_message', language_id: Language::ENGLISH)
    ApplicationSetup.create app_setup_type_id: AppSetupType::STRING, language_id: Language::ENGLISH,  
      code_id: 'yeshivat_haverim_message', description: 'Technical Problems message', 
      str_value: 'Hi Dear Friends, everyone are invited to share their impression from the topic of the Yeshivat Haverim' 
  end 
  
  unless ApplicationSetup.exists?(code_id: 'yeshivat_haverim_message', language_id: Language::SPANISH)
    ApplicationSetup.create app_setup_type_id: AppSetupType::STRING, language_id: Language::SPANISH,  
      code_id: 'yeshivat_haverim_message', description: 'Technical Problems message', 
      str_value: 'Hola queridos amigos, todos estan invitados a compartir sus impresiones de la Yeshivat Haverim.' 
  end 
  
  unless ApplicationSetup.exists?(code_id: 'yeshivat_haverim_message', language_id: Language::HEBREW)
    ApplicationSetup.create app_setup_type_id: AppSetupType::STRING, language_id: Language::HEBREW,  
      code_id: 'yeshivat_haverim_message', description: 'Technical Problems message', 
      str_value: 'שלום חברים יקרים, כולם מוזמנים לשלוח דברי התפעלות בנושא ישיבת החברים' 
  end 
  
  unless ApplicationSetup.exists?(code_id: 'yeshivat_haverim_message', language_id: Language::RUSSIAN)
    ApplicationSetup.create app_setup_type_id: AppSetupType::STRING, language_id: Language::RUSSIAN,  
      code_id: 'yeshivat_haverim_message', description: 'Technical Problems message', 
      str_value: 'Здравствуйте, дорогие друзья. Мы приглашаем всех присылать воодушевляющие отрывки по теме собрания товарищей.' 
  end 
end

def make_users  
  if  !User.exists?(:email => "slavapas13@gmail.com")
    User.create!(name:'Slava', family_name:'Pasechnik', 
    email:'slavapas13@gmail.com', password:'xxxxxx', password_confirmation:'xxxxxx',
    admin: true)
  end
  
  if  !User.exists?(:email => "nukegluk@gmail.com")
    User.create!(name:'Genady', family_name:'Petelko', 
    email:'nukegluk@gmail.com', password:'xxxxxx', password_confirmation:'xxxxxx',
    admin: true)
  end
  
  # if User.count < 30 
  #   30.times do |i| 
  #     lupName = "#{random_string()}#{i}" 
  #     User.create!(name: lupName, family_name: random_string(), 
  #     email:"#{lupName}@gmail.com", password:'xxxxxx', password_confirmation:'xxxxxx',
  #     admin: true)
  #   end
  # end
  
end

create_app_setup_types
create_languages
create_application_setups
make_users
