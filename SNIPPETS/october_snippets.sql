-- October Snippets: Core Programming (Complete Month 1-31)
INSERT INTO snippets (month, day, title, code, explanation, language_id, category_id) VALUES
(10, 1, 'C Memory Allocation', '#include <stdio.h>
#include <stdlib.h>
int main() {
    int *arr = malloc(5 * sizeof(int));
    if (!arr) {
        printf("Memory allocation failed!\\n");
        return 1;
    }
    
    for (int i = 0; i < 5; i++) {
        arr[i] = i * 10;
        printf("arr[%d] = %d\\n", i, arr[i]);
    }
    
    free(arr);  // Always free allocated memory!
    return 0;
}', 'malloc() allocates memory dynamically. Always check if allocation succeeded. free() releases memory to prevent leaks. sizeof() gets type size.', 2, 5),
(10, 2, 'Python Lists', 'numbers = [1, 2, 3, 4, 5]
print(f"Original: {numbers}")

# Add elements
numbers.append(6)
numbers.insert(0, 0)

# Remove elements
numbers.remove(3)  # Remove first occurrence of 3
last = numbers.pop()  # Remove and return last

# Slice
first_three = numbers[:3]
print(f"Modified: {numbers}")
print(f"First three: {first_three}")
print(f"Length: {len(numbers)}")', 'Python lists are dynamic arrays. append() adds to end. insert() adds at position. remove() deletes by value. pop() removes and returns.', 1, 3),
(10, 3, 'C++ Basic Syntax', '#include <iostream>
#include <string>
using namespace std;

int main() {
    string name;
    int age;
    
    cout << "Enter name: ";
    getline(cin, name);
    
    cout << "Enter age: ";
    cin >> age;
    
    cout << "Hello " << name;
    cout << ", you are " << age << " years old!" << endl;
    
    return 0;
}', 'C++ extends C with objects. cout/cin for I/O. string type for text. getline() reads entire line. endl adds newline and flushes buffer.', 3, 1),
(10, 4, 'JavaScript Variables', '// Variable declarations
var oldWay = "global or function scope";
let modernWay = "block scope";
const constant = "cannot be reassigned";

// Data types
let number = 42;
let text = "Hello World";
let boolean = true;
let array = [1, 2, 3];
let object = {name: "Alice", age: 25};

console.log(typeof number);   // "number"
console.log(typeof text);     // "string"
console.log(typeof boolean);  // "boolean"', 'let and const preferred over var. JavaScript is dynamically typed. Objects use key-value pairs. typeof returns type as string. Arrays are special objects.', 5, 1),
(10, 5, 'C Structures', '#include <stdio.h>

struct Student {
    char name[50];
    int age;
    float gpa;
};

int main() {
    struct Student s1 = {"Alice", 20, 3.8};
    struct Student s2;
    
    // Access with dot operator
    printf("Name: %s\\n", s1.name);
    printf("Age: %d\\n", s1.age);
    printf("GPA: %.2f\\n", s1.gpa);
    
    // Assign values individually
    strcpy(s2.name, "Bob");
    s2.age = 21;
    s2.gpa = 3.5;
    
    return 0;
}', 'Structures group related data. Define with struct keyword. Access members with dot operator. Can initialize at declaration or assign later.', 2, 3),
(10, 6, 'Python Functions', 'def calculate_area(length, width, shape="rectangle"):
    """Calculate area of rectangle or square"""
    if shape == "square":
        return length ** 2
    else:
        return length * width

# Function calls
rect_area = calculate_area(5, 3)
square_area = calculate_area(4, 4, "square")
default_area = calculate_area(6, 2)  # Uses default shape

print(f"Rectangle: {rect_area}")
print(f"Square: {square_area}")
print(f"Default: {default_area}")', 'Functions encapsulate reusable code. def keyword defines function. Parameters can have default values. Return value with return statement. Docstrings document functions.', 1, 1),
(10, 7, 'C++ Vectors', '#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;

int main() {
    vector<int> numbers = {3, 1, 4, 1, 5};
    
    // Add elements
    numbers.push_back(9);
    
    // Sort
    sort(numbers.begin(), numbers.end());
    
    // Print all elements
    for (int n : numbers) {
        cout << n << " ";
    }
    cout << endl;
    
    cout << "Size: " << numbers.size() << endl;
    return 0;
}', 'vector is dynamic array in C++. push_back() adds elements. sort() from <algorithm>. Range-based for loop iterates. size() returns element count.', 3, 3),
(10, 8, 'C Error Handling', '#include <stdio.h>
#include <errno.h>
#include <string.h>

int divide(int a, int b, int *result) {
    if (b == 0) {
        return -1;  // Error code
    }
    *result = a / b;
    return 0;  // Success
}

int main() {
    FILE *file = fopen("data.txt", "r");
    if (!file) {
        printf("Error: %s\\n", strerror(errno));
        return 1;
    }
    
    int result;
    if (divide(10, 0, &result) != 0) {
        printf("Division by zero!\\n");
    }
    
    fclose(file);
    return 0;
}', 'C uses return codes for errors. 0 typically success, non-zero error. errno global variable stores system error codes. strerror() converts to message.', 2, 5),
(10, 9, 'Python Dictionaries', 'student = {
    "name": "Alice",
    "age": 20,
    "courses": ["Math", "Physics", "CS"],
    "gpa": 3.8
}

# Access values
print(f"Name: {student[''name'']}")
print(f"Courses: {student[''courses'']}")

# Add/modify
student["email"] = "alice@epitech.eu"
student["age"] = 21

# Iterate
for key, value in student.items():
    print(f"{key}: {value}")

# Check existence
if "email" in student:
    print("Email found!")', 'Dictionaries store key-value pairs. Access with square brackets. items() returns key-value pairs. in operator checks key existence. Flexible data structure.', 1, 3),
(10, 10, 'C Function Pointers', 'int add(int a, int b) { return a + b; }
int multiply(int a, int b) { return a * b; }

int main() {
    // Declare function pointer
    int (*operation)(int, int);
    
    // Assign function
    operation = add;
    printf("5 + 3 = %d\\n", operation(5, 3));
    
    operation = multiply;
    printf("5 * 3 = %d\\n", operation(5, 3));
    
    // Array of function pointers
    int (*ops[])(int, int) = {add, multiply};
    printf("Using array: %d\\n", ops[0](10, 2));
    
    return 0;
}', 'Function pointers store addresses of functions. Syntax: return_type (*name)(parameters). Enable callbacks and dynamic function calls. Arrays of function pointers possible.', 2, 9),
(10, 11, 'JavaScript Objects', 'const person = {
    firstName: "John",
    lastName: "Doe",
    age: 30,
    
    // Method
    fullName: function() {
        return this.firstName + " " + this.lastName;
    },
    
    // Arrow function (different ''this'' binding)
    greet: () => {
        return "Hello from " + person.firstName;
    }
};

console.log(person.fullName());
console.log(person.greet());

// Add new property
person.email = "john@example.com";
console.log(person.email);', 'Objects contain properties and methods. this refers to object in regular functions. Arrow functions have lexical this. Properties can be added dynamically.', 5, 3),
(10, 12, 'C++ Classes Basic', '#include <iostream>
#include <string>
using namespace std;

class Rectangle {
private:
    double width, height;
    
public:
    Rectangle(double w, double h) : width(w), height(h) {}
    
    double area() {
        return width * height;
    }
    
    void display() {
        cout << "Rectangle: " << width << "x" << height;
        cout << ", Area: " << area() << endl;
    }
};

int main() {
    Rectangle rect(5.0, 3.0);
    rect.display();
    return 0;
}', 'Classes encapsulate data and functions. private members hidden from outside. public members accessible. Constructor initializes object. Methods operate on data.', 3, 9),
(10, 13, 'C Arrays and Strings', '#include <stdio.h>
#include <string.h>

int main() {
    char str1[20] = "Hello";
    char str2[] = "World";
    char result[50];
    
    // String operations
    strcpy(result, str1);    // Copy
    strcat(result, " ");     // Concatenate
    strcat(result, str2);
    
    printf("Result: %s\\n", result);
    printf("Length: %zu\\n", strlen(result));
    
    // Compare strings
    if (strcmp(str1, "Hello") == 0) {
        printf("Strings match!\\n");
    }
    
    return 0;
}', 'C strings are null-terminated char arrays. strcpy() copies, strcat() concatenates, strlen() gets length, strcmp() compares. Always ensure buffer sizes adequate.', 2, 3),
(10, 14, 'Python File Handling', '# Writing to file
with open("data.txt", "w") as file:
    file.write("Hello, World!\
")
    file.write("Python file handling\
")

# Reading from file
with open("data.txt", "r") as file:
    content = file.read()
    print("Full content:", content)

# Reading line by line
with open("data.txt", "r") as file:
    for line_number, line in enumerate(file, 1):
        print(f"Line {line_number}: {line.strip()}")

# Append to file
with open("data.txt", "a") as file:
    file.write("Appended line\\n")', 'with statement ensures file closure. "w" write mode, "r" read, "a" append. strip() removes whitespace. enumerate() adds line numbers. Always handle file operations safely.', 1, 5),
(10, 15, 'C Control Structures', '#include <stdio.h>

int main() {
    int day = 3;
    
    // Switch statement
    switch (day) {
        case 1: printf("Monday\\n"); break;
        case 2: printf("Tuesday\\n"); break;
        case 3: printf("Wednesday\\n"); break;
        case 4: printf("Thursday\\n"); break;
        case 5: printf("Friday\\n"); break;
        default: printf("Weekend\\n"); break;
    }
    
    // Ternary operator
    int age = 18;
    printf("You are %s\\n", (age >= 18) ? "adult" : "minor");
    
    return 0;
}', 'switch statement tests variable against multiple values. break prevents fall-through. default handles unmatched cases. Ternary operator (condition) ? true : false.', 2, 1),
(10, 16, 'JavaScript Functions', 'function greet(name, greeting = "Hello") {
    return `${greeting}, ${name}!`;
}

// Arrow function
const add = (a, b) => a + b;

// Function expression
const multiply = function(x, y) {
    return x * y;
};

// Higher-order function
function calculate(operation, a, b) {
    return operation(a, b);
}

console.log(greet("Alice"));
console.log(greet("Bob", "Hi"));
console.log(calculate(add, 5, 3));
console.log(calculate(multiply, 4, 2));', 'Functions are first-class objects. Default parameters provide fallback values. Arrow functions have concise syntax. Functions can be passed as arguments.', 5, 1),
(10, 17, 'C++ STL Containers', '#include <iostream>
#include <vector>
#include <list>
#include <set>
#include <map>
using namespace std;

int main() {
    vector<int> vec = {1, 2, 3};
    list<string> lst = {"a", "b", "c"};
    set<int> s = {3, 1, 2};  // Sorted, unique
    map<string, int> m = {{"key1", 10}, {"key2", 20}};
    
    cout << "Vector size: " << vec.size() << endl;
    cout << "Set contains: ";
    for (int x : s) cout << x << " ";
    cout << endl;
    
    return 0;
}', 'STL provides container classes. vector: dynamic array. list: doubly-linked list. set: sorted unique elements. map: key-value pairs. Choose based on use case.', 3, 3),
(10, 18, 'Python Classes', 'class Car:
    def __init__(self, make, model, year):
        self.make = make
        self.model = model
        self.year = year
        self.mileage = 0
    
    def drive(self, distance):
        self.mileage += distance
        print(f"Drove {distance} km. Total: {self.mileage} km")
    
    def __str__(self):
        return f"{self.year} {self.make} {self.model}"

# Create instance
my_car = Car("Toyota", "Camry", 2020)
print(my_car)
my_car.drive(150)
my_car.drive(75)', '__init__ is constructor. self refers to instance. Methods operate on object data. __str__ defines string representation. Classes enable object-oriented programming.', 1, 9),
(10, 19, 'C Parameter Passing', 'void by_value(int x) { x = 10; }
void by_pointer(int* x) { *x = 10; }
void by_reference(int& x) { x = 10; }

int main() {
    int a = 5;
    by_value(a);     // a still 5
    by_pointer(&a);  // a now 10
    by_reference(a); // a now 10 (C++ only)
    
    // Arrays always by pointer
    void modify_array(int arr[], int size);
    int nums[5] = {1,2,3,4,5};
    modify_array(nums, 5);  // Modified
}', 'C passes by value (copy). Pass pointer to modify original. C++ adds references. Arrays always passed as pointers. Understanding crucial for functions.', 2, 2),
(10, 20, 'C Conditional Compilation', '#ifdef DEBUG
    #define LOG(x) printf("Debug: %s\\n", x)
#else
    #define LOG(x)
#endif

int main() {
    LOG("Starting program");
    int result = calculate();
    LOG("Calculation done");
    #ifdef VERBOSE
        printf("Result: %d\\n", result);
    #endif
    return 0;
}', 'Preprocessor directives control compilation. #ifdef checks if defined. Different builds for debug/release. Zero overhead in production.', 2, 2),
(10, 21, 'Python Dictionary Methods', 'user = {"name": "Alice", "age": 25}

# Safe access
age = user.get("age", 0)
email = user.get("email", "no@email.com")

# Update multiple
user.update({"city": "Paris", "age": 26})

# Pop with default
old_age = user.pop("age", None)

# Dictionary comprehension
squares = {x: x**2 for x in range(5)}

# Merge dicts (Python 3.9+)
merged = dict1 | dict2', 'Dictionary methods for safe manipulation. get() avoids KeyError. update() merges dicts. pop() removes and returns. Comprehensions create dicts efficiently.', 1, 3),
(10, 22, 'C Static Variables', '#include <stdio.h>

void counter() {
    static int count = 0;  // Initialized once
    count++;
    printf("Called %d times\\n", count);
}

int* dangerous() {
    static int safe = 42;  // Survives function return
    return &safe;  // OK - static storage
}

int main() {
    counter();  // 1
    counter();  // 2
    counter();  // 3
}', 'Static variables persist between calls. Initialized once. File scope limits visibility. Function scope maintains state. Not thread-safe by default.', 2, 2),
(10, 23, 'C++ Range-Based Loops', '#include <vector>
#include <map>

int main() {
    std::vector<int> nums = {1, 2, 3, 4, 5};
    
    // Read-only
    for (const auto& n : nums) {
        std::cout << n << " ";
    }
    
    // Modify elements
    for (auto& n : nums) {
        n *= 2;
    }
    
    // Map iteration
    std::map<string, int> scores;
    for (const auto& [name, score] : scores) {
        cout << name << ": " << score;
    }
}', 'Range-based for loops simplify iteration. auto deduces type. & avoids copies. const prevents modification. Structured bindings for pairs.', 3, 2),
(10, 24, 'JavaScript Array Methods', 'const nums = [1, 2, 3, 4, 5];

// Transform
const doubled = nums.map(x => x * 2);

// Filter
const evens = nums.filter(x => x % 2 === 0);

// Reduce
const sum = nums.reduce((acc, x) => acc + x, 0);

// Find
const found = nums.find(x => x > 3);

// Check conditions
const hasEven = nums.some(x => x % 2 === 0);
const allPositive = nums.every(x => x > 0);', 'Functional array methods avoid loops. map transforms, filter selects, reduce aggregates. Immutable operations. Chain for complex transformations.', 5, 3),
(10, 25, 'C Bit Manipulation', '#include <stdio.h>

// Set bit n
#define SET_BIT(x, n) ((x) |= (1 << (n)))
// Clear bit n  
#define CLEAR_BIT(x, n) ((x) &= ~(1 << (n)))
// Toggle bit n
#define TOGGLE_BIT(x, n) ((x) ^= (1 << (n)))
// Check bit n
#define CHECK_BIT(x, n) (((x) >> (n)) & 1)

int main() {
    unsigned char flags = 0;
    SET_BIT(flags, 2);    // Set bit 2
    if (CHECK_BIT(flags, 2)) {
        printf("Bit 2 is set\\n");
    }
}', 'Bit operations for flags and optimization. OR sets bits, AND clears, XOR toggles. Shift for positioning. Efficient space usage.', 2, 4),
(10, 26, 'Python List Slicing', 'nums = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

# Basic slicing
first_three = nums[:3]      # [0, 1, 2]
last_three = nums[-3:]      # [7, 8, 9]
middle = nums[3:7]          # [3, 4, 5, 6]

# Step parameter
evens = nums[::2]           # [0, 2, 4, 6, 8]
reversed = nums[::-1]       # [9, 8, 7, ...]

# Copy list
copy = nums[:]              # Full copy

# Assign slice
nums[2:5] = [20, 30, 40]   # Replace elements', 'Slicing extracts subsequences. [start:stop:step] syntax. Negative indices from end. Omit for defaults. Creates new list (shallow copy).', 1, 3),
(10, 27, 'C File Handling Errors', '#include <stdio.h>
#include <errno.h>
#include <string.h>

int main() {
    FILE* file = fopen("data.txt", "r");
    if (!file) {
        fprintf(stderr, "Error opening file: %s\\n", strerror(errno));
        return 1;
    }
    
    char buffer[256];
    if (!fgets(buffer, sizeof(buffer), file)) {
        if (feof(file)) {
            printf("End of file\\n");
        } else if (ferror(file)) {
            perror("Read error");
        }
    }
    fclose(file);
}', 'Always check file operations. errno provides error codes. strerror() gets descriptions. feof() vs ferror() for read failures. Clean up resources.', 2, 5),
(10, 28, 'C++ STL Algorithms', '#include <algorithm>
#include <vector>
#include <numeric>

int main() {
    std::vector<int> v = {3, 1, 4, 1, 5, 9};
    
    std::sort(v.begin(), v.end());
    
    auto it = std::find(v.begin(), v.end(), 4);
    
    int sum = std::accumulate(v.begin(), v.end(), 0);
    
    std::reverse(v.begin(), v.end());
    
    bool has_nine = std::any_of(v.begin(), v.end(),
                                [](int x) { return x == 9; });
}', 'STL algorithms work on iterators. sort, find, accumulate common operations. Lambda expressions for predicates. Header <algorithm> required.', 3, 3),
(10, 29, 'Git Basics', '# Initialize repository
git init

# Stage changes
git add file.txt
git add -A  # All files

# Commit
git commit -m "Add feature"

# View history
git log --oneline

# Create branch
git checkout -b feature

# Merge
git checkout main
git merge feature

# Push to remote
git push origin main', 'Git tracks code changes. add stages, commit saves snapshot. Branches isolate features. Merge combines work. Essential for collaboration.', 14, 7),
(10, 30, 'C Memory Alignment', '#include <stddef.h>

struct Packed {
    char a;     // 1 byte
    int b;      // 4 bytes
    char c;     // 1 byte
} __attribute__((packed));

struct Aligned {
    char a;     // 1 byte + 3 padding
    int b;      // 4 bytes
    char c;     // 1 byte + 3 padding
};  // Total: 12 bytes

int main() {
    printf("Packed: %zu\\n", sizeof(struct Packed));   // 6
    printf("Aligned: %zu\\n", sizeof(struct Aligned)); // 12
}', 'CPU accesses aligned data faster. Compiler adds padding. packed attribute removes padding. Trade-off: space vs speed. Important for network protocols.', 2, 4),
(10, 31, 'Halloween Special: Spooky Code', '#include <stdio.h>
#include <time.h>

int main() {
    srand(time(NULL));
    char* spooky[] = {"👻", "🎃", "🦇", "🕷️", "💀"};
    char* messages[] = {
        "Segmentation fault... or is it?",
        "Undefined behavior lurks here",
        "Memory leak detected... *evil laugh*",
        "// TODO: Fix before midnight"
    };
    
    printf("%s %s\\n", spooky[rand()%5], messages[rand()%4]);
    printf("Happy Halloween from Epitech Nancy!\\n");
    return 0x1F383;  // 🎃 in hex
}', 'Halloween fun with code! Random spooky messages. Unicode emojis in strings. Hexadecimal return for pumpkin. Remember: real bugs are scarier!', 2, 10);