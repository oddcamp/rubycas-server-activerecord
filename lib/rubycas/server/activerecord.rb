require "rubycas/server/activerecord/version"

module RubaCAS
  module Server
    module Core
      module Database
        extend self
        def setup(config_file)
          ActiveRecord::Base.establish_connection(config_file)
        end
      end
    end
  end
end
