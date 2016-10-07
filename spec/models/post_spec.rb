require 'rails_helper'

RSpec.describe Post, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
it {should validate_length_of(:content).is_at_least(50)}
it {should validate_presence_of :title}
it {should validate_presence_of :author}
it {should validate_presence_of :content}
end
