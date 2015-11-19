public class Block {
  // BLOCK
  private static final int BLOCK_RADIUS = 8;
  private static final int BLOCK_TEXT_SIZE = 20;
  
  public int number;
  private int size;
  public Block(int number, int size) {
     this.number = number;
     this.size = size;
  }
  
  public void draw(int leftX, int topY) {
    // 数字がある場合に数字のブロックを描画する
    if(number > 0) {
      setBlockColor(number);
      rect(leftX, topY, size, size, BLOCK_RADIUS);
      if(number < 8) {
        fill(24);
      } else {
        fill(255);
      }
      textSize(BLOCK_TEXT_SIZE);
      text(number, (leftX + size / 2) - (textWidth(String.valueOf(number)) / 2), (topY + size / 2) + (BLOCK_TEXT_SIZE / 2));
    } else {
      fill(#c2b4a4);
      rect(leftX, topY, size, size, BLOCK_RADIUS);
    }
  }
  
  private void setBlockColor(int number) {
  switch(number) {
    case 2:
      fill(#eaded1);
      break;
    case 4:
      fill(#e9dabb);
      break;
    case 8:
      fill(#efa261);
      break;
    case 16:
      fill(#f3814c);
      break;
    case 32:
      fill(#f46549);
      break;
    case 64:
      fill(#f44526);
      break;
    case 128:
      fill(#e9c858);
      break;
    case 256:
      fill(#e9c447);
      break;
    case 512:
      fill(#dfb30c);
      break;
    case 1024:
      fill(#dbae00);
      break;
    case 2048:
      fill(#a86d9c);
      break;
    default:
      fill(#2e2c26);
      break;
  }
}


}