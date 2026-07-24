# frozen_string_literal: true

# Future multi-tenant support: add tenant_id to models and scope queries.
# Example: scope :for_tenant, ->(tenant) { where(tenant_id: tenant.id) }
module TenantScoped
  extend ActiveSupport::Concern

  included do
    # belongs_to :tenant, optional: true  # Enable when multi-tenant is activated
    # default_scope { where(tenant_id: Current.tenant&.id) if Current.tenant }
  end
end
