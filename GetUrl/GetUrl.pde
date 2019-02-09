
import http.requests.*;

void setup() {
  size(200, 200);
  background(50);
  fill(200);

 PostRequest post = new PostRequest("http://httprocessing.heroku.com");

  try {
    JSONObject something = loadJSONObject("https://api.streamelements.com/kappa/v2/points/5c235339072350ec38cd501f/top");
    JSONArray users = something.getJSONArray("users");
    //println(users);
    
    for(int i = 0; i < users.size(); i++) {
      JSONObject user = users.getJSONObject(i);
      if (user.get("username").equals("viewablegravy")) {
        println(user.get("points")); 
      }
    }
    println("done");
  } 
  catch (Exception e) {
  }
}
