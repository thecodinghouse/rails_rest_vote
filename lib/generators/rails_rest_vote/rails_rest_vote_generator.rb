# Requires
require 'rails/generators'
require 'rails/generators/active_record'
require 'rails/generators/migration'

class RailsRestVoteGenerator < Rails::Generators::NamedBase
  include Rails::Generators::Migration
  def self.source_root
    @source_root ||= File.join(File.dirname(__FILE__), 'templates')
  end

  def self.next_migration_number(dirname)
    if ActiveRecord::Base.timestamped_migrations
      Time.new.utc.strftime("%Y%m%d%H%M%S")
    else
      "%.3d" % (current_migration_number(dirname) + 1)
    end
  end

  #copy vote migration file to host application from template folder.
  def create_migration_file
    migration_template 'migration.rb', 'db/migrate/create_votes.rb'
  end

  #create vote model to host application
  def create_model_file
    create_file 'app/models/vote.rb',vote_model
  end

  #inject association in user.rb model of host application
  #
  #has_many :votes
  #
  def inject_model_content
    content = model_contents

    class_path = if namespaced?
      class_name.to_s.split("::")
    else
      [class_name]
    end

    indent_depth = class_path.size - 1
    content = content.split("\n").map { |line| "  " * indent_depth + line } .join("\n") << "\n"

    inject_into_class(model_path, class_path.last, content) if model_exists?
  end

  private

  def model_contents
    buffer = <<-CONTENT
  has_many :votes
  CONTENT
    buffer
  end

  def vote_model
<<RUBY
    class Vote < ActiveRecord::Base
      belongs_to :#{singular_table_name}
      belongs_to :votable, :polymorphic =>true
      validates :votable_type, :votable_id, :presence => true
    end
RUBY
  end

  def model_exists?
    File.exists?(File.join(destination_root, model_path))
  end

  def model_path
    @model_path ||= File.join("app", "models", "#{file_path}.rb")
  end

end
