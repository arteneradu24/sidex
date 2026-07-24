# frozen_string_literal: true

# Request-scoped attributes for future multi-tenant and i18n support.
class Current < ActiveSupport::CurrentAttributes
  attribute :tenant
  attribute :locale
end
