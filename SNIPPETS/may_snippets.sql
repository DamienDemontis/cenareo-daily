-- May Snippets: Network Programming & Security
INSERT INTO snippets (month, day, title, code, explanation, language_id, category_id) VALUES
(5, 1, 'TCP Socket Server', '#include <sys/socket.h>
#include <netinet/in.h>
int main() {
    int server_fd = socket(AF_INET, SOCK_STREAM, 0);
    struct sockaddr_in addr = {0};
    addr.sin_family = AF_INET;
    addr.sin_port = htons(8080);
    addr.sin_addr.s_addr = INADDR_ANY;
    bind(server_fd, (struct sockaddr*)&addr, sizeof(addr));
    listen(server_fd, 3);
    int client = accept(server_fd, NULL, NULL);
    send(client, "Hello\
", 6, 0);
}', 'TCP server basics: socket creates endpoint, bind assigns address, listen enables connections, accept waits for client. Foundation of network services.', 2, 11),
(5, 2, 'UDP Socket Communication', '#include <sys/socket.h>
int main() {
    int sock = socket(AF_INET, SOCK_DGRAM, 0);
    struct sockaddr_in addr = {0};
    addr.sin_family = AF_INET;
    addr.sin_port = htons(8080);
    inet_pton(AF_INET, "127.0.0.1", &addr.sin_addr);
    
    char* msg = "UDP message";
    sendto(sock, msg, strlen(msg), 0,
           (struct sockaddr*)&addr, sizeof(addr));
    
    char buffer[1024];
    recvfrom(sock, buffer, 1024, 0, NULL, NULL);
}', 'UDP is connectionless protocol. No handshake, lower overhead. sendto/recvfrom for datagrams. Fast but unreliable. Good for streaming, games.', 2, 11),
(5, 3, 'HTTP Client Request', 'import requests
import json

# GET request
response = requests.get("https://api.github.com/users/torvalds")
data = response.json()

# POST with headers
headers = {"Authorization": "Bearer token",
           "Content-Type": "application/json"}
payload = {"name": "test", "value": 42}
response = requests.post("https://api.example.com/data",
                        json=payload, headers=headers)

# Session for cookies
session = requests.Session()
session.post("/login", data={"user": "admin"})', 'HTTP client using requests library. GET fetches, POST sends data. Headers for auth, content type. Sessions maintain cookies.', 1, 11),
(5, 4, 'Buffer Overflow Protection', '#include <string.h>
void vulnerable(char* input) {
    char buffer[64];
    strcpy(buffer, input);  // BAD: No bounds check
}

void safe(char* input) {
    char buffer[64];
    strncpy(buffer, input, sizeof(buffer)-1);
    buffer[sizeof(buffer)-1] = ''\\0'';
    // Or use strlcpy, snprintf
}

// Compile with: gcc -fstack-protector -D_FORTIFY_SOURCE=2
// Enable ASLR, DEP/NX bit', 'Buffer overflows exploit memory corruption. Use bounded functions. Stack canaries detect overflows. ASLR randomizes addresses. Never trust input size.', 2, 8),
(5, 5, 'Password Hashing', 'import bcrypt
import secrets

def hash_password(password):
    # Generate salt and hash
    salt = bcrypt.gensalt(rounds=12)
    hashed = bcrypt.hashpw(password.encode(''utf-8''), salt)
    return hashed

def verify_password(password, hashed):
    return bcrypt.checkpw(password.encode(''utf-8''), hashed)

# Generate secure tokens
token = secrets.token_urlsafe(32)
api_key = secrets.token_hex(16)', 'Never store plain passwords. bcrypt adds salt, slow by design. Prevents rainbow tables, brute force. secrets for cryptographic randomness.', 1, 8),
(5, 6, 'SQL Injection Prevention', '# VULNERABLE - Never do this!
sql = f"SELECT * FROM users WHERE name = ''{name}''";

# SAFE - Parameterized queries
cursor.execute(
    "SELECT * FROM users WHERE name = ? AND age > ?",
    (name, age)
)

# SAFE - Prepared statements
stmt = connection.prepare(
    "INSERT INTO logs (user, action) VALUES ($1, $2)"
)
stmt.execute(user_id, action)

# Validate/escape input
name = re.sub(r''[^a-zA-Z0-9]'', '''', name)', 'SQL injection exploits string concatenation. Use parameterized queries. Prepared statements separate data from code. Never trust user input.', 1, 8),
(5, 7, 'HTTPS/TLS Setup', '#include <openssl/ssl.h>
SSL_CTX* create_context() {
    SSL_library_init();
    SSL_CTX* ctx = SSL_CTX_new(TLS_server_method());
    
    // Load certificate and private key
    SSL_CTX_use_certificate_file(ctx, "cert.pem", SSL_FILETYPE_PEM);
    SSL_CTX_use_PrivateKey_file(ctx, "key.pem", SSL_FILETYPE_PEM);
    
    // Set cipher suites
    SSL_CTX_set_cipher_list(ctx,
        "ECDHE-RSA-AES256-GCM-SHA384:ECDHE-RSA-AES128-GCM-SHA256");
    
    return ctx;
}', 'TLS encrypts network traffic. OpenSSL provides implementation. Certificates verify identity. Modern ciphers prevent attacks. HTTPS essential for web.', 2, 8),
(5, 8, 'WebSocket Protocol', 'import asyncio
import websockets

async def echo(websocket, path):
    async for message in websocket:
        await websocket.send(f"Echo: {message}")

async def main():
    async with websockets.serve(echo, "localhost", 8765):
        await asyncio.Future()  # Run forever

# Client
async def client():
    async with websockets.connect("ws://localhost:8765") as ws:
        await ws.send("Hello")
        response = await ws.recv()', 'WebSockets provide full-duplex communication. Persistent connection over HTTP. Real-time bidirectional data. Used in chat, live updates.', 1, 11),
(5, 9, 'Cross-Site Scripting (XSS)', '// VULNERABLE
document.getElementById("output").innerHTML = userInput;

// SAFE - Escape HTML
function escapeHtml(text) {
    const map = {
        ''&'': ''&amp;'', ''<'': ''&lt;'', ''>'': ''&gt;'',
        ''"'': ''&quot;'', "''": ''&#039;''
    };
    return text.replace(/[&<>"'']/g, m => map[m]);
}
element.textContent = userInput;  // Safe
element.innerHTML = escapeHtml(userInput);

// Content Security Policy
// <meta http-equiv="Content-Security-Policy"
//       content="default-src ''self'';">', 'XSS injects malicious scripts. Escape user content. Use textContent not innerHTML. CSP headers prevent inline scripts. Validate all input.', 5, 8),
(5, 10, 'JWT Authentication', 'const jwt = require(''jsonwebtoken'');

// Generate token
function generateToken(user) {
    return jwt.sign(
        { id: user.id, email: user.email },
        process.env.JWT_SECRET,
        { expiresIn: ''1h'', algorithm: ''HS256'' }
    );
}

// Verify token
function verifyToken(token) {
    try {
        return jwt.verify(token, process.env.JWT_SECRET);
    } catch (error) {
        throw new Error(''Invalid token'');
    }
}', 'JWT enables stateless authentication. Header.Payload.Signature structure. Sign with secret key. Include expiration. Never store sensitive data.', 5, 8),
(5, 11, 'Port Scanning', '#include <sys/socket.h>
#include <netinet/in.h>
#include <fcntl.h>
int scan_port(const char* host, int port) {
    int sock = socket(AF_INET, SOCK_STREAM, 0);
    fcntl(sock, F_SETFL, O_NONBLOCK);
    
    struct sockaddr_in addr;
    addr.sin_family = AF_INET;
    addr.sin_port = htons(port);
    inet_pton(AF_INET, host, &addr.sin_addr);
    
    int result = connect(sock, (struct sockaddr*)&addr, sizeof(addr));
    close(sock);
    return (result == 0) ? 1 : 0;
}', 'Port scanning checks open services. Non-blocking sockets for speed. Used for security audits. Respect rate limits, get permission.', 2, 11),
(5, 12, 'CORS Configuration', 'const cors = require(''cors'');

// Allow specific origins
const corsOptions = {
    origin: [''https://trusted-site.com''],
    credentials: true,
    methods: [''GET'', ''POST''],
    allowedHeaders: [''Content-Type'', ''Authorization''],
    maxAge: 86400  // Cache preflight
};

app.use(cors(corsOptions));

// Manual headers
res.setHeader(''Access-Control-Allow-Origin'', ''*'');
res.setHeader(''Access-Control-Allow-Methods'', ''GET, POST'');', 'CORS controls cross-origin requests. Prevents unauthorized API access. Whitelist trusted origins. Credentials require specific origin. Security boundary.', 5, 8),
(5, 13, 'Rate Limiting', 'from functools import wraps
import time

class RateLimiter:
    def __init__(self, max_calls, period):
        self.max_calls = max_calls
        self.period = period
        self.calls = {}
    
    def __call__(self, func):
        @wraps(func)
        def wrapper(request, *args):
            now = time.time()
            key = request.remote_addr
            
            if key not in self.calls:
                self.calls[key] = []
            
            # Remove old calls
            self.calls[key] = [t for t in self.calls[key] if now - t < self.period]
            
            if len(self.calls[key]) >= self.max_calls:
                return "Rate limit exceeded", 429
            
            self.calls[key].append(now)
            return func(request, *args)', 'Rate limiting prevents abuse. Track requests per IP/user. Sliding window algorithm. Return 429 when exceeded. Essential protection.', 1, 8),
(5, 14, 'Encryption AES', '#include <openssl/aes.h>
void encrypt_AES(unsigned char* plaintext, unsigned char* key,
                 unsigned char* ciphertext) {
    AES_KEY aes_key;
    AES_set_encrypt_key(key, 128, &aes_key);
    
    unsigned char iv[AES_BLOCK_SIZE];
    RAND_bytes(iv, AES_BLOCK_SIZE);  // Random IV
    
    // CBC mode encryption
    AES_cbc_encrypt(plaintext, ciphertext,
                    strlen((char*)plaintext),
                    &aes_key, iv, AES_ENCRYPT);
}
// Use authenticated encryption (AES-GCM) in production', 'AES symmetric encryption. 128/256-bit keys. CBC mode with random IV. Never reuse IV. Use authenticated encryption (AEAD) when possible.', 2, 8),
(5, 15, 'OAuth2 Flow', 'import requests

# Authorization Code Flow
def get_auth_url(client_id, redirect_uri):
    return (
        f"https://oauth.provider.com/authorize?"
        f"client_id={client_id}&"
        f"redirect_uri={redirect_uri}&"
        f"response_type=code&"
        f"scope=read:user"
    )

def exchange_code(code, client_id, client_secret):
    response = requests.post(
        "https://oauth.provider.com/token",
        data={
            "grant_type": "authorization_code",
            "code": code,
            "client_id": client_id,
            "client_secret": client_secret
        }
    )
    return response.json()["access_token"]', 'OAuth2 delegates authentication. Authorization code flow most secure. Exchange code for token. Never expose client secret. Use PKCE for public clients.', 1, 8),
(5, 16, 'DNS Resolution', '#include <netdb.h>
#include <arpa/inet.h>
void resolve_hostname(const char* hostname) {
    struct hostent* host = gethostbyname(hostname);
    if (host) {
        printf("Official name: %s\\n", host->h_name);
        for (int i = 0; host->h_addr_list[i]; i++) {
            struct in_addr addr;
            addr.s_addr = *((unsigned long*)host->h_addr_list[i]);
            printf("IP: %s\\n", inet_ntoa(addr));
        }
    }
    // Modern: use getaddrinfo() for IPv6 support
}', 'DNS resolves hostnames to IPs. gethostbyname legacy, getaddrinfo modern. Supports multiple IPs. Cache results. Handle failures gracefully.', 2, 11),
(5, 17, 'Firewall Rules', '#!/bin/bash
# iptables firewall configuration

# Default policies
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# Allow established connections
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Allow localhost
iptables -A INPUT -i lo -j ACCEPT

# Allow SSH from specific IP
iptables -A INPUT -p tcp --dport 22 -s 192.168.1.100 -j ACCEPT

# Allow HTTP/HTTPS
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT', 'Firewall controls network traffic. Default deny, whitelist allowed. Stateful tracking. Rate limiting possible. Essential security layer.', 14, 8),
(5, 18, 'Content Security Policy', 'const helmet = require(''helmet'');

app.use(helmet.contentSecurityPolicy({
    directives: {
        defaultSrc: ["''self''"],
        scriptSrc: ["''self''", "''unsafe-inline''", "cdn.trusted.com"],
        styleSrc: ["''self''", "''unsafe-inline''"],
        imgSrc: ["''self''", "data:", "https:"],
        connectSrc: ["''self''", "api.example.com"],
        fontSrc: ["''self''", "fonts.googleapis.com"],
        objectSrc: ["''none''"],
        upgradeInsecureRequests: [],
    },
    reportOnly: false
}));', 'CSP prevents XSS attacks. Whitelist content sources. Block inline scripts. Report violations. Start report-only, then enforce. Modern security standard.', 5, 8),
(5, 19, 'SSH Key Authentication', '#!/bin/bash
# Generate SSH key pair
ssh-keygen -t ed25519 -C "email@example.com"

# Copy public key to server
ssh-copy-id user@server

# SSH config (~/.ssh/config)
Host myserver
    HostName 192.168.1.10
    User admin
    Port 2222
    IdentityFile ~/.ssh/id_ed25519
    ForwardAgent yes

# Disable password auth (server)
# /etc/ssh/sshd_config:
# PasswordAuthentication no
# PubkeyAuthentication yes', 'SSH keys more secure than passwords. Ed25519 modern algorithm. Agent forwarding for chaining. Config simplifies connections. Disable password auth.', 14, 8),
(5, 20, 'Load Balancing', 'http {
    upstream backend {
        least_conn;  # or ip_hash, random
        server backend1.example.com:8080 weight=3;
        server backend2.example.com:8080 weight=1;
        server backend3.example.com:8080 backup;
        
        keepalive 32;  # Connection pooling
    }
    
    server {
        listen 80;
        location / {
            proxy_pass http://backend;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
        }
    }
}', 'Load balancers distribute traffic. Round-robin, least connections, IP hash. Health checks detect failures. Sticky sessions when needed. Scales horizontally.', 15, 11),
(5, 21, 'Certificate Pinning', 'import ssl
import hashlib

def verify_cert_pin(cert_der, expected_pin):
    # Calculate SHA256 of certificate
    cert_hash = hashlib.sha256(cert_der).digest()
    pin = base64.b64encode(cert_hash).decode()
    
    if pin != expected_pin:
        raise ssl.SSLError("Certificate pin mismatch")

# Android (Network Security Config)
# <pin-set expiration="2025-01-01">
#   <pin digest="SHA-256">base64hash==</pin>
# </pin-set>

# iOS (Info.plist)
# NSPinnedDomains -> domain -> NSPinnedCAIdentities', 'Certificate pinning prevents MITM attacks. Hardcode expected certificate hash. Update before expiration. Backup pins recommended. Mobile apps critical.', 1, 8),
(5, 22, 'GraphQL Security', 'const depthLimit = require(''graphql-depth-limit'');
const costAnalysis = require(''graphql-cost-analysis'');

const server = new GraphQLServer({
    validationRules: [
        depthLimit(5),  // Max query depth
        costAnalysis({
            maximumCost: 1000,
            defaultCost: 1,
            variables: {},
            createError: (max, actual) => {
                return new Error(`Query cost ${actual} exceeds ${max}`);
            }
        })
    ],
    // Disable introspection in production
    introspection: process.env.NODE_ENV !== ''production''
});', 'GraphQL needs special security. Limit query depth, complexity. Calculate query cost. Disable introspection. Rate limit by complexity. Prevent DoS.', 5, 8),
(5, 23, 'Zero Trust Network', 'class ZeroTrustGateway:
    def authenticate(self, request):
        # Verify device identity
        device_cert = request.client_cert
        if not self.verify_device(device_cert):
            return False
        
        # Verify user identity
        token = request.headers.get(''Authorization'')
        user = self.verify_token(token)
        if not user:
            return False
        
        # Check authorization for resource
        if not self.authorize(user, request.path):
            return False
        
        # Log access for audit
        self.audit_log(user, request)
        return True

# Never trust, always verify', 'Zero trust assumes breach. Verify every request. Device and user authentication. Least privilege access. Continuous verification. Modern security model.', 1, 8),
(5, 24, 'API Gateway', 'const express = require(''express'');
const httpProxy = require(''http-proxy-middleware'');

const app = express();

// Rate limiting
app.use(rateLimit({ windowMs: 60000, max: 100 }));

// Authentication
app.use(authenticateToken);

// Route to microservices
app.use(''/users'', httpProxy({
    target: ''http://user-service:3001'',
    changeOrigin: true
}));

app.use(''/orders'', httpProxy({
    target: ''http://order-service:3002'',
    changeOrigin: true,
    pathRewrite: { ''^/orders'': ''/api/v1/orders'' }
}));', 'API gateway centralizes access. Authentication, rate limiting, routing. Simplifies clients. Circuit breaking, caching possible. Microservices pattern.', 5, 11),
(5, 25, 'Network Packet Capture', '#include <pcap.h>
void packet_handler(u_char* user, const struct pcap_pkthdr* h,
                   const u_char* packet) {
    struct ether_header* eth = (struct ether_header*)packet;
    if (ntohs(eth->ether_type) == ETHERTYPE_IP) {
        struct ip* ip_hdr = (struct ip*)(packet + sizeof(*eth));
        printf("IP: %s -> ", inet_ntoa(ip_hdr->ip_src));
        printf("%s\\n", inet_ntoa(ip_hdr->ip_dst));
    }
}
int main() {
    pcap_t* handle = pcap_open_live("eth0", BUFSIZ, 1, 1000, NULL);
    pcap_loop(handle, -1, packet_handler, NULL);
}', 'Packet capture analyzes network traffic. libpcap foundation of tcpdump, Wireshark. Parse protocol headers. Requires root/admin. Debugging, security analysis.', 2, 11),
(5, 26, 'Secure Random', '#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>

void secure_random(void* buffer, size_t size) {
    int fd = open("/dev/urandom", O_RDONLY);
    if (fd < 0) {
        perror("Cannot open /dev/urandom");
        exit(1);
    }
    if (read(fd, buffer, size) != size) {
        fprintf(stderr, "Failed to read random bytes\\n");
        exit(1);
    }
    close(fd);
}
// Windows: use CryptGenRandom
// Modern C++: std::random_device', 'Cryptographic randomness essential for security. /dev/urandom on Unix. Never use rand() for security. Seeds, tokens, nonces, IVs.', 2, 8),
(5, 27, 'MQTT Protocol', 'import paho.mqtt.client as mqtt

def on_connect(client, userdata, flags, rc):
    print(f"Connected with result code {rc}")
    client.subscribe("sensors/temperature")

def on_message(client, userdata, msg):
    print(f"{msg.topic}: {msg.payload.decode()}")

client = mqtt.Client()
client.on_connect = on_connect
client.on_message = on_message

client.tls_set()  # Enable TLS
client.username_pw_set("user", "pass")
client.connect("mqtt.broker.com", 8883)

client.publish("sensors/humidity", "45%", qos=1)
client.loop_forever()', 'MQTT lightweight pub/sub protocol. QoS levels: 0 (at most once), 1 (at least once), 2 (exactly once). IoT standard. Broker manages messages.', 1, 11),
(5, 28, 'Secure Headers', 'app.use((req, res, next) => {
    // Security headers
    res.setHeader(''X-Frame-Options'', ''DENY'');
    res.setHeader(''X-Content-Type-Options'', ''nosniff'');
    res.setHeader(''X-XSS-Protection'', ''1; mode=block'');
    res.setHeader(''Strict-Transport-Security'',
                  ''max-age=31536000; includeSubDomains'');
    res.setHeader(''Referrer-Policy'', ''strict-origin-when-cross-origin'');
    res.setHeader(''Permissions-Policy'',
                  ''geolocation=(), microphone=(), camera=()'');
    
    // Remove sensitive headers
    res.removeHeader(''X-Powered-By'');
    next();
});', 'Security headers prevent attacks. X-Frame stops clickjacking. HSTS forces HTTPS. CSP prevents XSS. Hide server info. Defense in depth.', 5, 8),
(5, 29, 'VPN Tunneling', '#!/bin/bash
# OpenVPN client configuration
cat > client.ovpn << EOF
client
dev tun
proto udp
remote vpn.server.com 1194
resolv-retry infinite
nobind
persist-key
persist-tun
ca ca.crt
cert client.crt
key client.key
cipher AES-256-GCM
auth SHA256
comp-lzo
verb 3
EOF

# Connect
sudo openvpn --config client.ovpn

# WireGuard (modern alternative)
wg-quick up wg0', 'VPN creates secure tunnel. Encrypts all traffic. Hides real IP. OpenVPN widely supported. WireGuard faster, simpler. Corporate/privacy use.', 14, 11),
(5, 30, 'Input Validation', 'import re
from typing import Optional

class Validator:
    @staticmethod
    def email(email: str) -> bool:
        pattern = r''^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$''
        return bool(re.match(pattern, email))
    
    @staticmethod
    def sanitize_html(text: str) -> str:
        # Remove all HTML tags
        return re.sub(r''<[^>]+>'', '''', text)
    
    @staticmethod
    def validate_input(data: dict, rules: dict) -> tuple:
        errors = {}
        for field, rule in rules.items():
            if field not in data:
                errors[field] = "Required"
            elif not rule(data[field]):
                errors[field] = "Invalid"
        return len(errors) == 0, errors', 'Input validation prevents injection attacks. Whitelist acceptable input. Sanitize user data. Regular expressions for patterns. Never trust user input.', 1, 8),
(5, 31, 'Network Monitoring', 'import psutil
import socket

def monitor_connections():
    connections = psutil.net_connections()
    for conn in connections:
        if conn.status == ''ESTABLISHED'':
            try:
                remote_ip = conn.raddr.ip
                remote_port = conn.raddr.port
                local_port = conn.laddr.port
                pid = conn.pid
                process = psutil.Process(pid).name()
                
                print(f"{process}({pid}): "
                      f"{local_port} -> {remote_ip}:{remote_port}")
            except:
                pass

# Network statistics
stats = psutil.net_io_counters()
print(f"Bytes sent: {stats.bytes_sent:,}")
print(f"Bytes recv: {stats.bytes_recv:,}")', 'Monitor network connections and traffic. Detect suspicious activity. Track bandwidth usage. Identify processes. Security and performance analysis.', 1, 11);