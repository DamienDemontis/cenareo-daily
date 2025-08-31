-- July Snippets: Summer Projects & Internships (Complete Month 1-31)
INSERT INTO snippets (month, day, title, code, explanation, language_id, category_id) VALUES
(7, 1, 'Summer Project Planning', '#!/bin/bash
# Project setup script
echo "🌞 Summer 2024 Project Setup"

# Create project structure
mkdir -p project/{src,tests,docs,scripts}
cd project

# Initialize git
git init
echo "node_modules/
*.log
.env" > .gitignore

# Setup package.json
cat > package.json << EOF
{
  "name": "summer-project",
  "version": "1.0.0",
  "scripts": {
    "start": "node src/index.js",
    "test": "jest",
    "dev": "nodemon src/index.js"
  }
}
EOF', 'Summer project initialization. Create organized structure. Git setup with .gitignore. Package.json with useful scripts. Good planning saves time!', 14, 7),
(7, 2, 'Internship Code Review', '# Code Review Checklist for Interns

## Functionality
- [ ] Code does what it should
- [ ] Edge cases handled properly
- [ ] Error conditions managed
- [ ] Performance considerations

## Code Quality
- [ ] Clear, descriptive names
- [ ] Functions do one thing well
- [ ] No code duplication
- [ ] Proper commenting
- [ ] Follows team style guide

## Testing
- [ ] Unit tests included
- [ ] Tests actually test the feature
- [ ] Good test coverage

## Security
- [ ] Input validation present
- [ ] No hardcoded secrets
- [ ] SQL injection prevented', 'Code review skills essential for internships. Systematic approach catches issues. Focus on functionality, quality, testing. Constructive feedback helps team growth.', 16, 7),
(7, 3, 'Python Web Scraping', 'import requests
from bs4 import BeautifulSoup
import time
import csv

def scrape_jobs(url):
    headers = {
        ''User-Agent'': ''Mozilla/5.0 (compatible; JobBot/1.0)''
    }
    
    response = requests.get(url, headers=headers)
    soup = BeautifulSoup(response.content, ''html.parser'')
    
    jobs = []
    for job_card in soup.find_all(''div'', class_=''job-listing''):
        title = job_card.find(''h3'').text.strip()
        company = job_card.find(''span'', class_=''company'').text.strip()
        location = job_card.find(''span'', class_=''location'').text.strip()
        
        jobs.append({''title'': title, ''company'': company, ''location'': location})
        
    return jobs

# Respect rate limits
time.sleep(1)', 'Web scraping for job hunting. BeautifulSoup parses HTML. Set user agent to identify bot. Extract structured data. Always respect robots.txt!', 1, 11),
(7, 4, 'Git Collaboration', '# Team collaboration workflow

# 1. Clone repository
git clone https://github.com/company/project.git
cd project

# 2. Create feature branch
git checkout -b feature/user-authentication

# 3. Make changes and commit
git add .
git commit -m "feat: add user login system"

# 4. Push branch
git push -u origin feature/user-authentication

# 5. Create pull request (GitHub/GitLab)
# 6. Code review process
# 7. Merge after approval

# 8. Update main branch
git checkout main
git pull origin main
git branch -d feature/user-authentication', 'Git collaboration for teams. Feature branches isolate work. Pull requests enable code review. Keep main branch stable. Clean up merged branches.', 14, 7),
(7, 5, 'REST API Documentation', '/**
 * @api {post} /users Create User
 * @apiName CreateUser
 * @apiGroup Users
 * @apiVersion 1.0.0
 * 
 * @apiParam {String} email User email address
 * @apiParam {String} password User password (min 8 chars)
 * @apiParam {String} name Full name
 * 
 * @apiSuccess {Number} id User ID
 * @apiSuccess {String} email User email
 * @apiSuccess {String} name User name
 * @apiSuccess {String} token JWT token
 * 
 * @apiError {String} error Error message
 * 
 * @apiExample {curl} Example usage:
 * curl -X POST http://api.example.com/users \\
 *   -H "Content-Type: application/json" \\
 *   -d ''{"email":"user@example.com","password":"secret123","name":"John Doe"}''
 */', 'API documentation essential for teams. Specify endpoints, parameters, responses. Include examples. Tools: Swagger, Postman, apiDoc. Good docs save time.', 16, 11),
(7, 6, 'Database Design Patterns', '-- User management with roles
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
);

CREATE TABLE roles (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE user_roles (
    user_id INTEGER REFERENCES users(id),
    role_id INTEGER REFERENCES roles(id),
    PRIMARY KEY (user_id, role_id)
);

-- Audit trail
CREATE TABLE audit_log (
    id SERIAL PRIMARY KEY,
    table_name VARCHAR(50) NOT NULL,
    record_id INTEGER NOT NULL,
    action VARCHAR(10) NOT NULL,
    old_values JSONB,
    new_values JSONB,
    user_id INTEGER REFERENCES users(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);', 'Database design patterns for applications. Many-to-many relationships with junction tables. Audit trails track changes. Timestamps for data history.', 10, 3),
(7, 7, 'JavaScript Module Patterns', '// ES6 Modules
// utils.js
export const formatDate = (date) => {
    return date.toISOString().split(''T'')[0];
};

export const validateEmail = (email) => {
    const regex = /^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$/;
    return regex.test(email);
};

export default class ApiClient {
    constructor(baseURL) {
        this.baseURL = baseURL;
    }
    
    async get(endpoint) {
        const response = await fetch(`${this.baseURL}${endpoint}`);
        return response.json();
    }
}

// main.js
import ApiClient, { formatDate, validateEmail } from ''./utils.js'';

const api = new ApiClient(''https://api.example.com'');
const today = formatDate(new Date());', 'ES6 modules organize code. Named exports for utilities. Default export for main class. Import what you need. Better than global variables.', 5, 9),
(7, 8, 'C Memory Pool', '#include <stdlib.h>
#include <stdio.h>

typedef struct {
    void* memory;
    size_t size;
    size_t used;
    size_t block_size;
} MemoryPool;

MemoryPool* pool_create(size_t size, size_t block_size) {
    MemoryPool* pool = malloc(sizeof(MemoryPool));
    pool->memory = malloc(size);
    pool->size = size;
    pool->used = 0;
    pool->block_size = block_size;
    return pool;
}

void* pool_alloc(MemoryPool* pool) {
    if (pool->used + pool->block_size > pool->size) return NULL;
    void* ptr = (char*)pool->memory + pool->used;
    pool->used += pool->block_size;
    return ptr;
}

void pool_reset(MemoryPool* pool) {
    pool->used = 0;
}', 'Memory pools for performance. Pre-allocate large block. Fast allocation, bulk deallocation. No fragmentation. Great for games, embedded systems.', 2, 5),
(7, 9, 'Python Data Analysis', 'import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

# Load and explore data
df = pd.read_csv(''sales_data.csv'')
print(f"Dataset shape: {df.shape}")
print(df.describe())
print(df.isnull().sum())

# Data cleaning
df[''date''] = pd.to_datetime(df[''date''])
df[''revenue''] = df[''quantity''] * df[''price'']

# Group by analysis
monthly_sales = df.groupby(df[''date''].dt.month)[''revenue''].sum()

# Visualization
plt.figure(figsize=(10, 6))
monthly_sales.plot(kind=''bar'')
plt.title(''Monthly Sales Revenue'')
plt.xlabel(''Month'')
plt.ylabel(''Revenue ($)'')
plt.show()

# Export results
df.to_csv(''cleaned_data.csv'', index=False)', 'Data analysis with pandas. Load, clean, analyze data. Groupby for aggregations. Matplotlib for visualization. Essential internship skills.', 1, 4),
(7, 10, 'Docker Compose Setup', 'version: ''3.8''

services:
  web:
    build: .
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=development
      - DATABASE_URL=postgres://user:pass@db:5432/myapp
    volumes:
      - .:/app
      - /app/node_modules
    depends_on:
      - db
      - redis
    
  db:
    image: postgres:13
    environment:
      POSTGRES_DB: myapp
      POSTGRES_USER: user
      POSTGRES_PASSWORD: pass
    volumes:
      - postgres_data:/var/lib/postgresql/data
    ports:
      - "5432:5432"
      
  redis:
    image: redis:alpine
    ports:
      - "6379:6379"

volumes:
  postgres_data:', 'Docker Compose manages multi-container apps. Define services, networks, volumes. Environment variables for config. Perfect for development environments.', 16, 7),
(7, 11, 'TypeScript Interfaces', 'interface User {
    id: number;
    email: string;
    name: string;
    isActive: boolean;
    createdAt: Date;
    profile?: UserProfile; // Optional property
}

interface UserProfile {
    bio: string;
    avatar: string;
    socialLinks: SocialLinks;
}

interface SocialLinks {
    github?: string;
    linkedin?: string;
    twitter?: string;
}

// Function with interface parameter
function createUser(userData: Omit<User, ''id'' | ''createdAt''>): User {
    return {
        id: Math.random(),
        createdAt: new Date(),
        ...userData
    };
}

// Generic interface
interface ApiResponse<T> {
    data: T;
    success: boolean;
    message?: string;
}', 'TypeScript interfaces define contracts. Optional properties with ?. Utility types like Omit. Generics for reusability. Better than plain JavaScript.', 12, 9),
(7, 12, 'Linux System Administration', '#!/bin/bash
# System monitoring script

echo "=== System Status Report ==="
echo "Date: $(date)"
echo

# Disk usage
echo "Disk Usage:"
df -h | grep -E ''^/dev/'' | awk ''{ print $5 " " $1 }'' | while read output;
do
  usage=$(echo $output | awk ''{ print $1}'' | cut -d''%'' -f1 )
  if [ $usage -ge 90 ]; then
    echo "WARNING: $output"
  else
    echo "OK: $output"
  fi
done

# Memory usage
echo -e "\
Memory Usage:"
free -h

# CPU load
echo -e "\
CPU Load:"
uptime

# Top processes
echo -e "\
Top Processes:"
ps aux --sort=-%cpu | head -6', 'System administration basics. Monitor disk, memory, CPU usage. Shell scripting for automation. Essential for DevOps roles. Regular monitoring prevents issues.', 14, 6),
(7, 13, 'React Component Patterns', 'import React, { useState, useEffect, useCallback } from ''react'';

// Custom hook
function useLocalStorage(key, initialValue) {
    const [value, setValue] = useState(() => {
        const item = window.localStorage.getItem(key);
        return item ? JSON.parse(item) : initialValue;
    });
    
    useEffect(() => {
        window.localStorage.setItem(key, JSON.stringify(value));
    }, [key, value]);
    
    return [value, setValue];
}

// Component with custom hook
function UserPreferences() {
    const [theme, setTheme] = useLocalStorage(''theme'', ''light'');
    const [language, setLanguage] = useLocalStorage(''language'', ''en'');
    
    const handleThemeChange = useCallback((newTheme) => {
        setTheme(newTheme);
    }, [setTheme]);
    
    return (
        <div className={`theme-${theme}`}>
            <select value={theme} onChange={e => handleThemeChange(e.target.value)}>
                <option value="light">Light</option>
                <option value="dark">Dark</option>
            </select>
        </div>
    );
}', 'React patterns for reusable components. Custom hooks encapsulate logic. useCallback prevents unnecessary renders. Local storage integration.', 5, 9),
(7, 14, 'SQL Performance Tuning', '-- Identify slow queries
SELECT query, calls, total_time, mean_time, rows
FROM pg_stat_statements
ORDER BY total_time DESC
LIMIT 10;

-- Add indexes for common queries
CREATE INDEX CONCURRENTLY idx_orders_user_date 
ON orders(user_id, created_at) 
WHERE status = ''active'';

-- Analyze query plans
EXPLAIN (ANALYZE, BUFFERS)
SELECT u.name, COUNT(o.id) as order_count
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
WHERE u.created_at > ''2024-01-01''
GROUP BY u.id, u.name
HAVING COUNT(o.id) > 5;

-- Optimize with proper indexing
CREATE INDEX idx_users_created ON users(created_at) WHERE created_at > ''2024-01-01'';
CREATE INDEX idx_orders_user_id ON orders(user_id);', 'SQL performance optimization. Identify bottlenecks with pg_stat_statements. Add strategic indexes. EXPLAIN ANALYZE shows execution plans. Measure improvements.', 10, 10),
(7, 15, 'Microservices Communication', '// Service registry pattern
class ServiceRegistry {
    constructor() {
        this.services = new Map();
    }
    
    register(name, host, port) {
        this.services.set(name, { host, port, healthy: true });
    }
    
    async getService(name) {
        const service = this.services.get(name);
        if (!service) throw new Error(`Service ${name} not found`);
        
        // Health check
        try {
            const response = await fetch(`http://${service.host}:${service.port}/health`);
            service.healthy = response.ok;
        } catch (error) {
            service.healthy = false;
        }
        
        if (!service.healthy) {
            throw new Error(`Service ${name} is unhealthy`);
        }
        
        return service;
    }
}

// Usage
const registry = new ServiceRegistry();
registry.register(''user-service'', ''localhost'', 3001);
const service = await registry.getService(''user-service'');', 'Microservices need service discovery. Health checks ensure availability. Circuit breaker pattern prevents cascading failures. Resilient architecture.', 5, 11),
(7, 16, 'Algorithm Optimization', '#include <stdio.h>

// Naive O(n²)
int count_inversions_naive(int arr[], int n) {
    int count = 0;
    for (int i = 0; i < n - 1; i++) {
        for (int j = i + 1; j < n; j++) {
            if (arr[i] > arr[j]) count++;
        }
    }
    return count;
}

// O(n log n)
int merge_and_count(int arr[], int temp[], int left, int mid, int right) {
    int i = left, j = mid, k = left, inv_count = 0;
    
    while (i <= mid - 1 && j <= right) {
        if (arr[i] <= arr[j]) {
            temp[k++] = arr[i++];
        } else {
            temp[k++] = arr[j++];
            inv_count += (mid - i);
        }
    }
    
    while (i <= mid - 1) temp[k++] = arr[i++];
    while (j <= right) temp[k++] = arr[j++];
    
    for (i = left; i <= right; i++) arr[i] = temp[i];
    return inv_count;
}', 'Algorithm optimization techniques. Naive O(n²) vs optimized O(n log n). Divide and conquer approach. Big O analysis crucial for performance.', 2, 4),
(7, 17, 'CI/CD Pipeline', 'name: CI/CD Pipeline

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: ''18''
          cache: ''npm''
          
      - name: Install dependencies
        run: npm ci
        
      - name: Run tests
        run: npm test
        
      - name: Run lint
        run: npm run lint
        
      - name: Build application
        run: npm run build
        
  deploy:
    needs: test
    runs-on: ubuntu-latest
    if: github.ref == ''refs/heads/main''
    steps:
      - name: Deploy to production
        run: |
          echo "Deploying to production..."
          # Add deployment commands here', 'CI/CD automates testing and deployment. GitHub Actions on push/PR. Test before deploy. Only deploy from main branch. DevOps essential skill.', 13, 7),
(7, 18, 'Security Best Practices', '// Input validation middleware
const validator = require(''validator'');
const rateLimit = require(''express-rate-limit'');
const helmet = require(''helmet'');

// Security middleware
app.use(helmet());
app.use(rateLimit({
    windowMs: 15 * 60 * 1000, // 15 minutes
    max: 100 // limit each IP to 100 requests per windowMs
}));

// Input validation
function validateUserInput(req, res, next) {
    const { email, password, name } = req.body;
    
    if (!validator.isEmail(email)) {
        return res.status(400).json({ error: ''Invalid email format'' });
    }
    
    if (!validator.isLength(password, { min: 8, max: 128 })) {
        return res.status(400).json({ error: ''Password must be 8-128 characters'' });
    }
    
    if (!validator.isAlphanumeric(name.replace(/\\s/g, ''''))) {
        return res.status(400).json({ error: ''Name contains invalid characters'' });
    }
    
    next();
}

app.post(''/register'', validateUserInput, registerHandler);', 'Security best practices for web apps. Helmet adds security headers. Rate limiting prevents abuse. Input validation prevents injection. Defense in depth.', 5, 8),
(7, 19, 'Message Queue Implementation', 'import asyncio
import json

class Queue:
    def __init__(self):
        self.q = {}
        self.subs = {}
    
    async def pub(self, topic, msg):
        if topic not in self.q:
            self.q[topic] = asyncio.Queue()
        await self.q[topic].put(json.dumps(msg))
        
        if topic in self.subs:
            for cb in self.subs[topic]:
                try:
                    await cb(msg)
                except:
                    pass
    
    async def sub(self, topic, cb):
        if topic not in self.subs:
            self.subs[topic] = []
        self.subs[topic].append(cb)
    
    async def get(self, topic):
        if topic not in self.q:
            self.q[topic] = asyncio.Queue()
        while True:
            yield json.loads(await self.q[topic].get())', 'Message queue implementation. Pub/sub pattern for decoupling. Async/await for concurrency. Error handling for resilience. Scalable architecture.', 1, 11),
(7, 20, 'Caching Strategies', 'import redis
import json
import hashlib
from functools import wraps
from datetime import datetime, timedelta

redis_client = redis.Redis(host=''localhost'', port=6379, db=0)

def cache_result(expiration=3600):
    def decorator(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            # Create cache key
            key_data = f"{func.__name__}:{args}:{sorted(kwargs.items())}"
            cache_key = hashlib.md5(key_data.encode()).hexdigest()
            
            # Try to get from cache
            cached_result = redis_client.get(cache_key)
            if cached_result:
                return json.loads(cached_result)
            
            # Compute result
            result = func(*args, **kwargs)
            
            # Store in cache
            redis_client.setex(
                cache_key, 
                expiration, 
                json.dumps(result, default=str)
            )
            
            return result
        return wrapper
    return decorator

@cache_result(expiration=1800)  # 30 minutes
def expensive_computation(data):
    # Simulate expensive operation
    return sum(x * x for x in data)', 'Caching improves performance. Redis for distributed cache. Decorator pattern for easy use. TTL prevents stale data. Hash function for consistent keys.', 1, 10),
(7, 21, 'Load Testing', 'import asyncio
import aiohttp
import time
from statistics import mean, median

class LoadTester:
    def __init__(self, base_url, concurrent_users=10):
        self.base_url = base_url
        self.concurrent_users = concurrent_users
        self.results = []
    
    async def make_request(self, session, endpoint):
        start_time = time.time()
        try:
            async with session.get(f"{self.base_url}{endpoint}") as response:
                await response.text()
                end_time = time.time()
                self.results.append({
                    ''status'': response.status,
                    ''response_time'': end_time - start_time,
                    ''endpoint'': endpoint
                })
        except Exception as e:
            self.results.append({
                ''status'': 0,
                ''response_time'': time.time() - start_time,
                ''endpoint'': endpoint,
                ''error'': str(e)
            })
    
    async def run_test(self, endpoints, duration=60):
        async with aiohttp.ClientSession() as session:
            end_time = time.time() + duration
            
            while time.time() < end_time:
                tasks = []
                for _ in range(self.concurrent_users):
                    endpoint = endpoints[len(tasks) % len(endpoints)]
                    tasks.append(self.make_request(session, endpoint))
                
                await asyncio.gather(*tasks)
                await asyncio.sleep(0.1)
    
    def generate_report(self):
        success_count = sum(1 for r in self.results if r[''status''] == 200)
        response_times = [r[''response_time''] for r in self.results if r[''status''] == 200]
        
        print(f"Total requests: {len(self.results)}")
        print(f"Successful requests: {success_count}")
        print(f"Success rate: {success_count/len(self.results)*100:.2f}%")
        if response_times:
            print(f"Average response time: {mean(response_times):.3f}s")
            print(f"Median response time: {median(response_times):.3f}s")', 'Load testing simulates traffic. Async requests for concurrency. Measure response times, success rates. Identify performance bottlenecks. Plan capacity.', 1, 10),
(7, 22, 'Monitoring and Alerting', 'import psutil
import smtplib
import time
from email.mime.text import MIMEText
from datetime import datetime

class SystemMonitor:
    def __init__(self, thresholds=None):
        self.thresholds = thresholds or {
            ''cpu'': 80.0,
            ''memory'': 85.0,
            ''disk'': 90.0
        }
        self.alerts_sent = set()
    
    def check_cpu_usage(self):
        cpu_percent = psutil.cpu_percent(interval=1)
        if cpu_percent > self.thresholds[''cpu'']:
            return f"HIGH CPU: {cpu_percent:.1f}%"
        return None
    
    def check_memory_usage(self):
        memory = psutil.virtual_memory()
        if memory.percent > self.thresholds[''memory'']:
            return f"HIGH MEMORY: {memory.percent:.1f}%"
        return None
    
    def check_disk_usage(self):
        disk = psutil.disk_usage(''/'')
        disk_percent = (disk.used / disk.total) * 100
        if disk_percent > self.thresholds[''disk'']:
            return f"HIGH DISK: {disk_percent:.1f}%"
        return None
    
    def send_alert(self, message):
        # Prevent spam - only send once per hour per alert type
        alert_key = message.split('':'')[0]
        current_hour = datetime.now().hour
        
        if f"{alert_key}_{current_hour}" in self.alerts_sent:
            return
        
        print(f"ALERT: {message} at {datetime.now()}")
        # Email alert implementation here
        self.alerts_sent.add(f"{alert_key}_{current_hour}")
    
    def run_monitoring(self, interval=60):
        while True:
            alerts = []
            
            for check in [self.check_cpu_usage, self.check_memory_usage, self.check_disk_usage]:
                result = check()
                if result:
                    alerts.append(result)
            
            for alert in alerts:
                self.send_alert(alert)
            
            time.sleep(interval)', 'System monitoring with alerts. Track CPU, memory, disk usage. Threshold-based alerting. Prevent alert spam with deduplication. Essential for production.', 1, 6),
(7, 23, 'API Rate Limiting', 'import time
import redis
from flask import Flask, request, jsonify

app = Flask(__name__)
redis_client = redis.Redis()

class TokenBucketRateLimiter:
    def __init__(self, max_tokens, refill_rate, redis_client):
        self.max_tokens = max_tokens
        self.refill_rate = refill_rate  # tokens per second
        self.redis = redis_client
    
    def _get_bucket_key(self, identifier):
        return f"rate_limit:{identifier}"
    
    def allow_request(self, identifier):
        key = self._get_bucket_key(identifier)
        now = time.time()
        
        # Get current bucket state
        bucket_data = self.redis.hmget(key, ''tokens'', ''last_refill'')
        
        if bucket_data[0] is None:
            # Initialize bucket
            tokens = self.max_tokens - 1
            self.redis.hmset(key, {''tokens'': tokens, ''last_refill'': now})
            self.redis.expire(key, 3600)  # Expire after 1 hour of inactivity
            return True
        
        tokens = float(bucket_data[0])
        last_refill = float(bucket_data[1])
        
        # Refill tokens
        time_passed = now - last_refill
        tokens = min(self.max_tokens, tokens + time_passed * self.refill_rate)
        
        if tokens >= 1:
            tokens -= 1
            self.redis.hmset(key, {''tokens'': tokens, ''last_refill'': now})
            return True
        else:
            # Update last_refill even if request is denied
            self.redis.hset(key, ''last_refill'', now)
            return False

# Rate limiter instance
rate_limiter = TokenBucketRateLimiter(max_tokens=100, refill_rate=10, redis_client=redis_client)

@app.before_request
def limit_requests():
    client_ip = request.remote_addr
    if not rate_limiter.allow_request(client_ip):
        return jsonify({''error'': ''Rate limit exceeded''}), 429', 'Advanced rate limiting with token bucket algorithm. Redis for distributed state. Smooth traffic flow. Refills tokens over time. Production-ready implementation.', 1, 8),
(7, 24, 'Distributed Logging', 'import json
import logging
import uuid
from datetime import datetime
from flask import Flask, request, g

class StructuredFormatter(logging.Formatter):
    def format(self, record):
        log_entry = {
            ''timestamp'': datetime.utcnow().isoformat(),
            ''level'': record.levelname,
            ''message'': record.getMessage(),
            ''module'': record.module,
            ''function'': record.funcName,
            ''line'': record.lineno,
            ''thread'': record.thread
        }
        
        # Add request context if available
        if hasattr(g, ''request_id''):
            log_entry[''request_id''] = g.request_id
        if hasattr(g, ''user_id''):
            log_entry[''user_id''] = g.user_id
        
        # Add extra fields
        if hasattr(record, ''extra''):
            log_entry.update(record.extra)
        
        return json.dumps(log_entry)

app = Flask(__name__)

# Configure structured logging
logger = logging.getLogger()
handler = logging.StreamHandler()
handler.setFormatter(StructuredFormatter())
logger.addHandler(handler)
logger.setLevel(logging.INFO)

@app.before_request
def before_request():
    g.request_id = str(uuid.uuid4())
    g.start_time = datetime.utcnow()
    
    logger.info("Request started", extra={
        ''method'': request.method,
        ''path'': request.path,
        ''ip'': request.remote_addr,
        ''user_agent'': request.headers.get(''User-Agent'')
    })

@app.after_request
def after_request(response):
    duration = (datetime.utcnow() - g.start_time).total_seconds()
    
    logger.info("Request completed", extra={
        ''status_code'': response.status_code,
        ''duration_ms'': duration * 1000,
        ''content_length'': response.content_length
    })
    
    return response', 'Structured logging for microservices. JSON format for parsing. Request correlation IDs. Context propagation. Essential for debugging distributed systems.', 1, 7),
(7, 25, 'Kubernetes Deployment', 'apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-app
spec:
  replicas: 3
  selector:
    matchLabels:
      app: web-app
  template:
    metadata:
      labels:
        app: web-app
    spec:
      containers:
      - name: web-app
        image: myapp:latest
        ports:
        - containerPort: 3000
        env:
        - name: DATABASE_URL
          valueFrom:
            secretKeyRef:
              name: app-secrets
              key: db-url
        resources:
          limits:
            memory: "256Mi"
            cpu: "500m"
        livenessProbe:
          httpGet:
            path: /health
---
apiVersion: v1
kind: Service
metadata:
  name: web-service
spec:
  selector:
    app: web-app
  ports:
  - port: 80
    targetPort: 3000
  type: LoadBalancer', 'Kubernetes deployment configuration. Multiple replicas for availability. Health checks for reliability. Resource limits prevent resource hogging. Service for load balancing.', 13, 7),
(7, 26, 'GraphQL Schema Design', 'import { GraphQLSchema, GraphQLObjectType, GraphQLString, GraphQLInt, GraphQLList, GraphQLNonNull } from ''graphql'';

// Type definitions
const UserType = new GraphQLObjectType({
    name: ''User'',
    fields: () => ({
        id: { type: GraphQLNonNull(GraphQLString) },
        email: { type: GraphQLNonNull(GraphQLString) },
        name: { type: GraphQLString },
        posts: {
            type: GraphQLList(PostType),
            resolve: (user) => getPostsByUserId(user.id)
        }
    })
});

const PostType = new GraphQLObjectType({
    name: ''Post'',
    fields: {
        id: { type: GraphQLNonNull(GraphQLString) },
        title: { type: GraphQLNonNull(GraphQLString) },
        content: { type: GraphQLString },
        author: {
            type: UserType,
            resolve: (post) => getUserById(post.authorId)
        }
    }
});

// Root query
const RootQuery = new GraphQLObjectType({
    name: ''RootQueryType'',
    fields: {
        user: {
            type: UserType,
            args: { id: { type: GraphQLNonNull(GraphQLString) } },
            resolve: (parent, args) => getUserById(args.id)
        },
        posts: {
            type: GraphQLList(PostType),
            args: { limit: { type: GraphQLInt, defaultValue: 10 } },
            resolve: (parent, args) => getPosts(args.limit)
        }
    }
});

export default new GraphQLSchema({
    query: RootQuery
});', 'GraphQL schema design. Type definitions with relationships. Resolvers fetch data. Arguments for filtering. Alternative to REST APIs. Single endpoint, flexible queries.', 5, 11),
(7, 27, 'Blockchain Basics', 'import hashlib
from time import time

class Block:
    def __init__(self, i, d, p):
        self.i = i
        self.d = d
        self.t = time()
        self.p = p
        self.n = 0
        self.h = self.calc()
    
    def calc(self):
        return hashlib.sha256(f"{self.i}{self.d}{self.t}{self.p}{self.n}".encode()).hexdigest()
    
    def mine(self, diff):
        target = "0" * diff
        while self.h[:diff] != target:
            self.n += 1
            self.h = self.calc()

class Chain:
    def __init__(self):
        self.chain = [Block(0, "Gen", "0")]
    
    def add(self, data):
        prev = self.chain[-1]
        b = Block(len(self.chain), data, prev.h)
        b.mine(2)
        self.chain.append(b)

c = Chain()
c.add("Tx1")
print(c.chain[-1].h)', 'Blockchain fundamentals. Blocks contain transactions and hash of previous block. Mining involves finding hash with specific pattern. Chain validation ensures integrity.', 1, 8),
(7, 28, 'Machine Learning Pipeline', 'import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split, cross_val_score
from sklearn.preprocessing import StandardScaler, LabelEncoder
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import classification_report, confusion_matrix
import joblib

def create_ml_pipeline(data_path):
    # Load and explore data
    df = pd.read_csv(data_path)
    print(f"Dataset shape: {df.shape}")
    print(f"Missing values: {df.isnull().sum().sum()}")
    
    # Feature engineering
    df = df.dropna()  # Simple approach - in reality, be more careful
    
    # Separate features and target
    X = df.drop(''target'', axis=1)
    y = df[''target'']
    
    # Encode categorical variables
    label_encoders = {}
    for column in X.select_dtypes(include=[''object'']).columns:
        le = LabelEncoder()
        X[column] = le.fit_transform(X[column].astype(str))
        label_encoders[column] = le
    
    # Split data
    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.2, random_state=42, stratify=y
    )
    
    # Scale features
    scaler = StandardScaler()
    X_train_scaled = scaler.fit_transform(X_train)
    X_test_scaled = scaler.transform(X_test)
    
    # Train model
    model = RandomForestClassifier(n_estimators=100, random_state=42)
    model.fit(X_train_scaled, y_train)
    
    # Evaluate
    train_score = model.score(X_train_scaled, y_train)
    test_score = model.score(X_test_scaled, y_test)
    
    print(f"Training accuracy: {train_score:.3f}")
    print(f"Testing accuracy: {test_score:.3f}")
    
    # Cross-validation
    cv_scores = cross_val_score(model, X_train_scaled, y_train, cv=5)
    print(f"CV Score: {cv_scores.mean():.3f} (+/- {cv_scores.std() * 2:.3f})")
    
    # Save model and preprocessors
    joblib.dump(model, ''model.pkl'')
    joblib.dump(scaler, ''scaler.pkl'')
    joblib.dump(label_encoders, ''encoders.pkl'')
    
    return model, scaler, label_encoders', 'ML pipeline for classification. Data preprocessing and feature engineering. Train-test split and cross-validation. Model persistence. Production-ready approach.', 1, 4),
(7, 29, 'WebRTC Implementation', 'class WebRTCConnection {
    constructor(isInitiator = false) {
        this.isInitiator = isInitiator;
        this.pc = new RTCPeerConnection({
            iceServers: [
                { urls: ''stun:stun.l.google.com:19302'' }
            ]
        });
        this.setupEventListeners();
    }
    
    setupEventListeners() {
        this.pc.onicecandidate = (event) => {
            if (event.candidate) {
                this.sendSignal(''ice-candidate'', event.candidate);
            }
        };
        
        this.pc.ontrack = (event) => {
            const remoteVideo = document.getElementById(''remoteVideo'');
            remoteVideo.srcObject = event.streams[0];
        };
    }
    
    async startCall() {
        try {
            const stream = await navigator.mediaDevices.getUserMedia({ 
                video: true, audio: true 
            });
            
            const localVideo = document.getElementById(''localVideo'');
            localVideo.srcObject = stream;
            
            stream.getTracks().forEach(track => {
                this.pc.addTrack(track, stream);
            });
            
            if (this.isInitiator) {
                const offer = await this.pc.createOffer();
                await this.pc.setLocalDescription(offer);
                this.sendSignal(''offer'', offer);
            }
        } catch (error) {
            console.error(''Error starting call:'', error);
        }
    }
    
    async handleOffer(offer) {
        await this.pc.setRemoteDescription(offer);
        const answer = await this.pc.createAnswer();
        await this.pc.setLocalDescription(answer);
        this.sendSignal(''answer'', answer);
    }
    
    async handleAnswer(answer) {
        await this.pc.setRemoteDescription(answer);
    }
    
    async handleIceCandidate(candidate) {
        await this.pc.addIceCandidate(candidate);
    }
    
    sendSignal(type, data) {
        // Send via WebSocket or other signaling mechanism
        this.signalingSocket.send(JSON.stringify({ type, data }));
    }
}', 'WebRTC for peer-to-peer communication. Video calling implementation. ICE candidates for NAT traversal. Signaling server coordinates connection. Modern web technology.', 5, 11),
(7, 30, 'Performance Monitoring', 'class PerformanceMonitor {
    constructor() {
        this.metrics = new Map();
        this.observers = [];
        this.setupObservers();
    }
    
    setupObservers() {
        // Long Task Observer
        if (''PerformanceObserver'' in window) {
            const longTaskObserver = new PerformanceObserver((list) => {
                for (const entry of list.getEntries()) {
                    this.recordMetric(''long-task'', {
                        duration: entry.duration,
                        startTime: entry.startTime
                    });
                }
            });
            longTaskObserver.observe({ entryTypes: [''longtask''] });
            
            // Layout Shift Observer
            const clsObserver = new PerformanceObserver((list) => {
                for (const entry of list.getEntries()) {
                    if (!entry.hadRecentInput) {
                        this.recordMetric(''cls'', entry.value);
                    }
                }
            });
            clsObserver.observe({ entryTypes: [''layout-shift''] });
            
            // Largest Contentful Paint
            const lcpObserver = new PerformanceObserver((list) => {
                const entries = list.getEntries();
                const lastEntry = entries[entries.length - 1];
                this.recordMetric(''lcp'', lastEntry.startTime);
            });
            lcpObserver.observe({ entryTypes: [''largest-contentful-paint''] });
        }
    }
    
    recordMetric(name, value) {
        if (!this.metrics.has(name)) {
            this.metrics.set(name, []);
        }
        this.metrics.get(name).push({
            value,
            timestamp: Date.now()
        });
        
        // Send to analytics
        this.sendToAnalytics(name, value);
    }
    
    measureFunction(name, fn) {
        return async (...args) => {
            const start = performance.now();
            const result = await fn(...args);
            const duration = performance.now() - start;
            this.recordMetric(name, duration);
            return result;
        };
    }
    
    getWebVitals() {
        return {
            lcp: this.getLastMetric(''lcp''),
            cls: this.getTotalMetric(''cls''),
            fid: this.getLastMetric(''fid'')
        };
    }
    
    sendToAnalytics(metric, value) {
        // Send to your analytics service
        fetch(''/analytics'', {
            method: ''POST'',
            headers: { ''Content-Type'': ''application/json'' },
            body: JSON.stringify({ metric, value, timestamp: Date.now() })
        });
    }
}', 'Performance monitoring in browsers. Web Vitals tracking (LCP, CLS, FID). Performance Observer API. Function timing measurements. Real User Monitoring (RUM).', 5, 10),
(7, 31, 'Summer Project Showcase', '# Summer Project Showcase

## Code Learning Platform
- **Stack**: React, Node.js, PostgreSQL
- **Duration**: July 2024

## Features
1. Daily code snippets
2. Multi-language support
3. Progress tracking
4. Responsive design
5. API with auth
6. Testing suite
7. CI/CD pipeline

## Results
- Performance: 95+ Lighthouse
- Testing: 85%+ coverage
- Security: OWASP compliant
- Scale: 1000+ users

## Skills Gained
- Full-stack development
- DevOps practices
- Database design
- Problem solving

**Demo**: github.com/user/project
**Live**: project.vercel.app

Internship ready! 🚀', 'Summer project showcase template. Highlight key achievements and technical skills. Quantify results where possible. Include live demo links. Perfect for resume and interviews!', 16, 7);