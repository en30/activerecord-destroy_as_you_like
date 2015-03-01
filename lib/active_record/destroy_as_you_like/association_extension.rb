module ActiveRecord
  module DestroyAsYouLike
    module AssociationExtension
      def handle_dependency
        return super unless options[:dependent] == :destroy_as_you_like
        if destroy_related_callbacks?
          load_target.each { |t| t.destroyed_by_association = reflection }
          destroy_all
        else
          delete_all(:delete_all)
        end
      end

      private

      def destroy_related_callbacks?
        klass = reflection.klass
        !klass._destroy_callbacks.empty? or !klass._commit_callbacks.empty?
      end
    end
  end
end
