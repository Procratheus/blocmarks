class TopicPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    user.present?
  end

  def create?
    user.present?
  end

  def update?
    user.present? && (record.user == user)
  end

  def destroy?
    update?
  end
  
end