        // Configuration Supabase depuis config.js
        const SUPABASE_URL = window.SUPABASE_CONFIG?.URL || 'https://owjcgekrreywjegqshuk.supabase.co';
        const SUPABASE_KEY = window.SUPABASE_CONFIG?.PUBLISHABLE_KEY || '';

// Initialisation Supabase
const supabase = window.supabase.createClient(SUPABASE_URL, SUPABASE_KEY);

class SnippetManager {
    constructor() {
        this.currentDate = new Date();
        this.snippets = new Map();
        this.categories = [];
        this.languages = [];
        this.init();
    }

    async init() {
        await this.loadCategories();
        await this.loadLanguages();
        await this.loadSnippets();
        this.setupEventListeners();
        this.updateStats();
        this.updateMissingDays();
        this.setupCalendar();
        this.setCurrentDate();
    }

    async loadCategories() {
        try {
            const { data, error } = await supabase
                .from('categories')
                .select('*')
                .order('name');

            if (error) throw error;
            this.categories = data;
            this.populateCategorySelect();
        } catch (error) {
            console.error('Erreur chargement catégories:', error);
            this.showMessage('Erreur chargement catégories', 'error');
        }
    }

    async loadLanguages() {
        try {
            const { data, error } = await supabase
                .from('programming_languages')
                .select('*')
                .order('display_name');

            if (error) throw error;
            this.languages = data;
            this.populateLanguageSelect();
        } catch (error) {
            console.error('Erreur chargement langages:', error);
            this.showMessage('Erreur chargement langages', 'error');
        }
    }

    async loadSnippets() {
        try {
            const { data, error } = await supabase
                .from('snippets')
                .select(`
                    *,
                    categories(name, color),
                    programming_languages(display_name, syntax_highlight, color)
                `)
                .order('date');

            if (error) throw error;
            
            this.snippets.clear();
            data.forEach(snippet => {
                this.snippets.set(snippet.date, snippet);
            });
        } catch (error) {
            console.error('Erreur chargement snippets:', error);
            this.showMessage('Erreur chargement snippets', 'error');
        }
    }

    populateCategorySelect() {
        const select = document.getElementById('snippet-category');
        select.innerHTML = '<sl-menu-item value="">Sélectionner une catégorie</sl-menu-item>';
        
        this.categories.forEach(category => {
            const option = document.createElement('sl-menu-item');
            option.value = category.id;
            option.textContent = category.name;
            select.appendChild(option);
        });
    }

    populateLanguageSelect() {
        const select = document.getElementById('snippet-language');
        select.innerHTML = '<sl-menu-item value="">Sélectionner un langage</sl-menu-item>';
        
        this.languages.forEach(language => {
            const option = document.createElement('sl-menu-item');
            option.value = language.id;
            option.textContent = language.display_name;
            select.appendChild(option);
        });
    }

    setupEventListeners() {
        // Formulaire
        document.getElementById('snippet-form').addEventListener('submit', (e) => {
            e.preventDefault();
            this.saveSnippet();
        });

        // Boutons
        document.getElementById('clear-btn').addEventListener('click', () => this.clearForm());
        document.getElementById('delete-btn').addEventListener('click', () => this.deleteSnippet());

        // Contrôles calendrier
        document.getElementById('prev-month').addEventListener('click', () => this.previousMonth());
        document.getElementById('next-month').addEventListener('click', () => this.nextMonth());
        document.getElementById('today-btn').addEventListener('click', () => this.goToToday());

        // Événements de changement pour prévisualisation
        ['snippet-title', 'snippet-category', 'snippet-language', 'snippet-difficulty', 'snippet-code', 'snippet-explanation'].forEach(id => {
            document.getElementById(id).addEventListener('input', () => this.updatePreview());
            document.getElementById(id).addEventListener('change', () => this.updatePreview());
        });

        // Sélection de date
        document.getElementById('snippet-date').addEventListener('change', (e) => {
            this.loadSnippetForDate(e.target.value);
        });
    }

    async saveSnippet() {
        const formData = this.getFormData();
        
        if (!this.validateForm(formData)) {
            return;
        }

        try {
            const { data, error } = await supabase
                .from('snippets')
                .upsert({
                    date: formData.date,
                    title: formData.title,
                    category_id: parseInt(formData.category),
                    language_id: parseInt(formData.language),
                    difficulty: formData.difficulty,
                    code: formData.code,
                    explanation: formData.explanation
                });

            if (error) throw error;

            // Recharger les données
            await this.loadSnippets();
            this.updateStats();
            this.updateMissingDays();
            this.updateCalendar();
            
            this.showMessage('Snippet sauvegardé avec succès !', 'success');
        } catch (error) {
            console.error('Erreur sauvegarde:', error);
            this.showMessage('Erreur lors de la sauvegarde', 'error');
        }
    }

    async deleteSnippet() {
        const date = document.getElementById('snippet-date').value;
        if (!date) {
            this.showMessage('Aucune date sélectionnée', 'error');
            return;
        }

        if (!confirm('Êtes-vous sûr de vouloir supprimer ce snippet ?')) {
            return;
        }

        try {
            const { error } = await supabase
                .from('snippets')
                .delete()
                .eq('date', date);

            if (error) throw error;

            this.snippets.delete(date);
            this.updateStats();
            this.updateMissingDays();
            this.updateCalendar();
            this.clearForm();
            
            this.showMessage('Snippet supprimé avec succès !', 'success');
        } catch (error) {
            console.error('Erreur suppression:', error);
            this.showMessage('Erreur lors de la suppression', 'error');
        }
    }

    async loadSnippetForDate(date) {
        const snippet = this.snippets.get(date);
        
        if (snippet) {
            this.fillForm(snippet);
        } else {
            this.clearForm();
            document.getElementById('snippet-date').value = date;
        }
        
        this.updatePreview();
    }

    fillForm(snippet) {
        document.getElementById('snippet-date').value = snippet.date;
        document.getElementById('snippet-title').value = snippet.title;
        document.getElementById('snippet-category').value = snippet.category_id;
        document.getElementById('snippet-language').value = snippet.language_id;
        document.getElementById('snippet-difficulty').value = snippet.difficulty;
        document.getElementById('snippet-code').value = snippet.code;
        document.getElementById('snippet-explanation').value = snippet.explanation;
    }

    clearForm() {
        document.getElementById('snippet-form').reset();
        this.updatePreview();
    }

    getFormData() {
        return {
            date: document.getElementById('snippet-date').value,
            title: document.getElementById('snippet-title').value,
            category: document.getElementById('snippet-category').value,
            language: document.getElementById('snippet-language').value,
            difficulty: document.getElementById('snippet-difficulty').value,
            code: document.getElementById('snippet-code').value,
            explanation: document.getElementById('snippet-explanation').value
        };
    }

    validateForm(data) {
        if (!data.date) {
            this.showMessage('Date requise', 'error');
            return false;
        }
        if (!data.title) {
            this.showMessage('Titre requis', 'error');
            return false;
        }
        if (!data.category) {
            this.showMessage('Catégorie requise', 'error');
            return false;
        }
        if (!data.language) {
            this.showMessage('Langage requis', 'error');
            return false;
        }
        if (!data.difficulty) {
            this.showMessage('Difficulté requise', 'error');
            return false;
        }
        if (!data.code) {
            this.showMessage('Code requis', 'error');
            return false;
        }
        if (!data.explanation) {
            this.showMessage('Explication requise', 'error');
            return false;
        }
        return true;
    }

    updatePreview() {
        const data = this.getFormData();
        const container = document.getElementById('preview-container');
        
        if (!data.title || !data.code) {
            container.innerHTML = `
                <div class="preview-snippet">
                    <p style="text-align: center; color: var(--light-grey);">
                        <i class="fa-solid fa-code"></i><br>
                        Prévisualisation du snippet
                    </p>
                </div>
            `;
            return;
        }

        const category = this.categories.find(c => c.id == data.category);
        const language = this.languages.find(l => l.id == data.language);

        container.innerHTML = `
            <div class="preview-snippet">
                <div class="snippet-header">
                    <span class="snippet-category" style="background: ${category?.color || '#007bff'}">
                        ${category?.name || 'Catégorie'}
                    </span>
                    <span class="snippet-difficulty">${data.difficulty || 'Difficulté'}</span>
                </div>
                <h3 style="color: var(--white); margin-bottom: 15px;">${data.title}</h3>
                <div class="snippet-code">
                    <pre><code class="language-${language?.syntax_highlight || 'cpp'}">${this.escapeHtml(data.code)}</code></pre>
                </div>
                <p class="snippet-explanation">${this.escapeHtml(data.explanation)}</p>
                <div style="margin-top: 15px; font-size: 0.8rem; color: var(--light-grey);">
                    <span style="color: ${language?.color || '#007bff'}">${language?.display_name || 'Langage'}</span>
                </div>
            </div>
        `;

        // Re-highlight le code
        if (window.Prism) {
            window.Prism.highlightAll();
        }
    }

    escapeHtml(text) {
        const div = document.createElement('div');
        div.textContent = text;
        return div.innerHTML;
    }

    updateStats() {
        const currentYear = new Date().getFullYear();
        const totalDays = 366; // Année bissextile
        const createdSnippets = this.snippets.size;
        const missingDays = totalDays - createdSnippets;
        const progressPercentage = Math.round((createdSnippets / totalDays) * 100);

        document.getElementById('total-snippets').textContent = `${createdSnippets}/${totalDays}`;
        document.getElementById('missing-days').textContent = missingDays;
        document.getElementById('progress-percentage').textContent = `${progressPercentage}%`;
        document.getElementById('current-year').textContent = currentYear;
        document.getElementById('progress-fill').style.width = `${progressPercentage}%`;
    }

    updateMissingDays() {
        const currentYear = new Date().getFullYear();
        const grid = document.getElementById('missing-days-grid');
        
        // Générer toutes les dates de l'année
        const allDates = [];
        const startDate = new Date(currentYear, 0, 1);
        const endDate = new Date(currentYear, 11, 31);
        
        for (let d = new Date(startDate); d <= endDate; d.setDate(d.getDate() + 1)) {
            allDates.push(d.toISOString().split('T')[0]);
        }

        // Filtrer les dates manquantes
        const missingDates = allDates.filter(date => !this.snippets.has(date));
        
        if (missingDates.length === 0) {
            grid.innerHTML = '<div style="text-align: center; color: var(--light-grey);">🎉 Tous les snippets sont créés !</div>';
            return;
        }

        grid.innerHTML = missingDates.map(date => `
            <div class="missing-day" onclick="snippetManager.selectDate('${date}')">
                ${new Date(date).toLocaleDateString('fr-FR', { day: '2-digit', month: '2-digit' })}
            </div>
        `).join('');
    }

    selectDate(date) {
        document.getElementById('snippet-date').value = date;
        this.loadSnippetForDate(date);
    }

    setupCalendar() {
        this.currentDate = new Date();
        this.selectedDate = new Date();
        this.renderCalendar();
        
        // Navigation du calendar
        document.getElementById('prev-month')?.addEventListener('click', () => {
            this.currentDate.setMonth(this.currentDate.getMonth() - 1);
            this.renderCalendar();
        });

        document.getElementById('next-month')?.addEventListener('click', () => {
            this.currentDate.setMonth(this.currentDate.getMonth() + 1);
            this.renderCalendar();
        });

        document.getElementById('today-btn')?.addEventListener('click', () => {
            this.currentDate = new Date();
            this.selectedDate = new Date();
            this.renderCalendar();
            document.getElementById('snippet-date').value = new Date().toISOString().split('T')[0];
        });
    }

    renderCalendar() {
        const calendarDays = document.getElementById('calendar-days');
        const currentMonthEl = document.getElementById('current-month');
        
        if (!calendarDays || !currentMonthEl) return;

        const year = this.currentDate.getFullYear();
        const month = this.currentDate.getMonth();
        
        // Mettre à jour le titre du mois
        const monthNames = ['Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin', 
                           'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'];
        currentMonthEl.textContent = `${monthNames[month]} ${year}`;

        // Calculer le premier jour du mois et le nombre de jours
        const firstDay = new Date(year, month, 1);
        const lastDay = new Date(year, month + 1, 0);
        const startDate = new Date(firstDay);
        startDate.setDate(startDate.getDate() - firstDay.getDay());

        calendarDays.innerHTML = '';

        // Générer les jours
        for (let i = 0; i < 42; i++) {
            const dayDate = new Date(startDate);
            dayDate.setDate(startDate.getDate() + i);

            const dayEl = document.createElement('div');
            dayEl.className = 'calendar-day';
            dayEl.textContent = dayDate.getDate();

            // Ajouter les classes appropriées
            if (dayDate.getMonth() !== month) {
                dayEl.classList.add('other-month');
            }

            const today = new Date();
            if (dayDate.toDateString() === today.toDateString()) {
                dayEl.classList.add('today');
            }

            if (dayDate.toDateString() === this.selectedDate.toDateString()) {
                dayEl.classList.add('selected');
            }

            // Vérifier si le jour a un snippet
            const dateStr = dayDate.toISOString().split('T')[0];
            if (this.snippets.has(dateStr)) {
                dayEl.classList.add('has-snippet');
            }

            // Événement de clic
            dayEl.addEventListener('click', () => {
                this.selectedDate = dayDate;
                document.getElementById('snippet-date').value = dateStr;
                this.renderCalendar();
                this.loadSnippetForDate(dateStr);
            });

            calendarDays.appendChild(dayEl);
        }
    }

    updateCalendar() {
        this.renderCalendar();
    }

    setCurrentDate() {
        const today = new Date().toISOString().split('T')[0];
        document.getElementById('snippet-date').value = today;
        this.loadSnippetForDate(today);
    }

    showMessage(message, type = 'info') {
        const container = document.getElementById('editor-messages');
        const messageDiv = document.createElement('div');
        messageDiv.className = type;
        messageDiv.textContent = message;
        
        container.appendChild(messageDiv);
        
        // Auto-remove after 5 seconds
        setTimeout(() => {
            if (messageDiv.parentNode) {
                messageDiv.parentNode.removeChild(messageDiv);
            }
        }, 5000);
    }
}

// Initialisation
let snippetManager;

document.addEventListener('DOMContentLoaded', () => {
    snippetManager = new SnippetManager();
});

// Exposer globalement pour les clics sur les jours manquants
window.snippetManager = snippetManager;
