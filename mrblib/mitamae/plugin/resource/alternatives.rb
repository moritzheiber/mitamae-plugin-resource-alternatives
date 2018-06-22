module ::MItamae
  module Plugin
    module Resource
      class Alternatives < ::MItamae::Resource::Base
        define_attribute :action, default: :create
        define_attribute :name, type: String, default_name: true
        define_attribute :path, type: String, default: nil
        define_attribute :auto, type: [TrueClass, FalseClass], default: false

        self.available_actions = [:create]
      end
    end
  end
end
