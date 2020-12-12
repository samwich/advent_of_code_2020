class Ship
  HEADINGS = {
    'N' => [0, 1],
    'S' => [0, -1],
    'E' => [1, 0],
    'W' => [-1, 0],
  }
  
  def initialize (file_name, heading='E')
    File.open(file_name) do |f|
      @directions = f.readlines.map do |l|
        [ l[0] , l[1..].to_i ]
      end
    end
    @x = 0
    @y = 0
    @heading = heading
  end
  
  def navigate
    @directions.each do |d|
      command = d[0]
      distance = d[1]
      
      if command == 'F'
        forward(distance)
      elsif 'LR'.include?(command)
        turn(command)
      else
        move(command, distance)
      end
    end
  end
  
  def turn (side)
    new_heading = {
      'N' => { 'L'=>'W','R'=>'E' },
      'S' => { 'L'=>'E','R'=>'W' },
      'E' => { 'L'=>'N','R'=>'S' },
      'W' => { 'L'=>'S','R'=>'N' },
    }[@heading][side]
    @heading = new_heading
  end
  
  def forward (distance)
    move(@heading, distance)
  end
  
  def move (heading, distance)
    x_mov, y_mov = HEADINGS[heading]
    move_x = x_mov * distance
    move_y = y_mov * distance
    @x += move_x
    @y += move_y
  end
  
  def manhatten
    @x.abs + @y.abs
  end
end