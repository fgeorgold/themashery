module Merb
  module GlobalHelpers
    
    def add_separator_if(link_string)
      if link_string
        link_string + " |"
      end
    end
 
  end
end
