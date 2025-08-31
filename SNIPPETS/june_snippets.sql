-- June Snippets: Projects & Professional Development
INSERT INTO snippets (month, day, title, code, explanation, language_id, category_id) VALUES
(6, 1, 'Git Workflow', '#!/bin/bash
# Feature branch workflow
git checkout -b feature/new-feature
# Make changes
git add -A
git commit -m "feat: add new feature"

# Interactive rebase to clean history
git rebase -i main

# Push and create PR
git push -u origin feature/new-feature

# After review, squash merge
git checkout main
git merge --squash feature/new-feature
git commit -m "feat: implement complete feature"', 'Git workflow for teams. Feature branches isolate work. Interactive rebase cleans history. Squash merge keeps main clean. PR for code review.', 14, 7),
(6, 2, 'Docker Containerization', 'FROM node:16-alpine
WORKDIR /app

# Cache dependencies
COPY package*.json ./
RUN npm ci --only=production

# Copy app
COPY . .

# Non-root user
RUN addgroup -g 1001 -S nodejs
RUN adduser -S nodejs -u 1001
USER nodejs

EXPOSE 3000
CMD ["node", "server.js"]

# Build: docker build -t app .
# Run: docker run -p 3000:3000 app', 'Docker packages apps with dependencies. Multi-stage builds reduce size. Layer caching speeds builds. Non-root for security. Portable deployment.', 16, 7),
(6, 3, 'CI/CD Pipeline', 'name: Deploy
on:
  push:
    branches: [main]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - run: npm ci
      - run: npm test
      - run: npm run build
  
  deploy:
    needs: test
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - run: |
          echo "${{ secrets.DEPLOY_KEY }}" | ssh-add -
          ssh user@server "cd /app && git pull && npm install && pm2 restart app"', 'CI/CD automates deployment. Tests run on every push. Deploy only from main branch. Secrets store credentials. Zero-downtime deployment.', 13, 7),
(6, 4, 'Code Documentation', '/**
 * Calculates compound interest
 * @param {number} principal - Initial amount
 * @param {number} rate - Annual interest rate (decimal)
 * @param {number} time - Time period in years
 * @param {number} n - Compounding frequency per year
 * @returns {number} Final amount after compound interest
 * @example
 * // Returns 110.25 for 10% annual interest over 1 year
 * calculateCompoundInterest(100, 0.1, 1, 4)
 */
function calculateCompoundInterest(principal, rate, time, n) {
    return principal * Math.pow((1 + rate / n), n * time);
}', 'JSDoc documents JavaScript code. Describes parameters, returns, examples. IDEs show hints. Generate docs automatically. Improves maintainability.', 5, 7),
(6, 5, 'API Design REST', 'from flask import Flask, jsonify, request
from http import HTTPStatus

app = Flask(__name__)

# RESTful endpoints
@app.route(''/api/v1/users'', methods=[''GET''])
def get_users():
    return jsonify({''users'': users}), HTTPStatus.OK

@app.route(''/api/v1/users/<int:user_id>'', methods=[''GET''])
def get_user(user_id):
    user = find_user(user_id)
    if not user:
        return jsonify({''error'': ''Not found''}), HTTPStatus.NOT_FOUND
    return jsonify(user), HTTPStatus.OK

@app.route(''/api/v1/users'', methods=[''POST''])
def create_user():
    return jsonify(user), HTTPStatus.CREATED', 'RESTful API design. HTTP verbs for actions. Status codes communicate results. Versioning for compatibility. JSON for data exchange.', 1, 11),
(6, 6, 'Database Migrations', '-- migrations/001_create_users.sql
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- migrations/002_add_user_profile.sql
ALTER TABLE users ADD COLUMN name VARCHAR(100);
ALTER TABLE users ADD COLUMN avatar_url TEXT;

-- rollback/002_add_user_profile.sql
ALTER TABLE users DROP COLUMN name;
ALTER TABLE users DROP COLUMN avatar_url;

-- Track: INSERT INTO migrations (version, applied_at)', 'Database migrations version schema changes. Sequential numbered files. Forward and rollback scripts. Track applied migrations. Team synchronization.', 10, 3),
(6, 7, 'Logging Best Practices', 'import logging
import json
from datetime import datetime

class JSONFormatter(logging.Formatter):
    def format(self, record):
        log_obj = {
            ''timestamp'': datetime.utcnow().isoformat(),
            ''level'': record.levelname,
            ''message'': record.getMessage(),
            ''module'': record.module,
            ''function'': record.funcName,
            ''line'': record.lineno
        }
        if hasattr(record, ''user_id''):
            log_obj[''user_id''] = record.user_id
        return json.dumps(log_obj)

logger = logging.getLogger(__name__)
logger.info("User logged in", extra={''user_id'': 123})', 'Structured logging aids debugging. JSON format for parsing. Include context (user, request ID). Log levels: DEBUG, INFO, WARNING, ERROR. Centralized aggregation.', 1, 7),
(6, 8, 'Error Handling', 'class AppError extends Error {
    constructor(message, statusCode, isOperational = true) {
        super(message);
        this.statusCode = statusCode;
        this.isOperational = isOperational;
        Error.captureStackTrace(this, this.constructor);
    }
}

class ValidationError extends AppError {
    constructor(message) {
        super(message, 400);
    }
}

// Global error handler
app.use((err, req, res, next) => {
    logger.error(err);
    if (!err.isOperational) {
        process.exit(1);  // Unexpected errors
    }
    res.status(err.statusCode || 500).json({
        error: err.message
    });
});', 'Custom error classes improve handling. Operational vs programmer errors. Centralized error handling. Log all errors. Graceful degradation.', 5, 7),
(6, 9, 'Environment Configuration', '# .env.example
NODE_ENV=development
PORT=3000
DATABASE_URL=postgresql://user:pass@localhost/db
REDIS_URL=redis://localhost:6379
JWT_SECRET=change-this-secret
AWS_ACCESS_KEY_ID=your-key
AWS_SECRET_ACCESS_KEY=your-secret

# config.js
require(''dotenv'').config();

module.exports = {
    port: process.env.PORT || 3000,
    db: {
        url: process.env.DATABASE_URL,
        pool: { min: 2, max: 10 }
    },
    jwt: {
        secret: process.env.JWT_SECRET,
        expiresIn: ''1d''
    }
};', 'Environment variables configure apps. Never commit secrets. .env.example documents required vars. Different configs per environment. Validate on startup.', 5, 7),
(6, 10, 'Code Review Checklist', '# Code Review Checklist

## Functionality
- [ ] Code does what it should
- [ ] Edge cases handled
- [ ] Error handling present

## Code Quality
- [ ] Clear variable/function names
- [ ] No code duplication
- [ ] Follows style guide
- [ ] Complexity reasonable

## Testing
- [ ] Unit tests included
- [ ] Tests pass locally
- [ ] Coverage adequate

## Security
- [ ] Input validated
- [ ] No hardcoded secrets
- [ ] SQL injection prevented

## Performance
- [ ] No obvious bottlenecks
- [ ] Database queries optimized', 'Code reviews improve quality. Checklist ensures consistency. Look for bugs, style, security. Constructive feedback. Knowledge sharing opportunity.', 16, 7),
(6, 11, 'Microservices Communication', 'import grpc
import service_pb2
import service_pb2_grpc

# gRPC server
class UserService(service_pb2_grpc.UserServiceServicer):
    def GetUser(self, request, context):
        user = find_user(request.id)
        return service_pb2.User(
            id=user.id,
            name=user.name,
            email=user.email
        )

# gRPC client
channel = grpc.insecure_channel(''localhost:50051'')
stub = service_pb2_grpc.UserServiceStub(channel)
response = stub.GetUser(service_pb2.GetUserRequest(id=123))', 'Microservices need efficient communication. gRPC uses Protocol Buffers. Binary format, strongly typed. Faster than REST. Streaming support.', 1, 11),
(6, 12, 'Caching Strategy', 'import redis
import hashlib
import json

cache = redis.Redis()

def cached(expiration=3600):
    def decorator(func):
        def wrapper(*args, **kwargs):
            # Create cache key
            key = f"{func.__name__}:{hashlib.md5(
                json.dumps([args, kwargs]).encode()
            ).hexdigest()}"
            
            # Check cache
            result = cache.get(key)
            if result:
                return json.loads(result)
            
            # Compute and cache
            result = func(*args, **kwargs)
            cache.setex(key, expiration, json.dumps(result))
            return result
        return wrapper
    return decorator', 'Caching improves performance. Redis for distributed cache. Cache key from function and args. TTL prevents stale data. Invalidation strategy crucial.', 1, 10),
(6, 13, 'API Rate Limiting', 'class TokenBucket {
    constructor(capacity, refillRate) {
        this.capacity = capacity;
        this.tokens = capacity;
        this.refillRate = refillRate;
        this.lastRefill = Date.now();
    }
    
    consume(tokens = 1) {
        this.refill();
        if (this.tokens >= tokens) {
            this.tokens -= tokens;
            return true;
        }
        return false;
    }
    
    refill() {
        const now = Date.now();
        const timePassed = (now - this.lastRefill) / 1000;
        this.tokens = Math.min(
            this.capacity,
            this.tokens + timePassed * this.refillRate
        );
        this.lastRefill = now;
    }
}', 'Token bucket algorithm for rate limiting. Smooth traffic flow. Allows bursts within capacity. Refills at constant rate. Per-user buckets recommended.', 5, 11),
(6, 14, 'Database Connection Pool', 'const { Pool } = require(''pg'');

const pool = new Pool({
    host: process.env.DB_HOST,
    database: process.env.DB_NAME,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    max: 20,  // Maximum connections
    idleTimeoutMillis: 30000,
    connectionTimeoutMillis: 2000,
});

// Use pool
async function query(text, params) {
    const start = Date.now();
    const res = await pool.query(text, params);
    const duration = Date.now() - start;
    console.log(''Query took'', duration, ''ms'');
    return res;
}', 'Connection pools reuse database connections. Reduces overhead of creating connections. Configure pool size carefully. Monitor pool metrics. Essential for performance.', 5, 3),
(6, 15, 'Message Queue', 'import pika
import json

# Producer
connection = pika.BlockingConnection(
    pika.ConnectionParameters(''localhost''))
channel = connection.channel()
channel.queue_declare(queue=''tasks'', durable=True)

message = json.dumps({''action'': ''send_email'', ''to'': ''user@example.com''})
channel.basic_publish(
    exchange='''',
    routing_key=''tasks'',
    body=message,
    properties=pika.BasicProperties(delivery_mode=2)  # Persistent
)

# Consumer
def callback(ch, method, properties, body):
    task = json.loads(body)
    process_task(task)
    ch.basic_ack(delivery_tag=method.delivery_tag)

channel.basic_consume(queue=''tasks'', on_message_callback=callback)', 'Message queues decouple services. RabbitMQ, Redis, Kafka options. Async processing. Handles load spikes. Retry failed tasks. Scalable architecture.', 1, 11),
(6, 16, 'Monitoring & Metrics', 'const prometheus = require(''prom-client'');

// Metrics
const httpDuration = new prometheus.Histogram({
    name: ''http_request_duration_seconds'',
    help: ''Duration of HTTP requests in seconds'',
    labelNames: [''method'', ''route'', ''status'']
});

const activeConnections = new prometheus.Gauge({
    name: ''active_connections'',
    help: ''Number of active connections''
});

// Middleware
app.use((req, res, next) => {
    const end = httpDuration.startTimer();
    res.on(''finish'', () => {
        end({ method: req.method, route: req.path, status: res.statusCode });
    });
    next();
});

// Metrics endpoint
app.get(''/metrics'', (req, res) => {
    res.set(''Content-Type'', prometheus.register.contentType);
    res.end(prometheus.register.metrics());
});', 'Monitoring tracks system health. Prometheus collects metrics. Histograms for latency. Gauges for current values. Grafana visualizes. Alerts on thresholds.', 5, 7),
(6, 17, 'Feature Flags', 'class FeatureFlags {
    constructor() {
        this.flags = new Map();
    }
    
    set(feature, config) {
        this.flags.set(feature, config);
    }
    
    isEnabled(feature, user = null) {
        const config = this.flags.get(feature);
        if (!config) return false;
        
        if (config.enabled === false) return false;
        if (config.enabled === true) return true;
        
        // Percentage rollout
        if (config.percentage && user) {
            const hash = this.hash(feature + user.id);
            return (hash % 100) < config.percentage;
        }
        
        // User whitelist
        if (config.users && user) {
            return config.users.includes(user.id);
        }
        
        return false;
    }
}', 'Feature flags control functionality. Gradual rollouts. A/B testing. Quick rollback. Decouple deployment from release. Essential for continuous delivery.', 5, 7),
(6, 18, 'Semantic Versioning', '{
  "name": "my-package",
  "version": "2.1.3",
  // MAJOR.MINOR.PATCH
  // MAJOR: Breaking changes
  // MINOR: New features, backwards compatible
  // PATCH: Bug fixes
  
  "dependencies": {
    "express": "^4.17.1",  // Compatible with 4.x.x
    "lodash": "~4.17.0",   // Compatible with 4.17.x
    "uuid": "8.3.2"        // Exact version
  },
  
  "scripts": {
    "version": "npm run build && git add -A dist",
    "postversion": "git push && git push --tags"
  }
}

// npm version patch  # 2.1.3 -> 2.1.4
// npm version minor  # 2.1.3 -> 2.2.0
// npm version major  # 2.1.3 -> 3.0.0', 'Semantic versioning communicates changes. Major.Minor.Patch format. Caret (^) allows minor updates. Tilde (~) allows patches. Lock files ensure reproducibility.', 16, 7),
(6, 19, 'Database Indexing', 'CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_posts_user_created 
    ON posts(user_id, created_at DESC);
CREATE INDEX idx_products_search 
    ON products USING GIN(to_tsvector(''english'', name || '' '' || description));

-- Analyze query performance
EXPLAIN ANALYZE
SELECT * FROM posts
WHERE user_id = 123
ORDER BY created_at DESC
LIMIT 10;

-- Find missing indexes
SELECT schemaname, tablename, attname, n_distinct, correlation
FROM pg_stats
WHERE schemaname = ''public''
AND n_distinct > 100
AND correlation < 0.1
ORDER BY n_distinct DESC;', 'Indexes speed up queries. B-tree default, GIN for full-text. Composite indexes for multiple columns. EXPLAIN shows query plan. Balance read/write performance.', 10, 3),
(6, 20, 'Deployment Strategies', '# Blue-Green Deployment
# Two identical environments
# Switch traffic after testing

# Rolling Deployment
kubectl set image deployment/app app=app:v2
kubectl rollout status deployment/app

# Canary Deployment
apiVersion: v1
kind: Service
spec:
  selector:
    app: myapp
  # 90% to stable, 10% to canary
  sessionAffinity: ClientIP

# Feature Flags
if (featureFlag.isEnabled("new-algorithm")) {
    return newAlgorithm();
} else {
    return oldAlgorithm();
}', 'Deployment strategies minimize risk. Blue-green for instant rollback. Rolling for gradual update. Canary tests with real traffic. Feature flags for granular control.', 13, 7),
(6, 21, 'Performance Optimization', 'use std::collections::HashMap;
use rayon::prelude::*;

// Parallel processing
fn process_data(items: Vec<Item>) -> Vec<Result> {
    items.par_iter()
        .map(|item| expensive_computation(item))
        .collect()
}

// Memoization
struct Fibonacci {
    cache: HashMap<u64, u64>,
}

impl Fibonacci {
    fn calculate(&mut self, n: u64) -> u64 {
        if let Some(&result) = self.cache.get(&n) {
            return result;
        }
        let result = match n {
            0 | 1 => n,
            _ => self.calculate(n - 1) + self.calculate(n - 2),
        };
        self.cache.insert(n, result);
        result
    }
}', 'Optimization techniques: parallelization, memoization, caching. Profile first, optimize bottlenecks. Measure improvements. Premature optimization harmful.', 7, 10),
(6, 22, 'Security Audit', '#!/bin/bash
# Security audit script

echo "=== Security Audit ==="

# Check for exposed secrets
echo "Checking for secrets..."
git secrets --scan

# Dependency vulnerabilities
echo "Checking dependencies..."
npm audit
pip-audit

# OWASP dependency check
dependency-check --scan . --format HTML

# Static analysis
echo "Running static analysis..."
semgrep --config=auto .
bandit -r python_code/

# Container scanning
trivy image myapp:latest

# SSL/TLS check
nmap --script ssl-enum-ciphers -p 443 example.com', 'Security audits find vulnerabilities. Check dependencies, secrets, code patterns. Automated scanning tools. Regular audits essential. Fix critical issues first.', 14, 8),
(6, 23, 'GraphQL Schema', 'type Query {
  user(id: ID!): User
  users(limit: Int = 10, offset: Int = 0): [User!]!
}

type Mutation {
  createUser(input: CreateUserInput!): User!
  updateUser(id: ID!, input: UpdateUserInput!): User!
}

type User {
  id: ID!
  name: String!
  email: String!
  posts: [Post!]!
  createdAt: DateTime!
}

input CreateUserInput {
  name: String!
  email: String!
}

type Subscription {
  userUpdated(id: ID!): User!
}', 'GraphQL schema defines API. Strong typing. Query exactly needed data. Mutations modify. Subscriptions for real-time. Single endpoint. Client-driven.', 16, 11),
(6, 24, 'Kubernetes Deployment', 'apiVersion: apps/v1
kind: Deployment
metadata:
  name: app
spec:
  replicas: 3
  selector:
    matchLabels:
      app: myapp
  template:
    metadata:
      labels:
        app: myapp
    spec:
      containers:
      - name: app
        image: myapp:latest
        ports:
        - containerPort: 3000
        env:
        - name: DATABASE_URL
          valueFrom:
            secretKeyRef:
              name: db-secret
              key: url
        resources:
          limits:
            memory: "256Mi"
            cpu: "500m"
        livenessProbe:
          httpGet:
            path: /health
            port: 3000', 'Kubernetes orchestrates containers. Deployments manage pods. Auto-scaling, self-healing. Secrets for sensitive data. Resource limits prevent noisy neighbors.', 13, 7),
(6, 25, 'Technical Debt', '// TODO: Refactor this function - too complex
// FIXME: Handle edge case when array is empty
// HACK: Temporary workaround for API bug
// DEPRECATED: Use newFunction() instead

/**
 * @deprecated Since version 2.0. Will be removed in 3.0.
 * Use {@link newFunction} instead.
 */
function oldFunction() {
    console.warn("oldFunction is deprecated");
    return newFunction();
}

// Technical Debt Register:
// 1. Database queries need optimization (HIGH)
// 2. No input validation in API (CRITICAL)
// 3. Missing unit tests (MEDIUM)
// 4. Hardcoded configuration (LOW)', 'Technical debt accumulates over time. Document with TODOs, FIXMEs. Deprecation warnings for migrations. Regular refactoring sessions. Balance features with maintenance.', 5, 7),
(6, 26, 'Load Balancer Config', 'upstream backend {
    least_conn;
    server backend1.example.com:8080 weight=5;
    server backend2.example.com:8080 weight=3;
    server backend3.example.com:8080 backup;
    
    keepalive 32;
}

server {
    listen 80;
    server_name api.example.com;
    
    location / {
        proxy_pass http://backend;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        
        proxy_connect_timeout 60s;
        proxy_send_timeout 60s;
        proxy_read_timeout 60s;
    }
}', 'Load balancers distribute traffic. Least connections, round robin, IP hash algorithms. Health checks detect failures. Sticky sessions when needed.', 15, 11),
(6, 27, 'Project Structure', 'project/
├── src/
│   ├── controllers/    # Request handlers
│   ├── services/       # Business logic
│   ├── models/         # Data models
│   ├── repositories/   # Data access
│   ├── middleware/     # Express middleware
│   ├── utils/          # Helper functions
│   └── config/         # Configuration
├── tests/
│   ├── unit/
│   ├── integration/
│   └── e2e/
├── scripts/            # Build, deploy scripts
├── docs/               # Documentation
├── .env.example
├── docker-compose.yml
├── Dockerfile
└── README.md', 'Good project structure improves maintainability. Separation of concerns. Clear naming conventions. Consistent organization. Easy onboarding.', 16, 7),
(6, 28, 'Makefile Automation', 'SHELL := /bin/bash
.PHONY: help build test deploy

help: ## Show this help
\t@grep -E ''^[a-zA-Z_-]+:.*?## .*$$'' $(MAKEFILE_LIST) | \\
\t\tawk ''BEGIN {FS = ":.*?## "}; {printf "%-15s %s\
", $$1, $$2}''

build: ## Build the application
\tdocker build -t app:latest .

test: ## Run tests
\t@echo "Running tests..."
\tnpm test
\t@echo "Running linter..."
\tnpm run lint

deploy: build test ## Deploy to production
\t@echo "Deploying to production..."
\tkubectl apply -f k8s/
\tkubectl rollout status deployment/app

clean: ## Clean build artifacts
\trm -rf dist/ node_modules/', 'Makefiles automate tasks. Targets with dependencies. PHONY for non-file targets. Self-documenting with help. Standard interface across projects.', 16, 7),
(6, 29, 'Performance Profiling', 'import cProfile
import pstats
from memory_profiler import profile

# CPU profiling
def profile_function():
    profiler = cProfile.Profile()
    profiler.enable()
    
    # Code to profile
    result = expensive_function()
    
    profiler.disable()
    stats = pstats.Stats(profiler)
    stats.sort_stats(''cumulative'')
    stats.print_stats(10)  # Top 10 functions
    
    return result

# Memory profiling
@profile
def memory_intensive():
    large_list = [i for i in range(1000000)]
    large_dict = {i: i**2 for i in range(100000)}
    return len(large_list) + len(large_dict)

# Line profiler: kernprof -l -v script.py', 'Profiling identifies bottlenecks. CPU profiling shows time per function. Memory profiling tracks allocations. Line profiler for granular analysis.', 1, 10),
(6, 30, 'Summer Internship Tips', '# Epitech Summer Internship Success Guide

## Technical Preparation
- Master Git workflows
- Practice code reviews
- Learn Docker basics
- Understand CI/CD

## Soft Skills
- Ask questions early
- Document your work
- Communicate progress
- Take initiative

## First Day
git clone <repo>
docker-compose up
npm install
npm test

## Daily Routine
- Morning standup
- Code, test, commit
- Afternoon review
- Update tickets

Remember: Every expert was once a beginner!', 'Internship success tips for Epitech students. Technical and soft skills equally important. Be proactive, ask questions. Document everything. Network and learn!', 16, 7);