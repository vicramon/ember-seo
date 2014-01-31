require 'rails/generators'

module EmberSeo
  module Generators
    class InstallGenerator < Rails::Generators::Base

      source_root File.expand_path("../templates", __FILE__)
      desc "Sets up app for Ember Seo gem"

      def generate
        copy_file "../templates/static_controller.rb", "app/controllers/static_controller.rb"
        copy_file "../templates/location.js", "app/models/location.js"
        copy_file "../templates/static_constraint.rb", "lib/constraints/static_constraint.rb"

        inject_into_file 'config/routes.rb', after: "routes.draw do\n" do
          "\n  get '/', to: 'static#show', constraints: Constraint::Static.new" +
          "\n  get '*path', to: 'static#show', constraints: Constraint::Static.new\n"
        end

      end

    end
  end
end