// server.js
const express = require("express");
const bodyParser = require("body-parser");
const http = require("http");
const WebSocket = require("ws");

const app = express();
app.use(bodyParser.json());

const server = http.createServer(app);
const wss = new WebSocket.Server({
  server,
  host: "0.0.0.0",
});

let clients = new Set();

wss.on("connection", (ws) => {
  console.log("WebSocket Connected");
  clients.add(ws);

  ws.on("close", () => {
    console.log("WebSocket Disconnected");
    clients.delete(ws);
  });
});

// 1) Flutter용 문자열 broadcast 함수
function safeBroadcast(rawMsg) {
  console.log("📤 Flutter Broadcast:", rawMsg);

  wss.clients.forEach((ws) => {
    if (ws.readyState === WebSocket.OPEN) {
      ws.send(rawMsg);
    }
  });
}

// RC카 명령
app.post("/command", (req, res) => {
  const { command } = req.body;

  if (!command) return res.status(400).json({ ok: false });

  console.log("받은 명령(로봇):", command);

  const payload = JSON.stringify({
    type: "command",
    command,
  });

  for (const ws of clients) {
    if (ws.readyState === WebSocket.OPEN) {
      ws.send(payload);
    }
  }

  res.json({ ok: true });
});

// 2) /suda/llm → Flutter로 raw 문자열 전송
app.post("/suda/llm", (req, res) => {
  const llmText = req.body.data; // 예: "<maum_2>(mode=2, time="오전 6시")"

  console.log("받은 명령:", llmText);

  // Flutter에게만 raw 문자열 전달
  safeBroadcast(llmText);

  res.json({ ok: true });
});

// TTS 로그
app.post("/suda/tts", (req, res) => {
  console.log("TTS 로그:", req.body);
  res.json({ ok: true });
});

// 서버 실행
const PORT = 3001;
server.listen(PORT, "0.0.0.0", () => {
  console.log(`Server running at http://0.0.0.0:${PORT}`);
});
