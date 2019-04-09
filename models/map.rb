ActiveRecord::Base.establish_connection(ENV['DATABASE_URL']||'sqlite3:db/development.db')

class Map < ActiveRecord::Base
    has_and_belongs_to_many :stores,:uniq => true
    
end

class Store < ActiveRecord::Base
    has_and_belongs_to_many :maps
end

class Station < ActiveRecord::Base
    
end
