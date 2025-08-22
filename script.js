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
        // Utilisation de l'API RSS2JSON pour parser les flux RSS de sites tech français
        const rssUrls = [
            'https://www.numerama.com/feed/',
            'https://www.01net.com/feed/',
            'https://www.lemonde.fr/technologies/rss_full.xml',
            'https://www.usine-digitale.fr/feed/'
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
        
        const techKeywords = ['informatique', 'technologie', 'software', 'hardware', 'programmation', 'développement', 'intelligence artificielle', 'ia', 'machine learning', 'blockchain', 'cybersécurité', 'startup', 'innovation', 'digital', 'numérique', 'app', 'application', 'web', 'mobile', 'cloud', 'data', 'données', 'algorithm', 'algorithme', 'code', 'coding', 'developer', 'développeur', 'tech', 'computer', 'internet', 'ai', 'artificial intelligence', 'chatgpt', 'openai', 'google', 'microsoft', 'apple', 'facebook', 'meta', 'amazon', 'netflix', 'uber', 'airbnb'];
        
        for (const article of allArticles) {
            if (techArticlesFound >= 3) break;
            
            const isTechRelated = techKeywords.some(keyword => 
                (article.title && article.title.toLowerCase().includes(keyword)) ||
                (article.description && article.description.toLowerCase().includes(keyword))
            );
            
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

    // --- XKCD Widget ---
    const xkcdContent = document.getElementById('xkcd-content');
    async function fetchXkcd() {
        const url = 'https://xkcd.com/info.0.json';
        const proxyUrl = 'https://vercel-cors-proxy.vercel.app/api?url=' + encodeURIComponent(url);
        try {
            const response = await fetch(proxyUrl);
            const data = await response.json();
            xkcdContent.innerHTML = `
                <p class="xkcd-title">${data.safe_title}</p>
                <img src="${data.img}" alt="${data.alt}" class="xkcd-image">
            `;
        } catch (error) {
            console.error("Impossible de récupérer le comic XKCD:", error);
            xkcdContent.innerHTML = `<p>Impossible de charger le comic du jour.</p>`;
        }
    }
    fetchXkcd();
    setInterval(fetchXkcd, 24 * 60 * 60 * 1000); // Refresh once a day

    // --- Code Snippet Widget ---
    const apodContent = document.getElementById('apod-content');
    
            // Configuration Supabase depuis config.js
        const SUPABASE_URL = window.SUPABASE_CONFIG?.URL || 'https://owjcgekrreywjegqshuk.supabase.co';
        const SUPABASE_KEY = window.SUPABASE_CONFIG?.PUBLISHABLE_KEY || '';
    
    // Initialisation Supabase
    const supabase = window.supabase.createClient(SUPABASE_URL, SUPABASE_KEY);
    
    async function fetchCodeSnippet() {
        const today = new Date().toISOString().split('T')[0];
        
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
                // Afficher le snippet
                apodContent.innerHTML = `
                    <div class="code-snippet-widget">
                        <div class="snippet-header">
                            <span class="snippet-category" style="background: ${data.categories?.color || '#007bff'}">
                                ${data.categories?.name || 'Code'}
                            </span>
                            <span class="snippet-difficulty">${data.difficulty}</span>
                        </div>
                        <h3 class="snippet-title">${data.title}</h3>
                        <div class="snippet-code">
                            <pre><code class="language-${data.programming_languages?.syntax_highlight || 'cpp'}">${escapeHtml(data.code)}</code></pre>
                        </div>
                        <p class="snippet-explanation">${escapeHtml(data.explanation)}</p>
                        <div class="snippet-meta">
                            <span class="snippet-language" style="color: ${data.programming_languages?.color || '#007bff'}">
                                ${data.programming_languages?.display_name || 'Langage'}
                            </span>
                            <span class="snippet-date">${new Date(data.date).toLocaleDateString('fr-FR', { day: '2-digit', month: '2-digit' })}</span>
                        </div>
                    </div>
                `;
                
                // Appliquer syntax highlighting
                if (window.Prism) {
                    window.Prism.highlightAll();
                }
            } else {
                // Fallback si pas de snippet pour aujourd'hui
                apodContent.innerHTML = `
                    <div class="code-snippet-fallback">
                        <i class="fa-solid fa-code" style="font-size: 3rem; color: var(--epitech-blue); margin-bottom: 15px;"></i>
                        <p style="color: var(--light-grey); margin-bottom: 10px;">Code Snippet du Jour</p>
                        <p style="color: var(--white); font-size: 1.1rem; font-weight: 600;">Aucun snippet pour aujourd'hui</p>
                        <p style="color: var(--light-grey); font-size: 0.9rem; margin-top: 10px;">
                            Revenez demain pour un nouveau snippet !
                        </p>
                    </div>
                `;
            }
        } catch (error) {
            console.error("Erreur chargement snippet:", error);
            // Fallback en cas d'erreur
            apodContent.innerHTML = `
                <div class="code-snippet-fallback">
                    <i class="fa-solid fa-code" style="font-size: 3rem; color: var(--epitech-blue); margin-bottom: 15px;"></i>
                    <p style="color: var(--light-grey);">Code Snippet du Jour</p>
                </div>
            `;
        }
    }
    
    function escapeHtml(text) {
        const div = document.createElement('div');
        div.textContent = text;
        return div.innerHTML;
    }
    
    fetchCodeSnippet();
    setInterval(fetchCodeSnippet, 24 * 60 * 60 * 1000); // Refresh once a day

    // Other widgets will be initialized here
});