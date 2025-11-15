// server.js
const express = require("express");
const bodyParser = require("body-parser");
const http = require("http");
const WebSocket = require("ws");

const app = express();
app.use(bodyParser.json());

// HTTP + WS 서버 생성
const server = http.createServer(app);
const wss = new WebSocket.Server({ server });

// 연결된 브라우저 목록
let clients = new Set();

wss.on("connection", (ws) => {
  console.log("WebSocket Connected");
  clients.add(ws);

  ws.on("close", () => {
    console.log("WebSocket Disconnected");
    clients.delete(ws);
  });
});

// Android → HTTP POST로 명령 보내는 엔드포인트
app.post("/command", (req, res) => {
  const { command } = req.body;
  console.log("받은 명령:", command);

  // 연결된 WebSocket 클라이언트(브라우저)에게 전달
  for (const ws of clients) {
    ws.send(JSON.stringify({ type: "command", command }));
  }

  res.json({ ok: true });
});

// 서버 실행
const PORT = 3001;
server.listen(PORT, "0.0.0.0", () => {
  console.log(`Server running at http://0.0.0.0:${PORT}`);
});
