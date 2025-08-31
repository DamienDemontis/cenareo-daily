-- November Snippets: Data Structures (Complete Month 1-30) - FIXED
INSERT INTO snippets (month, day, title, code, explanation, language_id, category_id) VALUES
(11, 1, 'C Makefile Basics', 'CC=gcc
CFLAGS=-Wall -Wextra -Werror -std=c99
SRCS=main.c utils.c
OBJS=$(SRCS:.c=.o)
TARGET=program

all: $(TARGET)

$(TARGET): $(OBJS)
\t$(CC) $(OBJS) -o $@

%.o: %.c
\t$(CC) $(CFLAGS) -c $< -o $@

clean:
\trm -f $(OBJS)

fclean: clean
\trm -f $(TARGET)

re: fclean all

.PHONY: all clean fclean re', 'Makefiles automate compilation. Variables make maintenance easier. Pattern rules handle multiple files. Phony targets for commands. Essential for C projects.', 16, 7),
(11, 2, 'Python Error Handling', 'def safe_divide(a, b):
    try:
        result = a / b
        return result
    except ZeroDivisionError:
        print("Cannot divide by zero!")
        return None
    except TypeError:
        print("Invalid input types!")
        return None
    finally:
        print("Division operation completed")

try:
    with open("data.txt", "r") as file:
        content = file.read()
except FileNotFoundError:
    print("File not found!")
except PermissionError:
    print("No permission to read file!")', 'try-except handles exceptions gracefully. Multiple except blocks catch different errors. finally always executes. Prevents program crashes.', 1, 5),
(11, 3, 'C++ Namespaces', '#include <iostream>

namespace Math {
    const double PI = 3.14159;
    
    double area_circle(double radius) {
        return PI * radius * radius;
    }
}

namespace Physics {
    const double G = 9.81;
    
    double kinetic_energy(double mass, double velocity) {
        return 0.5 * mass * velocity * velocity;
    }
}

int main() {
    std::cout << "Circle area: " << Math::area_circle(5.0) << std::endl;
    std::cout << "Energy: " << Physics::kinetic_energy(10, 5) << std::endl;
    return 0;
}', 'Namespaces organize code and avoid name conflicts. :: scope resolution operator. using namespace can import entire namespace. Prevents naming collisions.', 3, 2),
(11, 4, 'JavaScript Async/Await', 'async function fetchUserData(userId) {
    try {
        console.log("Fetching user data...");
        
        const userResponse = await fetch(`/api/users/${userId}`);
        const user = await userResponse.json();
        
        const postsResponse = await fetch(`/api/users/${userId}/posts`);
        const posts = await postsResponse.json();
        
        return { user, posts };
    } catch (error) {
        console.error("Failed to fetch data:", error);
        throw error;
    }
}

// Usage
fetchUserData(123).then(data => {
    console.log(data);
});', 'async/await simplifies promise handling. await pauses until promise resolves. try/catch for error handling. More readable than promise chains.', 5, 11),
(11, 5, 'C Enum Types', '#include <stdio.h>

enum Status {
    PENDING = 0,
    PROCESSING = 1,
    COMPLETED = 2,
    ERROR = -1
};

enum Color { RED, GREEN, BLUE };  // 0, 1, 2

const char* status_to_string(enum Status s) {
    switch (s) {
        case PENDING: return "Pending";
        case PROCESSING: return "Processing";
        case COMPLETED: return "Completed";
        case ERROR: return "Error";
        default: return "Unknown";
    }
}

int main() {
    enum Status current = PROCESSING;
    printf("Status: %s\\n", status_to_string(current));
    return 0;
}', 'Enums create named integer constants. Values can be explicit or auto-incremented. Improves code readability. Switch statements work well with enums.', 2, 3),
(11, 6, 'Python List Comprehensions', '# Basic list comprehension
squares = [x**2 for x in range(10)]

# With condition
evens = [x for x in range(20) if x % 2 == 0]

# Transform strings
words = ["hello", "world", "python"]
uppercase = [word.upper() for word in words]

# Nested comprehension
matrix = [[i*j for j in range(3)] for i in range(3)]

# Dictionary comprehension
word_lengths = {word: len(word) for word in words}

# Set comprehension
unique_lengths = {len(word) for word in words}', 'List comprehensions create lists concisely. Syntax: [expression for item in iterable if condition]. More Pythonic than loops. Works with dict/set too.', 1, 3),
(11, 7, 'C++ Overloading', '#include <iostream>
using namespace std;

class Calculator {
public:
    int add(int a, int b) {
        return a + b;
    }
    
    double add(double a, double b) {
        return a + b;
    }
    
    string add(string a, string b) {
        return a + b;
    }
};

int main() {
    Calculator calc;
    
    cout << calc.add(5, 3) << endl;           // int version
    cout << calc.add(2.5, 1.5) << endl;       // double version
    cout << calc.add("Hello", " World") << endl; // string version
    
    return 0;
}', 'Function overloading allows same name with different parameters. Compiler chooses based on argument types. Enables intuitive interfaces.', 3, 9),
(11, 8, 'C Linked List Basics', 'struct Node {
    int data;
    struct Node* next;
};

struct Node* create(int data) {
    struct Node* node = malloc(sizeof(struct Node));
    node->data = data;
    node->next = NULL;
    return node;
}

void insert_front(struct Node** head, int data) {
    struct Node* new = create(data);
    new->next = *head;
    *head = new;
}

void print_list(struct Node* head) {
    while (head) {
        printf("%d ", head->data);
        head = head->next;
    }
}', 'Linked lists store data in nodes. Each node points to next. Dynamic size. insert_front adds to beginning. Pointer to pointer for head modification.', 2, 3),
(11, 9, 'JavaScript Closures', 'function createCounter() {
    let count = 0;
    
    return function() {
        count++;
        return count;
    };
}

const counter1 = createCounter();
const counter2 = createCounter();

console.log(counter1()); // 1
console.log(counter1()); // 2
console.log(counter2()); // 1 (separate closure)

// Closure with parameters
function multiplyBy(factor) {
    return function(number) {
        return number * factor;
    };
}

const double = multiplyBy(2);
console.log(double(5)); // 10', 'Closures capture variables from outer scope. Inner function remembers outer variables even after outer function returns. Useful for data privacy.', 5, 9),
(11, 10, 'C Advanced String Functions', 'char* my_strstr(const char* hay, const char* needle) {
    if (!*needle) return (char*)hay;
    for (; *hay; hay++) {
        const char *h = hay, *n = needle;
        while (*h && *n && *h == *n) { h++; n++; }
        if (!*n) return (char*)hay;
    }
    return NULL;
}

char* my_strtok(char* str, const char* delim) {
    static char* next;
    if (str) next = str;
    if (!next) return NULL;
    char* token = next;
    while (*next && !strchr(delim, *next)) next++;
    if (*next) *next++ = ''\\0'';
    return token;
}', 'String search algorithms. strstr finds substring. strtok splits by delimiter. Static variables maintain state between calls. Understanding pointers crucial.', 2, 4),
(11, 11, 'C++ String Class Features', '#include <string>
#include <algorithm>
using namespace std;

string s = "Hello World";
// Find substring
size_t pos = s.find("World");  // Returns 6
// Replace
s.replace(6, 5, "C++");  // "Hello C++"
// Substring
string sub = s.substr(0, 5);  // "Hello"
// Transform
transform(s.begin(), s.end(), s.begin(), ::tolower);
// Trim spaces
s.erase(0, s.find_first_not_of(" \\t"));
s.erase(s.find_last_not_of(" \\t") + 1);', 'C++ string class provides rich functionality. find(), replace(), substr() for manipulation. STL algorithms work on strings. Much safer than C strings.', 3, 3),
(11, 12, 'Regular Expression Basics', '#include <regex.h>
int main() {
    regex_t regex;
    // Compile pattern
    regcomp(&regex, "^[a-zA-Z0-9]+@[a-z]+\\.[a-z]+$", REG_EXTENDED);
    
    // Match string
    int result = regexec(&regex, "user@email.com", 0, NULL, 0);
    if (result == 0) {
        printf("Valid email\\n");
    } else if (result == REG_NOMATCH) {
        printf("Invalid email\\n");
    }
    
    regfree(&regex);
    return 0;
}', 'Regular expressions match patterns in text. Compile pattern once, use multiple times. Powerful for validation, parsing. Clean up with regfree().', 2, 4),
(11, 13, 'C Stack Data Structure', 'typedef struct {
    int* items;
    int top;
    int capacity;
} Stack;

Stack* create_stack(int cap) {
    Stack* s = malloc(sizeof(Stack));
    s->items = malloc(cap * sizeof(int));
    s->top = -1;
    s->capacity = cap;
    return s;
}

void push(Stack* s, int item) {
    if (s->top < s->capacity - 1)
        s->items[++s->top] = item;
}

int pop(Stack* s) {
    return (s->top >= 0) ? s->items[s->top--] : -1;
}', 'Stack follows LIFO (Last In, First Out). Array-based implementation. Check bounds to prevent overflow/underflow. Essential for recursion, parsing.', 2, 3),
(11, 14, 'Python Decorators', 'import functools
import time

def timer(func):
    @functools.wraps(func)
    def wrapper(*args, **kwargs):
        start = time.time()
        result = func(*args, **kwargs)
        end = time.time()
        print(f"{func.__name__} took {end-start:.4f} seconds")
        return result
    return wrapper

@timer
def slow_function():
    time.sleep(1)
    return "Done"

# Decorator with parameters
def repeat(times):
    def decorator(func):
        def wrapper(*args, **kwargs):
            for _ in range(times):
                func(*args, **kwargs)
        return wrapper
    return decorator', 'Decorators modify function behavior without changing code. @syntax applies decorator. functools.wraps preserves function metadata. Powerful metaprogramming tool.', 1, 9),
(11, 15, 'C++ Map Container', '#include <map>
#include <string>
using namespace std;

map<string, int> scores;
// Insert
scores["Alice"] = 95;
scores.insert({"Bob", 87});

// Access
int alice = scores["Alice"];
int charlie = scores["Charlie"];  // Creates with 0

// Check existence
if (scores.find("David") != scores.end()) {
    cout << "Found David\\n";
}

// Iterate
for (const auto& [name, score] : scores) {
    cout << name << ": " << score << "\\n";
}', 'std::map stores sorted key-value pairs. Red-black tree implementation. O(log n) operations. Auto-creates entries with default values.', 3, 3),
(11, 16, 'C Queue Data Structure', 'typedef struct {
    int* items;
    int front, rear, size, capacity;
} Queue;

Queue* create_queue(int cap) {
    Queue* q = malloc(sizeof(Queue));
    q->items = malloc(cap * sizeof(int));
    q->front = q->size = 0;
    q->rear = cap - 1;
    q->capacity = cap;
    return q;
}

void enqueue(Queue* q, int item) {
    if (q->size == q->capacity) return;
    q->rear = (q->rear + 1) % q->capacity;
    q->items[q->rear] = item;
    q->size++;
}

int dequeue(Queue* q) {
    if (q->size == 0) return -1;
    int item = q->items[q->front];
    q->front = (q->front + 1) % q->capacity;
    q->size--;
    return item;
}', 'Queue follows FIFO (First In, First Out). Circular array implementation. Modulo arithmetic wraps indices. Used in scheduling, breadth-first search.', 2, 3),
(11, 17, 'Node.js HTTP Server', 'const http = require(''http'');
const url = require(''url'');

const server = http.createServer((req, res) => {
    const parsed = url.parse(req.url, true);
    
    if (parsed.pathname === ''/api/hello'') {
        res.writeHead(200, {''Content-Type'': ''application/json''});
        res.end(JSON.stringify({message: ''Hello Epitech!''}));
    } else {
        res.writeHead(404);
        res.end(''Not Found'');
    }
});

server.listen(3000, () => {
    console.log(''Server running on port 3000'');
});', 'Node.js creates HTTP servers easily. Parse URLs to route requests. Set headers and status codes. JSON API endpoints. Event-driven, non-blocking I/O.', 5, 11),
(11, 18, 'C Bubble Sort Algorithm', 'void bubble_sort(int arr[], int n) {
    for (int i = 0; i < n-1; i++) {
        int swapped = 0;
        for (int j = 0; j < n-i-1; j++) {
            if (arr[j] > arr[j+1]) {
                int temp = arr[j];
                arr[j] = arr[j+1];
                arr[j+1] = temp;
                swapped = 1;
            }
        }
        if (!swapped) break;  // Already sorted
    }
}', 'Bubble sort compares adjacent elements. Swaps if wrong order. Optimization: stop if no swaps (already sorted). O(n²) complexity. Good for learning.', 2, 4),
(11, 19, 'Python CSV File Processing', 'import csv

# Write CSV
with open(''data.csv'', ''w'', newline='''') as file:
    writer = csv.writer(file)
    writer.writerow([''Name'', ''Age'', ''City''])
    writer.writerow([''Alice'', 25, ''Paris''])

# Read CSV
with open(''data.csv'', ''r'') as file:
    reader = csv.DictReader(file)
    for row in reader:
        print(f"{row[''Name'']}: {row[''Age'']}")

# Write dictionary
with open(''output.csv'', ''w'') as file:
    fieldnames = [''name'', ''score'']
    writer = csv.DictWriter(file, fieldnames=fieldnames)
    writer.writeheader()
    writer.writerow({''name'': ''Bob'', ''score'': 95})', 'CSV module handles comma-separated values. DictReader/DictWriter use column names. Handle headers automatically. Common data exchange format.', 1, 5),
(11, 20, 'C++ Vector Advanced Operations', '#include <vector>
#include <algorithm>
using namespace std;

vector<int> v = {3, 1, 4, 1, 5};

// Sort
sort(v.begin(), v.end());

// Binary search (must be sorted)
bool found = binary_search(v.begin(), v.end(), 4);

// Remove duplicates
v.erase(unique(v.begin(), v.end()), v.end());

// Partition
auto pivot = partition(v.begin(), v.end(),
    [](int x) { return x < 3; });

// Transform
transform(v.begin(), v.end(), v.begin(),
    [](int x) { return x * 2; });', 'STL algorithms work on vectors. sort() rearranges elements. unique() removes consecutive duplicates. partition() reorders by predicate.', 3, 3),
(11, 21, 'C Preprocessor Macros', '#define MAX(a,b) ((a) > (b) ? (a) : (b))
#define MIN(a,b) ((a) < (b) ? (a) : (b))
#define ARRAY_SIZE(arr) (sizeof(arr)/sizeof(arr[0]))
#define SWAP(a,b) do { typeof(a) _t = a; a = b; b = _t; } while(0)

int main() {
    int x = 5, y = 10;
    printf("Max: %d\\n", MAX(x, y));
    SWAP(x, y);
    printf("After swap: x=%d, y=%d\\n", x, y);
    
    int arr[] = {1, 2, 3, 4, 5};
    printf("Array size: %zu\\n", ARRAY_SIZE(arr));
}', 'Macros provide code substitution. Parentheses prevent precedence issues. do-while for multi-statement safety. typeof for generic code (GCC).', 2, 2),
(11, 22, 'Python Decorators', 'def memoize(func):
    cache = {}
    def wrapper(*args):
        if args in cache:
            return cache[args]
        result = func(*args)
        cache[args] = result
        return result
    return wrapper

@memoize
def fibonacci(n):
    if n < 2:
        return n
    return fibonacci(n-1) + fibonacci(n-2)

print(fibonacci(100))  # Fast with memoization', 'Decorators modify function behavior. @ syntax applies decorator. Closure captures cache. Memoization stores results. Dramatic performance improvement.', 1, 9),
(11, 23, 'C Signal Handling', '#include <signal.h>
#include <stdio.h>
#include <unistd.h>

volatile sig_atomic_t running = 1;

void handle_sigint(int sig) {
    printf("\
Received signal %d, stopping...\\n", sig);
    running = 0;
}

int main() {
    signal(SIGINT, handle_sigint);
    
    while (running) {
        printf("Working...\\n");
        sleep(1);
    }
    
    printf("Cleanup complete\\n");
    return 0;
}', 'Signals enable async communication. SIGINT from Ctrl+C. Handler must be async-safe. volatile for shared variables. Graceful shutdown pattern.', 2, 6),
(11, 24, 'C++ Template Functions', 'template <typename T>
T max(T a, T b) {
    return (a > b) ? a : b;
}

template <typename T>
void swap(T& a, T& b) {
    T temp = a;
    a = b;
    b = temp;
}

template <typename T, size_t N>
size_t array_size(T (&)[N]) {
    return N;
}

int main() {
    int x = max(3, 7);          // int version
    double y = max(3.14, 2.71); // double version
}', 'Templates generate code for multiple types. Compiler deduces types. Zero runtime overhead. Type-safe generics. Compile-time polymorphism.', 3, 9),
(11, 25, 'SQL Basics', 'CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT CHECK (age >= 18),
    email VARCHAR(255) UNIQUE
);

INSERT INTO students (name, age, email)
VALUES (''Alice'', 20, ''alice@epitech.eu'');

SELECT name, age 
FROM students 
WHERE age > 18 
ORDER BY name;

UPDATE students SET age = 21 WHERE id = 1;
DELETE FROM students WHERE email IS NULL;', 'SQL manages relational data. CREATE defines structure. Constraints ensure integrity. CRUD operations: Create, Read, Update, Delete.', 10, 3),
(11, 26, 'JavaScript Promises', 'function delay(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}

async function fetchData() {
    try {
        console.log("Fetching...");
        await delay(1000);
        const data = await fetch(''/api/data'');
        const json = await data.json();
        return json;
    } catch (error) {
        console.error("Error:", error);
        throw error;
    }
}

fetchData().then(data => console.log(data));', 'Promises handle async operations. async/await simplifies syntax. try/catch for errors. Chain with then(). Better than callbacks.', 5, 11),
(11, 27, 'C Dynamic Memory', '#include <stdlib.h>
#include <string.h>

char* duplicate_string(const char* src) {
    if (!src) return NULL;
    
    size_t len = strlen(src) + 1;
    char* copy = malloc(len);
    if (!copy) return NULL;
    
    strcpy(copy, src);
    return copy;
}

int main() {
    char* str = duplicate_string("Hello");
    if (str) {
        printf("%s\\n", str);
        free(str);
    }
}', 'Dynamic allocation for runtime sizing. Check malloc return. Match malloc/free pairs. Calculate size carefully. Handle allocation failures.', 2, 5),
(11, 28, 'Python Comprehensions', '# List comprehension
squares = [x**2 for x in range(10) if x % 2 == 0]

# Dict comprehension
word_len = {word: len(word) for word in ["hi", "hello", "bye"]}

# Set comprehension
unique = {x % 10 for x in range(100)}

# Generator expression
sum_squares = sum(x**2 for x in range(1000000))

# Nested comprehension
matrix = [[i*j for j in range(3)] for i in range(3)]', 'Comprehensions create collections concisely. Filter with if clause. Generators save memory. Nested for matrices. Pythonic and efficient.', 1, 3),
(11, 29, 'C Hash Table Implementation', '#define TABLE_SIZE 100

typedef struct Entry {
    char* key;
    int value;
    struct Entry* next;
} Entry;

typedef struct {
    Entry* buckets[TABLE_SIZE];
} HashTable;

unsigned int hash(const char* key) {
    unsigned int hash = 5381;
    int c;
    while ((c = *key++)) hash = ((hash << 5) + hash) + c;
    return hash % TABLE_SIZE;
}

void insert(HashTable* ht, const char* key, int value) {
    unsigned int index = hash(key);
    Entry* entry = malloc(sizeof(Entry));
    entry->key = strdup(key);
    entry->value = value;
    entry->next = ht->buckets[index];
    ht->buckets[index] = entry;
}', 'Hash tables provide O(1) average lookup. Hash function maps keys to indices. Collision handling with chaining. djb2 algorithm for string hashing.', 2, 3),
(11, 30, 'C Binary Search Algorithm', 'int binary_search(int arr[], int size, int target) {
    int left = 0, right = size - 1;
    
    while (left <= right) {
        int mid = left + (right - left) / 2;
        
        if (arr[mid] == target)
            return mid;
        
        if (arr[mid] < target)
            left = mid + 1;
        else
            right = mid - 1;
    }
    
    return -1;  // Not found
}', 'Binary search requires sorted array. Divides search space in half each iteration. O(log n) time complexity. Efficient for large datasets.', 2, 4);