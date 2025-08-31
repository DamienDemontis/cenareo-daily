-- September Snippets: Welcome & Fundamentals (Complete Month)
INSERT INTO snippets (month, day, title, code, explanation, language_id, category_id) VALUES
(9, 1, 'Welcome to Programming', '#include <stdio.h>
int main() {
    printf("Welcome to Epitech Nancy!\\n");
    printf("Starting your coding journey\\n");
    return 0;
}', 'First program of the year! printf() outputs text. Every C program needs main() function. return 0 indicates successful execution.', 2, 1),
(9, 2, 'Variables Declaration', 'name = "Student"
age = 19
height = 1.75
is_student = True
\nprint(f"Name: {name}")
print(f"Age: {age} years")
print(f"Height: {height}m")
print(f"Student: {is_student}")', 'Python variables store different data types. No declaration needed. f-strings format output with {}. Dynamic typing automatically detects type.', 1, 1),
(9, 3, 'C Data Types', '#include <stdio.h>
int main() {
    int count = 42;
    float price = 9.99;
    char letter = ''A'';
    
    printf("Count: %d\\n", count);
    printf("Price: %.2f\\n", price);
    printf("Letter: %c\\n", letter);
    
    return 0;
}', 'C has strict data types. int for whole numbers, float for decimals, char for single characters. Format: %d, %f, %c respectively.', 2, 1),
(9, 4, 'First C++ Program', '#include <iostream>
using namespace std;

int main() {
    cout << "Hello from C++!" << endl;
    cout << "C++ uses streams for I/O" << endl;
    return 0;
}', 'C++ uses iostream for input/output. cout sends data to console. << is stream insertion operator. endl adds newline and flushes buffer.', 3, 1),
(9, 5, 'Basic Shell Commands', '#!/bin/bash
# Navigate filesystem
ls -la          # List files with details
cd Documents    # Change directory
pwd             # Show current path
mkdir projects  # Create directory
cp file.txt backup.txt  # Copy file
mv old.txt new.txt     # Move/rename', 'Essential shell commands for file management. ls lists, cd changes directory, pwd shows location, mkdir creates folders, cp/mv for files.', 5, 4),
(9, 6, 'C Input with scanf', '#include <stdio.h>
int main() {
    int number;
    char name[30];
    
    printf("Enter a number: ");
    scanf("%d", &number);
    
    printf("Enter your name: ");
    scanf("%s", name);
    
    printf("Hello %s, your number is %d\\n", name, number);
    return 0;
}', 'scanf() reads formatted input from user. & gets variable address for int, arrays dont need & as they are addresses already.', 2, 1),
(9, 7, 'Python Lists Basics', 'numbers = [1, 2, 3, 4, 5]
names = ["Alice", "Bob", "Charlie"]

# Accessing elements
print(f"First number: {numbers[0]}")
print(f"Last name: {names[-1]}")

# Adding elements
numbers.append(6)
names.insert(0, "David")

print(f"Updated numbers: {numbers}")
print(f"Updated names: {names}")', 'Python lists store multiple items. Index starts at 0, -1 for last. append() adds to end, insert() adds at position. Very flexible data structure.', 1, 2),
(9, 8, 'C Arithmetic Operations', '#include <stdio.h>
int main() {
    int a = 10, b = 3;
    
    printf("Addition: %d + %d = %d\\n", a, b, a + b);
    printf("Subtraction: %d - %d = %d\\n", a, b, a - b);
    printf("Multiplication: %d * %d = %d\\n", a, b, a * b);
    printf("Division: %d / %d = %d\\n", a, b, a / b);
    printf("Modulo: %d %% %d = %d\\n", a, b, a % b);
    
    return 0;
}', 'Basic arithmetic in C: +, -, *, / for math operations. % (modulo) gives remainder. Integer division truncates decimals.', 2, 1),
(9, 9, 'C++ cin Input', '#include <iostream>
#include <string>
using namespace std;

int main() {
    string name;
    int age;
    
    cout << "Enter your name: ";
    getline(cin, name);  // For strings with spaces
    
    cout << "Enter your age: ";
    cin >> age;
    
    cout << "Hello " << name << ", you are " << age << " years old!" << endl;
    return 0;
}', 'C++ uses cin for input with >> operator. getline() reads entire line including spaces. string type handles text automatically.', 3, 1),
(9, 10, 'Git Version Control', '# Initialize repository
git init

# Add files to staging
git add .
git add file.c

# Commit changes
git commit -m "Initial commit"

# Check status
git status
git log --oneline', 'Git tracks code changes. init starts repository, add stages files, commit saves changes with message. Essential for teamwork and backups.', 5, 4),
(9, 11, 'C Boolean Logic', '#include <stdio.h>
int main() {
    int score = 85;
    int attendance = 90;
    
    if (score >= 60 && attendance >= 80) {
        printf("Pass: Good score AND attendance\\n");
    }
    
    if (score >= 90 || attendance >= 95) {
        printf("Excellent: High score OR attendance\\n");
    }
    
    printf("Not failing: %s\\n", (score < 60) ? "false" : "true");
    return 0;
}', 'Logical operators: && (AND), || (OR), ! (NOT). Ternary operator ?: is shorthand if-else. Both conditions must be true for &&.', 2, 1),
(9, 12, 'Python Functions', 'def calculate_area(length, width):\n    """Calculate rectangle area"""
    area = length * width
    return area

def greet_user(name, age=18):
    """Greet user with optional age"""
    return f"Hello {name}, age {age}!"

# Function calls
result = calculate_area(5, 3)
print(f"Area: {result}")
print(greet_user("Alice"))
print(greet_user("Bob", 25))', 'Functions organize code. def keyword defines, docstrings document. Default parameters make arguments optional. return sends values back.', 1, 1),
(9, 13, 'C Constants and Macros', '#include <stdio.h>
#define PI 3.14159
#define MAX_SIZE 100

int main() {
    const int days_in_week = 7;
    const float gravity = 9.81;
    
    printf("PI value: %.5f\\n", PI);
    printf("Circle area (r=5): %.2f\\n", PI * 5 * 5);
    printf("Days in week: %d\\n", days_in_week);
    printf("Max array size: %d\\n", MAX_SIZE);
    
    return 0;
}', '#define creates macros (text replacement). const creates read-only variables. Constants improve code readability and maintenance.', 2, 1),
(9, 14, 'C++ Classes Introduction', '#include <iostream>
using namespace std;

class Student {
public:
    string name;
    int age;
    
    void introduce() {
        cout << "Hi, I am " << name << ", " << age << " years old." << endl;
    }
};

int main() {
    Student s1;
    s1.name = "Alice";
    s1.age = 20;
    s1.introduce();
    return 0;
}', 'Classes group data and functions together. public: means accessible outside class. Objects are instances of classes. . accesses members.', 3, 2),
(9, 15, 'HTML Document Structure', '<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My First Page</title>
</head>
<body>
    <h1>Welcome to Web Development</h1>
    <p>This is a paragraph with <strong>bold</strong> text.</p>
    <ul>
        <li>HTML structures content</li>
        <li>CSS styles appearance</li>
        <li>JavaScript adds interactivity</li>
    </ul>
</body>
</html>', 'HTML creates web page structure. DOCTYPE declares HTML5. head contains metadata, body contains visible content. Tags define elements.', 6, 5),
(9, 16, 'C Character Arrays', '#include <stdio.h>
#include <string.h>
int main() {
    char greeting[20] = "Hello";
    char name[20];
    
    strcpy(name, "World");
    strcat(greeting, " ");
    strcat(greeting, name);
    
    printf("Message: %s\\n", greeting);
    printf("Length: %zu characters\\n", strlen(greeting));
    
    return 0;
}', 'C strings are character arrays ending with \\0. strcpy copies, strcat joins strings. Always ensure array is large enough to prevent overflow.', 2, 3),
(9, 17, 'Python Conditionals', 'temperature = 22
weather = "sunny"

if temperature > 25 and weather == "sunny":
    print("Perfect beach weather!")
elif temperature > 20:
    print("Nice day for a walk")
elif temperature > 10:
    print("Need a light jacket")
else:
    print("Stay warm inside")

# Compact conditional
clothing = "shorts" if temperature > 20 else "pants"\nprint(f"Wear: {clothing}")', 'Python if-elif-else chain for multiple conditions. and/or for logic. Compact conditional assigns based on condition. == tests equality.', 1, 1),
(9, 18, 'C For Loops', '#include <stdio.h>
int main() {
    // Basic counting
    for (int i = 1; i <= 5; i++) {
        printf("Count: %d\\n", i);
    }
    
    // Array processing
    int numbers[] = {10, 20, 30, 40};
    int sum = 0;
    
    for (int i = 0; i < 4; i++) {
        sum += numbers[i];
    }
    
    printf("Sum: %d\\n", sum);
    return 0;
}', 'for loops have initialization, condition, increment. Perfect for counting and array processing. i++ increments counter each iteration.', 2, 1),
(9, 19, 'CSS Styling Basics', 'body {
    font-family: Arial, sans-serif;
    margin: 20px;
    background-color: #f0f0f0;
}

h1 {
    color: #2c3e50;
    text-align: center;
    border-bottom: 2px solid #3498db;
}

.highlight {
    background-color: yellow;
    padding: 5px;
    border-radius: 3px;
}

#main-content {
    max-width: 800px;
    margin: 0 auto;
}', 'CSS styles HTML elements. Selectors target elements: tag names, .class, #id. Properties change appearance: color, fonts, spacing, layout.', 7, 5),
(9, 20, 'C While Loops', '#include <stdio.h>
int main() {
    int number = 16;
    int count = 0;
    
    // Count digits
    int temp = number;
    while (temp > 0) {
        temp /= 10;
        count++;
    }
    
    printf("Number %d has %d digits\\n", number, count);
    
    // Simple menu
    char choice = ''y'';
    while (choice == ''y'') {
        printf("Continue? (y/n): ");
        scanf(" %c", &choice);
    }
    
    return 0;
}', 'while loops continue while condition is true. Useful when iteration count is unknown. Be careful to avoid infinite loops by updating condition.', 2, 1),
(9, 21, 'JavaScript Basics', 'let name = "Student";
const school = "Epitech Nancy";
let age = 20;

// Function declaration
function greetStudent(studentName, studentAge) {
    return `Hello ${studentName}! Welcome to ${school}. You are ${studentAge} years old.`;
}

// Arrow function
const calculateGrade = (score) => {
    if (score >= 90) return "A";
    if (score >= 80) return "B"; 
    return "C";
};

console.log(greetStudent(name, age));
console.log(`Grade: ${calculateGrade(85)}`);', 'JavaScript variables: let (changeable), const (fixed). Template literals use backticks and ${}. Functions can be declared or arrow syntax.', 4, 1),
(9, 22, 'Hello World in C', '#include <stdio.h>
int main() {
    printf("Hello, Epitech Nancy!\\n");
    return 0;
}', 'Your first C program! printf() displays text to console. #include adds header files. main() is program entry point. return 0 means success.', 2, 1),
(9, 23, 'Variables and Types', '#include <stdio.h>
int main() {
    int age = 20;
    float height = 1.75;
    char grade = ''A'';
    char name[] = "Student";
    
    printf("Name: %s\\n", name);
    printf("Age: %d years\\n", age);
    printf("Height: %.2f meters\\n", height);
    printf("Grade: %c\\n", grade);
    
    return 0;
}', 'C basic data types: int (numbers), float (decimals), char (single character), arrays for strings. Format specifiers: %d, %f, %c, %s.', 2, 1),
(9, 24, 'Conditional Statements', '#include <stdio.h>
int main() {
    int score = 85;
    
    if (score >= 90) {
        printf("Excellent!\\n");
    } else if (score >= 70) {
        printf("Good job!\\n");
    } else if (score >= 50) {
        printf("Pass\\n");
    } else {
        printf("Need improvement\\n");
    }
    
    return 0;
}', 'if-else statements control program flow. Comparison operators: >=, <=, ==, !=. Logical operators: && (and), || (or), ! (not). Braces group statements.', 2, 1),
(9, 25, 'Loops in C', '#include <stdio.h>
int main() {
    // For loop
    for (int i = 1; i <= 5; i++) {
        printf("Count: %d\\n", i);
    }
    
    // While loop
    int j = 10;
    while (j > 0) {
        printf("Countdown: %d\\n", j);
        j--;
    }
    
    return 0;
}', 'Loops repeat code blocks. for loop has init, condition, increment. while loop continues while condition true. i++ increments, j-- decrements.', 2, 1),
(9, 26, 'Arrays Basics', '#include <stdio.h>
int main() {
    int numbers[5] = {10, 20, 30, 40, 50};
    int sum = 0;
    
    // Calculate sum
    for (int i = 0; i < 5; i++) {
        sum += numbers[i];
    }
    
    printf("Numbers: ");
    for (int i = 0; i < 5; i++) {
        printf("%d ", numbers[i]);
    }
    printf("\
Sum: %d\\n", sum);
    
    return 0;
}', 'Arrays store multiple values of same type. Index starts at 0. numbers[i] accesses element at position i. Use loops to process all elements.', 2, 1),
(9, 27, 'Functions Introduction', '#include <stdio.h>

int add(int a, int b) {
    return a + b;
}

void greet(char name[]) {
    printf("Hello, %s!\\n", name);
}

int main() {
    int result = add(5, 3);
    printf("5 + 3 = %d\\n", result);
    
    greet("Epitech");
    
    return 0;
}', 'Functions organize code into reusable blocks. Parameters pass data in. return sends data back. void means no return value. Declare before use.', 2, 1),
(9, 28, 'Pointers Basics', '#include <stdio.h>
int main() {
    int number = 42;
    int *pointer = &number;
    
    printf("Value: %d\\n", number);
    printf("Address: %p\\n", &number);
    printf("Pointer points to: %p\\n", pointer);
    printf("Value via pointer: %d\\n", *pointer);
    
    *pointer = 100;  // Change value through pointer
    printf("New value: %d\\n", number);
    
    return 0;
}', 'Pointers store memory addresses. & gets address of variable. * dereferences (gets value at address). Powerful but requires careful handling.', 2, 2),
(9, 29, 'String Operations', '#include <stdio.h>
#include <string.h>
int main() {
    char str1[20] = "Hello";
    char str2[] = " World";
    char str3[20];
    
    // Copy string
    strcpy(str3, str1);
    
    // Concatenate
    strcat(str1, str2);
    
    printf("Combined: %s\\n", str1);
    printf("Length: %zu\\n", strlen(str1));
    printf("Copy: %s\\n", str3);
    
    return 0;
}', 'C strings are character arrays ending with \\0. strcpy() copies, strcat() concatenates, strlen() gets length. Always ensure buffer size adequate.', 2, 3),
(9, 30, 'Basic Input/Output', '#include <stdio.h>
int main() {
    char name[50];
    int age;
    float height;
    
    printf("Enter your name: ");
    fgets(name, sizeof(name), stdin);
    
    printf("Enter your age: ");
    scanf("%d", &age);
    
    printf("Enter your height (m): ");
    scanf("%f", &height);
    
    printf("\
Profile:\\n");
    printf("Name: %s", name);
    printf("Age: %d years\\n", age);
    printf("Height: %.2f meters\\n", height);
    
    return 0;
}', 'scanf() reads formatted input. fgets() safely reads strings. & required for scanf() with variables. Always validate user input in real programs.', 2, 1);