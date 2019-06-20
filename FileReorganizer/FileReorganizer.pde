

WheelOfAnime animeWheel;

void setup() {
  fullScreen();
  
  animeWheel = new WheelOfAnime("TestAnimeFile.txt", "TestAnimeOutput.txt");
}

void draw() {
  
  animeWheel.Run();

}
