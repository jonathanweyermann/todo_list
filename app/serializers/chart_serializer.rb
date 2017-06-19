class ChartSerializer < ActiveModel::Serializer
  attributes :name, :data

  def name
    object.description
  end

  def data
    (JSON.parse (["first": object.finished_completion_units,"second":object.completion_units].to_json)).first
  end
end
