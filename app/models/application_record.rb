# ApplicationRecord class
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # Find record on first attribute/value match
  # @param value value one the attributes should have
  # @param attr array of attributes names (strings)
  # @return [ActiveRecord] corresponding record
  def self.dirty_find(value, attrs = new.attributes.keys)
    attrs.each do |a|
      record = where("#{a} = ?", value).first
      return record unless record.nil?
    end
    raise ActiveRecord::RecordNotFound, "Couldn't find #{name} with '#{attrs.join('\' or \'')}' matching '#{value}'"
  end
end
