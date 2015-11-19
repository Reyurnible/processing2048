// 定数の定義をしている部分で、ここの値はプログラム実行中に実態に変更されないことを表しています。
static final int BOARD_SIZE = 4;
static final int BOARD_PADDING_LEFT = 25;
static final int BOARD_PADDING_TOP = 200;
// BLOCK
static final int BLOCK_SIZE = 50;
static final int BLOCK_RADIUS = 8;
static final int BLOCK_TEXT_SIZE = 20;
// ブロック間の線の太さ
static final int DIVIDER_SIZE = 10;
// Score
static final int SCORE_WIDTH = 150;
static final int SCORE_HEIGHT = 75;
static final int SCORE_PADDING_RIGHT = 25;

int[][] board;
int score = 0;
boolean isGameOver;

/** 
  Processing特有のメソッド
  プログラムの起動時に自動的に呼びだされる
 */
void setup() {
  // 使う変数を初期化します
  board = new int[BOARD_SIZE][BOARD_SIZE];
  isGameOver = false;
  // 起動時の画面サイズを設定します
  size(300, 500);
  noStroke();
  // RGBの色を使用するという指定
  colorMode(RGB,256);
  // 背景色
  background(250, 247, 237);
}

/**
  Processing特有のメソッド
  プログラムを描画する1フレームごとに毎回呼ばれる
 */
void draw() {
  // 背景の描画
  background(250, 247, 237);
  // タイトルの表示
  drawTitle();
  // スコアの表示
  drawScore();
  // ボードの背景を書く
  drawBoard();
  // ブロックを書く
  drawBlocks();
  // ゲームオーバーの表示をする
  if(isGameOver) {
    drawGameOver();
  }
  drawGameOver();
}

private void drawTitle() {
  textSize(35);
  fill(#645b52);
  text("2048", BOARD_PADDING_LEFT, 78);
}

private void drawScore() {
  fill(#ad9d8e);
  rect(width - (SCORE_WIDTH + SCORE_PADDING_RIGHT), 25, SCORE_WIDTH, SCORE_HEIGHT, BLOCK_RADIUS);
  fill(255);
  textSize(20);
  text("SCORE", width - (SCORE_WIDTH / 2 + SCORE_PADDING_RIGHT)  - (textWidth("SCORE") / 2), 50);
  textSize(25);
  text(score, width - (SCORE_WIDTH / 2 + SCORE_PADDING_RIGHT)  - (textWidth(String.valueOf(score)) / 2), SCORE_HEIGHT + 12);
}

private void drawBoard() {
  fill(#ad9d8e);
  rect(BOARD_PADDING_LEFT, BOARD_PADDING_TOP, BOARD_SIZE * BLOCK_SIZE + (BOARD_SIZE + 1) * DIVIDER_SIZE, BOARD_SIZE * BLOCK_SIZE + (BOARD_SIZE + 1) * DIVIDER_SIZE, BLOCK_RADIUS);
}

private void drawBlocks() {
  for(int x = 0; x < BOARD_SIZE; x++) {
    for(int y = 0; y < BOARD_SIZE; y++) {
      drawBlock(board[x][y], x, y);
    }
  }
}

private void drawBlock(int number, int x, int y) {
  final int leftX = x * BLOCK_SIZE + (x + 1) * DIVIDER_SIZE + BOARD_PADDING_LEFT;
  final int topY = y * BLOCK_SIZE + (y + 1) * DIVIDER_SIZE + BOARD_PADDING_TOP;
  // 数字がある場合に数字のブロックを描画する
  if(number > 0) {
    setBlockColor(number);
    rect(leftX, topY, BLOCK_SIZE, BLOCK_SIZE, BLOCK_RADIUS);
    if(number < 8) {
      fill(24);
    } else {
      fill(255);
    }
    textSize(BLOCK_TEXT_SIZE);
    text(board[x][y], (leftX + BLOCK_SIZE / 2) - (textWidth(String.valueOf(number)) / 2), (topY + BLOCK_SIZE / 2) + (BLOCK_TEXT_SIZE / 2));
  } else {
    fill(#c2b4a4);
    rect(leftX, topY, BLOCK_SIZE, BLOCK_SIZE, BLOCK_RADIUS);
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

private void drawGameOver() {
  // 白いカラーフィルターをかける
  fill(#eaded1, 90);
  rect(0, 0, width, height);
  // GAMEOVERの表示
  fill(#645b52);
  textSize(50);
  text("GAME OVER", width / 2 - textWidth("GAME OVER") / 2, height / 2 - 25);
  // リトライボタンの表示
  rect(25, height / 2 + 50, width - 50, 50, BLOCK_RADIUS);
  fill(255);
  textSize(30);
  text("RETRY", width / 2 - textWidth("RETRY") / 2, height / 2 + 75 + 10);
}

/**
  Processing特有のメソッド
  キーボードを押した時に呼ばれる
*/
void keyPressed() {
  switch(keyCode) {
    // Left Key
    case 37:
      println("LEFT KEY PRESSED");
      pressedLeft();
      break;
    // Right Key
    case 39:
      println("RIGHT KEY PRESSED");
      pressedRight();
      break;
    // Top Key
    case 38:
      println("TOP KEY PRESSED");
      pressedTop();
      break;
    // Bottom Key
    case 40:
      println("BOTTOM KEY PRESSED");
      pressedBottom();
      break;
  }
}

private void pressedLeft() {
  for(int y = 0; y < BOARD_SIZE; y++) {
    // 同じ数をチェックしていくのに、値を保存しておくようの変数
    int lastIndex = -1;
    // 左から同じ数字がないか見ていく
    for(int x = 0; x < BOARD_SIZE; x++) {
      // もし隣の数字と一緒だったら
      if(board[x][y] > 0) {
        // 同じ数字があったので、数字を消す
        if(lastIndex != -1 && board[lastIndex][y] == board[x][y]) {
          score += board[lastIndex][y]; 
          board[lastIndex][y] = board[lastIndex][y] * 2;
          board[x][y] = 0;
          // この数字はもう評価しないので、初期化する
          lastIndex = -1;
        } else {
          // 数字があった場所として記録しておく
          lastIndex = x;
        }
      }
    }
    // ブロックを左によせる
    // 今度は数字がなかった最後の場所を記録しておく
    lastIndex = -1;
    for(int x = 0; x < BOARD_SIZE; x++) {
      if(lastIndex == -1) {
        // 数字がなかった場所として記録する
        if(board[x][y] == 0) lastIndex = x;  
        continue;
      }
      // 開いてる場所が見つかっている時に処理をする
      if(board[x][y] > 0) {
        // 数字があったので、数を左に動かすようにする
        board[lastIndex][y] = board[x][y];
        // 動かしたので空にする
        board[x][y] = 0;
        // この場所からブロックが消えたので、lastIndexの次の場所を入れる
        lastIndex = lastIndex + 1;
      }
    }
  }
  // 新たにブロックを追加できる場所を探す
  for(int y = 0; y < BOARD_SIZE; y++) {
    if(board[BOARD_SIZE - 1][y] == 0) {
       board[BOARD_SIZE - 1][y] = 2;
       break;
    } else if(y == 3) {
      // 置く場所なかった場合ゲームオーバー
      isGameOver = true;
    }
  }
}

private void pressedRight() {
  for(int y = 0; y < BOARD_SIZE; y++) {
    // 同じ数をチェックしていくのに、値を保存しておくようの変数
    int lastIndex = -1;
    // 右から同じ数字がないか見ていく
    for(int x = BOARD_SIZE - 1; x >= 0; x--) {
      // もし隣の数字と一緒だったら
      if(board[x][y] > 0) {
        // 同じ数字があったので、数字を消す
        if(lastIndex != -1 && board[lastIndex][y] == board[x][y]) {
          score += board[lastIndex][y];
          board[lastIndex][y] = board[lastIndex][y] * 2;
          board[x][y] = 0;
          // この数字はもう評価しないので、初期化する
          lastIndex = -1;
        } else {
          // 数字があった場所として記録しておく
          lastIndex = x;
        }
      }
    }
    // ブロックを左によせる
    // 今度は数字がなかった最後の場所を記録しておく
    lastIndex = -1;
    for(int x = BOARD_SIZE - 1; x >= 0; x--) {
      if(lastIndex == -1) {
        // 数字がなかった場所として記録する
        if(board[x][y] == 0) lastIndex = x;  
        continue;
      }
      // 開いてる場所が見つかっている時に処理をする
      if(board[x][y] > 0) {
        // 数字があったので、数を左に動かすようにする
        board[lastIndex][y] = board[x][y];
        // 動かしたので空にする
        board[x][y] = 0;
        // この場所からブロックが消えたので、lastIndexの次の場所を入れる
        lastIndex = lastIndex - 1;
      }
    }
  }
  // 新たにブロックを追加できる場所を探す
  for(int y = 0; y < BOARD_SIZE; y++) {
    if(board[0][y] == 0) {
       board[0][y] = 2;
       break;
    } else if(y == 3) {
      // 置く場所なかった場合ゲームオーバー
      isGameOver = true;
    }
  }
}

private void pressedTop() {
  for(int x = 0; x < BOARD_SIZE; x++) {
    // 同じ数をチェックしていくのに、値を保存しておくようの変数
    int lastIndex = -1;
    // 上から同じ数字がないか見ていく
    for(int y = 0; y < BOARD_SIZE; y++) {
      // もし隣の数字と一緒だったら
      if(board[x][y] > 0) {
        // 同じ数字があったので、数字を消す
        if(lastIndex != -1 && board[x][lastIndex] == board[x][y]) {
          score += board[x][lastIndex];
          board[x][lastIndex] = board[x][lastIndex] * 2;
          board[x][y] = 0;
          // この数字はもう評価しないので、初期化する
          lastIndex = -1;
        } else {
          // 数字があった場所として記録しておく
          lastIndex = y;
        }
      }
    }
    // ブロックを上によせる
    // 今度は数字がなかった最後の場所を記録しておく
    lastIndex = -1;
    for(int y = 0; y < BOARD_SIZE; y++) {
      if(lastIndex == -1) {
        // 数字がなかった場所として記録する
        if(board[x][y] == 0) lastIndex = y;  
        continue;
      }
      // 開いてる場所が見つかっている時に処理をする
      if(board[x][y] > 0) {
        // 数字があったので、数を左に動かすようにする
        board[x][lastIndex] = board[x][y];
        // 動かしたので空にする
        board[x][y] = 0;
        // この場所からブロックが消えたので、lastIndexの次の場所を入れる
        lastIndex = lastIndex + 1;
      }
    }
  }
  // 新たにブロックを追加できる場所を探す
  for(int x = 0; x < BOARD_SIZE; x++) {
    if(board[x][BOARD_SIZE - 1] == 0) {
       board[x][BOARD_SIZE - 1] = 2;
       break;
    } else if(x == 3) {
      // 置く場所なかった場合ゲームオーバー
      isGameOver = true;
    }
  }
}

private void pressedBottom() {
  for(int x = 0; x < BOARD_SIZE; x++) {
    // 同じ数をチェックしていくのに、値を保存しておくようの変数
    int lastIndex = -1;
    // 下から同じ数字がないか見ていく
    for(int y = BOARD_SIZE - 1; y >= 0 ; y--) {
      // もし隣の数字と一緒だったら
      if(board[x][y] > 0) {
        // 同じ数字があったので、数字を消す
        if(lastIndex != -1 && board[x][lastIndex] == board[x][y]) {
          score += board[x][lastIndex];
          board[x][lastIndex] = board[x][lastIndex] * 2;
          board[x][y] = 0;
          // この数字はもう評価しないので、初期化する
          lastIndex = -1;
        } else {
          // 数字があった場所として記録しておく
          lastIndex = y;
        }
      }
    }
    // ブロックを下によせる
    // 今度は数字がなかった最後の場所を記録しておく
    lastIndex = -1;
    for(int y = BOARD_SIZE - 1; y >= 0 ; y--) {
      if(lastIndex == -1) {
        // 数字がなかった場所として記録する
        if(board[x][y] == 0) lastIndex = y;  
        continue;
      }
      // 開いてる場所が見つかっている時に処理をする
      if(board[x][y] > 0) {
        // 数字があったので、数を左に動かすようにする
        board[x][lastIndex] = board[x][y];
        // 動かしたので空にする
        board[x][y] = 0;
        // この場所からブロックが消えたので、lastIndexの次の場所を入れる
        lastIndex = lastIndex - 1;
      }
    }
  }
  // 新たにブロックを追加できる場所を探す
  for(int x = 0; x < BOARD_SIZE; x++) {
    if(board[x][0] == 0) {
       board[x][0] = 2;
       break;
    } else if(x == 3) {
      // 置く場所なかった場合ゲームオーバー
      isGameOver = true;
    }
  }
}