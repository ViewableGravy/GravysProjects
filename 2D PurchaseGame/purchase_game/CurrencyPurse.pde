
class CurrencyPurse {
  private int copper, peach, gold, gravy;
  private final int COPPER_TO_GRAVY = 10000;
  private final int COPPER_TO_GOLD = 1000;
  private final int COPPER_TO_PEACH = 100;
  
  //takes a value in copper and converts it up
  public CurrencyPurse(int inCopper) {
   gravy = floor(inCopper / COPPER_TO_GRAVY);
   copper = inCopper % COPPER_TO_GRAVY;
   gold = floor(copper / COPPER_TO_GOLD);
   copper %= COPPER_TO_GOLD;
   peach = floor(copper/COPPER_TO_PEACH);
   copper %= 100;
  }

  //adds two currency purses
  public CurrencyPurse add(CurrencyPurse purse) {
    return new CurrencyPurse(ToCopper(this) + ToCopper(purse));
  }
  
  //subtracts two currency purses (Throws exception if the second is larger than first)
  public CurrencyPurse sub(CurrencyPurse cp) throws Exception {
    int newCopper = ToCopper(this) - ToCopper(cp);
    if (newCopper >= 0) {
     return new CurrencyPurse(newCopper); 
    } else {
     throw new Exception("Cannot Subtract money");
    }
  }
  
  //converts a currency purse to copper
  public int ToCopper(CurrencyPurse cp) {
    int Copper = 0;
    Copper+=cp.copper;
    Copper+=cp.peach*COPPER_TO_PEACH;
    Copper+=cp.gold*COPPER_TO_GOLD;
    Copper+=cp.gravy*COPPER_TO_GRAVY;
    return Copper;
  }
}
