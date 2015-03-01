ActiveSupport.on_load(:active_record) do
  class << ActiveRecord::Associations::Builder::HasMany
    prepend ActiveRecord::DestroyAsYouLike::BuilderExtension
  end
  ActiveRecord::Associations::HasManyAssociation.send :prepend, ActiveRecord::DestroyAsYouLike::AssociationExtension
end
