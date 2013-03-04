require_relative '../spec_helper.rb'
require_relative '../../lib/models/point.rb'
require 'awesome_print'
describe Point do

  let!(:p0) { Point.create(:lat => 0, :lng => 0, :created_at => DateTime.now - 2/24.0) }
  let!(:p1) { Point.create(:lat => 1, :lng => 1, :created_at => DateTime.now) }

  it { ap (p1 - p0).marshal_dump }

end
