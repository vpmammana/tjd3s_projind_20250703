const CACHE_NAME = 'meu-app-cache-v1';
const FILES_TO_CACHE = [
    '/', // Página inicial
    '/dev_vitor/sugere_frases/php/sugere_frases2.php', // HTML principal
    '/dev_vitor/sugere_frases/js/offline.js', // JavaScript principal
];

// Instalar o Service Worker e armazenar os arquivos no cache
self.addEventListener('install', (event) => {
    console.log('[ServiceWorker] Instalando...');
    event.waitUntil(
        caches.open(CACHE_NAME).then((cache) => {
            console.log('[ServiceWorker] Cacheando arquivos...');
            return cache.addAll(FILES_TO_CACHE);
        })
    );
});

// Ativar o Service Worker e limpar caches antigos
self.addEventListener('activate', (event) => {
    console.log('[ServiceWorker] Ativando...');
    event.waitUntil(
        caches.keys().then((keyList) => {
            return Promise.all(
                keyList.map((key) => {
                    if (key !== CACHE_NAME) {
                        console.log('[ServiceWorker] Removendo cache antigo:', key);
                        return caches.delete(key);
                    }
                })
            );
        })
    );
    return self.clients.claim();
});

// Interceptar requisições e servir do cache, se necessário
self.addEventListener('fetch', (event) => {
    console.log('[ServiceWorker] Fetch para:', event.request.url);
    event.respondWith(
        caches.match(event.request).then((response) => {
            return response || fetch(event.request).catch(() => {
                // Opcional: Servir um fallback se a rede falhar
                if (event.request.destination === 'document') {
                    return caches.match('/dev_vitor/sugere_frases/html/index.html');
                }
            });
        })
    );
});

