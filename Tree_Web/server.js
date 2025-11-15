// server.js
const express = require("express");
const bodyParser = require("body-parser");
const http = require("http");
const WebSocket = require("ws");

const app = express();
app.use(bodyParser.json());

// HTTP + WebSocket 서버 생성
const server = http.createServer(app);
const wss = new WebSocket.Server({ server });

// 연결된 Three.js 브라우저 목록
let clients = new Set();

// 브라우저(WebSocket) 연결 처리
wss.on("connection", (ws) => {
  console.log("WebSocket Connected");
  clients.add(ws);

  ws.on("close", () => {
    console.log("WebSocket Disconnected");
    clients.delete(ws);
  });
});

// 안드로이드에서 명령 보내는 엔드포인트
// body: { "command": "<maum_0>(direction=1)<maum_end>" }
app.post("/command", (req, res) => {
  const { command } = req.body;

  if (!command) {
    console.error("command 필드가 비어 있음");
    return res.status(400).json({ ok: false, error: "command is required" });
  }

  console.log("받은 명령:", command);

  // 연결된 모든 브라우저로 전파
  for (const ws of clients) {
    try {
      ws.send(JSON.stringify({ type: "command", command }));
    } catch (e) {
      console.error("WS 전송 중 에러:", e);
    }
  }

  res.json({ ok: true });
});

// 서버 실행
const PORT = 3001;
server.listen(PORT, "0.0.0.0", () => {
  console.log(`Server running at http://0.0.0.0:${PORT}`);
});
