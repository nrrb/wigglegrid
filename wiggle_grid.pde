int vertical_sections = 50;
int horizontal_sections = 80;
color grid_color = color(255, 255, 255, 127);
color bg_color = color(0, 0, 30);
float grid_thickness = 1.0;
float wiggle_magic = random(1.0);


float[][] grid_point_x;
float[][] grid_point_y;

void setup()
{
  //size(displayWidth, displayHeight);
  size(1300, 700);
  smooth();
  strokeWeight(grid_thickness);
  randomize_colors();
  
  grid_point_x = new float[horizontal_sections + 3][vertical_sections + 3];
  grid_point_y = new float[horizontal_sections + 3][vertical_sections + 3];

  reset_grid();
}

void draw()
{
  background(bg_color);
  draw_grid();
  wiggle_grid(); 
}

void keyPressed()
{
  save(year()+"."+month()+"."+day()+"."+hour()+"."+minute()+"."+second()+".png");
  randomize_colors();
  reset_grid();
  wiggle_magic = random(1.0);
}

void reset_grid()
{
  for (int y = 0; y < vertical_sections + 3; y++)
  {
    for (int x = 0; x < horizontal_sections + 3; x++)
    {
      float section_width = float(width) / float(horizontal_sections - 2),
            section_height = float(height) / float(vertical_sections - 2);      
      grid_point_x[x][y] = (x - 1) * section_width;
      grid_point_y[x][y] = (y - 1) * section_height;
    }
  }
}  
  
void wiggle_grid()
{
  for (int y = 0; y < vertical_sections + 3; y++)
  {
    for (int x = 0; x < horizontal_sections + 3; x++)
    {
      if(random(1.0) < wiggle_magic)
      {
        float x_noise = random(1.0) - 0.5,
              y_noise = random(1.0) - 0.5;
        grid_point_x[x][y] += x_noise;
        grid_point_y[x][y] += y_noise;
      }
    }
  }
}

void draw_grid()
{
  for (int y = 0; y < vertical_sections + 2; y++)
  {
    for (int x = 0; x < horizontal_sections + 2; x++)
    {
      line(grid_point_x[x][y], grid_point_y[x][y], 
            grid_point_x[x+1][y] - 1, grid_point_y[x+1][y] - 1);
      line(grid_point_x[x][y], grid_point_y[x][y], 
            grid_point_x[x][y+1] - 1, grid_point_y[x][y+1] - 1);      
    }
  }
  for (int x = horizontal_sections + 2, y = 0; y < vertical_sections + 2; y++)
  {
    line(grid_point_x[x][y], grid_point_y[x][y],
          grid_point_x[x][y+1] - 1, grid_point_y[x][y+1] - 1);
  }
  for (int x = 0, y = vertical_sections + 2; x < horizontal_sections + 2; x++)
  {
    line(grid_point_x[x][y], grid_point_y[x][y],
          grid_point_x[x+1][y] - 1, grid_point_y[x+1][y] - 1);
  }
}

void randomize_colors()
{
  bg_color = color(random(256), random(256), random(256));
  grid_color = color(random(256), random(256), random(256), 127);
  stroke(grid_color);
  background(bg_color);
}
