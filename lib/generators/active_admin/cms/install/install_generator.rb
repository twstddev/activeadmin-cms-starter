module ActiveAdmin
	module Cms
		class InstallGenerator < Rails::Generators::Base
			desc "Installs starting CMS for active admin"

			include Rails::Generators::Migration
			source_root File.expand_path( '../templates', __FILE__ )

			def self.next_migration_number(path)
				Time.now.utc.strftime("%Y%m%d%H%M%S")
			end

			def create_routes
				route "resources :menus, only: [ :index ]"
				route "resources :pages, only: [ :index, :show ]"
			end

			def create_migrations
				migration_template "migrations/1_create_menu_items.rb", "db/migrate/create_menu_items.rb"
				sleep 1
				migration_template "migrations/2_create_pages.rb", "db/migrate/create_pages.rb"
				sleep 1
				migration_template "migrations/3_extend_pages_table.rb", "db/migrate/extend_pages_table.rb"
			end

			def run_generators
				generate "friendly_id"
				generate "rich:install", "install"
			end

			def copy_main_files
				directory "admin", "app/admin"
				directory "controllers", "app/controllers"
				directory "models", "app/models"
				directory "views", "app/views"
			end
		end
	end
end
