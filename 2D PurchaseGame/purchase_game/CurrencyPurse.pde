
class CurrencyPurse {
  public int copper, silver, peach, gravy;
  CurrencyPurse(int _copper, int _silver, int _peach, int _gravy) {
    copper = _copper;
    silver = _silver;
    peach = _peach;
    gravy = _gravy;
  }
  // could have functions to calculate the amount in other currency e.g. gold to silver

  public void ConvertDown(int amount, String type) {
    switch(type) {
    case "silver" :
      if (silver >= amount) {
        copper+= amount*10;
        silver-= amount;
      }
      break;
    case "peach" :
      if (peach >= amount) {
        silver+= amount*10;
        peach-= amount;
      }
      break;
    case "gravy" :
      if (gravy >= amount) {
        peach += amount * 10;
        gravy -= amount;
      }
      break;
    default:
      println("Unknown currency");
    }
  }

  public void ConvertUp(int amount, String type) {
    switch(type) {
      case "silver" :
        if (silver >= amount && amount % 10 == 1) {
          peach+= amount/10;
          silver-= amount;
        }
        break;
      case "peach" :
        if (peach >= amount && amount % 10 == 1) {
          gravy+= amount/10;
          peach-= amount;
        }
        break;
      case "copper" :
        if (copper >= amount && amount % 10 == 1) {
          silver += amount/10;
          copper -= amount;
        }
        break;
      default:
        println("Unknown currency");
    }
  }
}
