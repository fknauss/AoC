
Point = Struct.new(:x, :y)
class Point
  def valid?
    x >= 0 && x<@@bound.x && y >=0 && y< @@bound.y
  end
  
  def +(p)
    Point[x+p.x,y+p.y]
  end
  
  def n4
    [[0,1],[0,-1],[1,0],[-1,0]].map{|c| self+Point[*c]}
  end
  
  def vn4
    a=n4.filter(&:valid?)
  end
  
  def n8
    ([-1,0,1].product([-1,0,1])-[[0,0]]).map{|c| self+Point[*c]}
  end
  
  def vn8
    n8.filter(&:valid?)
  end
    
  def self.bound(p)
    @@bound = p
  end
  
  def to_s
    "<%d, %d>"%[x,y]
  end
  
  def self.all
    (0...@@bound.x).to_a.product((0...@@bound.y).to_a).map{|x|new(*x)}
  end
  
end