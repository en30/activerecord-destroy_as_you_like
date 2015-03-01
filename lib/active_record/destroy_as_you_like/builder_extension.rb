module ActiveRecord
  module DestroyAsYouLike
    module BuilderExtension
      def valid_dependent_options
        super + [:destroy_as_you_like]
      end
    end
  end
end
