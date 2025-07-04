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

    // --- Tech History Widget ---
    const techHistoryContent = document.getElementById('tech-history-content');

    async function fetchTechHistory() {
        const now = new Date();
        const month = now.getMonth() + 1;
        const day = now.getDate();
        const url = `https://history.muffinlabs.com/date/${month}/${day}`;

        try {
            const response = await fetch(url);
            if (!response.ok) {
                throw new Error(`Erreur HTTP: ${response.status}`);
            }
            const data = await response.json();
            const events = data.data.Events;

            const techKeywords = ['computer', 'internet', 'software', 'apple', 'microsoft', 'google', 'nasa', 'space', 'ibm'];
            const techEvents = events.filter(event => 
                techKeywords.some(keyword => event.text.toLowerCase().includes(keyword))
            );

            let html = '<ul class="history-list">';
            if (techEvents.length > 0) {
                techEvents.slice(0, 4).forEach(event => {
                    html += `
                        <li class="history-event">
                            <span class="history-year">${event.year}</span>
                            <p class="history-text">${event.text}</p>
                        </li>
                    `;
                });
            } else {
                html += `<li class="history-event"><p class="history-text">Aucun événement tech majeur trouvé pour aujourd'hui.</p></li>`;
            }
            html += '</ul>';

            techHistoryContent.innerHTML = html;

        } catch (error) {
            console.error("Impossible de récupérer l'histoire de la tech:", error);
            techHistoryContent.innerHTML = `<p>Impossible de charger les éphémérides.</p>`;
        }
    }

    fetchTechHistory();
     // Refresh history every hour
    setInterval(fetchTechHistory, 60 * 60 * 1000);

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

    // --- NASA APOD Widget ---
    const apodContent = document.getElementById('apod-content');
    async function fetchApod() {
        const url = 'https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY';
        try {
            const response = await fetch(url);
            const data = await response.json();
            if (data.media_type === 'image') {
                apodContent.innerHTML = `
                    <img src="${data.url}" alt="${data.title}" class="apod-image">
                    <p class="apod-title">${data.title}</p>
                `;
            } else {
                apodContent.innerHTML = `<p>L'image du jour n'est pas disponible (c'est peut-être une vidéo).</p><a href="${data.url}" target="_blank">Voir ici</a>`;
            }
        } catch (error) {
            console.error("Impossible de récupérer l'image de la NASA:", error);
            apodContent.innerHTML = `<p>Impossible de charger l'image du jour.</p>`;
        }
    }
    fetchApod();
    setInterval(fetchApod, 24 * 60 * 60 * 1000); // Refresh once a day

    // Other widgets will be initialized here
}); 