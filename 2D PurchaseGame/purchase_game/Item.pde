
public abstract class Item extends Entity {
  protected CurrencyPurse cost;
  protected int weight;
  protected String desc;
  public categoryEnum category;
  public boolean mousePreviousFrame = false;
  protected int wid, hei;

  Item(Float _x, Float _y, int rad, String _name, CurrencyPurse _cost, int _weight, categoryEnum _category, String _desc) {
    super(_x, _y, rad, _name); 
    cost = _cost;
    weight = _weight;
    desc = _desc;
    category = _category;
  }
  
  Item(String _name, CurrencyPurse _cost, categoryEnum _category, String _desc) {
    super(0.0, 0.0, 5, _name); 
    cost = _cost;
    weight = 5;
    desc = _desc;
    category = _category;
  }

  public Entity interact(char key) {
    return null; /*this is not implemented yet for this object */
  };
  public  int GetDirection() {
    return 0; /*this is not implemented yet for this object */
  };

  public  boolean ShowInteractionInterface(Player player, float mousex, float mousey) {
    return false; 
    /*this is not implemented yet for this object */
  };


   boolean clicked = false;
   public boolean Clicked(float mousex, float mousey) {
    if (clicked || mousex > pos.x && mousex < pos.x + wid && mousey < pos.y + hei && mousey > pos.y && mousePressed) {
     return clicked = true;
    }
    return clicked = false;
  }
  
  public abstract Item CreateNewInstance();
  public abstract categoryEnum GetCategory();
  
   public void SetButton(int _x, int _y, int _wid, int _hei) {
    pos.x = _x;
    pos.y = _y;
    wid = _wid;
    hei = _hei;
  }
  
  public void DisplayButton(String displayLocation) {
    //rect(x, y, wid, hei);
    switch (displayLocation) {
    case "merchant":
      final int IMG = hei - 20;
      fill(100, 0, 0);
      rect(pos.x, pos.y, wid, hei);
      fill(0, 100, 0);
      textAlign(RIGHT);
      textSize(32);
      //
      text(name, pos.x + wid - 20, pos.y + 2*hei/3 + hei/6); //category name
      rect(pos.x +10, pos.y + 10, IMG, IMG);                            //represents Category image
      //
      textSize(12);
      textAlign(CENTER);
      fill(255);
    }
  }
  
  public void ShowConfirmPurchase() {
   rect( width/2 - width/4, height/2 - height/4 ,width/2,height/2); 
  }
  
   int firstclick = 0;
  public String Confirm(float mousex, float mousey) {
    
    
    if (firstclick == 0) {
      mousePreviousFrame = true;
      firstclick = 1;
      }
      if (firstclick == 1) {
        if (!mousePreviousFrame) {
          firstclick = 2;
        }
      } else if (firstclick == 2) {
       if (mousex > width/2 - width/4 &&  mousey < height/2 + height/4 && mousex > width/2 - width/4 && mousey < height/2 + height/4 && mousePressed) {
          println("something");
   
          firstclick = 0;
          return "confirm";
        }
      }
    
    
    return "show";
  }

  public  void display(int angle) { //
  };
}
