const fs = require('fs');
const path = require('path');

// Lire les variables d'environnement GitHub Actions
const SUPABASE_URL = process.env.SUPABASE_URL || 'https://owjcgekrreywjegqshuk.supabase.co';
const SUPABASE_PUBLISHABLE_KEY = process.env.SUPABASE_PUBLISHABLE_KEY || '';

// Lire le fichier config.js
const configPath = path.join(__dirname, 'config.js');
let configContent = fs.readFileSync(configPath, 'utf8');

// Remplacer les valeurs hardcodées par les variables d'environnement
configContent = configContent.replace(
    /URL: '[^']*'/g,
    `URL: '${SUPABASE_URL}'`
);

configContent = configContent.replace(
    /PUBLISHABLE_KEY: '[^']*'/g,
    `PUBLISHABLE_KEY: '${SUPABASE_PUBLISHABLE_KEY}'`
);

// Écrire le fichier config.js mis à jour
fs.writeFileSync(configPath, configContent);

console.log('✅ Configuration mise à jour avec les variables d\'environnement');
console.log(`URL: ${SUPABASE_URL}`);
console.log(`Key: ${SUPABASE_PUBLISHABLE_KEY ? '***' + SUPABASE_PUBLISHABLE_KEY.slice(-4) : 'Non définie'}`);
