class OrganizationSerializer < ActiveModel::Serializer
  attributes :id, :name, :abbreviation, :address, :remarks, :url, :owner, :owner_id
  def owner_id
    object.owner.nil? ? nil : object.owner.id
  end
end
