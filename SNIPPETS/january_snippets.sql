-- January Snippets: Advanced Data Structures & System Programming (Complete Month 1-31) - FIXED
INSERT INTO snippets (month, day, title, code, explanation, language_id, category_id) VALUES
(1, 1, 'C New Year Programming Goals', '#include <stdio.h>

int main() {
    // New Year Goals for Epitech Students
    char* goals[] = {
        "Master C memory management",
        "Learn modern C++ features",
        "Contribute to open source",
        "Build amazing projects",
        "Ace the technical interviews"
    };
    
    printf("2024 Programming Goals:\\n");
    for (int i = 0; i < 5; i++) {
        printf("%d. %s\\n", i+1, goals[i]);
    }
    
    return 0;
}', 'Start 2024 with clear programming goals! Arrays of strings for organization. Loop through objectives. Motivation through code. Happy New Year!', 2, 10),
(1, 2, 'Python Advanced List Comprehensions', '# List comprehensions
squares = [x**2 for x in range(10) if x % 2 == 0]

# Nested comprehensions
matrix = [[i*j for j in range(3)] for i in range(3)]

# Dictionary comprehension
word_len = {word: len(word) for word in words}

# Set comprehension
unique = {x % 10 for x in numbers}

# Generator expression (memory efficient)
sum_squares = sum(x**2 for x in range(1000000))

# Multiple conditions
filtered = [x for x in data if x > 0 and x < 100]', 'Advanced comprehension techniques. Nested loops create matrices. Generator expressions save memory. Multiple conditions filter effectively. Pythonic code patterns.', 1, 3),
(1, 3, 'C Doubly Linked List', 'struct Node {
    int data;
    struct Node *prev, *next;
};

void insert_front(struct Node** head, int data) {
    struct Node* new = malloc(sizeof(struct Node));
    new->data = data;
    new->prev = NULL;
    new->next = *head;
    if (*head) (*head)->prev = new;
    *head = new;
}

void delete_node(struct Node** head, struct Node* del) {
    if (!*head || !del) return;
    if (*head == del) *head = del->next;
    if (del->next) del->next->prev = del->prev;
    if (del->prev) del->prev->next = del->next;
    free(del);
}', 'Doubly linked lists have forward and backward links. Easier deletion but more memory overhead. Update both directions when modifying.', 2, 3),
(1, 4, 'C Array Pointers', 'int arr[5] = {10, 20, 30, 40, 50};
int *p = arr;  // Points to first element

// Different ways to access
printf("%d\\n", arr[2]);     // 30\nprintf("%d\\n", *(arr + 2)); // 30\nprintf("%d\\n", *(p + 2));   // 30\nprintf("%d\\n", p[2]);       // 30

// Pointer arithmetic
p++;  // Now points to arr[1]\nprintf("%d\\n", *p);  // 20

// Array of pointers
int *ptrs[3];
for (int i = 0; i < 3; i++)
    ptrs[i] = &arr[i];', 'Arrays decay to pointers. Pointer arithmetic moves by element size. arr[i] equals *(arr+i). Arrays and pointers interchangeable in many contexts.', 2, 2),
(1, 5, 'Python Lambda Functions', '# Simple lambda
square = lambda x: x ** 2
print(square(5))  # 25

# Lambda in sort
students = [(''Alice'', 85), (''Bob'', 75), (''Charlie'', 95)]
students.sort(key=lambda x: x[1], reverse=True)

# Map with lambda
nums = [1, 2, 3, 4, 5]
squared = list(map(lambda x: x**2, nums))

# Filter with lambda
evens = list(filter(lambda x: x % 2 == 0, nums))

# Reduce with lambda
from functools import reduce
product = reduce(lambda x, y: x * y, nums)', 'Lambda creates anonymous functions. Single expression only. Useful with map, filter, sort. Concise for simple operations. Not always more readable.', 1, 9),
(1, 6, 'C++ References', 'void swap(int& a, int& b) {
    int temp = a;
    a = b;
    b = temp;
}

int main() {
    int x = 5, y = 10;
    swap(x, y);  // x=10, y=5
    
    // Reference must be initialized
    int& ref = x;  // ref is alias for x
    ref = 20;      // x is now 20
    
    // Const reference
    const int& cref = 100;  // Can bind to temporary
    
    // Return by reference
    int& get_element(int arr[], int i) { return arr[i]; }
}', 'References are aliases to objects. Cannot be null or reassigned. Pass by reference avoids copies. Const references bind to temporaries.', 3, 2),
(1, 7, 'Shell Scripting Basics', '#!/bin/bash

# Variables
NAME="Epitech"
YEAR=2024

# Conditionals
if [ -f "file.txt" ]; then
    echo "File exists"
fi

# Loops
for i in {1..5}; do
    echo "Count: $i"
done

# Functions
greet() {
    echo "Hello, $1!"
}

greet "$NAME"

# Command substitution
FILES=$(ls *.c 2>/dev/null | wc -l)
echo "C files: $FILES"', 'Shell scripts automate tasks. Variables with $. Conditionals with [ ]. Loops iterate. Functions organize code. Command substitution with $().', 14, 7),
(1, 8, 'JavaScript Closures', 'function counter() {
    let count = 0;
    return {
        increment: () => ++count,
        decrement: () => --count,
        get: () => count
    };
}

const c = counter();
console.log(c.increment()); // 1
console.log(c.increment()); // 2
console.log(c.get());       // 2

// Closure in loop fix
for (let i = 0; i < 3; i++) {
    setTimeout(() => console.log(i), 100);  // 0, 1, 2
}', 'Closures capture outer variables. Private variables pattern. Functions remember environment. let creates block scope. Common interview topic.', 5, 9),
(1, 9, 'C Structures Padding', 'struct Example1 {
    char a;    // 1 byte + 3 padding
    int b;     // 4 bytes
    char c;    // 1 byte + 3 padding
};  // Total: 12 bytes

struct Example2 {
    char a;    // 1 byte
    char c;    // 1 byte + 2 padding
    int b;     // 4 bytes
};  // Total: 8 bytes

#pragma pack(1)
struct Packed {
    char a;    // 1 byte
    int b;     // 4 bytes
    char c;    // 1 byte
};  // Total: 6 bytes
#pragma pack()', 'Compiler adds padding for alignment. Order affects struct size. Pack pragma removes padding. Trade-off: memory vs performance. Important for protocols.', 2, 3),
(1, 10, 'Python Decorators Advanced', 'import functools
import time

def timer(func):
    @functools.wraps(func)
    def wrapper(*args, **kwargs):
        start = time.perf_counter()
        result = func(*args, **kwargs)
        end = time.perf_counter()
        print(f"{func.__name__} took {end-start:.4f}s")
        return result
    return wrapper

@timer
def slow_function():
    time.sleep(1)
    return "Done"

# Decorator with arguments
def repeat(times):
    def decorator(func):
        def wrapper(*args, **kwargs):
            for _ in range(times):
                func(*args, **kwargs)
        return wrapper
    return decorator', 'Decorators modify function behavior. @functools.wraps preserves metadata. Can accept arguments. Useful for logging, timing, validation.', 1, 9),
(1, 11, 'C Volatile Keyword', '#include <signal.h>

volatile int flag = 0;

void signal_handler(int sig) {
    flag = 1;  // Modified by signal
}

int main() {
    signal(SIGINT, signal_handler);
    
    // Without volatile, compiler might optimize this
    while (!flag) {
        // Wait for signal
    }
    
    // Hardware register (embedded)
    volatile uint32_t* GPIO = (uint32_t*)0x40020000;
    *GPIO = 0x01;  // Write to hardware
    
    return 0;
}', 'Volatile prevents optimization. Used for hardware registers, signals, multi-threading. Tells compiler value can change unexpectedly. Not thread-safe alone.', 2, 2),
(1, 12, 'Database Indexing', 'CREATE INDEX idx_email ON users(email);
CREATE INDEX idx_composite ON orders(user_id, created_at);
CREATE UNIQUE INDEX idx_unique ON products(sku);

-- Analyze query performance
EXPLAIN ANALYZE
SELECT * FROM orders
WHERE user_id = 123
AND created_at > ''2024-01-01'';

-- Full-text index
CREATE INDEX idx_search ON articles
USING GIN(to_tsvector(''english'', title || '' '' || content));

-- Drop unused index
DROP INDEX idx_old;', 'Indexes speed up queries. B-tree for equality/range. GIN for full-text. Composite for multiple columns. Trade-off: faster reads, slower writes.', 10, 3),
(1, 13, 'C++ Move Semantics', 'class String {
    char* data;
    size_t size;
public:
    // Move constructor
    String(String&& other) noexcept
        : data(other.data), size(other.size) {
        other.data = nullptr;
        other.size = 0;
    }
    
    // Move assignment
    String& operator=(String&& other) noexcept {
        if (this != &other) {
            delete[] data;
            data = other.data;
            size = other.size;
            other.data = nullptr;
        }
        return *this;
    }
};', 'Move semantics avoid unnecessary copies. && indicates rvalue reference. noexcept enables optimizations. Transfers ownership of resources.', 3, 9),
(1, 14, 'Git Advanced', '# Interactive rebase
git rebase -i HEAD~3

# Stash changes
git stash save "WIP: feature"
git stash pop

# Cherry-pick commit
git cherry-pick abc123

# Reset types
git reset --soft HEAD~1   # Keep changes staged
git reset --mixed HEAD~1  # Keep changes unstaged
git reset --hard HEAD~1   # Discard changes

# Bisect to find bug
git bisect start
git bisect bad HEAD
git bisect good v1.0
# Test and mark good/bad until found', 'Advanced Git techniques. Rebase rewrites history. Stash saves work temporarily. Cherry-pick applies specific commits. Bisect finds bugs systematically.', 14, 7),
(1, 15, 'Python Context Managers', 'from contextlib import contextmanager
import os

@contextmanager
def change_dir(path):
    old_path = os.getcwd()
    try:
        os.chdir(path)
        yield
    finally:
        os.chdir(old_path)

# Usage
with change_dir(''/tmp''):
    print(os.getcwd())  # /tmp
# Back to original dir

@contextmanager
def timing():
    start = time.time()
    yield
    print(f"Took {time.time() - start:.2f}s")', 'Context managers ensure cleanup. @contextmanager decorator simplifies creation. yield separates setup/teardown. finally ensures cleanup. Resource management pattern.', 1, 9),
(1, 16, 'C Enums and Unions', 'enum Status { SUCCESS = 0, ERROR = -1, PENDING = 1 };

union Value {
    int i;
    float f;
    char str[20];
};

struct Message {
    enum { INT, FLOAT, STRING } type;
    union Value value;
};

void print_message(struct Message* msg) {
    switch (msg->type) {
        case INT: printf("%d\\n", msg->value.i); break;
        case FLOAT: printf("%.2f\\n", msg->value.f); break;
        case STRING: printf("%s\\n", msg->value.str); break;
    }
}', 'Enums create named constants. Unions save memory for variants. Tagged unions track active member. Common in protocols and parsers.', 2, 3),
(1, 17, 'Web Security Basics', '// XSS Prevention
function escapeHtml(text) {
    const map = {
        ''&'': ''&amp;'',
        ''<'': ''&lt;'',
        ''>'': ''&gt;'',
        ''"'': ''&quot;'',
        "''": ''&#039;''
    };
    return text.replace(/[&<>"'']/g, m => map[m]);
}

// SQL Injection Prevention
const query = ''SELECT * FROM users WHERE id = ?'';
db.query(query, [userId]);

// CSRF Token
app.use(csrf());
app.get(''/form'', (req, res) => {
    res.render(''form'', { csrfToken: req.csrfToken() });
});', 'Web security essentials. Escape user input for XSS. Parameterized queries prevent SQL injection. CSRF tokens verify requests. Never trust user input.', 5, 8),
(1, 18, 'C++ Templates Advanced', 'template<typename T, size_t N>
class Array {
    T data[N];
public:
    T& operator[](size_t i) { return data[i]; }
    constexpr size_t size() { return N; }
};

// Variadic template
template<typename... Args>
void print(Args... args) {
    ((cout << args << " "), ...);
}

// SFINAE
template<typename T>
typename enable_if<is_integral<T>::value, T>::type
safe_divide(T a, T b) {
    return b != 0 ? a / b : 0;
}', 'Advanced template techniques. Non-type parameters for compile-time values. Variadic templates for variable arguments. SFINAE for conditional compilation.', 3, 9),
(1, 19, 'Network Programming', 'import socket
import threading

def handle_client(conn, addr):
    print(f"Connected: {addr}")
    while True:
        data = conn.recv(1024)
        if not data: break
        conn.send(data.upper())
    conn.close()

server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server.bind((''localhost'', 8080))
server.listen(5)

while True:
    conn, addr = server.accept()
    thread = threading.Thread(target=handle_client, args=(conn, addr))
    thread.start()', 'TCP server with threading. Each client gets separate thread. Echo server pattern. accept blocks until connection. Handle multiple clients concurrently.', 1, 11),
(1, 20, 'Memory Management', '#include <string.h>

void* my_realloc(void* ptr, size_t old_size, size_t new_size) {
    if (new_size == 0) {
        free(ptr);
        return NULL;
    }
    if (!ptr) return malloc(new_size);
    
    void* new_ptr = malloc(new_size);
    if (!new_ptr) return NULL;
    
    size_t copy_size = old_size < new_size ? old_size : new_size;
    memcpy(new_ptr, ptr, copy_size);
    free(ptr);
    
    return new_ptr;
}', 'Custom memory reallocation. Handle edge cases: NULL, zero size. Copy minimum of old/new size. Free old memory. Error checking essential.', 2, 5),
(1, 21, 'Regex Patterns', 'import re

# Common patterns
patterns = {
    ''email'': r''^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$'',
    ''phone'': r''^\\+?1?\\d{9,15}$'',
    ''url'': r''^https?://[\\w.-]+\\.[a-z]{2,}(/.*)?$'',
    ''ipv4'': r''^\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}$''
}

# Extract and validate
text = "Contact: john@email.com or call 555-1234"
email = re.search(patterns[''email''], text)

# Replace with groups
formatted = re.sub(r''(\\d{3})(\\d{3})(\\d{4})'', r''(\\1) \\2-\\3'', "5551234567")', 'Regular expressions match patterns. ^ and $ anchor start/end. \\d digits, \\w word chars. Groups with (). Powerful but use carefully.', 1, 4),
(1, 22, 'C Preprocessor Advanced', '#define STRINGIFY(x) #x
#define CONCAT(a, b) a##b
#define FOREACH(arr, size) \\
    for(int CONCAT(i, __LINE__) = 0; CONCAT(i, __LINE__) < size; CONCAT(i, __LINE__)++)

#if defined(__linux__)
    #define PLATFORM "Linux"
#elif defined(_WIN32)
    #define PLATFORM "Windows"
#elif defined(__APPLE__)
    #define PLATFORM "macOS"
#endif

#define MIN(a, b) ({ \\
    typeof(a) _a = (a); \\
    typeof(b) _b = (b); \\
    _a < _b ? _a : _b; \\
})', 'Advanced preprocessor techniques. # stringifies, ## concatenates. Platform detection. Statement expressions (GCC). __LINE__ for unique names.', 2, 2),
(1, 23, 'Async JavaScript', 'async function fetchWithRetry(url, retries = 3) {
    for (let i = 0; i < retries; i++) {
        try {
            const response = await fetch(url);
            if (response.ok) return await response.json();
        } catch (error) {
            if (i === retries - 1) throw error;
            await new Promise(r => setTimeout(r, 1000 * Math.pow(2, i)));
        }
    }
}

// Parallel requests
const [user, posts] = await Promise.all([
    fetch(''/api/user'').then(r => r.json()),
    fetch(''/api/posts'').then(r => r.json())
]);', 'Async patterns in JavaScript. Retry with exponential backoff. Promise.all for parallel. Error handling in async. Modern JavaScript patterns.', 5, 11),
(1, 24, 'C++ STL Algorithms', '#include <algorithm>
#include <numeric>
#include <vector>

vector<int> v = {3, 1, 4, 1, 5, 9};

// Common algorithms
sort(v.begin(), v.end());
auto it = find(v.begin(), v.end(), 4);
int sum = accumulate(v.begin(), v.end(), 0);

// Remove duplicates
v.erase(unique(v.begin(), v.end()), v.end());

// Partition
auto pivot = partition(v.begin(), v.end(),
                      [](int x) { return x < 5; });

// Transform
transform(v.begin(), v.end(), v.begin(),
         [](int x) { return x * 2; });', 'STL algorithms operate on ranges. Iterator-based design. Lambda expressions for predicates. Functional programming style. Efficient and tested.', 3, 3),
(1, 25, 'Docker Basics', '# Dockerfile
FROM python:3.9-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
CMD ["python", "app.py"]

# Build image
docker build -t myapp .

# Run container
docker run -d -p 8080:8080 --name app myapp

# Docker compose
version: ''3''
services:
  web:
    build: .
    ports:
      - "8080:8080"
  db:
    image: postgres:13
    environment:
      POSTGRES_PASSWORD: secret', 'Docker containerizes applications. Dockerfile defines image. Layers cache for efficiency. Compose manages multi-container apps. Portable deployments.', 16, 7),
(1, 26, 'Testing Strategies', 'import unittest
from unittest.mock import Mock, patch

class TestCalculator(unittest.TestCase):
    def setUp(self):
        self.calc = Calculator()
    
    def test_addition(self):
        self.assertEqual(self.calc.add(2, 3), 5)
    
    def test_division_by_zero(self):
        with self.assertRaises(ZeroDivisionError):
            self.calc.divide(10, 0)
    
    @patch(''requests.get'')
    def test_api_call(self, mock_get):
        mock_get.return_value.json.return_value = {''result'': 42}
        result = fetch_data()
        self.assertEqual(result, 42)', 'Unit testing best practices. Setup/teardown for test isolation. Mock external dependencies. Test edge cases. Assertions verify behavior.', 1, 10),
(1, 27, 'Optimization Techniques', '#include <immintrin.h>  // SIMD

// Loop unrolling
void sum_array(int* arr, int n) {
    int sum = 0;
    int i;
    for (i = 0; i < n - 3; i += 4) {
        sum += arr[i] + arr[i+1] + arr[i+2] + arr[i+3];
    }
    for (; i < n; i++) sum += arr[i];
}

// SIMD vectorization
void add_vectors(float* a, float* b, float* c, int n) {
    for (int i = 0; i < n; i += 8) {
        __m256 va = _mm256_load_ps(&a[i]);
        __m256 vb = _mm256_load_ps(&b[i]);
        __m256 vc = _mm256_add_ps(va, vb);
        _mm256_store_ps(&c[i], vc);
    }
}', 'Performance optimization techniques. Loop unrolling reduces overhead. SIMD processes multiple data. Compiler flags: -O3 -march=native. Profile first.', 2, 10),
(1, 28, 'Design Patterns Review', '// Singleton
class Logger {
    static Logger* instance;
    Logger() {}
public:
    static Logger* getInstance() {
        if (!instance) instance = new Logger();
        return instance;
    }
};

// Factory
class ShapeFactory {
public:
    static Shape* createShape(string type) {
        if (type == "circle") return new Circle();
        if (type == "square") return new Square();
        return nullptr;
    }
};

// Observer
class Subject {
    vector<Observer*> observers;
public:
    void notify() {
        for (auto obs : observers) obs->update();
    }
};', 'Common design patterns. Singleton: one instance. Factory: object creation. Observer: event handling. Patterns solve recurring problems.', 3, 9),
(1, 29, 'Cryptography Basics', 'import hashlib
import secrets
from cryptography.fernet import Fernet

# Hashing (one-way)
password = "secret123"
hashed = hashlib.pbkdf2_hmac(''sha256'', 
    password.encode(), b''salt'', 100000)

# Symmetric encryption
key = Fernet.generate_key()
cipher = Fernet(key)
encrypted = cipher.encrypt(b"Secret message")
decrypted = cipher.decrypt(encrypted)

# Secure random
token = secrets.token_urlsafe(32)
nonce = secrets.randbits(128)', 'Cryptography fundamentals. Hashing for passwords (one-way). Symmetric encryption (same key). Use established libraries. Never roll your own crypto.', 1, 8),
(1, 30, 'Performance Profiling', 'import cProfile
import pstats

def profile_code():
    profiler = cProfile.Profile()
    profiler.enable()
    
    # Code to profile
    expensive_operation()
    
    profiler.disable()
    stats = pstats.Stats(profiler)
    stats.sort_stats(''cumulative'')
    stats.print_stats(10)

# Memory profiling
from memory_profiler import profile

@profile
def memory_intensive():
    large_list = [i for i in range(1000000)]
    return sum(large_list)', 'Profile to find bottlenecks. CPU profiling shows time distribution. Memory profiling tracks allocations. Optimize hotspots first. Measure improvements.', 1, 10),
(1, 31, 'Month End Review', '/* January Learning Summary:
 * ✓ Memory management fundamentals
 * ✓ Advanced data structures
 * ✓ Network programming basics
 * ✓ Design patterns overview
 * ✓ Testing strategies
 * ✓ Performance optimization
 * 
 * Next Month Goals:
 * - Deepen algorithm knowledge
 * - Practice system design
 * - Contribute to open source
 * - Build portfolio project
 */

printf("January complete! 31 days of learning.\\n");\nprintf("Ready for February challenges!\\n");', 'Monthly review and planning. Celebrate progress made. Identify areas for improvement. Set concrete goals. Continuous learning mindset. Keep coding!', 2, 7);