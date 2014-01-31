Dir[File.join(File.dirname(__FILE__),'tasks/*.rake')].each { |f| load f } if defined?(Rake)
