require "active_record"
require "rubycas/server/activerecord/model"
require "rubycas/server/activerecord/version"

module RubyCAS::Server::Core::Database
  extend self
  def setup(config_file)
    return true
  end
end
