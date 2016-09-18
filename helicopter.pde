class helicopter{
  
  public int x,y, width, height;
  public boolean collided = false;
  
  public helicopter(int x,int y, int width, int height){
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
  }
  
  public void update(int vitesse){
    x -= vitesse;
  }
  
}
