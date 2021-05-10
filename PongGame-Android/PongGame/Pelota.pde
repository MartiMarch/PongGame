class Pelota{
  private static final int R = 50;
  private float x = width/2, y = height/2;
  
  public Pelota()
  {
  }
  
  public void dibujar()
  {
    circle(x, y, R);
    fill(0, 0, 255);
  }
  
  public float getY()
  {
    return y;
  }
  
  public float getX()
  {
    return x;
  }
  
  public void setY(float y)
  {
    this.y = y;
  }
  
  public void setX(float x)
  {
    this.x = x;
  }
  
  public float getRadio()
  {
    return R;
  }
  
  public void setUbicacion(float x, float y)
  {
    this.x = x;
    this.y = y;
  }
}
