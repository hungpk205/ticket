# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return undefine_user if user.blank?
    if user.admin?
      permission_admin user
    elsif user.editor?
      if user.company.present?
        can :manage, user.company
        can :manage, Employee, company_id: user.company.id
        can :manage, Route, company_id: user.company.id
        can :manage, Bus, company_id: user.company.id
        can :manage, Trip, company_id: user.company.id
        can :manage, Ticket, trip_id: user.company.trips.ids
        can %i(read update accept reject), Booking, trip_id: user.company.trips.ids
        can :create, Booking
      else
        can :create, Company
      end
    end
  end

    private

    def permission_admin user
      return unless user.admin?
      can :read, all
      can :destroy, Company
    end

    def undefine_user
      can :create, User
      can %i(create destroy), Booking
    end
end
