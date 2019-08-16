# Manage Roles for Admin
class AdminUserPolicy < ApplicationPolicy
  # Scope for the role
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
