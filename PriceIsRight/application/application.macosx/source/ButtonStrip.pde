public class ButtonStrip {
  float x; // left
  float y; // upper
  float w;
  float h;

  GameData gameData;
  
  int[] colors;
  Button[] buttons;

  public ButtonStrip(GameData gameData, float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;

    this.gameData = gameData;

    colors = new int[10];
    for (int i=0; i < colors.length; i++) {
      colors[i] = YELLOW;
    }

    buttons  = new Button[10];
    for (int i=0; i < buttons.length; i++) {
      buttons[i] = new Button(x+w/2, (i+0.35)*h/10, new String[2], i, height/10);
    }
    buttons[0].s[0] = "about";
    buttons[0].s[1] = "";
    buttons[1].s[0] = "help";
    buttons[1].s[1] = "";
    buttons[2].s[0] = "least $";
    buttons[2].s[1] = "average";
    buttons[3].s[0] = "most $";
    buttons[3].s[1] = "average";
    buttons[4].s[0] = "least $";
    buttons[4].s[1] = "possible";
    buttons[5].s[0] = "most $";
    buttons[5].s[1] = "possible";
    buttons[6].s[0] = "least";
    buttons[6].s[1] = "wins";
    buttons[7].s[0] = "most";
    buttons[7].s[1] = "wins";
    buttons[8].s[0] = "least";
    buttons[8].s[1] = "plays";
    buttons[9].s[0] = "most";
    buttons[9].s[1] = "plays";
  } 
  
  public void update() {
    for (int i=0; i < buttons.length; i++) {
      buttons[i].update();
      
      if (buttons[i].selected) colors[i] = RED;
      else colors[i] = YELLOW;
    }
  }

  public void render() {
    fill(DARK_ORANGE);
    noStroke();
    rectMode(CORNER);
    rect(x, y, w, h);

    noStroke();
    textAlign(CENTER, CENTER);
    rectMode(CENTER);
    textFont(font_bold, 18);
    for (int i=0; i < buttons.length; i++) {
      fill(colors[i]);
      buttons[i].render();
    }
  }
  
  public int getSelectedData() {
    if (buttons[2].selected) {
      return gameData.minAverageWinnings();
    }
    if (buttons[3].selected) {
      return gameData.maxAverageWinnings();
    }
    if (buttons[4].selected) {
      return gameData.minMaxWinnings();
    }
    if (buttons[5].selected) {
      return gameData.maxMaxWinnings();
    }
    if (buttons[6].selected) {
      return gameData.minMaxWinningStats();
    }
    if (buttons[7].selected) {
      return gameData.maxMaxWinningStats();
    }
    if (buttons[8].selected) {
      return gameData.minFrequencies();
    }
    if (buttons[9].selected) {
      return gameData.maxFrequencies();
    }
    return -1;
  }
}

