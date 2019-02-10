
class CurrencyPurse {
  public int copper, silver, peach, gravy;
  CurrencyPurse(String username) {
    String temp = "";
    try {
    JSONObject something = loadJSONObject("https://api.streamelements.com/kappa/v2/points/5c235339072350ec38cd501f/top");
    JSONArray users = something.getJSONArray("users");
    //println(users);
    
    for(int i = 0; i < users.size(); i++) {
      JSONObject user = users.getJSONObject(i);
      if (user.get("username").equals(username.toLowerCase())) {
        temp = user.get("points").toString(); 
      }
    }
    println("done");
  } 
  catch (Exception e) {
  }
    copper = 0;
    silver = 0;
    peach = int(temp);
    gravy = 0;
  }
  
  CurrencyPurse(int cop, int sil, int _peach, int grav) {
     copper = cop;
    silver = sil;
    peach = _peach;
    gravy = grav;
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
