class Project < ApplicationRecord
	has_many :clients, dependent: :destroy
	accepts_nested_attributes_for :clients, allow_destroy: true, reject_if: lambda {|attributes| attributes['contact'].blank?}
end
