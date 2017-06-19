class List < ActiveRecord::Base
  has_many :items
  before_validation :finished_completion_units
  validates_numericality_of :finished_completion_units, :less_than_or_equal_to => Proc.new {|list| list.completion_units }
  validates_numericality_of :finished_completion_units, :greater_than_or_equal_to => 0

  def finished_completion_units
    self[:finished_completion_units] ||= 0
  end
end
