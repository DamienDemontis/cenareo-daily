-- December Snippets: Memory Management & Advanced Concepts (Complete Month 1-31) - FIXED
INSERT INTO snippets (month, day, title, code, explanation, language_id, category_id) VALUES
(12, 1, 'C Memory Debugging', '#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void* debug_malloc(size_t size, const char* file, int line) {
    void* ptr = malloc(size);
    printf("[MALLOC] %zu bytes at %p (%s:%d)\\n", size, ptr, file, line);
    return ptr;
}

void debug_free(void* ptr, const char* file, int line) {
    printf("[FREE] %p (%s:%d)\\n", ptr, file, line);
    free(ptr);
}

#define malloc(s) debug_malloc(s, __FILE__, __LINE__)
#define free(p) debug_free(p, __FILE__, __LINE__)', 'Debug memory allocations with custom functions. Track allocation location with __FILE__ and __LINE__. Helps find memory leaks. Wrap with macros for transparency.', 2, 5),
(12, 2, 'Python Exception Handling', 'try:
    result = risky_operation()
except ValueError as e:
    print(f"Value error: {e}")
except KeyError as e:
    print(f"Key not found: {e}")
except Exception as e:
    print(f"Unexpected: {e}")
    raise
else:
    print("Success!")
finally:
    cleanup()', 'Exception handling prevents crashes. Multiple except blocks for different errors. else runs if no exception. finally always executes. Proper cleanup essential.', 1, 5),
(12, 3, 'C Dynamic 2D Array Allocation', 'int** create_2d_array(int rows, int cols) {
    int** arr = malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        arr[i] = malloc(cols * sizeof(int));
    }
    return arr;
}

void free_2d_array(int** arr, int rows) {
    for (int i = 0; i < rows; i++) {
        free(arr[i]);
    }
    free(arr);
}', '2D arrays need array of pointers to arrays. Allocate row pointers first, then each row. Free in reverse order: rows first, then pointer array.', 2, 5),
(12, 4, 'C++ Smart Pointer Basics', '#include <memory>

// Unique pointer - single owner
std::unique_ptr<int> up(new int(42));
auto up2 = std::make_unique<int>(42);

// Shared pointer - multiple owners
std::shared_ptr<int> sp = std::make_shared<int>(42);
auto sp2 = sp;  // Reference count = 2

// Weak pointer - no ownership
std::weak_ptr<int> wp = sp;
if (auto locked = wp.lock()) {
    // Use locked
}', 'Smart pointers manage memory automatically. unique_ptr single ownership. shared_ptr reference counting. weak_ptr breaks cycles. RAII principle.', 3, 5),
(12, 5, 'Advanced Regular Expressions', 'import re

# Email validation
email_pattern = r''^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$''
if re.match(email_pattern, "user@example.com"):
    print("Valid email")

# Extract numbers\ntext = "Order 123 costs $45.67"
numbers = re.findall(r''\\d+\\.?\\d*'', text)

# Replace with groups
phone = re.sub(r''(\\d{3})(\\d{3})(\\d{4})'', r''(\\1) \\2-\\3'', "5551234567")', 'Regular expressions for pattern matching. Validate email format. Extract numeric data. Group captures for replacement. Powerful text processing tool.', 1, 4),
(12, 6, 'C Memory Leak Detection', '#include <stdlib.h>
#include <stdio.h>

void* my_malloc(size_t size, const char* file, int line) {
    void* ptr = malloc(size);
    printf("[ALLOC] %zu bytes at %p (%s:%d)\\n", size, ptr, file, line);
    return ptr;
}

void my_free(void* ptr, const char* file, int line) {
    printf("[FREE] %p (%s:%d)\\n", ptr, file, line);
    free(ptr);
}

#define malloc(s) my_malloc(s, __FILE__, __LINE__)
#define free(p) my_free(p, __FILE__, __LINE__)', 'Custom allocation tracking. Override malloc/free with macros. Log every allocation and deallocation. Find unmatched pairs. Simple leak detection.', 2, 5),
(12, 7, 'C Function Pointers', 'int add(int a, int b) { return a + b; }
int sub(int a, int b) { return a - b; }
int mul(int a, int b) { return a * b; }

int main() {
    int (*operation)(int, int);
    operation = add;
    printf("3 + 5 = %d\\n", operation(3, 5));
    
    // Array of function pointers
    int (*ops[])(int, int) = {add, sub, mul};
    char symbols[] = {''+'' ,''-'', ''*''};
    for (int i = 0; i < 3; i++)
        printf("10 %c 3 = %d\\n", symbols[i], ops[i](10, 3));
}', 'Function pointers store function addresses. Enable callbacks and dynamic dispatch. Array of functions for menu systems. Basis for polymorphism in C.', 2, 9),
(12, 8, 'Python Classes', 'class Student:
    def __init__(self, name, age):
        self.name = name
        self.age = age
        self._grades = []  # Protected
    
    def add_grade(self, grade):
        self._grades.append(grade)
    
    @property
    def average(self):
        return sum(self._grades) / len(self._grades) if self._grades else 0
    
    def __str__(self):
        return f"Student({self.name}, avg: {self.average:.1f})"

student = Student("Alice", 20)
student.add_grade(85)', 'Classes encapsulate data and behavior. __init__ constructor initializes. @property creates computed attributes. __str__ for string representation.', 1, 9),
(12, 9, 'C++ Operator Overloading', 'class Vector2D {
    double x, y;
public:
    Vector2D(double x, double y) : x(x), y(y) {}
    
    Vector2D operator+(const Vector2D& v) const {
        return Vector2D(x + v.x, y + v.y);
    }
    
    Vector2D& operator+=(const Vector2D& v) {
        x += v.x; y += v.y;
        return *this;
    }
    
    friend ostream& operator<<(ostream& os, const Vector2D& v) {
        return os << "(" << v.x << ", " << v.y << ")";
    }
};', 'Operator overloading customizes operators for classes. Enables intuitive syntax. const for read-only. Friend functions access private members.', 3, 9),
(12, 10, 'Git Branching', '# Create and switch to new branch
git checkout -b feature/new-feature

# List branches
git branch -a

# Switch branches
git checkout main

# Merge branch
git merge feature/new-feature

# Delete branch
git branch -d feature/new-feature

# Rebase (cleaner history)
git rebase main

# Cherry-pick specific commit
git cherry-pick abc123', 'Branches isolate development. Feature branches for new work. Merge combines changes. Rebase creates linear history. Cherry-pick selective commits.', 14, 7),
(12, 11, 'JavaScript Objects', 'const person = {
    name: "Alice",
    age: 25,
    greet() {
        return `Hello, I''m ${this.name}`;
    }
};

// Destructuring
const {name, age} = person;

// Spread operator
const updated = {...person, age: 26};

// Object methods
const keys = Object.keys(person);
const values = Object.values(person);
const entries = Object.entries(person);

// Freeze object
Object.freeze(person);', 'Objects store key-value pairs. Methods are functions in objects. Destructuring extracts values. Spread copies and merges. Object.freeze prevents changes.', 5, 3),
(12, 12, 'C Unions', 'union Data {
    int i;
    float f;
    char str[20];
};

int main() {
    union Data data;
    
    data.i = 10;
    printf("int: %d\\n", data.i);
    
    data.f = 220.5;
    printf("float: %.2f\\n", data.f);
    
    strcpy(data.str, "C Programming");
    printf("string: %s\\n", data.str);
    
    printf("Size: %zu bytes\\n", sizeof(data));
    // Size is largest member
}', 'Unions share memory between members. Only one member valid at a time. Memory size equals largest member. Useful for variant types.', 2, 3),
(12, 13, 'Python File Context', 'class FileManager:
    def __init__(self, filename, mode):
        self.filename = filename
        self.mode = mode
        self.file = None
    
    def __enter__(self):
        self.file = open(self.filename, self.mode)
        return self.file
    
    def __exit__(self, exc_type, exc_val, exc_tb):
        self.file.close()
        if exc_type:
            print(f"Error: {exc_val}")
        return False  # Propagate exception

# Usage
with FileManager("data.txt", "r") as f:
    content = f.read()', 'Context managers ensure cleanup. __enter__ sets up resource. __exit__ handles cleanup. with statement manages lifecycle. Exception safe.', 1, 5),
(12, 14, 'C Recursive Functions', '#include <stdio.h>

int factorial(int n) {
    if (n <= 1) return 1;
    return n * factorial(n - 1);
}

int fibonacci(int n) {
    if (n <= 1) return n;
    return fibonacci(n-1) + fibonacci(n-2);
}

void hanoi(int n, char from, char to, char aux) {
    if (n == 1) {
        printf("Move disk from %c to %c\\n", from, to);
        return;
    }
    hanoi(n-1, from, aux, to);
    hanoi(1, from, to, aux);
    hanoi(n-1, aux, to, from);
}', 'Recursion solves problems by self-calling. Base case prevents infinite recursion. Stack space limitation. Elegant for tree/divide-conquer problems.', 2, 4),
(12, 15, 'Database Transactions', 'BEGIN TRANSACTION;

UPDATE accounts SET balance = balance - 100 WHERE id = 1;
UPDATE accounts SET balance = balance + 100 WHERE id = 2;

-- Check business rules
IF (SELECT balance FROM accounts WHERE id = 1) < 0
    ROLLBACK TRANSACTION;
ELSE
    COMMIT TRANSACTION;

-- With savepoint
BEGIN;
SAVEPOINT before_risky;
UPDATE risky_table SET value = 100;
ROLLBACK TO before_risky;  -- Undo only risky
COMMIT;', 'Transactions ensure atomicity. All succeed or all fail. ACID properties guaranteed. Savepoints for partial rollback. Essential for data integrity.', 10, 3),
(12, 16, 'C++ Inheritance', 'class Animal {
protected:
    string name;
public:
    Animal(string n) : name(n) {}
    virtual void speak() = 0;  // Pure virtual
};

class Dog : public Animal {
public:
    Dog(string n) : Animal(n) {}
    void speak() override {
        cout << name << " barks!\
";
    }
};

class Cat : public Animal {
public:
    Cat(string n) : Animal(n) {}
    void speak() override {
        cout << name << " meows!\
";
    }
};', 'Inheritance creates class hierarchies. virtual enables polymorphism. Pure virtual makes abstract class. override ensures correct overriding.', 3, 9),
(12, 17, 'Network Sockets', '#include <sys/socket.h>
#include <netinet/in.h>

int main() {
    int sockfd = socket(AF_INET, SOCK_STREAM, 0);
    
    struct sockaddr_in server;
    server.sin_family = AF_INET;
    server.sin_port = htons(8080);
    server.sin_addr.s_addr = INADDR_ANY;
    
    bind(sockfd, (struct sockaddr*)&server, sizeof(server));
    listen(sockfd, 5);
    
    int client = accept(sockfd, NULL, NULL);
    char buffer[1024];
    recv(client, buffer, sizeof(buffer), 0);
    send(client, "Hello\
", 6, 0);
}', 'Sockets enable network communication. TCP for reliable streams. bind assigns address. listen/accept for servers. send/recv for data transfer.', 2, 11),
(12, 18, 'Python Generators', 'def fibonacci():
    a, b = 0, 1
    while True:
        yield a
        a, b = b, a + b

# Use generator
fib = fibonacci()
for _ in range(10):
    print(next(fib), end=" ")

# Generator expression
squares = (x**2 for x in range(1000000))

# Process large file
def read_large_file(file):
    with open(file) as f:
        for line in f:
            yield line.strip()', 'Generators produce values lazily. yield pauses and resumes. Memory efficient for sequences. Perfect for streaming data. Infinite sequences possible.', 1, 9),
(12, 19, 'C Inline Assembly', '#include <stdio.h>

int main() {
    int a = 10, b = 20, result;
    
    // Inline assembly (GCC syntax)
    asm volatile(
        "addl %%ebx, %%eax"
        : "=a" (result)  // Output
        : "a" (a), "b" (b)  // Input
    );
    
    printf("%d + %d = %d\\n", a, b, result);
    
    // CPUID example
    unsigned int eax, ebx, ecx, edx;
    asm("cpuid" : "=a"(eax), "=b"(ebx), "=c"(ecx), "=d"(edx) : "a"(0));
}', 'Inline assembly embeds machine code. Platform specific optimization. Access CPU features directly. Use sparingly for portability.', 2, 4),
(12, 20, 'Web APIs REST', 'from flask import Flask, jsonify, request

app = Flask(__name__)

@app.route(''/api/users'', methods=[''GET''])
def get_users():
    return jsonify([{''id'': 1, ''name'': ''Alice''}])

@app.route(''/api/users/<int:id>'', methods=[''GET''])
def get_user(id):
    return jsonify({''id'': id, ''name'': ''User''})

@app.route(''/api/users'', methods=[''POST''])
def create_user():
    data = request.json
    # Create user...
    return jsonify(data), 201

if __name__ == ''__main__'':
    app.run(debug=True)', 'REST APIs use HTTP methods. GET reads, POST creates, PUT updates, DELETE removes. JSON for data exchange. Status codes indicate results.', 1, 11),
(12, 21, 'Winter Solstice Code', '#include <time.h>
#include <math.h>

// Calculate daylight hours
double daylight_hours(int day_of_year, double latitude) {
    double P = asin(0.39795 * cos(0.98563 * (day_of_year - 173) * M_PI / 180));
    double sunrise = 12 - acos(-tan(latitude * M_PI / 180) * tan(P)) * 180 / M_PI / 15;
    double sunset = 12 + acos(-tan(latitude * M_PI / 180) * tan(P)) * 180 / M_PI / 15;
    return sunset - sunrise;
}

int main() {
    // Winter solstice: shortest day
    printf("Daylight on Dec 21: %.2f hours\\n", daylight_hours(355, 48.7));
}', 'Winter solstice marks shortest day. Calculate sunrise/sunset astronomically. Latitude affects daylight hours. Nancy latitude: 48.7°N.', 2, 4),
(12, 22, 'C++ STL Containers', '#include <vector>
#include <set>
#include <map>
#include <queue>

int main() {
    vector<int> vec = {3, 1, 4};
    vec.push_back(5);
    
    set<int> s = {3, 1, 4, 1};  // Unique, sorted
    
    map<string, int> m;
    m["alice"] = 95;
    
    priority_queue<int> pq;
    pq.push(3); pq.push(1); pq.push(4);
    
    while (!pq.empty()) {
        cout << pq.top() << " ";  // 4 3 1
        pq.pop();
    }
}', 'STL provides data structures. vector: dynamic array. set: unique sorted. map: key-value pairs. priority_queue: heap. Choose based on needs.', 3, 3),
(12, 23, 'Holiday Debugging', '#ifdef DEBUG
    #define DBG_PRINT(fmt, ...) \\
        fprintf(stderr, "[%s:%d] " fmt "\\n", __FILE__, __LINE__, ##__VA_ARGS__)
#else
    #define DBG_PRINT(fmt, ...)
#endif

int main() {
    DBG_PRINT("Starting holiday shopping calculator");
    
    int gifts = 5;
    double budget = 100.0;
    DBG_PRINT("Gifts: %d, Budget: %.2f", gifts, budget);
    
    double per_gift = budget / gifts;
    DBG_PRINT("Per gift: %.2f", per_gift);
    
    printf("You can spend %.2f per gift\\n", per_gift);
}', 'Debug macros help troubleshooting. Conditional compilation removes debug code. __FILE__ and __LINE__ show location. Variadic macros flexible.', 2, 10),
(12, 24, 'Christmas Eve Special', '#include <stdio.h>
#include <stdlib.h>
#include <time.h>

const char* gifts[] = {
    "Partridge in a pear tree",
    "Turtle doves",
    "French hens",
    "Calling birds",
    "Golden rings",
    "Geese a-laying",
    "Swans a-swimming",
    "Maids a-milking",
    "Ladies dancing",
    "Lords a-leaping",
    "Pipers piping",
    "Drummers drumming"
};

int main() {
    printf("🎄 Merry Christmas Eve from Epitech! 🎅\\n");
    srand(time(NULL));
    printf("Your gift: %s\\n", gifts[rand() % 12]);
}', 'Christmas tradition meets code! Array of strings for gifts. Random selection for fun. Holiday spirit in programming. Merry coding!', 2, 10),
(12, 25, 'Christmas Recursion Tree', 'def draw_tree(height, level=0):
    if level < height:
        # Draw current level
        spaces = " " * (height - level - 1)
        stars = "*" * (2 * level + 1)
        print(spaces + stars)
        # Recursive call for next level
        draw_tree(height, level + 1)
    else:
        # Draw trunk
        trunk_space = " " * (height - 1)
        print(trunk_space + "|")

print("🎄 Merry Christmas! 🎄")
draw_tree(7)\nprint("   Happy Coding!")', 'Recursive Christmas tree! Each level adds more stars. Base case at max height. Recursion creates patterns. Holiday fun with algorithms!', 1, 10),
(12, 26, 'Boxing Day Cleanup', '#!/bin/bash
# Post-holiday cleanup script

# Remove temporary files
find /tmp -type f -mtime +7 -delete

# Clean package cache
apt-get clean

# Remove old logs
find /var/log -name "*.log" -mtime +30 -delete

# Git cleanup
git gc --aggressive
git prune

# Docker cleanup
docker system prune -f

# Check disk space
df -h | grep -E ''^/dev/''

echo "System cleaned up! Ready for new year coding!"', 'Boxing Day system cleanup! Remove old files, clean caches. Git garbage collection. Docker prune unused. Start fresh for new projects!', 14, 7),
(12, 27, 'Data Serialization', 'import json
import pickle
import csv

# JSON serialization
data = {"name": "Alice", "scores": [95, 87, 92]}
json_str = json.dumps(data)
loaded = json.loads(json_str)

# Pickle for Python objects
class Student:
    def __init__(self, name):
        self.name = name

student = Student("Bob")
pickled = pickle.dumps(student)
unpickled = pickle.loads(pickled)

# CSV for tabular data
with open("data.csv", "w") as f:
    writer = csv.writer(f)
    writer.writerow(["Name", "Score"])
    writer.writerow(["Alice", 95])', 'Serialization converts objects to storable format. JSON for web APIs. Pickle for Python objects. CSV for spreadsheets. Choose based on use case.', 1, 5),
(12, 28, 'Parallel Processing', '#include <omp.h>
#include <stdio.h>

int main() {
    int sum = 0;
    
    #pragma omp parallel for reduction(+:sum)
    for (int i = 0; i < 1000000; i++) {
        sum += i;
    }
    
    printf("Sum: %d\\n", sum);
    
    #pragma omp parallel
    {
        int tid = omp_get_thread_num();
        printf("Thread %d of %d\\n", tid, omp_get_num_threads());
    }
    
    return 0;
}', 'OpenMP enables parallel processing. pragma directives parallelize loops. reduction combines results. Multiple threads speed computation. Compile with -fopenmp.', 2, 10),
(12, 29, 'Year-End Algorithms', '#include <stdio.h>
#include <stdbool.h>

// Check if year is leap year
bool is_leap(int year) {
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
}

// Days in month
int days_in_month(int month, int year) {
    int days[] = {31,28,31,30,31,30,31,31,30,31,30,31};
    if (month == 2 && is_leap(year)) return 29;
    return days[month - 1];
}

int main() {
    int year = 2024;
    printf("%d is %sleap year\\n", year, is_leap(year) ? "" : "not ");
}', 'Year-end calendar algorithms. Leap year rules handle special cases. Days per month vary. February special case. Essential for date calculations.', 2, 4),
(12, 30, 'Performance Review', '/* Performance Optimization Checklist:
 * 1. Profile before optimizing
 * 2. Optimize algorithms first (O(n²) -> O(n log n))
 * 3. Cache frequently used values
 * 4. Minimize memory allocations
 * 5. Use appropriate data structures
 * 6. Consider parallelization
 * 7. Inline small functions
 * 8. Loop unrolling for critical paths
 * 9. Avoid premature optimization
 * 10. Measure improvements
 */

// Example: Optimized vs Naive
int sum_naive(int* arr, int n) {
    int sum = 0;
    for(int i = 0; i < n; i++) sum += arr[i];
    return sum;
}', 'Year-end performance review! Profile first, optimize bottlenecks. Algorithm improvements biggest impact. Measure to verify gains. Balance readability with speed.', 2, 10),
(12, 31, 'New Year Countdown', '#include <stdio.h>
#include <time.h>
#include <unistd.h>

int main() {
    time_t now = time(NULL);
    struct tm nye = *localtime(&now);
    nye.tm_mon = 11; nye.tm_mday = 31;
    nye.tm_hour = 23; nye.tm_min = 59; nye.tm_sec = 50;
    
    time_t target = mktime(&nye);
    
    while (time(NULL) < target) {
        int diff = difftime(target, time(NULL));
        printf("\\r%02d:%02d:%02d until 2025!", diff/3600, (diff/60)%60, diff%60);
        fflush(stdout);
        sleep(1);
    }
    
    for (int i = 10; i > 0; i--) {
        printf("\\r%d...  ", i);
        fflush(stdout);
        sleep(1);
    }
    printf("\\r🎆 HAPPY NEW YEAR 2025! 🎆\\n");
}', 'New Year countdown timer! Calculate time difference. Update display each second. Carriage return for in-place update. Welcome 2025 with code!', 2, 10);