-- Snippets pour Janvier 2024
-- 60% C, 20% C++, 20% autres langages

-- 1er Janvier - Pointeurs de Fonctions (C)
INSERT INTO snippets (date, title, code, explanation, difficulty, category_id, language_id) VALUES (
    '2024-01-01',
    'Pointeurs de Fonctions',
    '#include <stdio.h>

typedef int (*operation_t)(int, int);

int add(int a, int b) { return a + b; }
int multiply(int a, int b) { return a * b; }

int execute_operation(operation_t op, int x, int y) {
    return op(x, y);
}

int main() {
    operation_t operations[] = {add, multiply};
    printf("Add: %d\n", execute_operation(operations[0], 5, 3));
    printf("Multiply: %d\n", execute_operation(operations[1], 5, 3));
    return 0;
}',
    'Les pointeurs de fonctions permettent de passer des fonctions comme paramètres. Ici, operation_t est un type de pointeur vers une fonction qui prend deux int et retourne un int. Très utile pour les callbacks et les algorithmes génériques.',
    'Intermédiaire',
    1, -- Memory Management
    1  -- C
);

-- 2 Janvier - Union avec Bit Fields (C)
INSERT INTO snippets (date, title, code, explanation, difficulty, category_id, language_id) VALUES (
    '2024-01-02',
    'Union avec Bit Fields',
    '#include <stdio.h>

union Color {
    struct {
        unsigned char r : 8;
        unsigned char g : 8;
        unsigned char b : 8;
        unsigned char a : 8;
    } rgba;
    unsigned int value;
};

int main() {
    union Color color;
    color.rgba.r = 255;
    color.rgba.g = 128;
    color.rgba.b = 64;
    color.rgba.a = 255;
    
    printf("RGBA: %d,%d,%d,%d\n", 
           color.rgba.r, color.rgba.g, color.rgba.b, color.rgba.a);
    printf("Hex: 0x%08X\n", color.value);
    return 0;
}',
    'Les unions permettent de partager la même mémoire entre différents types. Les bit fields (:8) permettent de contrôler précisément la taille de chaque champ. Ici, on peut accéder aux couleurs soit individuellement, soit comme un entier 32-bit.',
    'Avancé',
    2, -- Data Structures
    1  -- C
);

-- 3 Janvier - Macro avec Token Pasting (C)
INSERT INTO snippets (date, title, code, explanation, difficulty, category_id, language_id) VALUES (
    '2024-01-03',
    'Macro avec Token Pasting',
    '#include <stdio.h>

#define CONCAT(a, b) a##b
#define MAKE_VAR(name) CONCAT(var_, name)

int main() {
    int MAKE_VAR(x) = 42;
    int MAKE_VAR(y) = 100;
    
    printf("var_x = %d\n", var_x);
    printf("var_y = %d\n", var_y);
    
    // Équivalent à: int var_x = 42; int var_y = 100;
    return 0;
}',
    'L''opérateur ## (token pasting) permet de concaténer des tokens lors de la précompilation. MAKE_VAR(x) devient var_x. Très utile pour générer du code de manière automatique et éviter la répétition.',
    'Avancé',
    3, -- Template Metaprogramming
    1  -- C
);

-- 4 Janvier - Gestion d''Erreurs avec errno (C)
INSERT INTO snippets (date, title, code, explanation, difficulty, category_id, language_id) VALUES (
    '2024-01-04',
    'Gestion d''Erreurs avec errno',
    '#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <stdlib.h>

void* safe_malloc(size_t size) {
    errno = 0;
    void* ptr = malloc(size);
    
    if (ptr == NULL) {
        fprintf(stderr, "malloc failed: %s (errno: %d)\n", 
                strerror(errno), errno);
        exit(EXIT_FAILURE);
    }
    
    return ptr;
}

int main() {
    int* arr = safe_malloc(1000 * sizeof(int));
    printf("Allocation réussie\n");
    free(arr);
    return 0;
}',
    'errno est une variable globale qui contient le code d''erreur de la dernière fonction système. strerror() convertit ce code en message lisible. Bonne pratique pour la gestion d''erreurs robuste.',
    'Intermédiaire',
    4, -- Error Handling
    1  -- C
);

-- 5 Janvier - Structure avec Padding (C)
INSERT INTO snippets (date, title, code, explanation, difficulty, category_id, language_id) VALUES (
    '2024-01-05',
    'Structure avec Padding',
    '#include <stdio.h>

struct Packed {
    char a;     // 1 byte
    int b;      // 4 bytes
    char c;     // 1 byte
};

struct Optimized {
    int b;      // 4 bytes
    char a;     // 1 byte
    char c;     // 1 byte
};

int main() {
    printf("Packed: %zu bytes\n", sizeof(struct Packed));
    printf("Optimized: %zu bytes\n", sizeof(struct Optimized));
    return 0;
}',
    'L''ordre des champs dans une structure affecte sa taille à cause du padding (alignement mémoire). Le compilateur ajoute des octets vides pour aligner les données sur les frontières optimales du processeur.',
         'Intermédiaire',
     2, -- Data Structures
     1  -- C
 );

-- 6 Janvier - Fonction Variadic (C)
INSERT INTO snippets (date, title, code, explanation, difficulty, category_id, language_id) VALUES (
    '2024-01-06',
    'Fonction Variadic',
    '#include <stdio.h>
#include <stdarg.h>

int sum(int count, ...) {
    va_list args;
    va_start(args, count);
    
    int total = 0;
    for (int i = 0; i < count; i++) {
        total += va_arg(args, int);
    }
    
    va_end(args);
    return total;
}

int main() {
    printf("Sum(3, 1, 2, 3) = %d\n", sum(3, 1, 2, 3));
    printf("Sum(5, 10, 20, 30, 40, 50) = %d\n", sum(5, 10, 20, 30, 40, 50));
    return 0;
}',
    'Les fonctions variadic acceptent un nombre variable d''arguments. va_list, va_start, va_arg, et va_end permettent de parcourir ces arguments. Utilisé dans printf, scanf, etc.',
    'Intermédiaire',
    5, -- Advanced Functions
    1  -- C
);

-- 7 Janvier - Pointeur vers Tableau (C)
INSERT INTO snippets (date, title, code, explanation, difficulty, category_id, language_id) VALUES (
    '2024-01-07',
    'Pointeur vers Tableau',
    '#include <stdio.h>

int main() {
    int matrix[3][4] = {
        {1, 2, 3, 4},
        {5, 6, 7, 8},
        {9, 10, 11, 12}
    };
    
    int (*row)[4] = matrix;  // Pointeur vers un tableau de 4 int
    
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 4; j++) {
            printf("%2d ", row[i][j]);
        }
        printf("\n");
    }
    return 0;
}',
    'int (*row)[4] est un pointeur vers un tableau de 4 entiers. Permet de manipuler des tableaux multidimensionnels de manière élégante. La syntaxe (*row)[4] indique que row est un pointeur vers un tableau de 4 éléments.',
    'Avancé',
    1, -- Memory Management
    1  -- C
);

-- 8 Janvier - Const Qualifier Avancé (C)
INSERT INTO snippets (date, title, code, explanation, difficulty, category_id, language_id) VALUES (
    '2024-01-08',
    'Const Qualifier Avancé',
    '#include <stdio.h>

void print_string(const char* const str) {
    // str = "new";        // Erreur: str est const
    // str[0] = ''X'';       // Erreur: *str est const
    printf("%s\n", str);
}

int main() {
    const char* const message = "Hello World";
    print_string(message);
    return 0;
}',
    'const char* const str signifie que le pointeur ET ce qu''il pointe sont constants. Impossible de changer l''adresse du pointeur ou le contenu pointé. Garantit l''immutabilité des données.',
    'Intermédiaire',
    6, -- Type Safety
    1  -- C
);

-- 9 Janvier - Inline Assembly (C)
INSERT INTO snippets (date, title, code, explanation, difficulty, category_id, language_id) VALUES (
    '2024-01-09',
    'Inline Assembly',
    '#include <stdio.h>

int get_cpu_info() {
    int info;
    __asm__ volatile (
        "cpuid"
        : "=a" (info)
        : "a" (1)
        : "ebx", "ecx", "edx"
    );
    return info;
}

int main() {
    int cpu_info = get_cpu_info();
    printf("CPU Info: 0x%08X\n", cpu_info);
    return 0;
}',
    'L''assembly inline permet d''utiliser directement les instructions du processeur. cpuid retourne des informations sur le CPU. Les contraintes "=a" et "a" spécifient les registres à utiliser.',
    'Expert',
    7, -- Low Level Programming
    1  -- C
);

-- 10 Janvier - Fonction Static Inline (C)
INSERT INTO snippets (date, title, code, explanation, difficulty, category_id, language_id) VALUES (
    '2024-01-10',
    'Fonction Static Inline',
    '#include <stdio.h>

static inline int min(int a, int b) {
    return (a < b) ? a : b;
}

static inline int max(int a, int b) {
    return (a > b) ? a : b;
}

int main() {
    printf("min(5, 3) = %d\n", min(5, 3));
    printf("max(5, 3) = %d\n", max(5, 3));
    return 0;
}',
    'static inline combine deux optimisations : static limite la visibilité au fichier, inline suggère au compilateur de remplacer l''appel par le code de la fonction. Améliore les performances pour les petites fonctions.',
         'Débutant',
     5, -- Advanced Functions
     1  -- C
 );

-- 11 Janvier - Templates C++ (C++)
INSERT INTO snippets (date, title, code, explanation, difficulty, category_id, language_id) VALUES (
    '2024-01-11',
    'Templates C++',
    '#include <iostream>
#include <vector>

template<typename T>
class Stack {
private:
    std::vector<T> data;
    
public:
    void push(const T& item) {
        data.push_back(item);
    }
    
    T pop() {
        if (data.empty()) {
            throw std::runtime_error("Stack is empty");
        }
        T item = data.back();
        data.pop_back();
        return item;
    }
    
    bool empty() const {
        return data.empty();
    }
};

int main() {
    Stack<int> intStack;
    Stack<std::string> stringStack;
    
    intStack.push(42);
    stringStack.push("Hello");
    
    std::cout << intStack.pop() << std::endl;
    std::cout << stringStack.pop() << std::endl;
    return 0;
}',
    'Les templates permettent de créer du code générique qui fonctionne avec différents types. Ici, la classe Stack peut être utilisée avec int, string, ou tout autre type. Le compilateur génère automatiquement le code spécifique à chaque type.',
    'Intermédiaire',
    3, -- Template Metaprogramming
     2  -- C++
);

-- 12 Janvier - Smart Pointers (C++)
INSERT INTO snippets (date, title, code, explanation, difficulty, category_id, language_id) VALUES (
    '2024-01-12',
    'Smart Pointers',
    '#include <iostream>
#include <memory>

class Resource {
public:
    Resource() { std::cout << "Resource created\n"; }
    ~Resource() { std::cout << "Resource destroyed\n"; }
    void use() { std::cout << "Resource used\n"; }
};

int main() {
    // unique_ptr - propriété exclusive
    std::unique_ptr<Resource> ptr1 = std::make_unique<Resource>();
    ptr1->use();
    
    // shared_ptr - propriété partagée
    std::shared_ptr<Resource> ptr2 = std::make_shared<Resource>();
    std::shared_ptr<Resource> ptr3 = ptr2; // Compteur de références incrémenté
    ptr2->use();
    ptr3->use();
    
    // weak_ptr - référence faible (ne compte pas pour la destruction)
    std::weak_ptr<Resource> weak = ptr2;
    
    return 0; // Destruction automatique
}',
    'Les smart pointers gèrent automatiquement la mémoire. unique_ptr garantit la propriété exclusive, shared_ptr permet le partage avec comptage de références, weak_ptr évite les cycles de références. Plus besoin de delete manuel !',
    'Avancé',
    1, -- Memory Management
     2  -- C++
);

-- 13 Janvier - Lambda Expressions (C++)
INSERT INTO snippets (date, title, code, explanation, difficulty, category_id, language_id) VALUES (
    '2024-01-13',
    'Lambda Expressions',
    '#include <iostream>
#include <vector>
#include <algorithm>

int main() {
    std::vector<int> numbers = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
    
    // Lambda simple
    auto print = [](int n) { std::cout << n << " "; };
    
    // Lambda avec capture
    int threshold = 5;
    auto countAbove = [threshold](int n) { return n > threshold; };
    
    // Lambda avec capture par référence
    int sum = 0;
    auto accumulate = [&sum](int n) { sum += n; };
    
    std::for_each(numbers.begin(), numbers.end(), print);
    std::cout << std::endl;
    
    int count = std::count_if(numbers.begin(), numbers.end(), countAbove);
    std::cout << "Numbers above " << threshold << ": " << count << std::endl;
    
    std::for_each(numbers.begin(), numbers.end(), accumulate);
    std::cout << "Sum: " << sum << std::endl;
    
    return 0;
}',
    'Les lambda expressions permettent de créer des fonctions anonymes inline. [capture](params) { body } capture permet d''accéder aux variables locales, & pour capture par référence, = pour capture par valeur.',
    'Intermédiaire',
    5, -- Advanced Functions
     2  -- C++
);

-- 14 Janvier - Move Semantics (C++)
INSERT INTO snippets (date, title, code, explanation, difficulty, category_id, language_id) VALUES (
    '2024-01-14',
    'Move Semantics',
    '#include <iostream>
#include <vector>

class Buffer {
private:
    int* data;
    size_t size;
    
public:
    Buffer(size_t s) : size(s) {
        data = new int[s];
        std::cout << "Constructor: " << s << " elements\n";
    }
    
    // Move constructor
    Buffer(Buffer&& other) noexcept 
        : data(other.data), size(other.size) {
        other.data = nullptr;
        other.size = 0;
        std::cout << "Move constructor\n";
    }
    
    // Move assignment
    Buffer& operator=(Buffer&& other) noexcept {
        if (this != &other) {
            delete[] data;
            data = other.data;
            size = other.size;
            other.data = nullptr;
            other.size = 0;
            std::cout << "Move assignment\n";
        }
        return *this;
    }
    
    ~Buffer() {
        delete[] data;
        std::cout << "Destructor\n";
    }
};

int main() {
    Buffer b1(1000);
    Buffer b2 = std::move(b1); // Move constructor
    Buffer b3(500);
    b3 = std::move(b2);        // Move assignment
    return 0;
}',
    'Move semantics évite les copies coûteuses en "volant" les ressources d''un objet temporaire. std::move() convertit une l-value en r-value, permettant l''utilisation du move constructor/assignment. Améliore significativement les performances.',
    'Expert',
    1, -- Memory Management
     2  -- C++
);

-- 15 Janvier - Python Decorators (Python)
INSERT INTO snippets (date, title, code, explanation, difficulty, category_id, language_id) VALUES (
    '2024-01-15',
    'Python Decorators',
    'import time
import functools

def timer(func):
    @functools.wraps(func)
    def wrapper(*args, **kwargs):
        start = time.time()
        result = func(*args, **kwargs)
        end = time.time()
        print(f"{func.__name__} took {end - start:.4f} seconds")
        return result
    return wrapper

def cache(func):
    memo = {}
    @functools.wraps(func)
    def wrapper(*args):
        if args not in memo:
            memo[args] = func(*args)
        return memo[args]
    return wrapper

@timer
@cache
def fibonacci(n):
    if n < 2:
        return n
    return fibonacci(n-1) + fibonacci(n-2)

# Test
print(fibonacci(30))
print(fibonacci(30))  # Cached result',
    'Les décorateurs Python permettent de modifier le comportement d''une fonction sans changer son code. @timer mesure le temps d''exécution, @cache mémorise les résultats. functools.wraps préserve les métadonnées de la fonction originale.',
    'Intermédiaire',
    8, -- Functional Programming
     3  -- Python
);

-- 16 Janvier - Rust Ownership (Rust)
INSERT INTO snippets (date, title, code, explanation, difficulty, category_id, language_id) VALUES (
    '2024-01-16',
    'Rust Ownership',
    'fn main() {
    let s1 = String::from("hello");
    let s2 = s1; // s1 est "déplacé" vers s2, s1 n''est plus valide
    
    // println!("{}", s1); // Erreur: s1 a été déplacé
    println!("{}", s2); // OK
    
    let s3 = s2.clone(); // Copie explicite
    println!("{}", s2); // OK car clone() ne déplace pas
    println!("{}", s3);
    
    let x = 5;
    let y = x; // Copie car i32 implémente Copy
    println!("x: {}, y: {}", x, y); // OK
    
    // Borrowing
    let mut s4 = String::from("world");
    let len = calculate_length(&s4); // Référence immuable
    println!("Length of '{}' is {}", s4, len);
    
    change_string(&mut s4); // Référence mutable
    println!("Changed: {}", s4);
}

fn calculate_length(s: &String) -> usize {
    s.len()
}

fn change_string(s: &mut String) {
    s.push_str("!");
}',
    'Le système d''ownership de Rust garantit la sécurité mémoire sans garbage collector. Chaque valeur a un propriétaire unique. Les références permettent l''emprunt sans transfert de propriété. Le compilateur vérifie tout à la compilation.',
    'Avancé',
    6, -- Type Safety
     4  -- Rust
);

-- 17 Janvier - JavaScript Promises (JavaScript)
INSERT INTO snippets (date, title, code, explanation, difficulty, category_id, language_id) VALUES (
    '2024-01-17',
    'JavaScript Promises',
    '// Création d''une Promise
function fetchData(url) {
    return new Promise((resolve, reject) => {
        setTimeout(() => {
            if (url.includes("error")) {
                reject(new Error("Network error"));
            } else {
                resolve({ data: "Success!", url: url });
            }
        }, 1000);
    });
}

// Utilisation avec .then() et .catch()
fetchData("https://api.example.com/data")
    .then(response => {
        console.log("Success:", response.data);
        return fetchData("https://api.example.com/more");
    })
    .then(response => {
        console.log("Second success:", response.data);
    })
    .catch(error => {
        console.error("Error:", error.message);
    });

// Utilisation avec async/await
async function processData() {
    try {
        const result1 = await fetchData("https://api.example.com/data");
        console.log("Async result:", result1.data);
        
        const result2 = await fetchData("https://api.example.com/more");
        console.log("Second async result:", result2.data);
    } catch (error) {
        console.error("Async error:", error.message);
    }
}

processData();',
    'Les Promises gèrent les opérations asynchrones de manière élégante. .then() traite le succès, .catch() gère les erreurs. async/await rend le code asynchrone plus lisible en le faisant ressembler à du code synchrone.',
    'Intermédiaire',
    9, -- Asynchronous Programming
     5  -- JavaScript
);

-- 18 Janvier - Go Goroutines (Go)
INSERT INTO snippets (date, title, code, explanation, difficulty, category_id, language_id) VALUES (
    '2024-01-18',
    'Go Goroutines',
    'package main

import (
    "fmt"
    "sync"
    "time"
)

func worker(id int, jobs <-chan int, results chan<- int, wg *sync.WaitGroup) {
    defer wg.Done()
    
    for job := range jobs {
        fmt.Printf("Worker %d processing job %d\n", id, job)
        time.Sleep(time.Millisecond * 500) // Simuler du travail
        results <- job * 2
    }
}

func main() {
    const numJobs = 10
    const numWorkers = 3
    
    jobs := make(chan int, numJobs)
    results := make(chan int, numJobs)
    
    var wg sync.WaitGroup
    
    // Démarrer les workers
    for i := 1; i <= numWorkers; i++ {
        wg.Add(1)
        go worker(i, jobs, results, &wg)
    }
    
    // Envoyer les jobs
    for i := 1; i <= numJobs; i++ {
        jobs <- i
    }
    close(jobs)
    
    // Attendre que tous les workers terminent
    go func() {
        wg.Wait()
        close(results)
    }()
    
    // Collecter les résultats
    for result := range results {
        fmt.Printf("Result: %d\n", result)
    }
}',
    'Les goroutines sont des threads légers en Go. "go" démarre une nouvelle goroutine. Les channels permettent la communication entre goroutines. sync.WaitGroup synchronise l''attente de la fin des goroutines.',
    'Avancé',
    9, -- Asynchronous Programming
     6  -- Go
);

-- 19 Janvier - C++ RAII (C++)
INSERT INTO snippets (date, title, code, explanation, difficulty, category_id, language_id) VALUES (
    '2024-01-19',
    'RAII Pattern',
    '#include <iostream>
#include <memory>

class FileHandler {
private:
    FILE* file;
    
public:
    FileHandler(const char* filename, const char* mode) {
        file = fopen(filename, mode);
        if (!file) {
            throw std::runtime_error("Cannot open file");
        }
        std::cout << "File opened\n";
    }
    
    ~FileHandler() {
        if (file) {
            fclose(file);
            std::cout << "File closed\n";
        }
    }
    
    void write(const char* data) {
        if (file) {
            fputs(data, file);
        }
    }
    
    // Empêcher la copie
    FileHandler(const FileHandler&) = delete;
    FileHandler& operator=(const FileHandler&) = delete;
};

int main() {
    try {
        FileHandler file("test.txt", "w");
        file.write("Hello RAII!\n");
        // Le fichier est automatiquement fermé à la fin du scope
    } catch (const std::exception& e) {
        std::cerr << "Error: " << e.what() << std::endl;
    }
    return 0;
}',
    'RAII (Resource Acquisition Is Initialization) garantit que les ressources sont libérées automatiquement quand l''objet sort du scope. Le destructeur est appelé même en cas d''exception. Pattern fondamental en C++ moderne.',
    'Intermédiaire',
    1, -- Memory Management
     2  -- C++
);

-- 20 Janvier - C Bit Manipulation (C)
INSERT INTO snippets (date, title, code, explanation, difficulty, category_id, language_id) VALUES (
    '2024-01-20',
    'Bit Manipulation',
    '#include <stdio.h>

// Définir des bits
#define SET_BIT(x, n) ((x) |= (1 << (n)))
#define CLEAR_BIT(x, n) ((x) &= ~(1 << (n)))
#define TOGGLE_BIT(x, n) ((x) ^= (1 << (n)))
#define CHECK_BIT(x, n) ((x) & (1 << (n)))

// Compter les bits à 1
int count_bits(unsigned int x) {
    int count = 0;
    while (x) {
        count += x & 1;
        x >>= 1;
    }
    return count;
}

// Trouver le bit le plus significatif
int find_msb(unsigned int x) {
    int msb = 0;
    while (x >>= 1) {
        msb++;
    }
    return msb;
}

int main() {
    unsigned int flags = 0;
    
    SET_BIT(flags, 0);    // Bit 0 à 1
    SET_BIT(flags, 2);    // Bit 2 à 1
    TOGGLE_BIT(flags, 1); // Bit 1 toggle
    
    printf("Flags: 0x%X\n", flags);
    printf("Bit 0: %s\n", CHECK_BIT(flags, 0) ? "ON" : "OFF");
    printf("Bit 1: %s\n", CHECK_BIT(flags, 1) ? "ON" : "OFF");
    printf("Bit 2: %s\n", CHECK_BIT(flags, 2) ? "ON" : "OFF");
    
    printf("Bits set: %d\n", count_bits(flags));
    printf("MSB: %d\n", find_msb(flags));
    
    return 0;
}',
    'La manipulation de bits permet d''optimiser l''utilisation de la mémoire et d''accélérer certaines opérations. Les macros définissent des opérations courantes. Utile pour les flags, les masques, et l''optimisation.',
         'Avancé',
     7, -- Low Level Programming
     1  -- C
 );

-- 21 Janvier - C++ Constexpr (C++)
INSERT INTO snippets (date, title, code, explanation, difficulty, category_id, language_id) VALUES (
    '2024-01-21',
    'Constexpr Functions',
    '#include <iostream>

constexpr int factorial(int n) {
    return (n <= 1) ? 1 : n * factorial(n - 1);
}

constexpr int fibonacci(int n) {
    return (n <= 1) ? n : fibonacci(n - 1) + fibonacci(n - 2);
}

constexpr bool is_prime(int n) {
    if (n < 2) return false;
    for (int i = 2; i * i <= n; i++) {
        if (n % i == 0) return false;
    }
    return true;
}

int main() {
    constexpr int fact_5 = factorial(5);    // Calculé à la compilation
    constexpr int fib_10 = fibonacci(10);   // Calculé à la compilation
    constexpr bool prime_17 = is_prime(17); // Calculé à la compilation
    
    std::cout << "5! = " << fact_5 << std::endl;
    std::cout << "fib(10) = " << fib_10 << std::endl;
    std::cout << "17 is prime: " << (prime_17 ? "true" : "false") << std::endl;
    
    // Peut être utilisé dans des contextes constexpr
    int array[factorial(5)]; // Taille calculée à la compilation
    std::cout << "Array size: " << sizeof(array) / sizeof(int) << std::endl;
    
    return 0;
}',
    'constexpr permet d''évaluer des expressions à la compilation plutôt qu''à l''exécution. Améliore les performances en déplaçant les calculs vers la compilation. Peut être utilisé dans des contextes nécessitant des constantes.',
    'Avancé',
    3, -- Template Metaprogramming
     2  -- C++
);

-- 22 Janvier - C Function Pointers Array (C)
INSERT INTO snippets (date, title, code, explanation, difficulty, category_id, language_id) VALUES (
    '2024-01-22',
    'Function Pointers Array',
    '#include <stdio.h>

int add(int a, int b) { return a + b; }
int subtract(int a, int b) { return a - b; }
int multiply(int a, int b) { return a * b; }
int divide(int a, int b) { return b != 0 ? a / b : 0; }

typedef int (*operation_t)(int, int);

int main() {
    operation_t operations[] = {add, subtract, multiply, divide};
    char* op_names[] = {"Add", "Subtract", "Multiply", "Divide"};
    
    int a = 10, b = 3;
    
    for (int i = 0; i < 4; i++) {
        printf("%s(%d, %d) = %d\n", op_names[i], a, b, operations[i](a, b));
    }
    
    // Utilisation comme callback
    int (*callback)(int, int) = operations[1]; // subtract
    printf("Callback result: %d\n", callback(15, 7));
    
    return 0;
}',
    'Un tableau de pointeurs de fonctions permet de sélectionner dynamiquement quelle fonction appeler. Très utile pour les machines à états, les parsers, ou les systèmes de plugins. Permet une programmation plus flexible et modulaire.',
    'Intermédiaire',
    5, -- Advanced Functions
     1  -- C
);

-- 23 Janvier - Python Generators (Python)
INSERT INTO snippets (date, title, code, explanation, difficulty, category_id, language_id) VALUES (
    '2024-01-23',
    'Python Generators',
    'def fibonacci_generator():
    a, b = 0, 1
    while True:
        yield a
        a, b = b, a + b

def prime_generator():
    def is_prime(n):
        if n < 2:
            return False
        for i in range(2, int(n**0.5) + 1):
            if n % i == 0:
                return False
        return True
    
    n = 2
    while True:
        if is_prime(n):
            yield n
        n += 1

def range_generator(start, stop, step=1):
    current = start
    while current < stop:
        yield current
        current += step

# Utilisation
fib = fibonacci_generator()
print("First 10 Fibonacci numbers:")
for i, num in enumerate(fib):
    if i >= 10:
        break
    print(num, end=" ")

print("\n\nFirst 10 prime numbers:")
primes = prime_generator()
for i, prime in enumerate(primes):
    if i >= 10:
        break
    print(prime, end=" ")

print("\n\nCustom range:")
for num in range_generator(0, 20, 3):
    print(num, end=" ")',
    'Les générateurs Python permettent de créer des itérateurs sans stocker toute la séquence en mémoire. yield retourne une valeur et suspend l''exécution jusqu''au prochain appel. Idéal pour les grandes séquences ou les flux de données.',
    'Intermédiaire',
    8, -- Functional Programming
     3  -- Python
);

-- 24 Janvier - C++ Perfect Forwarding (C++)
INSERT INTO snippets (date, title, code, explanation, difficulty, category_id, language_id) VALUES (
    '2024-01-24',
    'Perfect Forwarding',
    '#include <iostream>
#include <utility>

class Widget {
public:
    Widget() { std::cout << "Default constructor\n"; }
    Widget(const Widget&) { std::cout << "Copy constructor\n"; }
    Widget(Widget&&) { std::cout << "Move constructor\n"; }
};

template<typename T>
class Wrapper {
private:
    T value;
    
public:
    // Perfect forwarding constructor
    template<typename U>
    Wrapper(U&& u) : value(std::forward<U>(u)) {
        std::cout << "Wrapper constructor with perfect forwarding\n";
    }
    
    // Perfect forwarding method
    template<typename U>
    void setValue(U&& u) {
        value = std::forward<U>(u);
        std::cout << "setValue with perfect forwarding\n";
    }
};

void processWidget(const Widget& w) {
    std::cout << "Processing const Widget\n";
}

void processWidget(Widget&& w) {
    std::cout << "Processing rvalue Widget\n";
}

int main() {
    Widget w1;
    const Widget w2;
    
    Wrapper<Widget> wrapper1(w1);           // Copy
    Wrapper<Widget> wrapper2(std::move(w1)); // Move
    Wrapper<Widget> wrapper3(w2);           // Copy (const)
    
    wrapper1.setValue(w2);                  // Copy
    wrapper1.setValue(Widget());            // Move
    
    return 0;
}',
    'Perfect forwarding permet de préserver la catégorie de valeur (l-value/r-value) lors du passage de paramètres. std::forward<U>(u) préserve la valeur exacte de u. Essentiel pour les templates génériques et les constructeurs universels.',
    'Expert',
    3, -- Template Metaprogramming
     2  -- C++
);

-- 25 Janvier - C Variadic Macros (C)
INSERT INTO snippets (date, title, code, explanation, difficulty, category_id, language_id) VALUES (
    '2024-01-25',
    'Variadic Macros',
    '#include <stdio.h>

#define DEBUG_PRINT(fmt, ...) \
    printf("[DEBUG] " fmt "\n", ##__VA_ARGS__)

#define LOG_ERROR(fmt, ...) \
    fprintf(stderr, "[ERROR] %s:%d: " fmt "\n", \
            __FILE__, __LINE__, ##__VA_ARGS__)

#define ASSERT(condition, ...) \
    do { \
        if (!(condition)) { \
            LOG_ERROR(__VA_ARGS__); \
            exit(1); \
        } \
    } while(0)

#define COUNT_ARGS(...) \
    (sizeof((int[]){__VA_ARGS__}) / sizeof(int))

int main() {
    DEBUG_PRINT("Application started");
    DEBUG_PRINT("Value: %d, String: %s", 42, "hello");
    
    int x = 10;
    ASSERT(x > 0, "x must be positive");
    ASSERT(x < 100, "x must be less than 100, got %d", x);
    
    printf("Number of args: %zu\n", COUNT_ARGS(1, 2, 3, 4, 5));
    
    return 0;
}',
    'Les macros variadic permettent de créer des macros avec un nombre variable d''arguments. __VA_ARGS__ représente tous les arguments supplémentaires. ##__VA_ARGS__ supprime la virgule si aucun argument n''est fourni. Utile pour le debugging et les assertions.',
    'Avancé',
    3, -- Template Metaprogramming
     1  -- C
);

-- 26 Janvier - Rust Pattern Matching (Rust)
INSERT INTO snippets (date, title, code, explanation, difficulty, category_id, language_id) VALUES (
    '2024-01-26',
    'Rust Pattern Matching',
    'enum Shape {
    Circle(f64),
    Rectangle(f64, f64),
    Triangle(f64, f64, f64),
}

fn area(shape: Shape) -> f64 {
    match shape {
        Shape::Circle(radius) => std::f64::consts::PI * radius * radius,
        Shape::Rectangle(width, height) => width * height,
        Shape::Triangle(a, b, c) => {
            let s = (a + b + c) / 2.0;
            (s * (s - a) * (s - b) * (s - c)).sqrt()
        }
    }
}

fn describe_number(x: i32) -> &''static str {
    match x {
        0 => "zero",
        1 | 2 | 3 => "small",
        4..=10 => "medium",
        _ if x < 0 => "negative",
        _ => "large",
    }
}

fn main() {
    let shapes = vec![
        Shape::Circle(5.0),
        Shape::Rectangle(3.0, 4.0),
        Shape::Triangle(3.0, 4.0, 5.0),
    ];
    
    for shape in shapes {
        println!("Area: {:.2}", area(shape));
    }
    
    println!("{}", describe_number(5));
    println!("{}", describe_number(-3));
}',
    'Le pattern matching en Rust permet de déstructurer et analyser les valeurs de manière exhaustive. match garantit que tous les cas sont couverts. Les patterns peuvent inclure des gardes (if) et des ranges. Plus puissant que switch/case.',
    'Intermédiaire',
    6, -- Type Safety
     4  -- Rust
);

-- 27 Janvier - C++ Type Erasure (C++)
INSERT INTO snippets (date, title, code, explanation, difficulty, category_id, language_id) VALUES (
    '2024-01-27',
    'Type Erasure',
    '#include <iostream>
#include <memory>
#include <vector>

// Interface virtuelle
class Drawable {
public:
    virtual ~Drawable() = default;
    virtual void draw() const = 0;
};

// Implémentations concrètes
class Circle : public Drawable {
private:
    double radius;
public:
    Circle(double r) : radius(r) {}
    void draw() const override {
        std::cout << "Drawing circle with radius " << radius << std::endl;
    }
};

class Rectangle : public Drawable {
private:
    double width, height;
public:
    Rectangle(double w, double h) : width(w), height(h) {}
    void draw() const override {
        std::cout << "Drawing rectangle " << width << "x" << height << std::endl;
    }
};

// Type erasure avec std::function
class Shape {
private:
    std::function<void()> draw_func;
public:
    template<typename T>
    Shape(T&& shape) : draw_func([shape = std::forward<T>(shape)]() {
        shape.draw();
    }) {}
    
    void draw() const {
        draw_func();
    }
};

int main() {
    std::vector<Shape> shapes;
    shapes.emplace_back(Circle(5.0));
    shapes.emplace_back(Rectangle(3.0, 4.0));
    
    for (const auto& shape : shapes) {
        shape.draw();
    }
    
    return 0;
}',
    'Type erasure permet de masquer le type concret derrière une interface commune. std::function permet de stocker des callables de types différents dans le même conteneur. Alternative aux interfaces virtuelles, plus flexible mais avec un overhead.',
    'Expert',
    3, -- Template Metaprogramming
     2  -- C++
);

-- 28 Janvier - C Flexible Array Members (C)
INSERT INTO snippets (date, title, code, explanation, difficulty, category_id, language_id) VALUES (
    '2024-01-28',
    'Flexible Array Members',
    '#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int id;
    int length;
    char data[];  // Flexible array member
} DynamicString;

DynamicString* create_string(const char* str) {
    int len = strlen(str);
    DynamicString* ds = malloc(sizeof(DynamicString) + len + 1);
    
    if (ds) {
        ds->id = 1;
        ds->length = len;
        strcpy(ds->data, str);
    }
    
    return ds;
}

void print_string(DynamicString* ds) {
    printf("ID: %d, Length: %d, Data: %s\n", 
           ds->id, ds->length, ds->data);
}

void free_string(DynamicString* ds) {
    free(ds);
}

int main() {
    DynamicString* str1 = create_string("Hello World");
    DynamicString* str2 = create_string("Flexible Array Members");
    
    print_string(str1);
    print_string(str2);
    
    free_string(str1);
    free_string(str2);
    
    return 0;
}',
    'Les flexible array members permettent d''avoir un tableau de taille variable à la fin d''une structure. Utile pour éviter les allocations multiples et améliorer les performances. La taille totale est calculée dynamiquement lors de l''allocation.',
    'Avancé',
    2, -- Data Structures
     1  -- C
);

-- 29 Janvier - JavaScript Closures (JavaScript)
INSERT INTO snippets (date, title, code, explanation, difficulty, category_id, language_id) VALUES (
    '2024-01-29',
    'JavaScript Closures',
    '// Factory function avec closure
function createCounter(initialValue = 0) {
    let count = initialValue;
    
    return {
        increment: () => ++count,
        decrement: () => --count,
        getValue: () => count,
        reset: () => { count = initialValue; }
    };
}

// Module pattern avec closure
const calculator = (function() {
    let history = [];
    
    function add(a, b) {
        const result = a + b;
        history.push(`${a} + ${b} = ${result}`);
        return result;
    }
    
    function multiply(a, b) {
        const result = a * b;
        history.push(`${a} * ${b} = ${result}`);
        return result;
    }
    
    function getHistory() {
        return [...history];
    }
    
    function clearHistory() {
        history = [];
    }
    
    return {
        add,
        multiply,
        getHistory,
        clearHistory
    };
})();

// Test
const counter1 = createCounter(10);
const counter2 = createCounter(5);

console.log(counter1.increment()); // 11
console.log(counter2.increment()); // 6
console.log(counter1.getValue());  // 11
console.log(counter2.getValue());  // 6

console.log(calculator.add(5, 3));      // 8
console.log(calculator.multiply(4, 7)); // 28
console.log(calculator.getHistory());   // ["5 + 3 = 8", "4 * 7 = 28"]',
    'Les closures permettent à une fonction d''accéder aux variables de son scope externe même après que ce scope soit fermé. Créent un état privé et persistent entre les appels. Fondamentales pour le module pattern et la programmation fonctionnelle.',
    'Intermédiaire',
    8, -- Functional Programming
     5  -- JavaScript
);

-- 30 Janvier - C++ CRTP (C++)
INSERT INTO snippets (date, title, code, explanation, difficulty, category_id, language_id) VALUES (
    '2024-01-30',
    'CRTP Pattern',
    '#include <iostream>

// Base class template
template<typename Derived>
class Base {
public:
    void interface() {
        static_cast<Derived*>(this)->implementation();
    }
    
    void implementation() {
        std::cout << "Base implementation\n";
    }
};

// Derived classes
class Derived1 : public Base<Derived1> {
public:
    void implementation() {
        std::cout << "Derived1 implementation\n";
    }
};

class Derived2 : public Base<Derived2> {
    // Utilise l''implémentation de base
};

// Singleton avec CRTP
template<typename T>
class Singleton {
protected:
    Singleton() = default;
public:
    static T& getInstance() {
        static T instance;
        return instance;
    }
    
    Singleton(const Singleton&) = delete;
    Singleton& operator=(const Singleton&) = delete;
};

class Logger : public Singleton<Logger> {
public:
    void log(const std::string& message) {
        std::cout << "Log: " << message << std::endl;
    }
};

int main() {
    Derived1 d1;
    Derived2 d2;
    
    d1.interface(); // Appelle Derived1::implementation
    d2.interface(); // Appelle Base::implementation
    
    Logger::getInstance().log("Hello CRTP!");
    
    return 0;
}',
    'CRTP (Curiously Recurring Template Pattern) permet l''héritage statique et le polymorphisme à la compilation. La classe de base connaît le type dérivé via le template. Évite le coût des fonctions virtuelles et permet l''optimisation à la compilation.',
    'Expert',
    3, -- Template Metaprogramming
     2  -- C++
);

-- 31 Janvier - C Duff''s Device (C)
INSERT INTO snippets (date, title, code, explanation, difficulty, category_id, language_id) VALUES (
    '2024-01-31',
    'Duff''s Device',
    '#include <stdio.h>

void duff_copy(char* to, char* from, int count) {
    int n = (count + 7) / 8;
    
    switch (count % 8) {
        case 0: do { *to++ = *from++;
        case 7:      *to++ = *from++;
        case 6:      *to++ = *from++;
        case 5:      *to++ = *from++;
        case 4:      *to++ = *from++;
        case 3:      *to++ = *from++;
        case 2:      *to++ = *from++;
        case 1:      *to++ = *from++;
                } while (--n > 0);
    }
}

void normal_copy(char* to, char* from, int count) {
    while (count-- > 0) {
        *to++ = *from++;
    }
}

int main() {
    char source[] = "Hello, Duff''s Device!";
    char dest1[50] = {0};
    char dest2[50] = {0};
    
    duff_copy(dest1, source, 22);
    normal_copy(dest2, source, 22);
    
    printf("Duff''s copy: %s\n", dest1);
    printf("Normal copy: %s\n", dest2);
    
    return 0;
}',
    'Duff''s Device est une technique d''optimisation qui déroule une boucle en utilisant un switch et des fall-through cases. Réduit le nombre de tests de condition dans la boucle. Exemple classique de programmation créative mais controversée.',
    'Expert',
    7, -- Low Level Programming
     1  -- C
);
