class DealSerializer < ActivityAwareSerializer
  attributes :id, :name, :organization, :organization_id, :contact, :contact_id, :pm, :pm_id, :sales, :sales_id, :start_date, :order_date, :accept_date, :amount, :accuracy, :status, :deleted_at, :following
  def organization_id
    object.organization.nil? ? nil : object.organization.id
  end
  def contact_id
    object.contact.nil? ? nil : object.contact.id
  end
  def pm_id
    object.pm.nil? ? nil : object.pm.id
  end
  def sales_id
    object.sales.nil? ? nil : object.sales.id
  end
  def following
    object.followed_by?(scope.current_user)
  end
end
