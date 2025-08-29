// Configuration Supabase
// Configuration pour le navigateur (frontend)

const SUPABASE_CONFIG = {
    URL: 'https://owjcgekrreywjegqshuk.supabase.co',
    PUBLISHABLE_KEY: 'sb_publishable_0UXb3eEz3JMJ0kc52_zxrQ_RKdAmCW7'
};

// Export pour utilisation dans d'autres fichiers
if (typeof window !== 'undefined') {
    window.SUPABASE_CONFIG = SUPABASE_CONFIG;
}

// Pour Node.js (si utilisé)
if (typeof module !== 'undefined' && module.exports) {
    module.exports = SUPABASE_CONFIG;
}
