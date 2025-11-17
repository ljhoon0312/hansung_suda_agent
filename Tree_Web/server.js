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

// LLM 결과 받는 핸들러 안에서 (POST /suda/llm)
app.post('/suda/llm', (req, res) => {
  const llmText = req.body.data;  // 안드에서 보낸 LLM 결과, 예: "<maum_1>(direction=2)"

  console.log('받은 명령:', llmText);

  // WebSocket으로 브라우저(Three.js)에 브로드캐스트
  const payload = JSON.stringify({
    type: 'command',     // ← 이게 꼭 "command" 여야 함
    command: llmText     // ← 여기 들어간 문자열이 parseCommand(message)에 들어감
  });

  wss.clients.forEach(client => {
    if (client.readyState === WebSocket.OPEN) {
      client.send(payload);
    }
  });

  res.json({ ok: true });
});

// TTS 로그 받는 핸들러 (POST /suda/tts)
app.post('/suda/tts', (req, res) => {
  console.log('TTS 로그:', req.body);
  res.status(200).json({ ok: true });
});

// 서버 실행
const PORT = 3001;
server.listen(PORT, "0.0.0.0", () => {
  console.log(`Server running at http://0.0.0.0:${PORT}`);
});
