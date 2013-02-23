public class SortBy {
  int[] fillColors;
  Button[] buttons;

  int buttonIndex;

  public SortBy() {
    fillColors = new int[4];
    for (int i=0; i < fillColors.length; i++) {
      fillColors[i] = YELLOW;
    }

    buttons = new Button[4];
    for (int i=0; i < buttons.length; i++) {
      buttons[i] = new Button(width-60-0.5*55-5, height/4-8+i*height/10, new String[2], i, height/10);
    }
    buttons[0].s[0] = "payoff";
    buttons[0].s[1] = "";
    buttons[1].s[0] = "max $";
    buttons[1].s[1] = "";
    buttons[2].s[0] = "win %";
    buttons[2].s[1] = "";
    buttons[3].s[0] = "play %";
    buttons[3].s[1] = "";

    buttonIndex = 0;
  }

  public void update() {
    for (int i=0; i < buttons.length; i++) {
      if (buttonIndex == i) {
        buttons[i].selected = true;
      }
      else {
        buttons[i].selected = false;
      }

      if (buttons[i].selected) {
        fillColors[i] = WHITE;
        gameGraph.category = i;
        buttons[i].showText = true;
      }
      else {
        fillColors[i] = color(ORANGE, 100);
        buttons[i].showText = false;
      }
    }
  }

  public void render() {
    if (customCursor.selectingSortBy) {
      fill(WHITE, 100);
      noStroke();
      rectMode(CORNER);
      //rect(0, 0, width-65, height);

      fill(DARK_ORANGE);
      noStroke();
      rectMode(CORNER);
      rect(width-60-55-5, height/4-35, 55, 4*height/10);

      noStroke();
      textAlign(CENTER, CENTER);
      rectMode(CENTER);
      textFont(font_bold, 18);
      for (int i=0; i < buttons.length; i++) {
        fill(fillColors[i]);
        buttons[i].render();
      }
    }
  }
}

