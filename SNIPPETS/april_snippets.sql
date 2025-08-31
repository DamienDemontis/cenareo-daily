-- April Snippets: Testing, Debugging & Performance
INSERT INTO snippets (month, day, title, code, explanation, language_id, category_id) VALUES
(4, 1, 'April Fools Code', '#include <stdio.h>
#define true false
#define false true
int main() {
    if (true) {
        printf("This is false!\\n");
    }
    if (false) {
        printf("This is true!\\n");
    }
    // Happy April Fools!
    return 0;
}', 'April Fools! Macro definitions can redefine keywords. Never do this in real code. Demonstrates preprocessor power and dangers.', 2, 10),
(4, 2, 'Unit Testing Basics', '#include <assert.h>
void test_addition() {
    assert(add(2, 2) == 4);
    assert(add(-1, 1) == 0);
    assert(add(0, 0) == 0);
}
void test_division() {
    assert(divide(10, 2) == 5);
    assert(divide(7, 2) == 3);  // Integer division
}
int main() {
    test_addition();
    test_division();
    printf("All tests passed!\\n");
}', 'Unit tests verify individual functions. assert() checks conditions. Test edge cases, normal cases, error cases. Foundation of TDD.', 2, 10),
(4, 3, 'Python pytest', 'import pytest

def test_string_methods():
    assert "hello".upper() == "HELLO"
    assert "HELLO".lower() == "hello"
    
@pytest.mark.parametrize("input,expected", [
    (2, 4),
    (3, 9),
    (4, 16),
])
def test_square(input, expected):
    assert input ** 2 == expected

def test_exception():
    with pytest.raises(ZeroDivisionError):
        1 / 0', 'pytest simplifies testing. Parametrize runs multiple inputs. Fixtures share setup. Mark categorizes tests. Better than unittest.', 1, 10),
(4, 4, 'GDB Debugging', '# Compile with debug symbols
gcc -g program.c -o program

# GDB commands:
(gdb) break main          # Set breakpoint
(gdb) run                 # Start program
(gdb) next                # Step over
(gdb) step                # Step into
(gdb) print variable      # Show value
(gdb) backtrace          # Show call stack
(gdb) watch variable     # Break on change
(gdb) continue           # Resume execution', 'GDB debugs C/C++ programs. -g flag includes debug symbols. Breakpoints pause execution. Inspect variables, stack, memory. Essential debugging tool.', 2, 10),
(4, 5, 'Valgrind Memory Check', '// Memory leak example
int main() {
    int* arr = malloc(10 * sizeof(int));
    // Missing free(arr);
    return 0;
}

// Run: valgrind --leak-check=full ./program
// Output:
// ==1234== 40 bytes in 1 blocks definitely lost
// ==1234== at 0x4C2AB80: malloc
// ==1234== by 0x40053E: main', 'Valgrind detects memory leaks, invalid access. --leak-check=full shows details. Catches use-after-free, buffer overflows. No recompilation needed.', 2, 10),
(4, 6, 'JavaScript Console Debug', 'console.log("Basic output");
console.error("Error message");
console.warn("Warning");
console.table([{a:1,b:2},{a:3,b:4}]);
console.time("Timer");
// Code to measure
console.timeEnd("Timer");
console.group("Group");
console.log("Nested");
console.groupEnd();
console.trace();  // Stack trace
console.assert(false, "Assertion failed");', 'Console methods aid debugging. table() formats data. time/timeEnd measure performance. group organizes output. trace shows call stack.', 5, 10),
(4, 7, 'Performance Profiling', '#include <time.h>
clock_t start = clock();
// Code to profile
for (int i = 0; i < 1000000; i++) {
    // Work
}
clock_t end = clock();
double cpu_time = ((double)(end - start)) / CLOCKS_PER_SEC;
printf("Execution time: %.6f seconds\\n", cpu_time);

// Compile with: gcc -pg for gprof profiling
// Run: ./program && gprof program', 'Measure execution time with clock(). gprof analyzes function calls. Identifies bottlenecks. Optimize hot paths first.', 2, 10),
(4, 8, 'Mock Objects Testing', 'class MockDatabase:
    def __init__(self):
        self.calls = []
    
    def query(self, sql):
        self.calls.append(sql)
        return [{"id": 1, "name": "Test"}]
    
    def insert(self, table, data):
        self.calls.append((table, data))
        return True

def test_user_service():
    mock_db = MockDatabase()
    service = UserService(mock_db)
    service.get_user(1)
    assert "SELECT" in mock_db.calls[0]', 'Mocks simulate dependencies. Test in isolation. Verify interactions. No real database needed. Faster, more reliable tests.', 1, 10),
(4, 9, 'C++ Google Test', '#include <gtest/gtest.h>

TEST(MathTest, Addition) {
    EXPECT_EQ(2 + 2, 4);
    EXPECT_NE(2 + 2, 5);
}

TEST(StringTest, Substring) {
    std::string str = "Hello World";
    EXPECT_TRUE(str.find("World") != std::string::npos);
    EXPECT_FALSE(str.empty());
}

int main(int argc, char** argv) {
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}', 'Google Test framework for C++. EXPECT continues on failure, ASSERT stops. TEST defines test cases. Automated test discovery.', 3, 10),
(4, 10, 'Code Coverage', '# Generate coverage data
gcc --coverage program.c -o program
./program
gcov program.c

# Python coverage
pip install coverage
coverage run -m pytest
coverage report
coverage html

# JavaScript with Jest
jest --coverage
# Aim for 80%+ coverage
# 100% is often impractical', 'Coverage measures tested code percentage. Identifies untested paths. gcov for C/C++, coverage.py for Python. Not quality guarantee.', 2, 10),
(4, 11, 'Sanitizers', '// Compile with sanitizers
// gcc -fsanitize=address    # AddressSanitizer
// gcc -fsanitize=undefined  # UBSan
// gcc -fsanitize=thread     # ThreadSanitizer

int main() {
    int arr[10];
    arr[10] = 42;  // Buffer overflow, caught by ASan
    
    int* p = NULL;
    *p = 42;  // Null deref, caught by ASan
    
    int x;
    if (x) {}  // Uninitialized, caught by MSan
}', 'Sanitizers detect runtime errors. ASan: memory errors. UBSan: undefined behavior. TSan: data races. Small overhead, huge benefit.', 2, 10),
(4, 12, 'Benchmark Code', '#include <benchmark/benchmark.h>

static void BM_StringCreation(benchmark::State& state) {
    for (auto _ : state) {
        std::string empty_string;
    }
}
BENCHMARK(BM_StringCreation);

static void BM_StringCopy(benchmark::State& state) {
    std::string x = "hello";
    for (auto _ : state) {
        std::string copy(x);
    }
}
BENCHMARK(BM_StringCopy);', 'Google Benchmark measures performance. Statistical analysis, outlier detection. Warm-up iterations. Prevents optimization. Reliable measurements.', 3, 10),
(4, 13, 'Python Debugging', 'import pdb

def buggy_function(x, y):
    result = x * y
    pdb.set_trace()  # Breakpoint
    result += 10
    return result

# Interactive debugger commands:
# n - next line
# s - step into
# c - continue
# l - list code
# p variable - print
# pp - pretty print
# h - help', 'pdb is Python debugger. set_trace() creates breakpoint. Interactive exploration. Inspect variables, step through code. Essential debugging tool.', 1, 10),
(4, 14, 'Memory Leak Detection', 'class LeakDetector {
    static std::unordered_map<void*, size_t> allocations;
public:
    static void* allocate(size_t size) {
        void* ptr = malloc(size);
        allocations[ptr] = size;
        return ptr;
    }
    static void deallocate(void* ptr) {
        allocations.erase(ptr);
        free(ptr);
    }
    static void report() {
        for (auto& [ptr, size] : allocations)
            printf("Leak: %zu bytes at %p\\n", size, ptr);
    }
};', 'Custom leak detector tracks allocations. Override new/delete operators. Report unreleased memory. Simpler than Valgrind for basic needs.', 3, 10),
(4, 15, 'Integration Testing', 'def test_api_integration():
    # Setup test database
    with test_database():
        # Create test data
        user = create_test_user()
        
        # Test API endpoint
        response = client.post("/login", {
            "username": user.username,
            "password": "testpass"
        })
        
        assert response.status_code == 200
        assert "token" in response.json()
        
        # Test authenticated request
        token = response.json()["token"]
        auth_response = client.get("/profile",
            headers={"Authorization": f"Bearer {token}"})', 'Integration tests verify component interaction. Test real workflows. Database, API, authentication. Slower but catch integration bugs.', 1, 10),
(4, 16, 'Static Analysis', '// Tools for static analysis:
// C/C++: clang-tidy, cppcheck, PVS-Studio
// Python: pylint, mypy, flake8
// JavaScript: ESLint, JSHint

// Example cppcheck warnings:
// [error] Null pointer dereference
// [warning] Unused variable ''x''
// [style] Variable can be const

// Run: cppcheck --enable=all program.cpp
// clang-tidy program.cpp -- -std=c++17', 'Static analysis finds bugs without running code. Catches common mistakes. Type errors, null derefs, resource leaks. Part of CI/CD pipeline.', 3, 10),
(4, 17, 'Fuzzing', '#include <stdint.h>
#include <stddef.h>

extern "C" int LLVMFuzzerTestOneInput(
    const uint8_t* data, size_t size) {
    if (size < 4) return 0;
    
    // Parse input as your format
    if (data[0] == ''F'' && data[1] == ''U'' &&
        data[2] == ''Z'' && data[3] == ''Z'') {
        // Process the data
        process_input(data + 4, size - 4);
    }
    return 0;
}
// Compile: clang++ -fsanitize=fuzzer,address', 'Fuzzing finds bugs with random input. LibFuzzer generates test cases. Coverage-guided evolution. Finds crashes, hangs, memory errors.', 3, 10),
(4, 18, 'Load Testing', 'import locust
from locust import HttpUser, task, between

class WebsiteUser(HttpUser):
    wait_time = between(1, 3)
    
    @task(3)
    def view_products(self):
        self.client.get("/products")
    
    @task(1)
    def view_product(self):
        product_id = random.randint(1, 100)
        self.client.get(f"/products/{product_id}")
    
    @task(1)
    def add_to_cart(self):
        self.client.post("/cart", json={"product_id": 1})', 'Load testing simulates users. Locust creates distributed load. Find breaking points. Monitor response times, error rates. Plan capacity.', 1, 10),
(4, 19, 'Assertion Macros', '#define ASSERT(cond) \\
    do { \\
        if (!(cond)) { \\
            fprintf(stderr, "Assertion failed: %s\\n" \\
                    "File: %s, Line: %d\\n", \\
                    #cond, __FILE__, __LINE__); \\
            abort(); \\
        } \\
    } while(0)

#ifdef DEBUG
    #define DEBUG_ASSERT(cond) ASSERT(cond)
#else
    #define DEBUG_ASSERT(cond) ((void)0)
#endif', 'Custom assertions with context. Macro shows file, line. DEBUG_ASSERT removed in release. do-while prevents if-else issues.', 2, 10),
(4, 20, 'Test Fixtures', 'class DatabaseTest : public ::testing::Test {
protected:
    Database* db;
    
    void SetUp() override {
        db = new Database(":memory:");
        db->execute("CREATE TABLE users (id, name)");
        db->execute("INSERT INTO users VALUES (1, ''Alice'')");
    }
    
    void TearDown() override {
        delete db;
    }
};

TEST_F(DatabaseTest, QueryUser) {
    auto result = db->query("SELECT * FROM users");
    ASSERT_EQ(result.size(), 1);
}', 'Fixtures provide test setup/teardown. Consistent test environment. Avoid test interdependence. Fresh state each test. Reduces duplication.', 3, 10),
(4, 21, 'Error Injection', 'class FaultInjector {
    static bool should_fail;
    static int fail_count;
public:
    static void* malloc_wrapper(size_t size) {
        if (should_fail && --fail_count <= 0) {
            errno = ENOMEM;
            return nullptr;
        }
        return malloc(size);
    }
    static void inject_failure(int after_n_calls) {
        should_fail = true;
        fail_count = after_n_calls;
    }
};
#define malloc(size) FaultInjector::malloc_wrapper(size)', 'Error injection tests failure handling. Simulate out-of-memory, network errors. Verify graceful degradation. Chaos engineering principle.', 3, 10),
(4, 22, 'Continuous Integration', '# .github/workflows/ci.yml
name: CI
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - name: Build
      run: make
    - name: Test
      run: make test
    - name: Coverage
      run: make coverage
    - name: Lint
      run: make lint', 'CI runs tests automatically. Every push, pull request. Catch bugs early. GitHub Actions, Jenkins, GitLab CI. Essential for teams.', 13, 10),
(4, 23, 'Performance Metrics', 'class PerformanceMonitor {
    std::chrono::high_resolution_clock::time_point start;
    std::string name;
public:
    PerformanceMonitor(const std::string& n) : name(n) {
        start = std::chrono::high_resolution_clock::now();
    }
    ~PerformanceMonitor() {
        auto end = std::chrono::high_resolution_clock::now();
        auto duration = std::chrono::duration_cast<
            std::chrono::microseconds>(end - start);
        std::cout << name << ": " << duration.count() << "μs\
";
    }
};
// Usage: PerformanceMonitor pm("Function");', 'RAII performance monitoring. Automatic timing with destructor. Microsecond precision. No manual start/stop. Profile critical sections.', 3, 10),
(4, 24, 'A/B Testing', 'import hashlib
import random

def get_variant(user_id, test_name, variants=[''A'', ''B'']):
    # Deterministic assignment
    hash_input = f"{user_id}:{test_name}"
    hash_value = hashlib.md5(hash_input.encode()).hexdigest()
    index = int(hash_value[:8], 16) % len(variants)
    return variants[index]

def track_metric(user_id, test_name, metric, value):
    variant = get_variant(user_id, test_name)
    # Log to analytics
    analytics.track(user_id, metric, value, {''variant'': variant})', 'A/B testing compares variations. Deterministic user assignment. Track metrics per variant. Statistical significance required. Data-driven decisions.', 1, 10),
(4, 25, 'Regression Testing', '#!/bin/bash
# Regression test suite
TESTS_DIR="tests"
EXPECTED_DIR="expected"
OUTPUT_DIR="output"

for test in $TESTS_DIR/*.in; do
    name=$(basename $test .in)
    ./program < $test > $OUTPUT_DIR/$name.out
    if diff -q $OUTPUT_DIR/$name.out $EXPECTED_DIR/$name.expected; then
        echo "✓ $name passed"
    else
        echo "✗ $name failed"
        diff $OUTPUT_DIR/$name.out $EXPECTED_DIR/$name.expected
    fi
done', 'Regression tests prevent feature breaks. Compare output to expected. Automated verification. Run before each release. Confidence in changes.', 14, 10),
(4, 26, 'Mutation Testing', '# Original code
def is_positive(n):
    return n > 0

# Mutations:
# 1. return n >= 0  (boundary)
# 2. return n < 0   (operator)
# 3. return True    (constant)

# If tests still pass with mutations,
# tests are inadequate

# Tools: mutmut (Python), Stryker (JS), Pitest (Java)
# Run: mutmut run --paths-to-mutate=src/', 'Mutation testing validates test quality. Changes code to verify tests catch it. Finds inadequate tests. Higher confidence than coverage.', 1, 10),
(4, 27, 'Smoke Testing', 'def smoke_test():
    """Quick sanity check of critical features"""
    
    # Can we connect to database?
    assert database.ping()
    
    # Can we reach external APIs?
    assert requests.get(API_URL).status_code == 200
    
    # Can we render homepage?
    response = client.get("/")
    assert response.status_code == 200
    assert "Welcome" in response.text
    
    # Basic functionality works?
    assert calculate_price(100, 0.1) == 90
    
    print("✓ Smoke tests passed")', 'Smoke tests verify basic functionality. Quick sanity check. Run after deployment. Catch major breaks early. Not comprehensive.', 1, 10),
(4, 28, 'Test Doubles', '// Test double types:

// Dummy - passed but not used
void test_log(DummyLogger logger) { /* ... */ }

// Stub - returns canned responses
class StubDatabase {
    User getUser(int id) { return User("Test", 25); }
};

// Spy - records calls
class SpyEmailer {
    vector<string> sent;
    void send(string email) { sent.push_back(email); }
};

// Mock - verifies interactions
class MockPayment {
    void charge(double amount) {
        assert(amount == 99.99);
    }
};', 'Test doubles isolate units. Dummy: unused parameter. Stub: fixed responses. Spy: records calls. Mock: verifies behavior. Faster tests.', 3, 10),
(4, 29, 'Chaos Engineering', 'import random
import time

class ChaosMonkey:
    def __init__(self, failure_rate=0.1):
        self.failure_rate = failure_rate
    
    def maybe_fail(self):
        if random.random() < self.failure_rate:
            raise Exception("Chaos strike!")
    
    def add_latency(self, max_ms=1000):
        delay = random.uniform(0, max_ms) / 1000
        time.sleep(delay)
    
    def corrupt_data(self, data):
        if random.random() < self.failure_rate:
            # Flip random bit
            byte_array = bytearray(data)
            byte_array[random.randint(0, len(data)-1)] ^= 1
            return bytes(byte_array)', 'Chaos engineering tests resilience. Inject failures randomly. Network delays, crashes, corruption. Find weaknesses before production. Netflix pioneered.', 1, 10),
(4, 30, 'End-to-End Testing', 'from selenium import webdriver
from selenium.webdriver.common.by import By

def test_user_journey():
    driver = webdriver.Chrome()
    
    # Navigate to site
    driver.get("http://localhost:3000")
    
    # Login
    driver.find_element(By.ID, "username").send_keys("user")
    driver.find_element(By.ID, "password").send_keys("pass")
    driver.find_element(By.ID, "login-btn").click()
    
    # Verify dashboard
    assert "Dashboard" in driver.title
    
    # Complete purchase flow
    driver.find_element(By.CLASS_NAME, "product").click()
    driver.find_element(By.ID, "add-to-cart").click()
    driver.find_element(By.ID, "checkout").click()', 'E2E tests complete user workflows. Real browser automation. Selenium, Cypress, Playwright. Slow but catch integration issues. Critical paths only.', 1, 10);