# == Schema Information
#
# Table name: grants
#
#  id         :bigint           not null, primary key
#  active     :boolean          default(TRUE)
#  details    :text
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Grant < ApplicationRecord
end
