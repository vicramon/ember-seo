require 'rails/generators'

module EmberSeo
  module Generators
    class InstallGenerator < Rails::Generators::Base

      source_root File.expand_path("../templates", __FILE__)

      desc "Sets up app for Ember Seo gem"

      def generate
        template "../templates/static_controller.rb", "app/controllers/static_controller.rb"
        template "../templates/location.js", "app/models/location.js"
        template "../templates/static_constraint.rb", "lib/constraints/static_constraint.rb"

        inject_into_file 'config/routes.rb', after: "routes.draw do" do <<-'RUBY'
          get '/', to: 'static#show', constraints: Constraint::Static.new
          get '*path', to: 'static#show', constraints: Constraint::Static.new
        RUBY
        end

      end

    end
  end
end
