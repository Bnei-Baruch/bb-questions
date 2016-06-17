class AppSetupType < ActiveRecord::Base
    TYPES = [STRING = 1, INTEGER = 2, FLOAT = 3, ATTACHMENT = 4, DATETIME = 5]
    
    after_save :reset_cache_references
    
    
   private
   def reset_cache_references
     ApplicationSetup.reset_setup_type_array 
   end
end
