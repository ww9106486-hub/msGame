int N = 20; //운석의 최대 개수
float[] mx = new float[N];
float[] my = new float[N];
float[] ms = new float[N]; //운석 속도
float[] mr = new float[N]; //운석 크기(반지름)
boolean[] live = new boolean[N]; //운석 생존 여부
float px, py; //플레이어 위치
float ps = 20; //플레이어 크기(반지름 기준)

int state = 0; //0게임 진행 중, 1게임 오버 
int life = 3;  //남은 목숨
int score = 0; //점수

void setup() {
  size(1000, 1000);
  reset(); //변수 초기화
}

//리셋
void reset() {
  px = width / 2;
  py = height - 100;
  life = 3;
  score = 0;
  state = 0;
  
  for (int i = 0; i < N; i++) {
    mx[i] = random(width);
    my[i] = random(-1000, -50); 
    ms[i] = random(3, 8);
    mr[i] = random(15, 35);
    live[i] = true;
  }
}

void draw() {
  if (state == 0) {
    background(20, 20, 40);
    
    handlePlayer();
    updateMeteors();
    drawObjects();
    drawUI();
  } 
  
  
//============================sprint 5
  else if (state == 1) {
    background(0); //까만 배경
    
    fill(255, 0, 0);
    textSize(80);
    text("GAME OVER", width / 2 - 200, height / 2 - 50);
    
    fill(255);
    textSize(40);
    text("Final Score: " + score, width / 2 - 120, height / 2 + 30);
    
    textSize(25);
    text("Press 'R' to Restart", width / 2 - 100, height / 2 + 100);
      
    //R 키 다시 시작
    if (keyPressed) {
      if (key == 'r' || key == 'R') {
        reset();
      }
    }
  }
}



//============================sprint 1
void drawObjects() {
  //우주선
  fill(0, 255, 0);
  triangle(px, py - ps, px - ps, py + ps, px + ps, py + ps);

  for (int i = 0; i < N; i++) {
    if (live[i]) {
      //운석
      fill(150);
      circle(mx[i], my[i], mr[i] * 2);
    }
  }
}





//============================sprint 2 
void handlePlayer() {
  //키보드
  if (keyPressed) {
    if (key == 'w' || key == 'W') py -= 7;
    if (key == 's' || key == 'S') py += 7;
    if (key == 'a' || key == 'A') px -= 7;
    if (key == 'd' || key == 'D') px += 7;
  }

  //화면 밖으로 못 나가게
  if (px < ps) 
    px = ps;
  
  if (px > width - ps) 
    px = width - ps;
  
  if (py < ps) 
     py = ps;
  
  if (py > height - ps) 
    py = height - ps;
}





//============================sprint 3
void updateMeteors() {
  for (int i = 0; i < N; i++) {
    if (live[i]) {
      my[i] += ms[i];
      
      //충돌
      if (dist(px, py, mx[i], my[i]) < ps + mr[i]) {
        live[i] = false; //부딪힌 운석은 사라짐
        life--;          //목숨 1 깎임
        
        //목숨이 0 게임 오버
        if (life <= 0) {
          state = 1; 
        }
      }
      
      //점수 오름
      if (my[i] > height + mr[i]) {
        score++; //점수 1점 추가
        my[i] = random(-200, -50); //다시 떨어지게
        mx[i] = random(width);
        live[i] = true;
      }
    }
  }
}





//============================sprint 4
void drawUI() {
  fill(255);
  textSize(30);
  text("Score: " + score, 20, 50);
  text("Life: " + life, 20, 90);
}
