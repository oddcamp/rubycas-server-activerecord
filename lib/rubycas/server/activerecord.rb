require "active_record"

module RubyCAS
  module Server
    module Core
      module Database
        extend self
        def setup(config_file)
          return true
        end
      end
    end
  end
end

require "rubycas/server/activerecord/model"
require "rubycas/server/activerecord/version"
