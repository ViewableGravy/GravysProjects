// this should be split into separate files


public class GravyBanner extends Item implements MiscItem {
    public GravyBanner() {
        super(0.0,0.0,5,"GravyBanner", new CurrencyPurse(0,0,300,0), 0, categoryEnum.Misc, "A high level banner representing your commitment to the GravyBoat");
    }
    
    public categoryEnum GetCategory() {
      return MiscItem.category; 
    }
    
    public Item CreateNewInstance() {
      return new GravyBanner(); 
    }
    
    public void DisplayButton(int x, int y, int wid, int hei) {
       rect(x,y,wid,hei);
    }
}

public class GravyArmour extends Item implements ArmourItem {
    public GravyArmour() {
        super(0.0,0.0,5,"GravyArmour", new CurrencyPurse(0,0,300,0), 0, categoryEnum.Misc, "A high level set of armour representing your commitment to the GravyBoat");
    }
    
    public categoryEnum GetCategory() {
      return ArmourItem.category; 
    }
    
    public Item CreateNewInstance() {
      return new GravyArmour(); 
    }
    
    public void DisplayButton(int x, int y, int wid, int hei) {
       rect(x,y,wid,hei);
    }
}

interface MiscItem {
  public categoryEnum category = categoryEnum.Misc;
}

interface ArmourItem {
 public categoryEnum category = categoryEnum.Armour; 
}
