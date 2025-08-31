-- August Snippets: Preparation & Advanced Summer Topics (Complete Month 1-31)
INSERT INTO snippets (month, day, title, code, explanation, language_id, category_id) VALUES
(8, 1, 'Summer Prep: C Refresher', '#include <stdio.h>
#include <stdlib.h>

int main() {
    // Basic C refresher for new semester
    printf("Welcome back to Epitech Nancy!\\n");
    
    int students = 150;
    double avg_grade = 85.5;
    char level[] = "5th year MSc";
    
    printf("Class: %s\\n", level);
    printf("Students: %d\\n", students);
    printf("Average grade: %.1f%%\\n", avg_grade);
    
    // Memory allocation reminder
    int *grades = malloc(students * sizeof(int));
    if (grades != NULL) {
        printf("Memory allocated for %d grades\\n", students);
        free(grades);
    }
    
    return 0;
}', 'August preparation for new semester. Review C fundamentals: variables, printf formatting, memory management. Get ready for advanced coursework!', 2, 1),
(8, 2, 'Internship Experience: Code Style', '// Internship code style guidelines

// GOOD: Clear, descriptive names
int calculateStudentAverage(int grades[], int count) {
    int sum = 0;
    for (int i = 0; i < count; i++) {
        sum += grades[i];
    }
    return sum / count;
}

// BAD: Unclear names
int calc(int g[], int c) {
    int s = 0;
    for (int i = 0; i < c; i++) s += g[i];
    return s / c;
}

// GOOD: Proper spacing and braces
if (grade >= 90) {
    printf("Excellent work!");
} else if (grade >= 70) {
    printf("Good job!");
}

// BAD: Poor formatting
if(grade>=90)printf("Excellent work!");else if(grade>=70)printf("Good job!");', 'Professional code style from internship experience. Clear naming, proper formatting, consistent braces. Good habits for team collaboration.', 2, 7),
(8, 3, 'Python Data Structures Review', '# Essential Python data structures

# Lists - ordered, mutable
students = ["Alice", "Bob", "Charlie"]
students.append("Diana")
print(f"First student: {students[0]}")  # Alice

# Dictionaries - key-value pairs
grades = {
    "Alice": 95,
    "Bob": 87,
    "Charlie": 92
}
print(f"Alice''s grade: {grades[''Alice'']}")  # 95

# Sets - unique elements
languages = {"Python", "C", "C++", "JavaScript"}
languages.add("Go")  # No duplicates allowed

# Tuples - immutable
coordinates = (48.6921, 6.1844)  # Nancy, France
latitude, longitude = coordinates  # Unpacking

print(f"Nancy coordinates: {latitude}, {longitude}")', 'Python data structures review. Lists for ordered data, dicts for key-value, sets for uniqueness, tuples for immutable data. Choose the right structure!', 1, 3),
(8, 4, 'C++ STL Containers Overview', '#include <iostream>
#include <vector>
#include <map>
#include <set>
#include <string>
using namespace std;

int main() {
    // Vector - dynamic array
    vector<int> numbers = {1, 2, 3, 4, 5};
    numbers.push_back(6);
    cout << "Vector size: " << numbers.size() << endl;
    
    // Map - key-value pairs (sorted)
    map<string, int> ages;
    ages["Alice"] = 22;
    ages["Bob"] = 21;
    cout << "Alice is " << ages["Alice"] << " years old" << endl;
    
    // Set - unique elements (sorted)
    set<string> courses = {"Math", "Physics", "CS"};
    courses.insert("Chemistry");
    
    // Range-based for loop
    cout << "Courses: ";
    for (const string& course : courses) {
        cout << course << " ";
    }
    cout << endl;
    
    return 0;
}', 'C++ STL container overview. Vector for dynamic arrays, map for key-value storage, set for unique elements. Modern C++ features included.', 3, 3),
(8, 5, 'Shell Scripting for Students', '#!/bin/bash
# Student productivity script

echo "📚 Student Productivity Helper"
echo "Date: $(date +''%Y-%m-%d'')")
echo

# Check assignments directory
ASSIGNMENT_DIR="$HOME/epitech/assignments"
if [ -d "$ASSIGNMENT_DIR" ]; then
    echo "📁 Assignment files:"
    ls -1 "$ASSIGNMENT_DIR" | head -5
else
    echo "Creating assignments directory..."
    mkdir -p "$ASSIGNMENT_DIR"
fi

echo

# Git status check
if [ -d ".git" ]; then
    echo "🔧 Git status:"
    git status --porcelain | wc -l | xargs echo "Modified files:"
else
    echo "💡 Tip: Initialize git repository with ''git init''"
fi

# Disk usage
echo
echo "💾 Disk usage: $(df -h . | tail -1 | awk ''{print $5}'')"', 'Shell scripting for student productivity. Check assignments, git status, disk usage. Automate daily tasks with bash scripts. Essential system skills.', 14, 7),
(8, 6, 'Database Design Principles', 'CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    enrollment_date DATE DEFAULT CURRENT_DATE
);

CREATE TABLE courses (
    id SERIAL PRIMARY KEY,
    code VARCHAR(10) UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    credits INTEGER CHECK (credits > 0)
);

CREATE TABLE enrollments (
    student_id INTEGER REFERENCES students(id),
    course_id INTEGER REFERENCES courses(id),
    grade DECIMAL(3,1) CHECK (grade >= 0 AND grade <= 20),
    PRIMARY KEY (student_id, course_id)
);', 'Database design with proper normalization. Primary keys, foreign keys, constraints. Many-to-many relationships through junction tables. Data integrity rules.', 10, 3),
(8, 7, 'JavaScript ES6+ Features', '// Modern JavaScript features

// Destructuring
const student = { name: "Alice", grade: 95 };
const { name, grade } = student;
console.log(`${name}: ${grade}%`);

// Arrow functions
const students = ["Alice", "Bob"];
const greetings = students.map(name => `Hello, ${name}!`);

// Spread operator
const nums = [1, 2, 3];
const more = [...nums, 4, 5];
console.log(Math.max(...more));

// Async/await
async function fetchData(id) {
    try {
        const response = await fetch(`/api/students/${id}`);
        return await response.json();
    } catch (error) {
        console.error("Error:", error);
    }
}

// Optional chaining
const url = student.profile?.avatar?.url ?? "default.jpg";', 'Modern JavaScript ES6+ features. Destructuring, template literals, arrow functions, async/await. Essential for web development internships.', 5, 9),
(8, 8, 'C Memory Management Patterns', '#include <stdio.h>
#include <stdlib.h>

typedef struct {
    void* memory;
    size_t block_size;
    void* free_list;
} MemoryPool;

MemoryPool* pool_create(size_t block_size, size_t num_blocks) {
    MemoryPool* pool = malloc(sizeof(MemoryPool));
    pool->memory = malloc(block_size * num_blocks);
    pool->block_size = block_size;
    
    // Link free blocks
    pool->free_list = pool->memory;
    char* current = (char*)pool->memory;
    for (size_t i = 0; i < num_blocks - 1; i++) {
        *(void**)current = current + block_size;
        current += block_size;
    }
    *(void**)current = NULL;
    return pool;
}

void* pool_alloc(MemoryPool* pool) {
    if (!pool->free_list) return NULL;
    void* block = pool->free_list;
    pool->free_list = *(void**)block;
    return block;
}', 'Advanced C memory management. Memory pool pattern for efficient allocation. Reduces fragmentation, improves performance. Professional programming technique.', 2, 5),
(8, 9, 'React Component Best Practices', 'import React, { useState, useEffect, useMemo, useCallback } from ''react'';

// Custom hook for data fetching
function useStudentData(studentId) {
    const [student, setStudent] = useState(null);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);
    
    useEffect(() => {
        let cancelled = false;
        
        async function fetchStudent() {
            try {
                const response = await fetch(`/api/students/${studentId}`);
                const data = await response.json();
                
                if (!cancelled) {
                    setStudent(data);
                    setLoading(false);
                }
            } catch (err) {
                if (!cancelled) {
                    setError(err.message);
                    setLoading(false);
                }
            }
        }
        
        fetchStudent();
        
        return () => { cancelled = true; };
    }, [studentId]);
    
    return { student, loading, error };
}

function StudentProfile({ studentId }) {
    const { student, loading, error } = useStudentData(studentId);
    
    const formattedGrade = useMemo(() => {
        return student?.grade ? `${student.grade.toFixed(1)}%` : ''N/A'';
    }, [student?.grade]);
    
    if (loading) return <div>Loading...</div>;
    if (error) return <div>Error: {error}</div>;
    
    return (
        <div className="student-profile">
            <h2>{student?.name}</h2>
            <p>Grade: {formattedGrade}</p>
        </div>
    );
}', 'React best practices. Custom hooks for data fetching, cleanup to prevent memory leaks, useMemo for expensive calculations. Professional component patterns.', 5, 9),
(8, 10, 'Algorithm Complexity Analysis', '#include <stdio.h>
#include <time.h>

// O(n²) - Bubble Sort
void bubble_sort(int arr[], int n) {
    for (int i = 0; i < n-1; i++) {
        for (int j = 0; j < n-i-1; j++) {
            if (arr[j] > arr[j+1]) {
                int temp = arr[j];
                arr[j] = arr[j+1];
                arr[j+1] = temp;
            }
        }
    }
}

// Benchmark function
void benchmark(void (*sort_func)(int[], int), int arr[], int n) {
    clock_t start = clock();
    sort_func(arr, n);
    clock_t end = clock();
    printf(\"Time: %.6f seconds\
\", ((double)(end-start))/CLOCKS_PER_SEC);
}

int main() {
    int arr[] = {64, 34, 25, 12, 22, 11, 90};
    benchmark(bubble_sort, arr, 7);
    return 0;
}', 'Algorithm complexity analysis. Compare O(n²) bubble sort vs O(n log n) quick sort. Benchmark performance with timing. Understanding Big O notation crucial.', 2, 4),
(8, 11, 'Git Advanced Techniques', '# Advanced Git techniques for team projects

# Interactive rebase to clean up commit history
git rebase -i HEAD~3
# In editor: pick, squash, reword commits

# Stash work in progress
git stash push -m "WIP: feature implementation"
git stash list
git stash apply stash@{0}

# Cherry-pick specific commits
git cherry-pick abc1234

# Find bugs with bisect
git bisect start
git bisect bad HEAD
git bisect good v1.0.0
# Git will checkout commits to test
git bisect good  # or git bisect bad

# Advanced branching
git checkout -b feature/user-auth
git push -u origin feature/user-auth

# Clean up merged branches
git branch --merged | grep -v "\\*\\|main\\|master" | xargs -n 1 git branch -d', 'Advanced Git for professional development. Interactive rebase, stashing, cherry-picking, bisecting. Essential skills for internships and team projects.', 14, 7),
(8, 12, 'C++ Templates Deep Dive', '#include <iostream>
using namespace std;

// Function template
template<typename T>
T max_value(const T& a, const T& b) {
    return (a > b) ? a : b;
}

// Class template
template<typename T, size_t N>
class FixedArray {
private:
    T data[N];
public:
    constexpr size_t size() const { return N; }
    T& operator[](size_t index) { return data[index]; }
    const T& operator[](size_t index) const { return data[index]; }
};

int main() {
    cout << max_value(10, 20) << endl;
    cout << max_value(3.14, 2.71) << endl;
    
    FixedArray<int, 3> arr;
    arr[0] = 42;
    cout << "Size: " << arr.size() << endl;
    
    return 0;
}', 'C++ templates deep dive. Function templates, class templates, SFINAE. Compile-time polymorphism, type deduction. Advanced C++ programming concepts.', 3, 9),
(8, 13, 'System Design Principles', '# System Design Principles for Scalable Applications

## 1. Single Responsibility Principle
# Each component should have one reason to change

class UserService:
    def create_user(self, user_data): pass
    def get_user(self, user_id): pass
    def update_user(self, user_id, data): pass

class EmailService:
    def send_welcome_email(self, user): pass
    def send_notification(self, user, message): pass

## 2. Database Sharding Strategy
# Horizontal partitioning for scalability
# Users 0-999999 → Shard 1
# Users 1000000-1999999 → Shard 2

def get_shard_id(user_id):
    return user_id // 1000000

## 3. Caching Layers
# L1: Application cache (in-memory)
# L2: Distributed cache (Redis)
# L3: CDN for static content

## 4. Load Balancing
# Round-robin, least connections, geographic', 'System design principles for scalable applications. Microservices, database sharding, caching layers, load balancing. Prepare for technical interviews.', 1, 7),
(8, 14, 'Security Fundamentals', '// Security best practices for web applications

// 1. Input Validation
function validateEmail(email) {
    const emailRegex = /^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$/;
    return emailRegex.test(email) && email.length <= 254;
}

function sanitizeInput(input) {
    // Remove potential XSS vectors
    return input.replace(/<script[^>]*>.*?<\\/script>/gi, '''')
                .replace(/<[^>]*>/g, '''')  // Strip HTML tags
                .trim();
}

// 2. Password Security
const bcrypt = require(''bcrypt'');
const saltRounds = 12;

async function hashPassword(password) {
    // Validate password strength
    if (password.length < 8) {
        throw new Error(''Password too short'');
    }
    
    return await bcrypt.hash(password, saltRounds);
}

// 3. JWT Token Security
const jwt = require(''jsonwebtoken'');

function generateSecureToken(payload) {
    return jwt.sign(
        payload,
        process.env.JWT_SECRET,
        { 
            expiresIn: ''15m'',  // Short-lived tokens
            algorithm: ''HS256''
        }
    );
}', 'Security fundamentals for web development. Input validation, password hashing, JWT tokens. Prevent XSS, SQL injection, authentication vulnerabilities.', 5, 8),
(8, 15, 'Microservices Architecture', 'version: ''3.8''

services:
  # API Gateway
  gateway:
    build: ./gateway
    ports:
      - "8080:8080"
    environment:
      - USER_SERVICE_URL=http://user-service:3001
      - ORDER_SERVICE_URL=http://order-service:3002
    depends_on:
      - user-service
      - order-service
  
  # User Service
  user-service:
    build: ./services/user
    environment:
      - DATABASE_URL=postgres://user:pass@user-db:5432/users
      - REDIS_URL=redis://redis:6379
    depends_on:
      - user-db
      - redis
  
  # Order Service  
  order-service:
    build: ./services/order
    environment:
      - DATABASE_URL=postgres://user:pass@order-db:5432/orders
      - MESSAGE_QUEUE_URL=amqp://rabbitmq:5672
    depends_on:
      - order-db
      - rabbitmq
  
  # Databases
  user-db:
    image: postgres:13
    environment:
      POSTGRES_DB: users
      POSTGRES_USER: user
      POSTGRES_PASSWORD: pass
  
  order-db:
    image: postgres:13
    environment:
      POSTGRES_DB: orders
      POSTGRES_USER: user
      POSTGRES_PASSWORD: pass
  
  # Message Queue
  rabbitmq:
    image: rabbitmq:3-management
    ports:
      - "15672:15672"
  
  # Cache
  redis:
    image: redis:alpine', 'Microservices architecture with Docker Compose. API gateway, service isolation, dedicated databases, message queues. Modern scalable system design.', 16, 7),
(8, 16, 'Performance Optimization', '#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int id;
    char name[32];
    float grade;
} Student;

void process_grades(float* grades, int count) {
    int simd_count = count & ~3;
    
    for (int i = 0; i < simd_count; i += 4) {
        grades[i] *= 1.1f;
        grades[i+1] *= 1.1f;
        grades[i+2] *= 1.1f;
        grades[i+3] *= 1.1f;
    }
    
    for (int i = simd_count; i < count; i++) {
        grades[i] *= 1.1f;
    }
}

static char pool[1024 * 1024];
static size_t offset = 0;

void* fast_alloc(size_t size) {
    if (offset + size > sizeof(pool)) offset = 0;
    void* ptr = pool + offset;
    offset += (size + 7) & ~7;
    return ptr;
}', 'Performance optimization techniques. Cache-friendly data structures, SIMD-friendly code, memory pools. Compiler optimizations, alignment. Systems programming skills.', 2, 10),
(8, 17, 'DevOps Pipeline Creation', 'name: Production Deployment

on:
  push:
    branches: [ main ]
    tags: [ ''v*'' ]

env:
  REGISTRY: ghcr.io
  IMAGE_NAME: ${{ github.repository }}

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v3
        
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: ''18''
          cache: ''npm''
          
      - name: Install dependencies
        run: npm ci
        
      - name: Run tests
        run: npm test -- --coverage
        
      - name: Run security audit
        run: npm audit --audit-level moderate
        
      - name: Build application
        run: npm run build
        
  build-and-push:
    needs: test
    runs-on: ubuntu-latest
    permissions:
      contents: read
      packages: write
    steps:
      - name: Build and push Docker image
        uses: docker/build-push-action@v4
        with:
          push: true
          tags: ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}:latest
          
  deploy:
    needs: build-and-push
    runs-on: ubuntu-latest
    environment: production
    steps:
      - name: Deploy to Kubernetes
        run: |
          kubectl set image deployment/app app=${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}:latest
          kubectl rollout status deployment/app', 'Complete DevOps pipeline. Automated testing, security audits, Docker builds, Kubernetes deployment. CI/CD best practices for production systems.', 13, 7),
(8, 18, 'Machine Learning Basics', 'import numpy as np
import matplotlib.pyplot as plt
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import train_test_split
from sklearn.metrics import mean_squared_error, r2_score

# Generate sample data - student study hours vs grades
np.random.seed(42)
study_hours = np.random.normal(6, 2, 200).reshape(-1, 1)
noise = np.random.normal(0, 5, 200)
grades = 70 + 3 * study_hours.flatten() + noise

# Ensure realistic grade range
grades = np.clip(grades, 0, 100)

# Split data
X_train, X_test, y_train, y_test = train_test_split(
    study_hours, grades, test_size=0.2, random_state=42
)

# Train model
model = LinearRegression()
model.fit(X_train, y_train)

# Make predictions
y_pred = model.predict(X_test)

# Evaluate model
mse = mean_squared_error(y_test, y_pred)
r2 = r2_score(y_test, y_pred)

print(f"Mean Squared Error: {mse:.2f}")
print(f"R-squared Score: {r2:.3f}")
print(f"Model equation: Grade = {model.intercept_:.1f} + {model.coef_[0]:.1f} * Hours")

# Visualize results
plt.figure(figsize=(10, 6))
plt.scatter(X_test, y_test, alpha=0.6, label=''Actual'')
plt.plot(X_test, y_pred, color=''red'', linewidth=2, label=''Predicted'')
plt.xlabel(''Study Hours'')
plt.ylabel(''Grade'')
plt.title(''Student Performance Prediction'')
plt.legend()
plt.grid(True, alpha=0.3)
plt.show()', 'Machine learning fundamentals with Python. Linear regression to predict student grades from study hours. Data preprocessing, model training, evaluation metrics.', 1, 4),
(8, 19, 'REST API Authentication', 'const express = require(''express'');
const jwt = require(''jsonwebtoken'');
const bcrypt = require(''bcrypt'');
const rateLimit = require(''express-rate-limit'');

const app = express();
app.use(express.json());

// Rate limiting
const authLimiter = rateLimit({
    windowMs: 15 * 60 * 1000, // 15 minutes
    max: 5, // 5 attempts per window
    message: ''Too many authentication attempts'',
    standardHeaders: true,
    legacyHeaders: false
});

// Middleware to verify JWT
function authenticateToken(req, res, next) {
    const authHeader = req.headers[''authorization''];
    const token = authHeader && authHeader.split('' '')[1];
    
    if (!token) {
        return res.status(401).json({ error: ''Access token required'' });
    }
    
    jwt.verify(token, process.env.JWT_SECRET, (err, user) => {
        if (err) {
            return res.status(403).json({ error: ''Invalid or expired token'' });
        }
        req.user = user;
        next();
    });
}

// Login endpoint
app.post(''/auth/login'', authLimiter, async (req, res) => {
    try {
        const { email, password } = req.body;
        
        // Validate input
        if (!email || !password) {
            return res.status(400).json({ error: ''Email and password required'' });
        }
        
        // Find user (implement your database logic)
        const user = await findUserByEmail(email);
        if (!user) {
            return res.status(401).json({ error: ''Invalid credentials'' });
        }
        
        // Verify password
        const validPassword = await bcrypt.compare(password, user.password_hash);
        if (!validPassword) {
            return res.status(401).json({ error: ''Invalid credentials'' });
        }
        
        // Generate tokens
        const accessToken = jwt.sign(
            { id: user.id, email: user.email },
            process.env.JWT_SECRET,
            { expiresIn: ''15m'' }
        );
        
        const refreshToken = jwt.sign(
            { id: user.id },
            process.env.REFRESH_SECRET,
            { expiresIn: ''7d'' }
        );
        
        res.json({
            access_token: accessToken,
            refresh_token: refreshToken,
            expires_in: 900 // 15 minutes
        });
    } catch (error) {
        res.status(500).json({ error: ''Internal server error'' });
    }
});

// Protected route
app.get(''/api/profile'', authenticateToken, (req, res) => {
    res.json({
        id: req.user.id,
        email: req.user.email,
        message: ''This is a protected route''
    });
});', 'Secure REST API authentication. JWT tokens, password hashing, rate limiting. Refresh token pattern, input validation. Production-ready security practices.', 5, 8),
(8, 20, 'GraphQL Implementation', 'const { ApolloServer } = require(''apollo-server-express'');
const { gql } = require(''apollo-server-express'');

// Schema definition
const typeDefs = gql`
    type Student {
        id: ID!
        name: String!
        email: String!
        grade: Float
        courses: [Course!]!
        createdAt: String!
    }
    
    type Course {
        id: ID!
        name: String!
        code: String!
        credits: Int!
        students: [Student!]!
    }
    
    type Query {
        students(limit: Int = 10, offset: Int = 0): [Student!]!
        student(id: ID!): Student
        courses: [Course!]!
        course(id: ID!): Course
    }
    
    type Mutation {
        createStudent(input: CreateStudentInput!): Student!
        updateStudent(id: ID!, input: UpdateStudentInput!): Student!
        deleteStudent(id: ID!): Boolean!
        enrollStudent(studentId: ID!, courseId: ID!): Boolean!
    }
    
    input CreateStudentInput {
        name: String!
        email: String!
        grade: Float
    }
    
    input UpdateStudentInput {
        name: String
        email: String
        grade: Float
    }
    
    type Subscription {
        studentAdded: Student!
        gradeUpdated(studentId: ID!): Student!
    }
`;

// Resolvers
const resolvers = {
    Query: {
        students: async (_, { limit, offset }) => {
            return await getStudents(limit, offset);
        },
        student: async (_, { id }) => {
            return await getStudentById(id);
        },
        courses: async () => {
            return await getAllCourses();
        },
        course: async (_, { id }) => {
            return await getCourseById(id);
        }
    },
    
    Mutation: {
        createStudent: async (_, { input }) => {
            const student = await createStudent(input);
            pubsub.publish(''STUDENT_ADDED'', { studentAdded: student });
            return student;
        },
        updateStudent: async (_, { id, input }) => {
            const student = await updateStudent(id, input);
            pubsub.publish(''GRADE_UPDATED'', { gradeUpdated: student });
            return student;
        },
        deleteStudent: async (_, { id }) => {
            return await deleteStudent(id);
        },
        enrollStudent: async (_, { studentId, courseId }) => {
            return await enrollStudentInCourse(studentId, courseId);
        }
    },
    
    Student: {
        courses: async (parent) => {
            return await getCoursesByStudentId(parent.id);
        }
    },
    
    Course: {
        students: async (parent) => {
            return await getStudentsByCourseId(parent.id);
        }
    },
    
    Subscription: {
        studentAdded: {
            subscribe: () => pubsub.asyncIterator([''STUDENT_ADDED''])
        },
        gradeUpdated: {
            subscribe: (_, { studentId }) => {
                return pubsub.asyncIterator([''GRADE_UPDATED'']);
            }
        }
    }
};

// Create Apollo Server
const server = new ApolloServer({
    typeDefs,
    resolvers,
    context: ({ req }) => {
        const token = req.headers.authorization || '''';
        const user = getUser(token);
        return { user };
    },
    introspection: process.env.NODE_ENV !== ''production'',
    playground: process.env.NODE_ENV !== ''production''
});', 'Complete GraphQL implementation with Apollo Server. Queries, mutations, subscriptions. Real-time updates, complex relationships. Modern API development approach.', 5, 11),
(8, 21, 'Blockchain Smart Contract', 'pragma solidity ^0.8.0;

contract StudentRegistry {
    mapping(uint256 => string) public students;
    mapping(address => bool) public teachers;
    uint256 public nextId = 1;
    address public admin;
    
    event StudentRegistered(uint256 id, string name);
    
    modifier onlyAdmin() {
        require(msg.sender == admin, "Admin only");
        _;
    }
    
    constructor() {
        admin = msg.sender;
    }
    
    function addTeacher(address teacher) external onlyAdmin {
        teachers[teacher] = true;
    }
    
    function registerStudent(string memory name) external returns (uint256) {
        require(teachers[msg.sender] || msg.sender == admin, "No auth");
        students[nextId] = name;
        emit StudentRegistered(nextId, name);
        return nextId++;
    }
}', 'Basic Ethereum smart contract. Solidity syntax, structs, mappings, modifiers, events. Access control and state management on blockchain.', 11, 8),
(8, 22, 'Cloud Architecture Design', 'import boto3
import json
from datetime import datetime

# AWS Lambda function for student data processing
def lambda_handler(event, context):
    # Initialize AWS services
    dynamodb = boto3.resource(''dynamodb'')
    s3 = boto3.client(''s3'')
    sns = boto3.client(''sns'')
    
    # Process incoming student data
    try:
        # Parse the event
        records = event.get(''Records'', [])
        
        for record in records:
            # Handle S3 event
            if ''s3'' in record:
                bucket = record[''s3''][''bucket''][''name'']
                key = record[''s3''][''object''][''key'']
                
                # Download and process file
                response = s3.get_object(Bucket=bucket, Key=key)
                content = response[''Body''].read().decode(''utf-8'')
                
                # Parse student data
                students = json.loads(content)
                
                # Store in DynamoDB
                table = dynamodb.Table(''Students'')
                
                with table.batch_writer() as batch:
                    for student in students:
                        batch.put_item(
                            Item={
                                ''student_id'': student[''id''],
                                ''name'': student[''name''],
                                ''email'': student[''email''],
                                ''grade'': student.get(''grade'', 0),
                                ''timestamp'': datetime.utcnow().isoformat(),
                                ''ttl'': int((datetime.utcnow().timestamp() + 86400 * 365))  # 1 year TTL
                            }
                        )
                
                # Send notification
                sns.publish(
                    TopicArn=''arn:aws:sns:region:account:student-updates'',
                    Message=f''Processed {len(students)} students from {key}'',
                    Subject=''Student Data Processing Complete''
                )
        
        return {
            ''statusCode'': 200,
            ''body'': json.dumps({
                ''message'': ''Successfully processed student data'',
                ''timestamp'': datetime.utcnow().isoformat()
            })
        }
        
    except Exception as e:
        # Log error and send alert
        print(f"Error processing student data: {str(e)}")
        
        sns.publish(
            TopicArn=''arn:aws:sns:region:account:alerts'',
            Message=f''Lambda function error: {str(e)}'',
            Subject=''Student Processing Error''
        )
        
        return {
            ''statusCode'': 500,
            ''body'': json.dumps({
                ''error'': ''Internal processing error'',
                ''timestamp'': datetime.utcnow().isoformat()
            })
        }

# CloudFormation template snippet
cloudformation_template = """
AWSTemplateFormatVersion: ''2010-09-09''
Description: ''Student Data Processing Architecture''

Resources:
  StudentDataBucket:
    Type: AWS::S3::Bucket
    Properties:
      BucketName: !Sub ''${AWS::StackName}-student-data''
      NotificationConfiguration:
        LambdaConfigurations:
          - Event: s3:ObjectCreated:*
            Function: !GetAtt ProcessStudentDataFunction.Arn
  
  StudentDataTable:
    Type: AWS::DynamoDB::Table
    Properties:
      TableName: Students
      BillingMode: PAY_PER_REQUEST
      AttributeDefinitions:
        - AttributeName: student_id
          AttributeType: S
      KeySchema:
        - AttributeName: student_id
          KeyType: HASH
      TimeToLiveSpecification:
        AttributeName: ttl
        Enabled: true
  
  ProcessStudentDataFunction:
    Type: AWS::Lambda::Function
    Properties:
      FunctionName: !Sub ''${AWS::StackName}-process-students''
      Runtime: python3.9
      Handler: index.lambda_handler
      Code:
        ZipFile: |
          # Lambda function code here
      Environment:
        Variables:
          STUDENT_TABLE: !Ref StudentDataTable
"""', 'Cloud architecture with AWS Lambda, DynamoDB, S3. Serverless processing, auto-scaling, cost optimization. Modern cloud-native application design.', 1, 7),
(8, 23, 'Advanced Testing Strategies', 'import pytest
import unittest.mock as mock
from unittest.mock import patch, MagicMock
import asyncio
from datetime import datetime, timedelta

class TestStudentService:
    @pytest.fixture
    def mock_database(self):
        """Mock database for testing"""
        db = MagicMock()
        db.query.return_value = [
            {''id'': 1, ''name'': ''Alice'', ''grade'': 95},
            {''id'': 2, ''name'': ''Bob'', ''grade'': 87}
        ]
        return db
    
    @pytest.fixture
    def student_service(self, mock_database):
        """Student service with mocked dependencies"""
        return StudentService(database=mock_database)
    
    def test_get_students_success(self, student_service, mock_database):
        """Test successful student retrieval"""
        # Act
        students = student_service.get_students()
        
        # Assert
        assert len(students) == 2
        assert students[0][''name''] == ''Alice''
        mock_database.query.assert_called_once()
    
    def test_get_student_by_id_not_found(self, student_service, mock_database):
        """Test student not found scenario"""
        # Arrange
        mock_database.query.return_value = []
        
        # Act & Assert
        with pytest.raises(StudentNotFoundException):
            student_service.get_student_by_id(999)
    
    @patch(''student_service.email_service'')
    def test_create_student_sends_welcome_email(self, mock_email, student_service, mock_database):
        """Test that creating a student sends welcome email"""
        # Arrange
        student_data = {''name'': ''Charlie'', ''email'': ''charlie@epitech.eu''}
        mock_database.insert.return_value = 3
        
        # Act
        student_service.create_student(student_data)
        
        # Assert
        mock_email.send_welcome_email.assert_called_once_with(
            email=''charlie@epitech.eu'',
            name=''Charlie''
        )
    
    @pytest.mark.asyncio
    async def test_async_grade_processing(self, student_service):
        """Test asynchronous grade processing"""
        # Arrange
        grades = [85, 92, 78, 95, 88]
        
        # Act
        with patch.object(student_service, ''process_grade'') as mock_process:
            mock_process.return_value = asyncio.sleep(0.1)  # Simulate async work
            await student_service.process_grades_async(grades)
        
        # Assert
        assert mock_process.call_count == len(grades)
    
    @pytest.mark.parametrize("grade,expected_letter", [
        (95, ''A''),
        (85, ''B''),
        (75, ''C''),
        (65, ''D''),
        (55, ''F'')
    ])
    def test_grade_to_letter_conversion(self, student_service, grade, expected_letter):
        """Parameterized test for grade conversion"""
        result = student_service.grade_to_letter(grade)
        assert result == expected_letter
    
    def test_concurrent_student_creation(self, student_service, mock_database):
        """Test concurrent student creation with race conditions"""
        import threading
        import time
        
        results = []
        
        def create_student_thread(student_id):
            try:
                result = student_service.create_student({
                    ''name'': f''Student {student_id}'',
                    ''email'': f''student{student_id}@epitech.eu''
                })
                results.append(result)
            except Exception as e:
                results.append(e)
        
        # Create multiple threads
        threads = []
        for i in range(10):
            thread = threading.Thread(target=create_student_thread, args=(i,))
            threads.append(thread)
            thread.start()
        
        # Wait for all threads to complete
        for thread in threads:
            thread.join()
        
        # Verify no race conditions occurred
        assert len(results) == 10
        assert all(not isinstance(r, Exception) for r in results)', 'Advanced testing strategies. Unit tests, mocks, parametrized tests, async testing, race condition testing. Comprehensive test coverage patterns.', 1, 10),
(8, 24, 'Distributed Systems Concepts', 'import hashlib
import json
import time
import threading
from typing import Dict, List, Optional

class ConsistentHashRing:
    """Consistent hashing for distributed systems"""
    
    def __init__(self, nodes: List[str], virtual_nodes: int = 150):
        self.virtual_nodes = virtual_nodes
        self.ring: Dict[int, str] = {}
        self.sorted_keys: List[int] = []
        
        for node in nodes:
            self.add_node(node)
    
    def _hash(self, key: str) -> int:
        return int(hashlib.md5(key.encode()).hexdigest(), 16)
    
    def add_node(self, node: str) -> None:
        """Add a node to the hash ring"""
        for i in range(self.virtual_nodes):
            virtual_key = f"{node}:{i}"
            hash_key = self._hash(virtual_key)
            self.ring[hash_key] = node
        
        self.sorted_keys = sorted(self.ring.keys())
    
    def remove_node(self, node: str) -> None:
        """Remove a node from the hash ring"""
        keys_to_remove = []
        for key, value in self.ring.items():
            if value == node:
                keys_to_remove.append(key)
        
        for key in keys_to_remove:
            del self.ring[key]
        
        self.sorted_keys = sorted(self.ring.keys())
    
    def get_node(self, key: str) -> str:
        """Get the node responsible for a key"""
        if not self.ring:
            return None
        
        hash_key = self._hash(key)
        
        # Find the first node clockwise
        for ring_key in self.sorted_keys:
            if hash_key <= ring_key:
                return self.ring[ring_key]
        
        # If no node found, wrap around to the first node
        return self.ring[self.sorted_keys[0]]

class DistributedCache:
    """Distributed cache with consistent hashing"""
    
    def __init__(self, nodes: List[str]):
        self.hash_ring = ConsistentHashRing(nodes)
        self.node_clients = {node: {} for node in nodes}  # Simulate node storage
        self.replication_factor = 2
    
    def put(self, key: str, value: any) -> bool:
        """Store a key-value pair with replication"""
        primary_node = self.hash_ring.get_node(key)
        if not primary_node:
            return False
        
        # Store on primary node
        self.node_clients[primary_node][key] = {
            ''value'': value,
            ''timestamp'': time.time(),
            ''version'': self._get_version(key) + 1
        }
        
        # Replicate to next N nodes
        replicas = self._get_replica_nodes(key, self.replication_factor - 1)
        for replica_node in replicas:
            self.node_clients[replica_node][key] = {
                ''value'': value,
                ''timestamp'': time.time(),
                ''version'': self._get_version(key) + 1
            }
        
        return True
    
    def get(self, key: str) -> Optional[any]:
        """Retrieve a value with read repair"""
        primary_node = self.hash_ring.get_node(key)
        if not primary_node:
            return None
        
        # Get from primary and replicas
        nodes_to_check = [primary_node] + self._get_replica_nodes(key, self.replication_factor - 1)
        
        results = []
        for node in nodes_to_check:
            if key in self.node_clients[node]:
                results.append(self.node_clients[node][key])
        
        if not results:
            return None
        
        # Find the most recent version (simple conflict resolution)
        latest = max(results, key=lambda x: x[''version''])
        
        # Read repair: update nodes with outdated versions
        for node in nodes_to_check:
            if key in self.node_clients[node]:
                if self.node_clients[node][key][''version''] < latest[''version'']:
                    self.node_clients[node][key] = latest
        
        return latest[''value'']
    
    def _get_version(self, key: str) -> int:
        """Get current version of a key"""
        primary_node = self.hash_ring.get_node(key)
        if primary_node and key in self.node_clients[primary_node]:
            return self.node_clients[primary_node][key][''version'']
        return 0
    
    def _get_replica_nodes(self, key: str, count: int) -> List[str]:
        """Get replica nodes for a key"""
        primary_node = self.hash_ring.get_node(key)
        all_nodes = list(self.node_clients.keys())
        
        if primary_node not in all_nodes:
            return []
        
        primary_index = all_nodes.index(primary_node)
        replicas = []
        
        for i in range(1, count + 1):
            replica_index = (primary_index + i) % len(all_nodes)
            replicas.append(all_nodes[replica_index])
        
        return replicas', 'Distributed systems fundamentals. Consistent hashing, data replication, conflict resolution, read repair. Core concepts for scalable architectures.', 1, 7),
(8, 25, 'Competitive Programming', '#include <iostream>
#include <vector>
#include <algorithm>
#include <unordered_map>
#include <queue>
#include <climits>

using namespace std;

// Fast I/O for competitive programming
static auto speedup = []() {
    ios_base::sync_with_stdio(false);
    cin.tie(nullptr);
    return 0;
}();

// Dijkstra''s algorithm for shortest path
class Solution {
public:
    vector<int> dijkstra(vector<vector<pair<int, int>>>& graph, int start) {
        int n = graph.size();
        vector<int> dist(n, INT_MAX);
        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<>> pq;
        
        dist[start] = 0;
        pq.push({0, start});
        
        while (!pq.empty()) {
            auto [d, u] = pq.top();
            pq.pop();
            
            if (d > dist[u]) continue;
            
            for (auto [v, w] : graph[u]) {
                if (dist[u] + w < dist[v]) {
                    dist[v] = dist[u] + w;
                    pq.push({dist[v], v});
                }
            }
        }
        
        return dist;
    }
    
    // Union-Find (Disjoint Set Union)
    class UnionFind {
    public:
        vector<int> parent, rank;
        
        UnionFind(int n) : parent(n), rank(n, 0) {
            for (int i = 0; i < n; i++) parent[i] = i;
        }
        
        int find(int x) {
            if (parent[x] != x) {
                parent[x] = find(parent[x]);  // Path compression
            }
            return parent[x];
        }
        
        bool unite(int x, int y) {
            int px = find(x), py = find(y);
            if (px == py) return false;
            
            // Union by rank
            if (rank[px] < rank[py]) {
                parent[px] = py;
            } else if (rank[px] > rank[py]) {
                parent[py] = px;
            } else {
                parent[py] = px;
                rank[px]++;
            }
            return true;
        }
    };
    
    // Segment tree for range queries
    class SegmentTree {
        vector<int> tree, lazy;
        int n;
        
    public:
        SegmentTree(vector<int>& arr) {
            n = arr.size();
            tree.resize(4 * n);
            lazy.resize(4 * n);
            build(arr, 1, 0, n - 1);
        }
        
        void build(vector<int>& arr, int node, int start, int end) {
            if (start == end) {
                tree[node] = arr[start];
            } else {
                int mid = (start + end) / 2;
                build(arr, 2 * node, start, mid);
                build(arr, 2 * node + 1, mid + 1, end);
                tree[node] = tree[2 * node] + tree[2 * node + 1];
            }
        }
        
        int query(int node, int start, int end, int l, int r) {
            if (r < start || end < l) return 0;
            if (l <= start && end <= r) return tree[node];
            
            int mid = (start + end) / 2;
            return query(2 * node, start, mid, l, r) +
                   query(2 * node + 1, mid + 1, end, l, r);
        }
        
        int query(int l, int r) {
            return query(1, 0, n - 1, l, r);
        }
    };
};', 'Competitive programming algorithms. Dijkstra''s shortest path, Union-Find with path compression, Segment tree for range queries. Contest preparation essentials.', 3, 4),
(8, 26, 'Mobile App Development', 'import React, { useState, useEffect } from ''react'';
import { 
    View, 
    Text, 
    TextInput, 
    TouchableOpacity, 
    FlatList, 
    StyleSheet, 
    Alert,
    AsyncStorage 
} from ''react-native'';
import { LinearGradient } from ''expo-linear-gradient'';

const StudentGradeApp = () => {
    const [students, setStudents] = useState([]);
    const [name, setName] = useState('''');
    const [grade, setGrade] = useState('''');
    const [loading, setLoading] = useState(false);
    
    useEffect(() => {
        loadStudents();
    }, []);
    
    const loadStudents = async () => {
        try {
            const storedStudents = await AsyncStorage.getItem(''students'');
            if (storedStudents) {
                setStudents(JSON.parse(storedStudents));
            }
        } catch (error) {
            console.error(''Error loading students:'', error);
        }
    };
    
    const saveStudents = async (updatedStudents) => {
        try {
            await AsyncStorage.setItem(''students'', JSON.stringify(updatedStudents));
        } catch (error) {
            console.error(''Error saving students:'', error);
        }
    };
    
    const addStudent = () => {
        if (!name.trim() || !grade.trim()) {
            Alert.alert(''Error'', ''Please enter both name and grade'');
            return;
        }
        
        const numericGrade = parseFloat(grade);
        if (isNaN(numericGrade) || numericGrade < 0 || numericGrade > 20) {
            Alert.alert(''Error'', ''Grade must be between 0 and 20'');
            return;
        }
        
        const newStudent = {
            id: Date.now().toString(),
            name: name.trim(),
            grade: numericGrade,
            timestamp: new Date().toLocaleDateString()
        };
        
        const updatedStudents = [...students, newStudent];
        setStudents(updatedStudents);
        saveStudents(updatedStudents);
        
        // Reset form
        setName('''');
        setGrade('''');
    };
    
    const deleteStudent = (id) => {
        Alert.alert(
            ''Delete Student'',
            ''Are you sure you want to delete this student?'',
            [
                { text: ''Cancel'', style: ''cancel'' },
                {
                    text: ''Delete'',
                    style: ''destructive'',
                    onPress: () => {
                        const updatedStudents = students.filter(s => s.id !== id);
                        setStudents(updatedStudents);
                        saveStudents(updatedStudents);
                    }
                }
            ]
        );
    };
    
    const getGradeColor = (grade) => {
        if (grade >= 16) return ''#4CAF50'';  // Green
        if (grade >= 14) return ''#2196F3'';  // Blue
        if (grade >= 12) return ''#FF9800'';  // Orange
        if (grade >= 10) return ''#FFC107'';  // Amber
        return ''#F44336'';  // Red
    };
    
    const renderStudent = ({ item }) => (
        <View style={styles.studentCard}>
            <View style={styles.studentInfo}>
                <Text style={styles.studentName}>{item.name}</Text>
                <Text style={styles.studentDate}>{item.timestamp}</Text>
            </View>
            <View style={styles.gradeContainer}>
                <View style={[styles.gradeBadge, { backgroundColor: getGradeColor(item.grade) }]}>
                    <Text style={styles.gradeText}>{item.grade}/20</Text>
                </View>
                <TouchableOpacity 
                    style={styles.deleteButton}
                    onPress={() => deleteStudent(item.id)}
                >
                    <Text style={styles.deleteText}>×</Text>
                </TouchableOpacity>
            </View>
        </View>
    );
    
    const averageGrade = students.length > 0 
        ? (students.reduce((sum, s) => sum + s.grade, 0) / students.length).toFixed(1)
        : 0;
    
    return (
        <LinearGradient colors={[''#667eea'', ''#764ba2'']} style={styles.container}>
            <View style={styles.header}>
                <Text style={styles.title}>Student Grades</Text>
                <Text style={styles.subtitle}>Average: {averageGrade}/20</Text>
            </View>
            
            <View style={styles.form}>
                <TextInput
                    style={styles.input}
                    placeholder="Student Name"
                    placeholderTextColor="#999"
                    value={name}
                    onChangeText={setName}
                />
                <TextInput
                    style={styles.input}
                    placeholder="Grade (0-20)"
                    placeholderTextColor="#999"
                    value={grade}
                    onChangeText={setGrade}
                    keyboardType="numeric"
                />
                <TouchableOpacity style={styles.addButton} onPress={addStudent}>
                    <Text style={styles.addButtonText}>Add Student</Text>
                </TouchableOpacity>
            </View>
            
            <FlatList
                data={students}
                keyExtractor={(item) => item.id}
                renderItem={renderStudent}
                style={styles.list}
                showsVerticalScrollIndicator={false}
            />
        </LinearGradient>
    );
};

const styles = StyleSheet.create({
    container: {
        flex: 1,
        padding: 20,
        paddingTop: 50
    },
    header: {
        alignItems: ''center'',
        marginBottom: 30
    },
    title: {
        fontSize: 28,
        fontWeight: ''bold'',
        color: ''white'',
        marginBottom: 5
    },
    subtitle: {
        fontSize: 16,
        color: ''rgba(255,255,255,0.8)''
    },
    form: {
        marginBottom: 20
    },
    input: {
        backgroundColor: ''rgba(255,255,255,0.9)'',
        borderRadius: 10,
        padding: 15,
        fontSize: 16,
        marginBottom: 10
    },
    addButton: {
        backgroundColor: ''#4CAF50'',
        borderRadius: 10,
        padding: 15,
        alignItems: ''center''
    },
    addButtonText: {
        color: ''white'',
        fontSize: 16,
        fontWeight: ''bold''
    },
    list: {
        flex: 1
    },
    studentCard: {
        backgroundColor: ''rgba(255,255,255,0.95)'',
        borderRadius: 10,
        padding: 15,
        marginBottom: 10,
        flexDirection: ''row'',
        justifyContent: ''space-between'',
        alignItems: ''center''
    },
    studentInfo: {
        flex: 1
    },
    studentName: {
        fontSize: 18,
        fontWeight: ''600'',
        color: ''#333''
    },
    studentDate: {
        fontSize: 14,
        color: ''#666'',
        marginTop: 2
    },
    gradeContainer: {
        flexDirection: ''row'',
        alignItems: ''center''
    },
    gradeBadge: {
        borderRadius: 20,
        paddingHorizontal: 12,
        paddingVertical: 6,
        marginRight: 10
    },
    gradeText: {
        color: ''white'',
        fontWeight: ''bold'',
        fontSize: 14
    },
    deleteButton: {
        backgroundColor: ''#F44336'',
        borderRadius: 15,
        width: 30,
        height: 30,
        justifyContent: ''center'',
        alignItems: ''center''
    },
    deleteText: {
        color: ''white'',
        fontSize: 18,
        fontWeight: ''bold''
    }
});

export default StudentGradeApp;', 'React Native mobile app for student grade management. Local storage, form validation, gradient UI, touch interactions. Cross-platform development skills.', 5, 9),
(8, 27, 'API Rate Limiting Advanced', 'import redis
import time
import json
from datetime import datetime, timedelta
from flask import Flask, request, jsonify, g
from functools import wraps
from typing import Optional, Dict, Any

class AdvancedRateLimiter:
    def __init__(self, redis_client):
        self.redis = redis_client
        
    def token_bucket(self, key: str, max_tokens: int, refill_rate: float, 
                     tokens_requested: int = 1) -> Dict[str, Any]:
        """Token bucket algorithm implementation"""
        now = time.time()
        pipeline = self.redis.pipeline()
        
        # Get current bucket state
        bucket_key = f"bucket:{key}"
        pipeline.hmget(bucket_key, ''tokens'', ''last_refill'')
        pipeline.expire(bucket_key, 3600)  # Expire after 1 hour
        results = pipeline.execute()
        
        bucket_data = results[0]
        
        if bucket_data[0] is None:
            # Initialize bucket
            tokens = max_tokens - tokens_requested
            if tokens >= 0:
                pipeline = self.redis.pipeline()
                pipeline.hmset(bucket_key, {''tokens'': tokens, ''last_refill'': now})
                pipeline.expire(bucket_key, 3600)
                pipeline.execute()
                return {''allowed'': True, ''tokens_remaining'': tokens, ''retry_after'': 0}
            else:
                return {''allowed'': False, ''tokens_remaining'': 0, ''retry_after'': 60}
        
        current_tokens = float(bucket_data[0])
        last_refill = float(bucket_data[1])
        
        # Calculate tokens to add
        time_passed = now - last_refill
        tokens_to_add = time_passed * refill_rate
        current_tokens = min(max_tokens, current_tokens + tokens_to_add)
        
        if current_tokens >= tokens_requested:
            # Allow request
            current_tokens -= tokens_requested
            pipeline = self.redis.pipeline()
            pipeline.hmset(bucket_key, {''tokens'': current_tokens, ''last_refill'': now})
            pipeline.expire(bucket_key, 3600)
            pipeline.execute()
            
            return {
                ''allowed'': True,
                ''tokens_remaining'': int(current_tokens),
                ''retry_after'': 0
            }
        else:
            # Deny request
            tokens_needed = tokens_requested - current_tokens
            retry_after = int(tokens_needed / refill_rate)
            
            # Update last_refill even for denied requests
            pipeline = self.redis.pipeline()
            pipeline.hset(bucket_key, ''last_refill'', now)
            pipeline.expire(bucket_key, 3600)
            pipeline.execute()
            
            return {
                ''allowed'': False,
                ''tokens_remaining'': int(current_tokens),
                ''retry_after'': retry_after
            }
    
    def sliding_window_log(self, key: str, window_seconds: int, 
                          max_requests: int) -> Dict[str, Any]:
        """Sliding window log algorithm"""
        now = time.time()
        window_start = now - window_seconds
        
        log_key = f"log:{key}"
        pipeline = self.redis.pipeline()
        
        # Remove old entries
        pipeline.zremrangebyscore(log_key, 0, window_start)
        
        # Count current requests
        pipeline.zcard(log_key)
        
        # Add current request
        pipeline.zadd(log_key, {str(now): now})
        
        # Set expiration
        pipeline.expire(log_key, window_seconds + 1)
        
        results = pipeline.execute()
        current_requests = results[1]
        
        if current_requests < max_requests:
            return {
                ''allowed'': True,
                ''requests_remaining'': max_requests - current_requests - 1,
                ''reset_time'': int(now + window_seconds)
            }
        else:
            # Remove the request we just added since it''s not allowed
            self.redis.zrem(log_key, str(now))
            
            # Find when the oldest request will expire
            oldest_requests = self.redis.zrange(log_key, 0, 0, withscores=True)
            if oldest_requests:
                reset_time = int(oldest_requests[0][1] + window_seconds)
            else:
                reset_time = int(now + window_seconds)
            
            return {
                ''allowed'': False,
                ''requests_remaining'': 0,
                ''reset_time'': reset_time,
                ''retry_after'': reset_time - int(now)
            }
    
    def fixed_window_counter(self, key: str, window_seconds: int, 
                           max_requests: int) -> Dict[str, Any]:
        """Fixed window counter algorithm"""
        now = time.time()
        window = int(now // window_seconds)
        
        counter_key = f"counter:{key}:{window}"
        
        pipeline = self.redis.pipeline()
        pipeline.incr(counter_key)
        pipeline.expire(counter_key, window_seconds)
        results = pipeline.execute()
        
        current_requests = results[0]
        
        if current_requests <= max_requests:
            next_reset = (window + 1) * window_seconds
            return {
                ''allowed'': True,
                ''requests_remaining'': max_requests - current_requests,
                ''reset_time'': int(next_reset)
            }
        else:
            next_reset = (window + 1) * window_seconds
            return {
                ''allowed'': False,
                ''requests_remaining'': 0,
                ''reset_time'': int(next_reset),
                ''retry_after'': int(next_reset - now)
            }

# Flask application with advanced rate limiting
app = Flask(__name__)
redis_client = redis.Redis(host=''localhost'', port=6379, db=0)
rate_limiter = AdvancedRateLimiter(redis_client)

def rate_limit(algorithm: str = ''token_bucket'', **kwargs):
    """Rate limiting decorator"""
    def decorator(f):
        @wraps(f)
        def decorated_function(*args, **kwargs_inner):
            # Get client identifier
            client_id = request.headers.get(''X-Client-ID'') or request.remote_addr
            
            # Get user tier for different limits
            user_tier = request.headers.get(''X-User-Tier'', ''free'')
            
            # Adjust limits based on user tier
            if user_tier == ''premium'':
                kwargs[''max_tokens''] = kwargs.get(''max_tokens'', 100) * 5
                kwargs[''max_requests''] = kwargs.get(''max_requests'', 100) * 5
            elif user_tier == ''pro'':
                kwargs[''max_tokens''] = kwargs.get(''max_tokens'', 100) * 2
                kwargs[''max_requests''] = kwargs.get(''max_requests'', 100) * 2
            
            # Apply rate limiting
            if algorithm == ''token_bucket'':
                result = rate_limiter.token_bucket(
                    key=f"{f.__name__}:{client_id}",
                    max_tokens=kwargs.get(''max_tokens'', 100),
                    refill_rate=kwargs.get(''refill_rate'', 10)
                )
            elif algorithm == ''sliding_window'':
                result = rate_limiter.sliding_window_log(
                    key=f"{f.__name__}:{client_id}",
                    window_seconds=kwargs.get(''window_seconds'', 3600),
                    max_requests=kwargs.get(''max_requests'', 100)
                )
            elif algorithm == ''fixed_window'':
                result = rate_limiter.fixed_window_counter(
                    key=f"{f.__name__}:{client_id}",
                    window_seconds=kwargs.get(''window_seconds'', 3600),
                    max_requests=kwargs.get(''max_requests'', 100)
                )
            else:
                return jsonify({''error'': ''Unknown rate limiting algorithm''}), 500
            
            if not result[''allowed'']:
                response = jsonify({
                    ''error'': ''Rate limit exceeded'',
                    ''retry_after'': result.get(''retry_after'', 60)
                })
                response.status_code = 429
                response.headers[''Retry-After''] = str(result.get(''retry_after'', 60))
                return response
            
            # Add rate limit headers
            response = f(*args, **kwargs_inner)
            if hasattr(response, ''headers''):
                response.headers[''X-RateLimit-Remaining''] = str(result.get(''tokens_remaining'', result.get(''requests_remaining'', 0)))
                if ''reset_time'' in result:
                    response.headers[''X-RateLimit-Reset''] = str(result[''reset_time''])
            
            return response
        return decorated_function
    return decorator

# Example endpoints with different rate limiting strategies
@app.route(''/api/search'')
@rate_limit(algorithm=''token_bucket'', max_tokens=1000, refill_rate=10)
def search():
    return jsonify({''results'': [''result1'', ''result2'']})

@app.route(''/api/upload'')
@rate_limit(algorithm=''sliding_window'', window_seconds=3600, max_requests=10)
def upload():
    return jsonify({''status'': ''uploaded''})

@app.route(''/api/data'')
@rate_limit(algorithm=''fixed_window'', window_seconds=60, max_requests=100)
def get_data():
    return jsonify({''data'': ''some data''})', 'Advanced API rate limiting with multiple algorithms. Token bucket, sliding window, fixed window. Redis-based, user tiers, comprehensive headers. Production-ready implementation.', 1, 8),
(8, 28, 'Data Engineering Pipeline', 'import pandas as pd
from sqlalchemy import create_engine
import logging
from datetime import datetime

class DataPipeline:
    def __init__(self, db_url):
        self.engine = create_engine(db_url)
        logging.basicConfig(level=logging.INFO)
        self.logger = logging.getLogger(__name__)
    
    def extract(self, source_path):
        """Extract data from CSV"""
        self.logger.info(f"Extracting from {source_path}")
        df = pd.read_csv(source_path)
        return df
    
    def transform(self, df):
        """Clean and transform data"""
        self.logger.info("Starting transformation")
        
        # Remove duplicates and nulls
        df = df.drop_duplicates()
        df = df.dropna(subset=[''student_id'', ''grade''])
        
        # Grade validation
        df = df[df[''grade''].between(0, 20)]
        
        # Add grade categories
        df[''grade_level''] = pd.cut(
            df[''grade''], 
            bins=[0, 8, 12, 16, 20],
            labels=[''F'', ''D'', ''C'', ''A'']
        )
        
        # Date processing
        df[''processed_date''] = datetime.now()
        
        self.logger.info(f"Transformed {len(df)} records")
        return df
    
    def load(self, df, table_name):
        """Load to database"""
        try:
            df.to_sql(
                table_name,
                self.engine,
                if_exists=''replace'',
                index=False
            )
            self.logger.info(f"Loaded {len(df)} records to {table_name}")
            return True
        except Exception as e:
            self.logger.error(f"Load failed: {e}")
            return False
    
    def run_etl(self, source, target_table):
        """Execute complete ETL pipeline"""
        try:
            # Extract
            raw_data = self.extract(source)
            
            # Transform
            clean_data = self.transform(raw_data)
            
            # Load
            success = self.load(clean_data, target_table)
            
            if success:
                self.logger.info("ETL pipeline finished successfully")
            else:
                self.logger.error("ETL pipeline failed")
                
            return success
            
        except Exception as e:
            self.logger.error(f"ETL pipeline error: {e}")
            return False

# Usage example
if __name__ == "__main__":
    pipeline = DataPipeline(''postgresql://user:pass@localhost/warehouse'')
    result = pipeline.run_etl(''/data/students.csv'', ''student_data'')
    print("ETL finished:", "success" if result else "failed")', 'Data engineering ETL pipeline. Extract from CSV, transform with pandas, load to database. Error handling, logging, data validation. Core data processing workflow.', 1, 4),
(8, 29, 'Cybersecurity Fundamentals', 'import hashlib
import secrets
import hmac
import base64
from cryptography.fernet import Fernet
from cryptography.hazmat.primitives import hashes, serialization
from cryptography.hazmat.primitives.asymmetric import rsa, padding
from cryptography.hazmat.primitives.kdf.pbkdf2 import PBKDF2HMAC
import os
from typing import Tuple, Dict, Any
import json
import time

class CyberSecurityToolkit:
    def __init__(self):
        self.symmetric_key = None
        self.private_key = None
        self.public_key = None
    
    # Password Security
    def hash_password(self, password: str, salt: bytes = None) -> Tuple[str, str]:
        """Securely hash a password using PBKDF2"""
        if salt is None:
            salt = os.urandom(32)  # 32 bytes = 256 bits
        
        # Use PBKDF2 with SHA-256
        kdf = PBKDF2HMAC(
            algorithm=hashes.SHA256(),
            length=32,
            salt=salt,
            iterations=100000,  # OWASP recommended minimum
        )
        key = kdf.derive(password.encode())
        
        # Return both the hash and salt (base64 encoded)
        return (
            base64.b64encode(key).decode(),
            base64.b64encode(salt).decode()
        )
    
    def verify_password(self, password: str, stored_hash: str, stored_salt: str) -> bool:
        """Verify a password against its hash"""
        try:
            salt = base64.b64decode(stored_salt.encode())
            expected_hash, _ = self.hash_password(password, salt)
            return hmac.compare_digest(expected_hash, stored_hash)
        except Exception:
            return False
    
    # Symmetric Encryption
    def generate_symmetric_key(self) -> str:
        """Generate a new symmetric encryption key"""
        key = Fernet.generate_key()
        self.symmetric_key = key
        return base64.b64encode(key).decode()
    
    def encrypt_data(self, data: str, key: str = None) -> str:
        """Encrypt data using symmetric encryption"""
        if key:
            cipher_key = base64.b64decode(key.encode())
        elif self.symmetric_key:
            cipher_key = self.symmetric_key
        else:
            raise ValueError("No encryption key provided")
        
        fernet = Fernet(cipher_key)
        encrypted_data = fernet.encrypt(data.encode())
        return base64.b64encode(encrypted_data).decode()
    
    def decrypt_data(self, encrypted_data: str, key: str = None) -> str:
        """Decrypt data using symmetric encryption"""
        if key:
            cipher_key = base64.b64decode(key.encode())
        elif self.symmetric_key:
            cipher_key = self.symmetric_key
        else:
            raise ValueError("No decryption key provided")
        
        fernet = Fernet(cipher_key)
        encrypted_bytes = base64.b64decode(encrypted_data.encode())
        decrypted_data = fernet.decrypt(encrypted_bytes)
        return decrypted_data.decode()
    
    # Asymmetric Encryption (RSA)
    def generate_rsa_keypair(self, key_size: int = 2048) -> Tuple[str, str]:
        """Generate RSA public/private key pair"""
        self.private_key = rsa.generate_private_key(
            public_exponent=65537,
            key_size=key_size
        )
        self.public_key = self.private_key.public_key()
        
        # Serialize keys
        private_pem = self.private_key.private_bytes(
            encoding=serialization.Encoding.PEM,
            format=serialization.PrivateFormat.PKCS8,
            encryption_algorithm=serialization.NoEncryption()
        )
        
        public_pem = self.public_key.public_bytes(
            encoding=serialization.Encoding.PEM,
            format=serialization.PublicFormat.SubjectPublicKeyInfo
        )
        
        return (
            base64.b64encode(private_pem).decode(),
            base64.b64encode(public_pem).decode()
        )
    
    def rsa_encrypt(self, data: str, public_key_b64: str) -> str:
        """Encrypt data with RSA public key"""
        public_key_bytes = base64.b64decode(public_key_b64.encode())
        public_key = serialization.load_pem_public_key(public_key_bytes)
        
        encrypted = public_key.encrypt(
            data.encode(),
            padding.OAEP(
                mgf=padding.MGF1(algorithm=hashes.SHA256()),
                algorithm=hashes.SHA256(),
                label=None
            )
        )
        
        return base64.b64encode(encrypted).decode()
    
    def rsa_decrypt(self, encrypted_data: str, private_key_b64: str) -> str:
        """Decrypt data with RSA private key"""
        private_key_bytes = base64.b64decode(private_key_b64.encode())
        private_key = serialization.load_pem_private_key(
            private_key_bytes, 
            password=None
        )
        
        encrypted_bytes = base64.b64decode(encrypted_data.encode())
        
        decrypted = private_key.decrypt(
            encrypted_bytes,
            padding.OAEP(
                mgf=padding.MGF1(algorithm=hashes.SHA256()),
                algorithm=hashes.SHA256(),
                label=None
            )
        )
        
        return decrypted.decode()
    
    # Digital Signatures
    def sign_data(self, data: str, private_key_b64: str) -> str:
        """Create digital signature for data"""
        private_key_bytes = base64.b64decode(private_key_b64.encode())
        private_key = serialization.load_pem_private_key(
            private_key_bytes, 
            password=None
        )
        
        signature = private_key.sign(
            data.encode(),
            padding.PSS(
                mgf=padding.MGF1(hashes.SHA256()),
                salt_length=padding.PSS.MAX_LENGTH
            ),
            hashes.SHA256()
        )
        
        return base64.b64encode(signature).decode()
    
    def verify_signature(self, data: str, signature_b64: str, public_key_b64: str) -> bool:
        """Verify digital signature"""
        try:
            public_key_bytes = base64.b64decode(public_key_b64.encode())
            public_key = serialization.load_pem_public_key(public_key_bytes)
            
            signature_bytes = base64.b64decode(signature_b64.encode())
            
            public_key.verify(
                signature_bytes,
                data.encode(),
                padding.PSS(
                    mgf=padding.MGF1(hashes.SHA256()),
                    salt_length=padding.PSS.MAX_LENGTH
                ),
                hashes.SHA256()
            )
            return True
        except Exception:
            return False
    
    # Secure Random Generation
    def generate_secure_token(self, length: int = 32) -> str:
        """Generate cryptographically secure random token"""
        return secrets.token_urlsafe(length)
    
    def generate_secure_password(self, length: int = 16) -> str:
        """Generate secure password with mixed character types"""
        alphabet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()_+-=[]{}|;:,.<>?"
        return ''''.join(secrets.choice(alphabet) for _ in range(length))
    
    # Hash Functions for Data Integrity
    def calculate_file_hash(self, file_path: str, algorithm: str = ''sha256'') -> str:
        """Calculate hash of a file for integrity checking"""
        hash_obj = hashlib.new(algorithm)
        
        with open(file_path, ''rb'') as f:
            for chunk in iter(lambda: f.read(8192), b""):
                hash_obj.update(chunk)
        
        return hash_obj.hexdigest()
    
    def calculate_hmac(self, data: str, key: str, algorithm: str = ''sha256'') -> str:
        """Calculate HMAC for message authentication"""
        return hmac.new(
            key.encode(), 
            data.encode(), 
            getattr(hashlib, algorithm)
        ).hexdigest()
    
    # Security Audit Functions
    def audit_password_strength(self, password: str) -> Dict[str, Any]:
        """Audit password strength and provide recommendations"""
        score = 0
        feedback = []
        
        # Length check
        if len(password) >= 12:
            score += 25
        elif len(password) >= 8:
            score += 15
            feedback.append("Consider using a longer password (12+ characters)")
        else:
            feedback.append("Password too short (minimum 8 characters)")
        
        # Character variety checks
        if any(c.islower() for c in password):
            score += 15
        else:
            feedback.append("Add lowercase letters")
        
        if any(c.isupper() for c in password):
            score += 15
        else:
            feedback.append("Add uppercase letters")
        
        if any(c.isdigit() for c in password):
            score += 15
        else:
            feedback.append("Add numbers")
        
        if any(c in "!@#$%^&*()_+-=[]{}|;:,.<>?" for c in password):
            score += 20
        else:
            feedback.append("Add special characters")
        
        # Common patterns check (simplified)
        common_patterns = [''123'', ''abc'', ''password'', ''admin'']
        if any(pattern in password.lower() for pattern in common_patterns):
            score -= 20
            feedback.append("Avoid common patterns and words")
        
        # Determine strength level
        if score >= 80:
            strength = "Strong"
        elif score >= 60:
            strength = "Moderate"
        elif score >= 40:
            strength = "Weak"
        else:
            strength = "Very Weak"
        
        return {
            ''score'': max(0, score),
            ''strength'': strength,
            ''feedback'': feedback,
            ''meets_minimum_requirements'': score >= 60
        }

# Example usage and demonstration
if __name__ == "__main__":
    toolkit = CyberSecurityToolkit()
    
    print("=== Cybersecurity Toolkit Demo ===")
    
    # Password hashing demo
    print("\
1. Password Hashing:")
    password = "MySecurePassword123!"
    hashed_pw, salt = toolkit.hash_password(password)
    print(f"Password: {password}")
    print(f"Hash: {hashed_pw[:20]}...")
    print(f"Verification: {toolkit.verify_password(password, hashed_pw, salt)}")
    
    # Symmetric encryption demo
    print("\
2. Symmetric Encryption:")
    key = toolkit.generate_symmetric_key()
    message = "This is a secret message from Epitech Nancy!"
    encrypted = toolkit.encrypt_data(message)
    decrypted = toolkit.decrypt_data(encrypted)
    print(f"Original: {message}")
    print(f"Encrypted: {encrypted[:30]}...")
    print(f"Decrypted: {decrypted}")
    
    # RSA encryption demo
    print("\
3. RSA Encryption:")
    private_key_b64, public_key_b64 = toolkit.generate_rsa_keypair()
    rsa_message = "RSA encrypted message"
    rsa_encrypted = toolkit.rsa_encrypt(rsa_message, public_key_b64)
    rsa_decrypted = toolkit.rsa_decrypt(rsa_encrypted, private_key_b64)
    print(f"Original: {rsa_message}")
    print(f"RSA Decrypted: {rsa_decrypted}")
    
    # Digital signature demo
    print("\
4. Digital Signatures:")
    document = "This document is authentic."
    signature = toolkit.sign_data(document, private_key_b64)
    is_valid = toolkit.verify_signature(document, signature, public_key_b64)
    print(f"Document: {document}")
    print(f"Signature valid: {is_valid}")
    
    # Password audit demo
    print("\
5. Password Audit:")
    test_passwords = ["123456", "Password1", "MyStr0ng!P@ssw0rd2024"]
    for pwd in test_passwords:
        audit = toolkit.audit_password_strength(pwd)
        print(f"Password: {pwd}")
        print(f"Strength: {audit[''strength'']} (Score: {audit[''score'']}/100)")
        if audit[''feedback'']:
            print(f"Feedback: {'', ''.join(audit[''feedback''][:2])}")
        print()', 'Comprehensive cybersecurity toolkit. Password hashing, symmetric/asymmetric encryption, digital signatures, secure random generation, password auditing. Production-ready security functions.', 1, 8),
(8, 30, 'Portfolio Project Demo', '# Student Portfolio Project - Code Snippet Learning Platform

## Project Overview
**Duration**: Summer 2024 (8 weeks)
**Role**: Full-Stack Developer
**Technologies**: React, Node.js, PostgreSQL, Docker, AWS

## Key Features Implemented

### Frontend (React + TypeScript)
```typescript
interface CodeSnippet {
  id: string;
  title: string;
  code: string;
  explanation: string;
  language: string;
  difficulty: ''beginner'' | ''intermediate'' | ''advanced'';
  createdAt: Date;
}

const SnippetCard: React.FC<{ snippet: CodeSnippet }> = ({ snippet }) => {
  const [isBookmarked, setIsBookmarked] = useState(false);
  
  return (
    <Card className="snippet-card">
      <CardHeader>
        <h3>{snippet.title}</h3>
        <Badge variant={getDifficultyVariant(snippet.difficulty)}>
          {snippet.difficulty}
        </Badge>
      </CardHeader>
      <CardContent>
        <SyntaxHighlighter language={snippet.language}>
          {snippet.code}
        </SyntaxHighlighter>
        <p>{snippet.explanation}</p>
      </CardContent>
    </Card>
  );
};
```

### Backend API (Node.js + Express)
```javascript
const express = require(''express'');
const { body, validationResult } = require(''express-validator'');
const rateLimit = require(''express-rate-limit'');

// Rate limiting
const apiLimiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100 // limit each IP to 100 requests per windowMs
});

app.use(''/api/'', apiLimiter);

// Get daily snippet
app.get(''/api/snippets/daily'', async (req, res) => {
  try {
    const today = new Date();
    const month = today.getMonth() + 1;
    const day = today.getDate();
    
    const snippet = await db.query(
      ''SELECT * FROM snippets WHERE month = $1 AND day = $2'',
      [month, day]
    );
    
    if (snippet.rows.length === 0) {
      return res.status(404).json({ error: ''No snippet found for today'' });
    }
    
    res.json(snippet.rows[0]);
  } catch (error) {
    res.status(500).json({ error: ''Internal server error'' });
  }
});
```

### Database Schema (PostgreSQL)
```sql
CREATE TABLE programming_languages (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    color VARCHAR(7) NOT NULL -- Hex color for UI
);

CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    description TEXT
);

CREATE TABLE snippets (
    id SERIAL PRIMARY KEY,
    month INTEGER NOT NULL CHECK (month BETWEEN 1 AND 12),
    day INTEGER NOT NULL CHECK (day BETWEEN 1 AND 31),
    title VARCHAR(200) NOT NULL,
    code TEXT NOT NULL,
    explanation TEXT NOT NULL,
    language_id INTEGER REFERENCES programming_languages(id),
    category_id INTEGER REFERENCES categories(id),
    difficulty VARCHAR(20) DEFAULT ''beginner'',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(month, day)
);

-- Indexes for performance
CREATE INDEX idx_snippets_date ON snippets(month, day);
CREATE INDEX idx_snippets_language ON snippets(language_id);
```

### DevOps & Deployment
```yaml
# docker-compose.yml
version: ''3.8''
services:
  frontend:
    build: ./frontend
    ports:
      - "3000:3000"
    environment:
      - REACT_APP_API_URL=http://localhost:8000
    
  backend:
    build: ./backend
    ports:
      - "8000:8000"
    environment:
      - DATABASE_URL=postgres://user:pass@db:5432/snippets
      - JWT_SECRET=your-secret-here
    depends_on:
      - db
    
  db:
    image: postgres:13
    environment:
      POSTGRES_DB: snippets
      POSTGRES_USER: user
      POSTGRES_PASSWORD: pass
    volumes:
      - postgres_data:/var/lib/postgresql/data

volumes:
  postgres_data:
```

## Technical Achievements

### Performance Optimization
- **Lighthouse Score**: 96/100
- **First Contentful Paint**: < 1.5s
- **Largest Contentful Paint**: < 2.5s
- **Database Query Optimization**: 40ms average response time

### Testing Strategy
```javascript
// Jest unit tests
describe(''Snippet API'', () => {
  test(''should return daily snippet'', async () => {
    const response = await request(app)
      .get(''/api/snippets/daily'')
      .expect(200);
    
    expect(response.body).toHaveProperty(''title'');
    expect(response.body).toHaveProperty(''code'');
    expect(response.body.code.length).toBeLessThanOrEqual(800);
  });
});

// Cypress E2E tests
describe(''User Journey'', () => {
  it(''should display daily snippet'', () => {
    cy.visit(''/dashboard'');
    cy.contains(''Today''''s Snippet'');
    cy.get(''[data-testid="snippet-card"]'').should(''be.visible'');
  });
});
```

### Security Implementation
- JWT authentication with refresh tokens
- Rate limiting (100 requests/15 minutes)
- Input validation and sanitization
- SQL injection prevention with parameterized queries
- CORS configuration for production
- Security headers with Helmet.js

## Learning Outcomes

1. **Full-Stack Development**: Gained experience with modern React patterns, Node.js best practices, and PostgreSQL optimization

2. **DevOps Skills**: Implemented CI/CD with GitHub Actions, containerization with Docker, and AWS deployment

3. **Testing**: Achieved 85% code coverage with unit, integration, and E2E tests

4. **Performance**: Optimized bundle size (< 200KB), implemented code splitting, and database indexing

5. **Security**: Applied OWASP guidelines, implemented authentication, and secured API endpoints

## Metrics & Results
- **Daily Active Users**: 200+ (during beta)
- **Code Coverage**: 85%
- **Performance Score**: 96/100 Lighthouse
- **Security Score**: A+ (Mozilla Observatory)
- **Load Time**: < 2 seconds on 3G

## Next Steps
- Mobile app development (React Native)
- AI-powered code suggestions
- Community features (comments, ratings)
- Advanced analytics dashboard

**Live Demo**: https://code-snippets-daily.vercel.app
**GitHub**: https://github.com/username/daily-code-snippets

---

*This project demonstrates full-stack development capabilities, DevOps knowledge, and attention to performance and security - ready for internship and entry-level positions!*', 'Portfolio project showcase for internships. Complete full-stack application with modern technologies. Performance metrics, security implementation, testing strategy. Professional presentation format.', 16, 7),
(8, 31, 'September Preparation', '#include <stdio.h>

int main() {
    printf("Back to Epitech Nancy!\\n\\n");
    
    char* goals[] = {
        "Master C programming",
        "Build portfolio projects", 
        "Secure internships",
        "Open source contributions"
    };
    
    printf("Goals:\\n");
    for (int i = 0; i < 4; i++) {
        printf("%d. %s\\n", i+1, goals[i]);
    }
    
    printf("\
Technical Focus:\\n");
    printf("- System Programming\\n");
    printf("- Web Development\\n");
    printf("- Database Design\\n");
    printf("- DevOps & Cloud\\n");
    printf("- Algorithms\\n");
    
    printf("\
Ready for challenges!\\n");
    
    return 0;
}', 'September preparation after summer experience. Set academic goals, technical focus areas. Motivation for new semester. Ready for advanced coursework and challenges!', 2, 7);