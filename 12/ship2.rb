class Ship2
  HEADINGS = {
    'N' => [0, 1],
    'S' => [0, -1],
    'E' => [1, 0],
    'W' => [-1, 0],
  }
  
  def initialize (file_name)
    File.open(file_name) do |f|
      @directions = f.readlines.map do |l|
        [ l[0] , l[1..].to_i ]
      end
    end
    @ship_x = 0
    @ship_y = 0
    @waypoint_x = 10
    @waypoint_y = 1
  end
  
  def navigate
    @directions.each do |d|
      command = d[0]
      distance = d[1]
      
      if command == 'F'
        forward(distance)
      elsif 'LR'.include?(command)
        turn_n = distance / 90
        turn_n.times do
          rotate(command)
        end
      else
        move(command, distance)
      end
    end
  end
  
  def rotate (side)
    #
    # rotate right
    # 1,2 -> 2,-1 -> -1,-2 -> -2,1
    # a,b -> b,-a ->  b,-a -> b,-a
    #
    if side == 'R'
      @waypoint_x, @waypoint_y = @waypoint_y, @waypoint_x * -1
    else
      @waypoint_x, @waypoint_y = @waypoint_y * -1, @waypoint_x
    end
  end
  
  def forward (distance)
    @ship_x += @waypoint_x * distance
    @ship_y += @waypoint_y * distance
  end
  
  def move (heading, distance)
    x_mov, y_mov = HEADINGS[heading]
    move_x = x_mov * distance
    move_y = y_mov * distance
    @waypoint_x += move_x
    @waypoint_y += move_y
  end
  
  def manhatten
    @ship_x.abs + @ship_y.abs
  end
end