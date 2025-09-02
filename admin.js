// Configuration Supabase
const SUPABASE_URL = window.SUPABASE_CONFIG?.URL || 'https://owjcgekrreywjegqshuk.supabase.co';
const SUPABASE_KEY = window.SUPABASE_CONFIG?.PUBLISHABLE_KEY || '';

// Initialisation Supabase
const supabase = window.supabase.createClient(SUPABASE_URL, SUPABASE_KEY);

class ModernSnippetManager {
    constructor() {
        this.snippets = new Map();
        this.categories = [];
        this.languages = [];
        this.currentDay = null;
        this.calendarMonth = new Date().getMonth();
        this.calendarYear = new Date().getFullYear();
        this.selectedCalendarDate = null;
        
        this.init();
    }

    async init() {
        await this.loadData();
        this.setupEventListeners();
        this.setToday();
        this.updatePreview();
        this.loadStatistics();
        this.initCalendarView();
    }

    async loadData() {
        try {
            // Load categories, languages, and snippets in parallel
            const [categoriesResult, languagesResult, snippetsResult] = await Promise.all([
                supabase.from('categories').select('*').order('name'),
                supabase.from('programming_languages').select('*').order('display_name'),
                supabase.from('snippets').select(`
                    *,
                    categories(name, color),
                    programming_languages(display_name, syntax_highlight, color)
                `).order('month', { ascending: true }).order('day', { ascending: true })
            ]);

            if (categoriesResult.error) throw categoriesResult.error;
            if (languagesResult.error) throw languagesResult.error;
            if (snippetsResult.error) throw snippetsResult.error;

            this.categories = categoriesResult.data || [];
            this.languages = languagesResult.data || [];
            
            // Map snippets by day of year (convert from month/day)
            this.snippets.clear();
            if (snippetsResult.data) {
                snippetsResult.data.forEach(snippet => {
                    if (snippet.month && snippet.day) {
                        const dayOfYear = this.monthDayToDayOfYear(snippet.month, snippet.day);
                        this.snippets.set(dayOfYear, snippet);
                    }
                });
            }

            this.populateSelects();
        } catch (error) {
            console.error('Erreur chargement des données:', error);
            this.showMessage('Erreur de chargement des données', 'error');
        }
    }

    populateSelects() {
        // Populate categories
        const categorySelect = document.getElementById('category-select');
        categorySelect.innerHTML = '<option value="">Choisir une catégorie</option>';
        this.categories.forEach(cat => {
            const option = document.createElement('option');
            option.value = cat.id;
            option.textContent = cat.name;
            categorySelect.appendChild(option);
        });

        // Populate languages
        const languageSelect = document.getElementById('language-select');
        languageSelect.innerHTML = '<option value="">Choisir un langage</option>';
        this.languages.forEach(lang => {
            const option = document.createElement('option');
            option.value = lang.id;
            option.textContent = lang.display_name;
            languageSelect.appendChild(option);
        });
    }

    setupEventListeners() {
        // Toggle between input methods
        document.getElementById('toggle-day-year').addEventListener('click', () => {
            this.switchToInputMethod('day-year');
        });

        document.getElementById('toggle-day-month').addEventListener('click', () => {
            this.switchToInputMethod('day-month');
        });

        // Day of year input
        document.getElementById('day-input').addEventListener('input', (e) => {
            const day = parseInt(e.target.value);
            if (day >= 1 && day <= 365) {
                this.currentDay = day;
                this.updateDateDisplay();
                this.loadSnippetForDay(day);
                this.syncInputs();
            }
        });

        // Day/Month inputs
        document.getElementById('day-only').addEventListener('input', () => {
            this.handleDayMonthInput();
        });

        document.getElementById('month-only').addEventListener('change', () => {
            this.handleDayMonthInput();
        });

        // Calendar button
        document.getElementById('calendar-btn').addEventListener('click', () => {
            this.openCalendar();
        });

        // Form inputs for live preview
        ['title-input', 'code-input', 'explanation-input', 'category-select', 'language-select'].forEach(id => {
            const element = document.getElementById(id);
            element.addEventListener('input', () => this.updatePreview());
            element.addEventListener('change', () => this.updatePreview());
        });

        // Action buttons
        document.getElementById('save-btn').addEventListener('click', () => this.saveSnippet());
        document.getElementById('clear-btn').addEventListener('click', () => this.clearForm());
        document.getElementById('delete-btn').addEventListener('click', () => this.deleteSnippet());
        
        // Categories and Languages management
        const addCategoryBtn = document.getElementById('add-category-btn');
        if (addCategoryBtn) {
            addCategoryBtn.addEventListener('click', () => this.addCategory());
        }
        
        const addLanguageBtn = document.getElementById('add-language-btn');
        if (addLanguageBtn) {
            addLanguageBtn.addEventListener('click', () => this.addLanguage());
        }
        
        // Tab change listener
        const tabGroup = document.getElementById('admin-tabs');
        if (tabGroup) {
            tabGroup.addEventListener('sl-tab-show', (event) => {
                if (event.detail.name === 'stats') {
                    this.loadStatistics();
                } else if (event.detail.name === 'calendar') {
                    this.initCalendarView();
                } else if (event.detail.name === 'categories') {
                    this.loadCategoriesList();
                } else if (event.detail.name === 'languages') {
                    this.loadLanguagesList();
                }
            });
        }

        // Calendar dialog
        document.getElementById('cal-prev').addEventListener('click', () => this.previousMonth());
        document.getElementById('cal-next').addEventListener('click', () => this.nextMonth());
        document.getElementById('cal-cancel').addEventListener('click', () => {
            document.getElementById('calendar-dialog').hide();
        });
        document.getElementById('cal-confirm').addEventListener('click', () => this.confirmCalendarSelection());
    }

    setToday() {
        const now = new Date();
        const start = new Date(now.getFullYear(), 0, 0);
        const diff = now - start;
        const dayOfYear = Math.floor(diff / (1000 * 60 * 60 * 24));
        
        document.getElementById('day-input').value = dayOfYear;
        this.currentDay = dayOfYear;
        this.updateDateDisplay();
        this.loadSnippetForDay(dayOfYear);
        this.syncInputs();
    }

    switchToInputMethod(method) {
        // Toggle button states
        document.querySelectorAll('.toggle-btn').forEach(btn => btn.classList.remove('active'));
        
        if (method === 'day-year') {
            document.getElementById('toggle-day-year').classList.add('active');
            document.getElementById('day-year-input').style.display = 'block';
            document.getElementById('day-month-input').style.display = 'none';
        } else {
            document.getElementById('toggle-day-month').classList.add('active');
            document.getElementById('day-year-input').style.display = 'none';
            document.getElementById('day-month-input').style.display = 'block';
        }
    }

    handleDayMonthInput() {
        const day = parseInt(document.getElementById('day-only').value);
        const month = parseInt(document.getElementById('month-only').value);
        
        if (day >= 1 && day <= 31 && month >= 1 && month <= 12) {
            // Validate day for the specific month
            const maxDaysInMonth = new Date(new Date().getFullYear(), month, 0).getDate();
            if (day > maxDaysInMonth) {
                this.showMessage(`Le mois sélectionné n'a que ${maxDaysInMonth} jours`, 'error');
                return;
            }
            
            // Calculate day of year
            const date = new Date(new Date().getFullYear(), month - 1, day);
            const dayOfYear = this.getDayOfYear(date);
            
            this.currentDay = dayOfYear;
            this.updateDateDisplay();
            this.loadSnippetForDay(dayOfYear);
            this.syncInputs();
        }
    }

    syncInputs() {
        if (!this.currentDay) return;
        
        // Update day-of-year input
        document.getElementById('day-input').value = this.currentDay;
        
        // Update day/month inputs
        const date = this.getDayOfYearDate(this.currentDay);
        document.getElementById('day-only').value = date.getDate();
        document.getElementById('month-only').value = date.getMonth() + 1;
    }

    updateDateDisplay() {
        if (!this.currentDay || this.currentDay < 1 || this.currentDay > 365) {
            document.getElementById('date-display').innerHTML = `
                <div class="date-display-text">Sélectionnez un jour</div>
                <div class="date-display-sub">1-365</div>
            `;
            return;
        }

        const date = this.getDayOfYearDate(this.currentDay);
        const monthNames = ['Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin',
                           'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'];
        
        const hasSnippet = this.snippets.has(this.currentDay);
        
        document.getElementById('date-display').innerHTML = `
            <div class="date-display-text">
                ${date.getDate()} ${monthNames[date.getMonth()]}
            </div>
            <div class="date-display-sub">
                Jour ${this.currentDay}/365 ${hasSnippet ? '✅' : '⭕'}
            </div>
        `;
    }

    getDayOfYearDate(dayOfYear) {
        const date = new Date(new Date().getFullYear(), 0, 1);
        date.setDate(dayOfYear);
        return date;
    }

    getDayOfYear(date) {
        const start = new Date(date.getFullYear(), 0, 0);
        const diff = date - start;
        return Math.floor(diff / (1000 * 60 * 60 * 24));
    }

    loadSnippetForDay(day) {
        const snippet = this.snippets.get(day);
        if (snippet) {
            document.getElementById('title-input').value = snippet.title;
            document.getElementById('code-input').value = snippet.code;
            document.getElementById('explanation-input').value = snippet.explanation;
            document.getElementById('category-select').value = snippet.category_id;
            document.getElementById('language-select').value = snippet.language_id;
            
            this.showMessage(`Snippet chargé pour le jour ${day}`, 'success');
        } else {
            this.clearFormFields();
        }
        this.updatePreview();
    }

    clearForm() {
        document.getElementById('day-input').value = '';
        this.clearFormFields();
        this.currentDay = null;
        this.updateDateDisplay();
        this.updatePreview();
    }

    clearFormFields() {
        document.getElementById('title-input').value = '';
        document.getElementById('code-input').value = '';
        document.getElementById('explanation-input').value = '';
        document.getElementById('category-select').value = '';
        document.getElementById('language-select').value = '';
    }

    async saveSnippet() {
        if (!this.validateForm()) return;

        const date = this.getDayOfYearDate(this.currentDay);
        const snippetData = {
            month: date.getMonth() + 1,
            day: date.getDate(),
            title: document.getElementById('title-input').value.trim(),
            code: document.getElementById('code-input').value.trim(),
            explanation: document.getElementById('explanation-input').value.trim(),
            category_id: parseInt(document.getElementById('category-select').value),
            language_id: parseInt(document.getElementById('language-select').value)
        };

        try {
            const existingSnippet = this.snippets.get(this.currentDay);
            
            if (existingSnippet) {
                const { error } = await supabase
                    .from('snippets')
                    .update(snippetData)
                    .eq('id', existingSnippet.id);
                
                if (error) throw error;
                this.showMessage('Snippet mis à jour avec succès!', 'success');
            } else {
                const { error } = await supabase
                    .from('snippets')
                    .insert([snippetData]);
                
                if (error) throw error;
                this.showMessage('Nouveau snippet créé avec succès!', 'success');
            }

            // Reload data to refresh the snippets map
            await this.loadData();
            this.updateDateDisplay();
            
        } catch (error) {
            console.error('Erreur sauvegarde:', error);
            this.showMessage('Erreur lors de la sauvegarde', 'error');
        }
    }

    async deleteSnippet() {
        if (!this.currentDay) return;
        
        const snippet = this.snippets.get(this.currentDay);
        if (!snippet) {
            this.showMessage('Aucun snippet à supprimer pour ce jour', 'error');
            return;
        }

        if (!confirm(`Êtes-vous sûr de vouloir supprimer le snippet du jour ${this.currentDay} ?`)) {
            return;
        }

        try {
            const { error } = await supabase
                .from('snippets')
                .delete()
                .eq('id', snippet.id);

            if (error) throw error;

            this.showMessage('Snippet supprimé avec succès!', 'success');
            await this.loadData();
            this.clearFormFields();
            this.updateDateDisplay();
            this.updatePreview();

        } catch (error) {
            console.error('Erreur suppression:', error);
            this.showMessage('Erreur lors de la suppression', 'error');
        }
    }

    validateForm() {
        if (!this.currentDay || this.currentDay < 1 || this.currentDay > 365) {
            this.showMessage('Veuillez sélectionner un jour valide (1-365)', 'error');
            return false;
        }

        const title = document.getElementById('title-input').value.trim();
        const code = document.getElementById('code-input').value.trim();
        const explanation = document.getElementById('explanation-input').value.trim();
        const categoryId = document.getElementById('category-select').value;
        const languageId = document.getElementById('language-select').value;

        if (!title) {
            this.showMessage('Le titre est requis', 'error');
            return false;
        }

        if (!code) {
            this.showMessage('Le code est requis', 'error');
            return false;
        }

        if (!explanation) {
            this.showMessage('L\'explication est requise', 'error');
            return false;
        }

        if (!categoryId) {
            this.showMessage('Veuillez sélectionner une catégorie', 'error');
            return false;
        }

        if (!languageId) {
            this.showMessage('Veuillez sélectionner un langage', 'error');
            return false;
        }

        return true;
    }

    updatePreview() {
        const title = document.getElementById('title-input').value.trim() || 'Titre du snippet';
        const code = document.getElementById('code-input').value.trim() || '// Votre code ici';
        const explanation = document.getElementById('explanation-input').value.trim() || 'Explication du code...';
        const categoryId = document.getElementById('category-select').value;
        const languageId = document.getElementById('language-select').value;

        const category = this.categories.find(c => c.id == categoryId) || { name: 'Catégorie', color: '#007bff' };
        const language = this.languages.find(l => l.id == languageId) || { display_name: 'Langage', syntax_highlight: 'javascript', color: '#10b981' };

        // Use EXACT same structure as dashboard widget
        const previewHTML = `
            <div class="widget code-snippet-widget">
                <h2 class="widget-title"><i class="fa-solid fa-code"></i> Code Snippet du Jour</h2>
                <div id="snippet-content">
                    <div class="snippet-header">
                        <div class="snippet-badges">
                            <span class="snippet-category">${category.name}</span>
                        </div>
                    </div>
                    <h3 class="snippet-title">${this.escapeHtml(title)}</h3>
                    <div class="snippet-code">
                        <pre><code class="language-${language.syntax_highlight}">${this.escapeHtml(code)}</code></pre>
                    </div>
                    <p class="snippet-explanation">${this.escapeHtml(explanation)}</p>
                </div>
            </div>
        `;

        document.getElementById('preview-content').innerHTML = previewHTML;

        // Apply syntax highlighting
        if (window.Prism) {
            window.Prism.highlightAll();
        }
    }

    hexToRgb(hex) {
        const result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
        return result ? 
            `${parseInt(result[1], 16)}, ${parseInt(result[2], 16)}, ${parseInt(result[3], 16)}` : 
            "0, 123, 255";
    }

    // Calendar functions
    openCalendar() {
        if (this.currentDay) {
            const date = this.getDayOfYearDate(this.currentDay);
            this.calendarMonth = date.getMonth();
            this.calendarYear = date.getFullYear();
        } else {
            const now = new Date();
            this.calendarMonth = now.getMonth();
            this.calendarYear = now.getFullYear();
        }
        
        this.renderCalendar();
        document.getElementById('calendar-dialog').show();
    }

    previousMonth() {
        this.calendarMonth--;
        if (this.calendarMonth < 0) {
            this.calendarMonth = 11;
            this.calendarYear--;
        }
        this.renderCalendar();
    }

    nextMonth() {
        this.calendarMonth++;
        if (this.calendarMonth > 11) {
            this.calendarMonth = 0;
            this.calendarYear++;
        }
        this.renderCalendar();
    }

    renderCalendar() {
        const monthNames = ['Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin',
                           'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'];
        
        document.getElementById('cal-month-year').textContent = 
            `${monthNames[this.calendarMonth]} ${this.calendarYear}`;

        const firstDay = new Date(this.calendarYear, this.calendarMonth, 1);
        const lastDay = new Date(this.calendarYear, this.calendarMonth + 1, 0);
        const startDate = new Date(firstDay);
        startDate.setDate(startDate.getDate() - firstDay.getDay());

        const calendarDays = document.getElementById('cal-days');
        calendarDays.innerHTML = '';

        const today = new Date();
        
        for (let i = 0; i < 42; i++) {
            const date = new Date(startDate);
            date.setDate(startDate.getDate() + i);
            
            const dayElement = document.createElement('div');
            dayElement.textContent = date.getDate();
            dayElement.className = 'calendar-day';

            // Add state classes
            if (date.getMonth() !== this.calendarMonth) {
                dayElement.classList.add('other-month');
            }

            if (this.isSameDay(date, today)) {
                dayElement.classList.add('today');
            }

            const dayOfYear = this.getDayOfYear(date);
            if (!this.snippets.has(dayOfYear)) {
                dayElement.classList.add('no-snippet');
            }

            dayElement.addEventListener('click', () => {
                // Remove previous selection
                document.querySelectorAll('.calendar-day.selected').forEach(el => {
                    el.classList.remove('selected');
                });

                // Add selection to clicked day
                dayElement.classList.add('selected');
                this.selectedCalendarDate = new Date(date);
            });

            calendarDays.appendChild(dayElement);
        }
    }

    confirmCalendarSelection() {
        if (this.selectedCalendarDate) {
            const dayOfYear = this.getDayOfYear(this.selectedCalendarDate);
            this.currentDay = dayOfYear;
            this.updateDateDisplay();
            this.loadSnippetForDay(dayOfYear);
            this.syncInputs();
            document.getElementById('calendar-dialog').hide();
        }
    }

    isSameDay(date1, date2) {
        return date1.getFullYear() === date2.getFullYear() &&
               date1.getMonth() === date2.getMonth() &&
               date1.getDate() === date2.getDate();
    }

    showMessage(message, type = 'success') {
        const messagesContainer = document.getElementById('messages');
        const messageElement = document.createElement('div');
        messageElement.className = `message ${type}`;
        
        const icon = type === 'success' ? 'fa-check-circle' : 'fa-exclamation-circle';
        messageElement.innerHTML = `
            <i class="fa-solid ${icon}"></i>
            <span>${message}</span>
        `;

        messagesContainer.innerHTML = '';
        messagesContainer.appendChild(messageElement);

        setTimeout(() => {
            messageElement.remove();
        }, 5000);
    }

    escapeHtml(text) {
        const div = document.createElement('div');
        div.textContent = text;
        return div.innerHTML;
    }

    dateStringToDayOfYear(dateString) {
        const date = new Date(dateString);
        const start = new Date(date.getFullYear(), 0, 0);
        const diff = date - start;
        return Math.floor(diff / (1000 * 60 * 60 * 24));
    }

    monthDayToDayOfYear(month, day) {
        const year = new Date().getFullYear();
        const date = new Date(year, month - 1, day);
        const start = new Date(year, 0, 0);
        const diff = date - start;
        return Math.floor(diff / (1000 * 60 * 60 * 24));
    }

    dayOfYearToDateString(dayOfYear) {
        const year = new Date().getFullYear();
        const date = new Date(year, 0, dayOfYear);
        return date.toISOString().split('T')[0]; // Returns YYYY-MM-DD format
    }

    async loadStatistics() {
        try {
            // Get total snippets count
            const totalSnippets = this.snippets.size;
            document.getElementById('total-snippets').textContent = totalSnippets;
            
            // Calculate completed days
            const completedDays = this.snippets.size;
            document.getElementById('completed-days').textContent = `${completedDays}/365`;
            
            // Calculate progress percentage
            const progressPercentage = Math.round((completedDays / 365) * 100);
            document.getElementById('progress-percentage').textContent = `${progressPercentage}%`;
            
            // Update progress bar if exists
            const progressFill = document.getElementById('progress-fill');
            if (progressFill) {
                progressFill.style.width = `${progressPercentage}%`;
            }
        } catch (error) {
            console.error('Error loading statistics:', error);
        }
    }

    initCalendarView() {
        const calendarContainer = document.getElementById('year-overview-calendar');
        if (!calendarContainer) return;
        
        // Create a year calendar view
        const months = ['Jan', 'Fév', 'Mar', 'Avr', 'Mai', 'Juin', 
                       'Juil', 'Aoû', 'Sep', 'Oct', 'Nov', 'Déc'];
        
        calendarContainer.innerHTML = '';
        
        // Create month grid
        const yearGrid = document.createElement('div');
        yearGrid.style.cssText = `
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            padding: 20px;
        `;
        
        const year = new Date().getFullYear();
        
        months.forEach((monthName, monthIndex) => {
            const monthCard = document.createElement('div');
            monthCard.style.cssText = `
                background: var(--widget-dark);
                border-radius: 12px;
                padding: 15px;
                border: 1px solid var(--border-color);
            `;
            
            const monthTitle = document.createElement('h4');
            monthTitle.textContent = monthName;
            monthTitle.style.cssText = `
                color: var(--white);
                margin-bottom: 10px;
                text-align: center;
            `;
            monthCard.appendChild(monthTitle);
            
            // Create mini calendar for the month
            const daysGrid = document.createElement('div');
            daysGrid.style.cssText = `
                display: grid;
                grid-template-columns: repeat(7, 1fr);
                gap: 2px;
                font-size: 0.7rem;
            `;
            
            // Add day headers
            ['D', 'L', 'M', 'M', 'J', 'V', 'S'].forEach(day => {
                const dayHeader = document.createElement('div');
                dayHeader.textContent = day;
                dayHeader.style.cssText = `
                    text-align: center;
                    color: var(--light-grey);
                    font-weight: 600;
                    padding: 2px;
                `;
                daysGrid.appendChild(dayHeader);
            });
            
            // Get first day of month and number of days
            const firstDay = new Date(year, monthIndex, 1).getDay();
            const daysInMonth = new Date(year, monthIndex + 1, 0).getDate();
            
            // Add empty cells for days before month starts
            for (let i = 0; i < firstDay; i++) {
                const emptyDay = document.createElement('div');
                daysGrid.appendChild(emptyDay);
            }
            
            // Add days of the month
            for (let day = 1; day <= daysInMonth; day++) {
                const dayCell = document.createElement('div');
                dayCell.textContent = day;
                
                // Check if this day has a snippet
                const hasSnippet = Array.from(this.snippets.values()).some(s => 
                    s.month === (monthIndex + 1) && s.day === day
                );
                
                dayCell.style.cssText = `
                    text-align: center;
                    padding: 4px;
                    border-radius: 4px;
                    cursor: pointer;
                    color: var(--white);
                    background: ${hasSnippet ? 'var(--success-color)' : 'var(--danger-color)'};
                    font-weight: 600;
                `;
                
                dayCell.addEventListener('click', () => {
                    // Switch to editor tab with this date
                    const date = new Date(year, monthIndex, day);
                    const dayOfYear = this.getDayOfYear(date);
                    document.getElementById('day-input').value = dayOfYear;
                    this.currentDay = dayOfYear;
                    this.updateDateDisplay();
                    this.loadSnippetForDay(dayOfYear);
                    this.syncInputs();
                    
                    // Switch to editor tab
                    const tabGroup = document.getElementById('admin-tabs');
                    if (tabGroup) {
                        tabGroup.show('editor');
                    }
                });
                
                daysGrid.appendChild(dayCell);
            }
            
            monthCard.appendChild(daysGrid);
            yearGrid.appendChild(monthCard);
        });
        
        calendarContainer.appendChild(yearGrid);
    }

    async loadCategoriesList() {
        const listContainer = document.getElementById('categories-list');
        if (!listContainer) return;
        
        listContainer.innerHTML = '';
        
        this.categories.forEach(category => {
            const item = document.createElement('div');
            item.style.cssText = `
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 12px;
                border-bottom: 1px solid var(--border-color);
            `;
            
            item.innerHTML = `
                <div style="display: flex; align-items: center; gap: 10px;">
                    <div style="width: 20px; height: 20px; background: ${category.color}; border-radius: 4px;"></div>
                    <span style="color: var(--white); font-weight: 500;">${category.name}</span>
                </div>
                <button onclick="window.snippetManager.deleteCategory(${category.id})" style="
                    background: var(--danger-color);
                    color: white;
                    border: none;
                    padding: 4px 12px;
                    border-radius: 4px;
                    cursor: pointer;
                    font-size: 0.85rem;
                ">Supprimer</button>
            `;
            
            listContainer.appendChild(item);
        });
    }

    async loadLanguagesList() {
        const listContainer = document.getElementById('languages-list');
        if (!listContainer) return;
        
        listContainer.innerHTML = '';
        
        // Calculate language usage percentages
        const totalSnippets = this.snippets.size;
        const languageCounts = {};
        
        this.snippets.forEach(snippet => {
            const langId = snippet.language_id;
            languageCounts[langId] = (languageCounts[langId] || 0) + 1;
        });
        
        this.languages.forEach(language => {
            const count = languageCounts[language.id] || 0;
            const percentage = totalSnippets > 0 ? Math.round((count / totalSnippets) * 100) : 0;
            
            const item = document.createElement('div');
            item.style.cssText = `
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 12px;
                border-bottom: 1px solid var(--border-color);
            `;
            
            item.innerHTML = `
                <div style="display: flex; align-items: center; gap: 10px;">
                    <div style="width: 20px; height: 20px; background: ${language.color}; border-radius: 4px;"></div>
                    <span style="color: var(--white); font-weight: 500;">${language.display_name}</span>
                    <span style="color: var(--light-grey); font-size: 0.85rem;">(${language.name})</span>
                    <span style="color: var(--accent-color); font-weight: 600; font-size: 0.85rem;">${count} snippets (${percentage}%)</span>
                </div>
                <button onclick="window.snippetManager.deleteLanguage(${language.id})" style="
                    background: var(--danger-color);
                    color: white;
                    border: none;
                    padding: 4px 12px;
                    border-radius: 4px;
                    cursor: pointer;
                    font-size: 0.85rem;
                ">Supprimer</button>
            `;
            
            listContainer.appendChild(item);
        });
    }

    async addCategory() {
        const nameInput = document.getElementById('new-category-name');
        const colorInput = document.getElementById('new-category-color');
        
        if (!nameInput.value.trim()) {
            this.showMessage('Veuillez entrer un nom de catégorie', 'error');
            return;
        }
        
        try {
            const { error } = await supabase
                .from('categories')
                .insert([{
                    name: nameInput.value.trim(),
                    color: colorInput.value
                }]);
            
            if (error) throw error;
            
            this.showMessage('Catégorie ajoutée avec succès!', 'success');
            nameInput.value = '';
            colorInput.value = '#007bff';
            await this.loadData();
            this.loadCategoriesList();
            
        } catch (error) {
            console.error('Erreur ajout catégorie:', error);
            this.showMessage('Erreur lors de l\'ajout de la catégorie', 'error');
        }
    }

    async addLanguage() {
        const nameInput = document.getElementById('new-language-name');
        const displayInput = document.getElementById('new-language-display');
        const colorInput = document.getElementById('new-language-color');
        
        if (!nameInput.value.trim() || !displayInput.value.trim()) {
            this.showMessage('Veuillez remplir tous les champs', 'error');
            return;
        }
        
        try {
            const { error } = await supabase
                .from('programming_languages')
                .insert([{
                    name: nameInput.value.trim().toLowerCase(),
                    display_name: displayInput.value.trim(),
                    syntax_highlight: nameInput.value.trim().toLowerCase(),
                    color: colorInput.value
                }]);
            
            if (error) throw error;
            
            this.showMessage('Langage ajouté avec succès!', 'success');
            nameInput.value = '';
            displayInput.value = '';
            colorInput.value = '#10b981';
            await this.loadData();
            this.loadLanguagesList();
            
        } catch (error) {
            console.error('Erreur ajout langage:', error);
            this.showMessage('Erreur lors de l\'ajout du langage', 'error');
        }
    }

    async deleteCategory(id) {
        if (!confirm('Êtes-vous sûr de vouloir supprimer cette catégorie?')) return;
        
        try {
            const { error } = await supabase
                .from('categories')
                .delete()
                .eq('id', id);
            
            if (error) throw error;
            
            this.showMessage('Catégorie supprimée avec succès!', 'success');
            await this.loadData();
            this.loadCategoriesList();
            
        } catch (error) {
            console.error('Erreur suppression catégorie:', error);
            this.showMessage('Erreur lors de la suppression', 'error');
        }
    }

    async deleteLanguage(id) {
        if (!confirm('Êtes-vous sûr de vouloir supprimer ce langage?')) return;
        
        try {
            const { error } = await supabase
                .from('programming_languages')
                .delete()
                .eq('id', id);
            
            if (error) throw error;
            
            this.showMessage('Langage supprimé avec succès!', 'success');
            await this.loadData();
            this.loadLanguagesList();
            
        } catch (error) {
            console.error('Erreur suppression langage:', error);
            this.showMessage('Erreur lors de la suppression', 'error');
        }
    }
}

// Initialize when DOM is ready
document.addEventListener('DOMContentLoaded', () => {
    window.snippetManager = new ModernSnippetManager();
});