int x,y,w,h;
int roofColorR,roofColorG,roofColorB;
void setup()
{
  size(300,300);
  background(0);
  
  x=80;
  y=50;
  w=40;
  h=30;
}
void draw()
{
    background(0);
    x=floor(random(256));
    y=floor(random(256));
  //roof
  stroke(255);
  roofColorR = floor(random(256));    
  roofColorG = floor(random(256));
  roofColorB = floor(random(256));
  fill(roofColorR,roofColorG,roofColorB);
  triangle(x+w/2,y,x,y+h/2,x+w,y+h/2);
  
  rectMode(CORNERS);
  
  //wall
  fill(#ffff00);
  rect(x,y+h/2,x+w,y+h);
  
  //door
  stroke(0);
  fill(255);
  rect(x+w/2,y+4.0/6*h,x+5.0/6*w,y+h);
  delay(1000);
}