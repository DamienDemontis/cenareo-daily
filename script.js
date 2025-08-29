// Epitech Nancy Daily Dashboard Script
// All widget logic will be added here. 

document.addEventListener('DOMContentLoaded', () => {
    // --- Date Widget ---
    const dateElement = document.getElementById('date');

    function updateDate() {
        const now = new Date();
        const dateString = now.toLocaleDateString('fr-FR', {
            weekday: 'long',
            year: 'numeric',
            month: 'long',
            day: 'numeric'
        });
        dateElement.textContent = dateString.charAt(0).toUpperCase() + dateString.slice(1);
    }
    
    updateDate();

    // --- Weather Widget ---
    const weatherContent = document.getElementById('weather-content');
    const WEATHER_CODES = {
        "0": { "day": { "description": "Ensoleillé", "image": "http://openweathermap.org/img/wn/01d@2x.png" }, "night": { "description": "Ciel Dégagé", "image": "http://openweathermap.org/img/wn/01n@2x.png" } },
        "1": { "day": { "description": "Plutôt Ensoleillé", "image": "http://openweathermap.org/img/wn/01d@2x.png" }, "night": { "description": "Plutôt Dégagé", "image": "http://openweathermap.org/img/wn/01n@2x.png" } },
        "2": { "day": { "description": "Partiellement Nuageux", "image": "http://openweathermap.org/img/wn/02d@2x.png" }, "night": { "description": "Partiellement Nuageux", "image": "http://openweathermap.org/img/wn/02n@2x.png" } },
        "3": { "day": { "description": "Nuageux", "image": "http://openweathermap.org/img/wn/03d@2x.png" }, "night": { "description": "Nuageux", "image": "http://openweathermap.org/img/wn/03n@2x.png" } },
        "45": { "day": { "description": "Brouillard", "image": "http://openweathermap.org/img/wn/50d@2x.png" }, "night": { "description": "Brouillard", "image": "http://openweathermap.org/img/wn/50n@2x.png" } },
        "48": { "day": { "description": "Brouillard Grivant", "image": "http://openweathermap.org/img/wn/50d@2x.png" }, "night": { "description": "Brouillard Grivant", "image": "http://openweathermap.org/img/wn/50n@2x.png" } },
        "51": { "day": { "description": "Bruine Légère", "image": "http://openweathermap.org/img/wn/09d@2x.png" }, "night": { "description": "Bruine Légère", "image": "http://openweathermap.org/img/wn/09n@2x.png" } },
        "53": { "day": { "description": "Bruine", "image": "http://openweathermap.org/img/wn/09d@2x.png" }, "night": { "description": "Bruine", "image": "http://openweathermap.org/img/wn/09n@2x.png" } },
        "55": { "day": { "description": "Bruine Forte", "image": "http://openweathermap.org/img/wn/09d@2x.png" }, "night": { "description": "Bruine Forte", "image": "http://openweathermap.org/img/wn/09n@2x.png" } },
        "56": { "day": { "description": "Légère Bruine Verglaçante", "image": "http://openweathermap.org/img/wn/09d@2x.png" }, "night": { "description": "Légère Bruine Verglaçante", "image": "http://openweathermap.org/img/wn/09n@2x.png" } },
        "57": { "day": { "description": "Bruine Verglaçante", "image": "http://openweathermap.org/img/wn/09d@2x.png" }, "night": { "description": "Bruine Verglaçante", "image": "http://openweathermap.org/img/wn/09n@2x.png" } },
        "61": { "day": { "description": "Pluie Légère", "image": "http://openweathermap.org/img/wn/10d@2x.png" }, "night": { "description": "Pluie Légère", "image": "http://openweathermap.org/img/wn/10n@2x.png" } },
        "63": { "day": { "description": "Pluie", "image": "http://openweathermap.org/img/wn/10d@2x.png" }, "night": { "description": "Pluie", "image": "http://openweathermap.org/img/wn/10n@2x.png" } },
        "65": { "day": { "description": "Grosse Pluie", "image": "http://openweathermap.org/img/wn/10d@2x.png" }, "night": { "description": "Grosse Pluie", "image": "http://openweathermap.org/img/wn/10n@2x.png" } },
        "66": { "day": { "description": "Pluie Verglaçante Légère", "image": "http://openweathermap.org/img/wn/10d@2x.png" }, "night": { "description": "Pluie Verglaçante Légère", "image": "http://openweathermap.org/img/wn/10n@2x.png" } },
        "67": { "day": { "description": "Pluie Verglaçante", "image": "http://openweathermap.org/img/wn/10d@2x.png" }, "night": { "description": "Pluie Verglaçante", "image": "http://openweathermap.org/img/wn/10n@2x.png" } },
        "71": { "day": { "description": "Neige Légère", "image": "http://openweathermap.org/img/wn/13d@2x.png" }, "night": { "description": "Neige Légère", "image": "http://openweathermap.org/img/wn/13n@2x.png" } },
        "73": { "day": { "description": "Neige", "image": "http://openweathermap.org/img/wn/13d@2x.png" }, "night": { "description": "Neige", "image": "http://openweathermap.org/img/wn/13n@2x.png" } },
        "75": { "day": { "description": "Grosse Neige", "image": "http://openweathermap.org/img/wn/13d@2x.png" }, "night": { "description": "Grosse Neige", "image": "http://openweathermap.org/img/wn/13n@2x.png" } },
        "77": { "day": { "description": "Grains de Neige", "image": "http://openweathermap.org/img/wn/13d@2x.png" }, "night": { "description": "Grains de Neige", "image": "http://openweathermap.org/img/wn/13n@2x.png" } },
        "80": { "day": { "description": "Averses Légères", "image": "http://openweathermap.org/img/wn/09d@2x.png" }, "night": { "description": "Averses Légères", "image": "http://openweathermap.org/img/wn/09n@2x.png" } },
        "81": { "day": { "description": "Averses", "image": "http://openweathermap.org/img/wn/09d@2x.png" }, "night": { "description": "Averses", "image": "http://openweathermap.org/img/wn/09n@2x.png" } },
        "82": { "day": { "description": "Averses Violentes", "image": "http://openweathermap.org/img/wn/09d@2x.png" }, "night": { "description": "Averses Violentes", "image": "http://openweathermap.org/img/wn/09n@2x.png" } },
        "85": { "day": { "description": "Averses de Neige Légères", "image": "http://openweathermap.org/img/wn/13d@2x.png" }, "night": { "description": "Averses de Neige Légères", "image": "http://openweathermap.org/img/wn/13n@2x.png" } },
        "86": { "day": { "description": "Averses de Neige", "image": "http://openweathermap.org/img/wn/13d@2x.png" }, "night": { "description": "Averses de Neige", "image": "http://openweathermap.org/img/wn/13n@2x.png" } },
        "95": { "day": { "description": "Orage", "image": "http://openweathermap.org/img/wn/11d@2x.png" }, "night": { "description": "Orage", "image": "http://openweathermap.org/img/wn/11n@2x.png" } },
        "96": { "day": { "description": "Orage avec Grêle", "image": "http://openweathermap.org/img/wn/11d@2x.png" }, "night": { "description": "Orage avec Grêle", "image": "http://openweathermap.org/img/wn/11n@2x.png" } },
        "99": { "day": { "description": "Orage avec Grosse Grêle", "image": "http://openweathermap.org/img/wn/11d@2x.png" }, "night": { "description": "Orage avec Grosse Grêle", "image": "http://openweathermap.org/img/wn/11n@2x.png" } }
    };

    function getWeatherInfo(code) {
        // For simplicity, we'll always use the 'day' variant.
        // A more complex version could check sunrise/sunset times.
        return WEATHER_CODES[code]?.day || { description: 'Inconnu', image: '' };
    }

    async function fetchWeather() {
        const lat = 48.69;
        const lon = 6.18;
        const url = `https://api.open-meteo.com/v1/forecast?latitude=${lat}&longitude=${lon}&current_weather=true&daily=weathercode,temperature_2m_max,temperature_2m_min&timezone=auto&forecast_days=4`;

        try {
            const response = await fetch(url);
            if (!response.ok) {
                throw new Error(`Erreur HTTP: ${response.status}`);
            }
            const data = await response.json();

            // Current weather
            const current = data.current_weather;
            const weatherInfo = getWeatherInfo(current.weathercode);

            let html = `
                <div class="weather-current">
                    <img src="${weatherInfo.image}" alt="${weatherInfo.description}" class="weather-icon-large">
                    <div class="weather-current-temp">${Math.round(current.temperature)}°C</div>
                    <div class="weather-current-desc">${weatherInfo.description}</div>
                </div>
                <div class="weather-forecast">
            `;

            // Daily forecast
            for (let i = 0; i < data.daily.time.length; i++) {
                const date = new Date(data.daily.time[i]);
                const dayName = date.toLocaleDateString('fr-FR', { weekday: 'short' });
                const forecastInfo = getWeatherInfo(data.daily.weathercode[i]);
                html += `
                    <div class="forecast-day">
                        <div class="forecast-day-name">${dayName.charAt(0).toUpperCase() + dayName.slice(1)}</div>
                        <img src="${forecastInfo.image}" alt="${forecastInfo.description}" class="weather-icon-small">
                        <div class="forecast-day-temp">
                            <span class="temp-max">${Math.round(data.daily.temperature_2m_max[i])}°</span> / 
                            <span class="temp-min">${Math.round(data.daily.temperature_2m_min[i])}°</span>
                        </div>
                    </div>
                `;
            }

            html += `</div>`;
            weatherContent.innerHTML = html;

        } catch (error) {
            console.error("Impossible de récupérer la météo:", error);
            weatherContent.innerHTML = `<p>Impossible de charger les données météo.</p>`;
        }
    }

    fetchWeather();
    // Refresh weather every 30 minutes
    setInterval(fetchWeather, 30 * 60 * 1000);

    // --- Quote of the Day Widget ---
    const quoteContent = document.getElementById('quote-content');

    async function fetchQuote() {
        const url = 'https://zenquotes.io/api/today';
        // This proxy is needed because zenquotes.io API does not send the correct CORS headers for the free version.
        const proxyUrl = 'https://vercel-cors-proxy.vercel.app/api?url=' + encodeURIComponent(url);
        try {
            const response = await fetch(proxyUrl);
            if (!response.ok) throw new Error('Quote API fetch failed');
            const data = await response.json();
            quoteContent.innerHTML = `
                <p class="quote-text">“${data[0].q}”</p>
                <p class="quote-author">- ${data[0].a}</p>
            `;
        } catch (error) {
            console.error("Impossible de récupérer la citation:", error);
            displayLocalQuote();
        }
    }
    
    function displayLocalQuote() {
        const localQuotes = [
            { text: "L'imagination est plus importante que le savoir.", author: "Albert Einstein" },
            { text: "La seule façon de faire du bon travail est d'aimer ce que vous faites.", author: "Steve Jobs" },
            { text: "Restez affamés, restez fous.", author: "Steve Jobs" },
            { text: "Le code est comme l'humour. Quand on doit l'expliquer, c'est mauvais.", author: "Cory House" },
            { text: "Tout le monde devrait savoir programmer un ordinateur, car ça vous apprend à penser.", author: "Steve Jobs" },
            { text: "Mesurer la progression du développement d'un logiciel à l'aune de ses lignes de code, c'est comme mesurer la progression de la construction d'un avion à son poids.", author: "Bill Gates" }
        ];
        const randomQuote = localQuotes[Math.floor(Math.random() * localQuotes.length)];
        quoteContent.innerHTML = `
            <p class="quote-text">“${randomQuote.text}”</p>
            <p class="quote-author">- ${randomQuote.author}</p>
        `;
    }

    fetchQuote();
    setInterval(fetchQuote, 60 * 60 * 1000);

    // --- GitHub Trending Widget ---
    const githubContent = document.getElementById('github-content');

    async function fetchGithubTrends() {
        const aWeekAgo = new Date();
        aWeekAgo.setDate(aWeekAgo.getDate() - 7);
        const date = aWeekAgo.toISOString().split('T')[0];
        
        const apiUrl = `https://api.github.com/search/repositories?q=created:>${date}&sort=stars&order=desc`;
        const proxyUrl = `https://vercel-cors-proxy.vercel.app/api?url=${encodeURIComponent(apiUrl)}`;


        try {
            const response = await fetch(proxyUrl);
            if (!response.ok) {
                throw new Error(`Erreur HTTP: ${response.status}`);
            }
            const data = await response.json();

            let html = '<ul class="github-list">';
            data.items.slice(0, 5).forEach(repo => {
                html += `
                    <li class="github-repo">
                        <a href="${repo.html_url}" target="_blank" class="repo-link">
                            <span class="repo-name">${repo.full_name}</span>
                        </a>
                        <p class="repo-desc">${repo.description || 'Pas de description.'}</p>
                        <div class="repo-meta">
                            <span class="repo-lang">${repo.language || 'N/A'}</span>
                            <span class="repo-stars">⭐ ${repo.stargazers_count}</span>
                        </div>
                    </li>
                `;
            });
            html += '</ul>';

            githubContent.innerHTML = html;

        } catch (error) {
            console.error("Impossible de récupérer les tendances GitHub:", error);
            githubContent.innerHTML = `<p>Impossible de charger les tendances GitHub.</p>`;
        }
    }

    fetchGithubTrends();
    // Refresh trends every 30 minutes
    setInterval(fetchGithubTrends, 30 * 60 * 1000);

    // --- Tech News Widget ---
    const techHistoryContent = document.getElementById('tech-history-content');

    async function fetchTechNews() {
        // Utilisation de l'API RSS2JSON pour parser les flux RSS de sites tech pour étudiants
        const rssUrls = [
            'https://www.wired.com/feed/rss',  // WIRED - Tech trends and culture
            'https://feeds.arstechnica.com/arstechnica/index',  // Ars Technica main feed
            'https://www.technologyreview.com/feed/',  // MIT Technology Review
            'https://spectrum.ieee.org/feeds/feed.rss',  // IEEE Spectrum - Engineering & CS
            'https://techcrunch.com/feed/',  // TechCrunch main feed
            'https://thenextweb.com/feed'  // The Next Web - Digital culture & tech
        ];
        
        let allArticles = [];
        
        // Récupérer les articles de tous les flux RSS
        for (const rssUrl of rssUrls) {
            try {
                const apiUrl = `https://api.rss2json.com/v1/api.json?rss_url=${encodeURIComponent(rssUrl)}`;
                const response = await fetch(apiUrl);
                
                if (response.ok) {
                    const data = await response.json();
                    if (data.status === 'ok' && data.items) {
                        allArticles = allArticles.concat(data.items.map(item => ({
                            ...item,
                            source: data.feed.title
                        })));
                    }
                }
            } catch (error) {
                console.error(`Erreur pour ${rssUrl}:`, error);
            }
        }
        
        // Trier par date et filtrer les articles tech
        allArticles.sort((a, b) => new Date(b.pubDate) - new Date(a.pubDate));
        
        let html = '<ul class="history-list">';
        let techArticlesFound = 0;
        
        // Prioritize articles with these keywords for students
        const priorityKeywords = ['ai', 'artificial intelligence', 'machine learning', 'programming', 'startup', 'innovation', 'breakthrough', 'research', 'google', 'microsoft', 'apple', 'meta', 'openai', 'developer', 'framework', 'language', 'cybersecurity', 'hack', 'data', 'cloud', 'quantum', 'robotics'];
        
        // Score and sort articles by relevance
        allArticles.forEach(article => {
            let score = 0;
            const titleLower = (article.title || '').toLowerCase();
            const descLower = (article.description || '').toLowerCase();
            
            priorityKeywords.forEach(keyword => {
                if (titleLower.includes(keyword)) score += 2;
                if (descLower.includes(keyword)) score += 1;
            });
            
            article.relevanceScore = score;
        });
        
        // Sort by relevance score and date
        allArticles.sort((a, b) => {
            if (b.relevanceScore !== a.relevanceScore) {
                return b.relevanceScore - a.relevanceScore;
            }
            return new Date(b.pubDate) - new Date(a.pubDate);
        });
        
        for (const article of allArticles) {
            if (techArticlesFound >= 3) break;
            
            // All articles from these sources are tech-related, just take the top scored ones
            const isTechRelated = true;
            
            if (isTechRelated) {
                // Nettoyer le titre
                const cleanTitle = article.title
                    .replace(/&amp;/g, '&')
                    .replace(/&quot;/g, '"')
                    .replace(/&#39;/g, "'")
                    .replace(/&lt;/g, '<')
                    .replace(/&gt;/g, '>')
                    .replace(/<[^>]*>/g, ''); // Enlever les balises HTML
                    
                html += `
                    <li class="tech-news-item">
                        <div class="tech-news-header">
                            <span class="tech-news-source">${article.source}</span>
                            <span class="tech-news-date">${new Date(article.pubDate).toLocaleDateString('fr-FR', { day: '2-digit', month: '2-digit' })}</span>
                        </div>
                        <p class="tech-news-title">${cleanTitle}</p>
                    </li>
                `;
                techArticlesFound++;
            }
        }
        
        if (techArticlesFound === 0) {
            html += `<li class="tech-news-item"><p class="tech-news-title">Aucune actualité tech majeure disponible pour le moment.</p></li>`;
        }
        
        html += '</ul>';
        techHistoryContent.innerHTML = html;
    }

    // Suppression de la fonction de fallback pour forcer l'utilisation de l'API RSS

    fetchTechNews();
    // Refresh news every hour
    setInterval(fetchTechNews, 60 * 60 * 1000);


    // --- Code Snippet Widget ---
    const snippetContent = document.getElementById('snippet-content');
    
            // Configuration Supabase depuis config.js
        const SUPABASE_URL = window.SUPABASE_CONFIG?.URL || 'https://owjcgekrreywjegqshuk.supabase.co';
        const SUPABASE_KEY = window.SUPABASE_CONFIG?.PUBLISHABLE_KEY || '';
    
    // Initialisation Supabase
    const supabase = window.supabase.createClient(SUPABASE_URL, SUPABASE_KEY);
    
    async function fetchCodeSnippet() {
        // Get today's date in YYYY-MM-DD format
        const now = new Date();
        const today = now.toISOString().split('T')[0]; // Format: 2025-08-29
        
        try {
            const { data, error } = await supabase
                .from('snippets')
                .select(`
                    *,
                    categories(name, color),
                    programming_languages(display_name, syntax_highlight, color)
                `)
                .eq('date', today)
                .single();

            if (error && error.code !== 'PGRST116') { // PGRST116 = no rows returned
                throw error;
            }

            if (data) {
                // Afficher le snippet - NO nested div, apply directly to snippet-content
                snippetContent.innerHTML = `
                    <div class="snippet-header">
                        <div class="snippet-badges">
                            <span class="snippet-category">${data.categories?.name || 'Code'}</span>
                            <span class="snippet-language" style="background: rgba(${hexToRgb(data.programming_languages?.color || '#10b981')}, 0.2); color: ${data.programming_languages?.color || '#10b981'}; border: 1px solid rgba(${hexToRgb(data.programming_languages?.color || '#10b981')}, 0.4);">${data.programming_languages?.display_name || 'Langage'}</span>
                            <span class="snippet-difficulty-badge ${data.difficulty?.toLowerCase() || 'intermédiaire'}">${data.difficulty}</span>
                        </div>
                    </div>
                    <h3 class="snippet-title">${data.title}</h3>
                    <div class="snippet-code">
                        <pre><code class="language-${data.programming_languages?.syntax_highlight || 'cpp'}">${escapeHtml(data.code)}</code></pre>
                    </div>
                    <p class="snippet-explanation">${escapeHtml(data.explanation)}</p>
                `;
                
                // Appliquer syntax highlighting
                if (window.Prism) {
                    window.Prism.highlightAll();
                }
                
                // Force black background after Prism highlighting
                setTimeout(() => {
                    const codeElements = document.querySelectorAll('#code-snippet-widget .snippet-code, #code-snippet-widget .snippet-code pre');
                    codeElements.forEach(el => {
                        el.style.background = '#1e1e1e';
                        el.style.backgroundColor = '#1e1e1e';
                    });
                }, 100);
                
                // Auto-adjust font size to fit content
                adjustSnippetFontSize();
            } else {
                // Fallback avec un snippet exemple si pas de snippet pour aujourd'hui
                const exampleSnippets = [
                    {
                        title: "Hello World en Python",
                        code: `def hello_world():
    """Fonction classique Hello World"""
    message = "Hello, Epitech Nancy!"
    print(f"🎓 {message}")
    return message

if __name__ == "__main__":
    hello_world()`,
                        explanation: "Le classique 'Hello World' avec une touche Python moderne utilisant les f-strings. Un rappel que tout grand projet commence par une simple ligne de code.",
                        language: "Python",
                        syntax: "python",
                        category: "Basics",
                        difficulty: "Débutant"
                    },
                    {
                        title: "Fibonacci Récursif avec Mémoïzation",
                        code: `function fibonacci(n, memo = {}) {
    if (n in memo) return memo[n];
    if (n <= 2) return 1;
    
    memo[n] = fibonacci(n - 1, memo) + fibonacci(n - 2, memo);
    return memo[n];
}

// Test avec les 10 premiers nombres
for (let i = 1; i <= 10; i++) {
    console.log(\`F(\${i}) = \${fibonacci(i)}\`);
}`,
                        explanation: "Implémentation optimisée de Fibonacci utilisant la mémoïzation pour éviter les calculs redondants. Complexité réduite de O(2^n) à O(n).",
                        language: "JavaScript",
                        syntax: "javascript",
                        category: "Algorithmes",
                        difficulty: "Intermédiaire"
                    },
                    {
                        title: "Quick Sort en C++",
                        code: `#include <vector>
#include <iostream>

void quickSort(std::vector<int>& arr, int low, int high) {
    if (low < high) {
        int pi = partition(arr, low, high);
        quickSort(arr, low, pi - 1);
        quickSort(arr, pi + 1, high);
    }
}

int partition(std::vector<int>& arr, int low, int high) {
    int pivot = arr[high];
    int i = (low - 1);
    
    for (int j = low; j < high; j++) {
        if (arr[j] < pivot) {
            i++;
            std::swap(arr[i], arr[j]);
        }
    }
    std::swap(arr[i + 1], arr[high]);
    return (i + 1);
}`,
                        explanation: "Implémentation du tri rapide (Quick Sort), un algorithme de tri efficace avec une complexité moyenne de O(n log n). Utilise la stratégie diviser pour régner.",
                        language: "C++",
                        syntax: "cpp",
                        category: "Algorithmes",
                        difficulty: "Avancé"
                    }
                ];

                // Sélectionner un snippet basé sur le jour
                const exampleSnippet = exampleSnippets[dayOfYear % exampleSnippets.length];
                
                snippetContent.innerHTML = `
                    <div class="snippet-header">
                        <div class="snippet-badges">
                            <span class="snippet-category" style="background: #6c757d">
                                Exemple
                            </span>
                            <span class="snippet-language" style="background: var(--epitech-blue)20; color: var(--epitech-blue); border: 1px solid var(--epitech-blue)">
                                ${exampleSnippet.language}
                            </span>
                            <span class="snippet-difficulty-badge ${exampleSnippet.difficulty?.toLowerCase() || 'intermediate'}">
                                ${exampleSnippet.difficulty}
                            </span>
                        </div>
                    </div>
                    <h3 class="snippet-title">${exampleSnippet.title}</h3>
                    <div class="snippet-code">
                        <pre><code class="language-${exampleSnippet.syntax}">${escapeHtml(exampleSnippet.code)}</code></pre>
                    </div>
                    <p class="snippet-explanation">${escapeHtml(exampleSnippet.explanation)}</p>
                    <div style="background: rgba(255, 193, 7, 0.1); border: 1px solid rgba(255, 193, 7, 0.3); padding: 10px; border-radius: 6px; margin-top: 15px;">
                        <i class="fa-solid fa-info-circle" style="color: #ffc107; margin-right: 8px;"></i>
                        <span style="color: #ffc107; font-size: 0.85rem;">
                            Snippet exemple - Ajoutez le snippet du jour via l'interface admin
                        </span>
                    </div>
                `;
                
                // Appliquer syntax highlighting
                if (window.Prism) {
                    window.Prism.highlightAll();
                }
                
                // Force black background after Prism highlighting for fallback
                setTimeout(() => {
                    const codeElements = document.querySelectorAll('#code-snippet-widget .snippet-code, #code-snippet-widget .snippet-code pre');
                    codeElements.forEach(el => {
                        el.style.background = '#1e1e1e';
                        el.style.backgroundColor = '#1e1e1e';
                    });
                }, 100);
            }
        } catch (error) {
            console.error("Erreur chargement snippet:", error);
            // Fallback en cas d'erreur
            snippetContent.innerHTML = `
                <div class="code-snippet-fallback" style="padding: 40px; text-align: center;">
                    <i class="fa-solid fa-exclamation-triangle" style="font-size: 3rem; color: var(--epitech-red); margin-bottom: 15px;"></i>
                    <p style="color: var(--white); font-size: 1.1rem; font-weight: 600;">Erreur de chargement</p>
                    <p style="color: var(--light-grey); font-size: 0.9rem; margin-top: 10px;">
                        Impossible de charger le snippet du jour.<br>
                        Veuillez rafraîchir la page ou contacter l'administrateur.
                    </p>
                </div>
            `;
        }
    }
    
    function escapeHtml(text) {
        const div = document.createElement('div');
        div.textContent = text;
        return div.innerHTML;
    }
    
    function hexToRgb(hex) {
        const result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
        return result ? 
            `${parseInt(result[1], 16)}, ${parseInt(result[2], 16)}, ${parseInt(result[3], 16)}` : 
            "16, 185, 129";
    }
    
    function adjustSnippetFontSize() {
        const widget = document.querySelector('#code-snippet-widget');
        const codeBlock = widget?.querySelector('.snippet-code pre');
        const explanation = widget?.querySelector('.snippet-explanation');
        
        if (!widget || !codeBlock) return;
        
        // Get available height for content
        const widgetHeight = widget.offsetHeight;
        const header = widget.querySelector('.snippet-header');
        const title = widget.querySelector('.snippet-title');
        const headerHeight = (header?.offsetHeight || 0) + (title?.offsetHeight || 0) + 60; // +margins
        
        const availableHeight = widgetHeight - headerHeight;
        const codeHeight = codeBlock.scrollHeight;
        const explanationHeight = explanation?.scrollHeight || 0;
        const totalContentHeight = codeHeight + explanationHeight + 30; // +margins
        
        if (totalContentHeight > availableHeight) {
            // Calculate scaling factor
            const scale = Math.max(0.6, availableHeight / totalContentHeight);
            const newFontSize = Math.max(0.6, 0.85 * scale);
            
            // Apply responsive sizing
            codeBlock.style.fontSize = `${newFontSize}rem`;
            codeBlock.style.lineHeight = scale < 0.8 ? '1.2' : '1.4';
            
            if (explanation) {
                explanation.style.fontSize = `${Math.max(0.7, 0.9 * scale)}rem`;
                explanation.style.lineHeight = '1.3';
            }
        }
    }
    
    fetchCodeSnippet();
    setInterval(fetchCodeSnippet, 24 * 60 * 60 * 1000); // Refresh once a day

    // Other widgets will be initialized here
});