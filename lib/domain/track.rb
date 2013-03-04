class Track

  # given a collection of points, can return distance travelled, speed between points and so on

  def initialize(points)
    @points = points
  end

  def kms
    calc.map(&:distance).sum 
  end

  def wait(wait_speed)
    calc.select{|p| p.speed <= wait_speed }.map(&:time).sum
  end



  private

  attr_reader :points

  def calc
    points.each_cons(2).map do |p1, p2| 
      p2 - p1
    end
  end



end
