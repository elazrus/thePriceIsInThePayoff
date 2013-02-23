public class Search {
  int strokeColor;
  int fillColor;
  int textColor;

  boolean typing;
  boolean selected;
  int selectedIndex;
  int suggestedIndex;

  boolean acceptInput;
  String input;
  String cursor;
  String suggested;

  ArrayList<String> matching;

  public Search() {
    strokeColor = WHITE;
    fillColor = ORANGE;
    textColor = WHITE;

    typing = false;
    selected = false;
    selectedIndex = -1;
    suggestedIndex = -1;

    acceptInput = true;
    input = "";
    cursor = "|";

    matching = new ArrayList<String>();
  }

  public void update() {
    matching.clear();
    cursor = "";

    if (customCursor.searching) {
      if (selected) {
        textColor = RED;
        strokeColor = YELLOW;
        suggestedIndex = -1;
      }
      else {
        textColor = WHITE;
        strokeColor = WHITE;
      }

      if (input.length() > 0) {
        typing = true;
      }
      else {
        typing = false;
      }
    }
    else {
      typing = false;
      selected = false;
      suggestedIndex = -1;

      acceptInput = true;
      input = "";
    }

    if (typing) {
      matching = gameData.searchGames(input);
      if (suggestedIndex == -1) {
        for (int i=0; i < input.length(); i++) {
          cursor += " ";
        }
      }
      else {
        for (int i=0; i < matching.get(suggestedIndex).length(); i++) {
          cursor += " ";
        }
      }
    }

    if (selected) {
      ArrayList<Integer> matchingIndices = gameGraph.main.searchVertTicks(input);
      if (matchingIndices.size() == 1) {
        selectedIndex = matchingIndices.get(0);
      }
      else {
        selectedIndex = -1;
      }
    }
    else {
      selectedIndex = -1;
    }
    
    cursor += "|";
  }

  public void render() {
    if (customCursor.searching) {
      fill(DARK_ORANGE);
      noStroke();
      rectMode(CORNER);
      rect(width-60-4*55-5, 3*height/10, 4*55, height/10);

      fill(fillColor);
      stroke(strokeColor);
      strokeWeight(3);
      rectMode(CORNER);
      rect(width-60-3.5*55-5, 3*height/10+(height/10-height/25)/2, 3*55, height/25);

      fill(YELLOW);
      noStroke();
      textAlign(LEFT, CENTER);
      textFont(font_normal, 17);
      text("Type the name of a game and hit enter", width-60-4*55, 3*height/10+.1*height/10);

      if (!selected && !typing) {
        fill(textColor);
        noStroke();
        textAlign(LEFT, CENTER);
        textFont(font_mono, 10);
        text("e.g. 2 for the Price of 1", width-60-3.5*55+5, 3*height/10+height/20-2);
        if (0 <= frameCount%80 && frameCount%80 <= 40) {
          fill(WHITE);
          noStroke();
          textAlign(LEFT, CENTER);
          textFont(font_bold, 30);
          text(cursor, width-60-3.5*55, 3*height/10+height/20-5);
        }
      }
      else {
        fill(textColor);
        noStroke();
        textAlign(LEFT, CENTER);
        textFont(font_mono, 10);
        if (suggestedIndex == -1) text(input, width-60-3.5*55+5, 3*height/10+height/20-2);
        else text(matching.get(suggestedIndex), width-60-3.5*55+5, 3*height/10+height/20-2);

        if (!selected) {
          fill(DARK_ORANGE);
          noStroke();
          rectMode(CORNER);
          rect(width-60-4*55-5, 4*height/10+5, 4*55, height/20-5+matching.size()*20);

          fill(YELLOW);
          noStroke();
          textAlign(LEFT, CENTER);
          textFont(font_normal, 18);
          text("Suggestions:", width-60-4*55, 4*height/10+5+10);

          for (int i=0; i < matching.size(); i++) {
            if (suggestedIndex==i) {
              fill(RED);
            }
            else {
              fill(textColor);
            }
            noStroke();
            textAlign(LEFT, CENTER);
            textFont(font_mono, 10);
            text(matching.get(i), width-60-3.5*55+5, 4*height/10+5+30+i*20);
          }

          if (0 <= frameCount%80 && frameCount%80 <= 40) {
            fill(WHITE);
            noStroke();
            textAlign(LEFT, CENTER);
            textFont(font_bold, 30);
            text(cursor, width-60-3.5*55+5, 3*height/10+height/20-5);
          }
        }
      }
    }
  }

  void keyTyped() {
    if (!selected && acceptInput) {
      acceptInput = false;
      if (key == ENTER) {
        if (suggestedIndex != -1) input = matching.get(suggestedIndex);
        selected = true;
      }
      else if (key == BACKSPACE) {
        if (suggestedIndex != -1) {
          input = matching.get(suggestedIndex);
          suggestedIndex = -1;
        }
        if (input.length() > 0) {
          input = input.substring(0, input.length() - 1);
        }
      }
      else if (isAlphaNumeral(key) || key == ' ') {
        if (suggestedIndex != -1) {
          input = matching.get(suggestedIndex);
          suggestedIndex = -1;
        }
        if (input.length() < 23) {
          input += key;
        }
      }
      acceptInput = true;
    }
    else if (selected) {
      if (key == BACKSPACE) {
        selected = false;
      }
    }
  }

  boolean isAlphaNumeral(int k) {
    String letters = "abcdefghijklmnopqrstuvwxyz";
    String numbers = "0123456789";
    String c = str(char(k));

    for (int i=0; i < letters.length(); i++) {
      if (c.compareToIgnoreCase(str(letters.charAt(i))) == 0) {
        return true;
      }
    }

    for (int i=0; i < numbers.length(); i++) {
      if (c.compareToIgnoreCase(str(numbers.charAt(i))) == 0) {
        return true;
      }
    }

    return false;
  }
}

