class Jugador{
  private float posicionY = (height/2) - ((height/5)/2), posicionX, margen;
  private float W = 20, H = height / 5;
  
  public Jugador(int posicionX, float radio)
  {
    this.posicionX = posicionX;
    margen += radio;
  }
  
  public void dibujar()
  {
    fill(255, 255, 255);
    stroke(0);
    rect(posicionX, posicionY, W, H);
  }
  
  public void setY(int y)
  { 
    if(y - H/2 < 0)
    {
      posicionY = 0;
    }
    else if(y + H > height)
    {
      posicionY = height - H;
    }
    else
    {
      posicionY = y - H/2;
    }
  }
  
  public float getW()
  {
    return W;
  }
  
  public boolean estaDentro(float x, float y)
  {
    boolean dentro = false;
    if(x >= posicionX - margen && x <= posicionX + margen + W && y  >= posicionY && y <= posicionY + H)
    {
      dentro = true;
    }
    return dentro;
  }
  
  public void setPosicion(float y)
  {
    posicionY = y;
  }
}
