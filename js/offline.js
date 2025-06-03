// o presente código foi desenvolvido por Victor Mammana, com base em interação com chatBots e a revisão de um código presente no repositório github oantenor

if ('serviceWorker' in navigator) {
    navigator.serviceWorker.register('/dev_vitor/sugere_frases/js/service-worker.js')
        .then((registration) => {
            console.log('Service Worker registrado com sucesso:', registration);
        })
        .catch((error) => {
            console.error('Falha ao registrar o Service Worker:', error);
        });
}


    const cache = {
        tokens: null,
        frases: null,
        tipos_resultados: null,
        tipos_acoes: null
    };

const cache_map = {
    tokens: new Map(),          // Map para armazenar tokens por `id_chave_token`
    frases: new Map(),          // Map para armazenar frases por ID (chave é integer)
    tipos_resultados: new Map(), // Map para armazenar tipos de resultados por `id_chave_tipo_resultado`
    tipos_acoes: new Map()       // Map para armazenar tipos de ações por `id_chave_tipo_acao`
};

async function preloadIndexedDBData() {
    const db = await openDatabaseOnce('papedins_db', 11);
    const stores = ['tokens', 'frases', 'tipos_resultados', 'tipos_acoes'];

    const promises = stores.map((storeName) => {
	console.log('storeName cache:', storeName);
        return new Promise((resolve, reject) => {
            const transaction = db.transaction([storeName], 'readonly');
            const objectStore = transaction.objectStore(storeName);

            const items = [];
            const request = objectStore.openCursor();

            request.onsuccess = (event) => {
                const cursor = event.target.result;
                if (cursor) {
                    items.push(cursor.value);
                    cursor.continue();
                } else {
                    // Resolve a Promise para este store quando todos os itens forem carregados
                    resolve({ storeName, items });
                }
            };

            request.onerror = () => reject(request.error);
        });
    });

    // Espera por todas as Promises para resolver
    const results = await Promise.all(promises);

    // Organiza os dados no cache global
    results.forEach(({ storeName, items }) => {
        cache[storeName] = items;
    });

    console.log("Dados carregados no cache:", cache);
}

async function preloadCacheMap() {
    const db = await openDatabaseOnce('papedins_db', 11);
    const stores = ['tokens', 'frases', 'tipos_resultados', 'tipos_acoes'];

    const promises = stores.map((storeName) => {
        console.log('Carregando store:', storeName);
        return new Promise((resolve, reject) => {
            const transaction = db.transaction([storeName], 'readonly');
            const objectStore = transaction.objectStore(storeName);

            const items = [];
            const request = objectStore.openCursor();

            request.onsuccess = (event) => {
                const cursor = event.target.result;
                if (cursor) {
                    items.push(cursor.value);
                    cursor.continue();
                } else {
                    // Resolve a Promise para este store quando todos os itens forem carregados
                    resolve({ storeName, items });
                }
            };

            request.onerror = () => reject(request.error);
        });
    });

    // Espera que todas as Promises sejam resolvidas
    const results = await Promise.all(promises);

    // Preenche o cache_map com os dados apropriados
    results.forEach(({ storeName, items }) => {
        switch (storeName) {
            case 'tokens':
                cache_map.tokens = new Map(items.map(item => [item.id_chave_token, item]));
                break;
            case 'frases':
                cache_map.frases = new Map(items.map(item => [item.id_chave_frase, item])); // Substitua `item.id` pelo nome correto do campo
                break;
            case 'tipos_resultados':
                cache_map.tipos_resultados = new Map(items.map(item => [item.id_chave_tipo_resultado, item]));
                break;
            case 'tipos_acoes':
                cache_map.tipos_acoes = new Map(items.map(item => [item.id_chave_tipo_acao, item]));
                break;
            default:
                console.warn(`Store ${storeName} não é reconhecida.`);
        }
    });

    console.log("Dados carregados no cache_map:", cache_map);
}



function openDatabaseOnce(dbName, version) {
    return new Promise((resolve, reject) => {
        const request = indexedDB.open(dbName, version);

        request.onupgradeneeded = (event) => {
            const db = event.target.result;
            //console.log('onupgradeneeded chamado');
            if (!db.objectStoreNames.contains('tipos_acoes')) {
                db.createObjectStore('tipos_acoes', { keyPath: 'id_chave_tipo_acao' });
                //console.log('Object store "tipos_acoes" criado.');
            }
            if (!db.objectStoreNames.contains('tipos_resultados')) {
                db.createObjectStore('tipos_resultados', { keyPath: 'id_chave_tipo_resultado' });
                //console.log('object store "tipos_resultados" criado.');
            }
            if (!db.objectStoreNames.contains('tokens')) {
                db.createObjectStore('tokens', { keyPath: 'id_chave_token' });
                //console.log('object store "tokens" criado.');
            }
            if (!db.objectStoreNames.contains('frases')) {
                db.createObjectStore('frases', { keyPath: 'id_chave_frase' });
                //console.log('object store "frases" criado.');
            }
            if (!db.objectStoreNames.contains('perguntas')) {
                db.createObjectStore('perguntas', { keyPath: 'id_chave_pergunta' });
                //console.log('object store "perguntas" criado.');
            }
        };

        request.onsuccess = (event) => {
            //console.log('Banco de dados aberto com sucesso.');
            resolve(event.target.result);
        };

        request.onerror = (event) => {
            console.error('Erro ao abrir o banco de dados:', event.target.error);
            reject(event.target.error);
        };

        request.onblocked = () => {
            console.warn('Abertura do banco de dados bloqueada. Feche outras conexões.');
            reject(new Error('Database opening blocked.'));
        };
    });
}


function upgradeTiposAcoesDB(db) {
    if (!db.objectStoreNames.contains('tipos_acoes')) {
        db.createObjectStore('tipos_acoes', { keyPath: 'id_chave_tipo_acao' });
    }
}

function upgradeTiposResultadosDB(db) {
    if (!db.objectStoreNames.contains('tipos_resultados')) {
        db.createObjectStore('tipos_resultados', { keyPath: 'id_chave_tipo_resultado' });
    }
}

function upgradeTokensDB(db) {
    if (!db.objectStoreNames.contains('tokens')) {
        db.createObjectStore('tokens', { keyPath: 'id_chave_token' });
    }
}

function upgradeFrasesDB(db) {
    if (!db.objectStoreNames.contains('frases')) {
        db.createObjectStore('frases', { keyPath: 'id_chave_frase' });
    }
}

// fim patch VPM

function upgradeOfflineDataDB(db) {
    if (!db.objectStoreNames.contains('offlineData')) {
        db.createObjectStore('offlineData', {
            keyPath: 'id',
            autoIncrement: true
        });
    }
}

function storePerguntasInDB(perguntas) {
    //console.log('storePerguntasInDB');
    openDatabaseOnce('papedins_db', 11).then(db => {
        const transaction = db.transaction(['perguntas'], 'readwrite');
        const objectStore = transaction.objectStore('perguntas');

        // Limpa os dados antigos antes de adicionar os novos
        objectStore.clear();
        perguntas.forEach(pergunta => {
            objectStore.add({
                id_chave_pergunta: pergunta.id_chave_pergunta,
                nome_pergunta: pergunta.nome_pergunta,
		placeholder: pergunta.placeholder,
		help: pergunta.help
            });
        });

        transaction.oncomplete = () => {
            console.log('perguntas stored in IndexedDB');
        };

        transaction.onerror = () => {
            console.error('Error storing perguntas in IndexedDB');
        };
    });
}

function storeTiposAcoesInDB(tiposAcoes) {
    //console.log('storeTiposAcoesInDB');
    openDatabaseOnce('papedins_db', 11).then(db => {
        const transaction = db.transaction(['tipos_acoes'], 'readwrite');
        const objectStore = transaction.objectStore('tipos_acoes');

        // Limpa os dados antigos antes de adicionar os novos
        objectStore.clear();
        tiposAcoes.forEach(tipoAcao => {
            objectStore.add({
                id_chave_tipo_acao: tipoAcao.id_chave_tipo_acao,
                id_tipo_resultado: tipoAcao.id_tipo_resultado
            });
        });

        transaction.oncomplete = () => {
            console.log('tipos_acoes stored in IndexedDB');
        };

        transaction.onerror = () => {
            console.error('Error storing tipos_acoes in IndexedDB');
        };
    });
}

function storeTiposResultadosInDB(tiposResultados) {
    //console.log('storeTiposResultadosInDB');
    openDatabaseOnce('papedins_db', 11).then(db => {
        const transaction = db.transaction(['tipos_resultados'], 'readwrite');
        const objectStore = transaction.objectStore('tipos_resultados');

        // Limpa os dados antigos antes de adicionar os novos
        objectStore.clear();

            //console.log(tiposResultados);
        tiposResultados.forEach(tipoResultado => {
            //console.log(tipoResultado.id_chave_tipo_resultado);
            objectStore.add({
                id_chave_tipo_resultado: tipoResultado.id_chave_tipo_resultado,
		id_tipo_resultado_pai: tipoResultado.id_tipo_resultado_pai,
                nome_tipo_resultado_pai: tipoResultado.nome_tipo_resultado_pai,
                numeracao_tipo_resultado: tipoResultado.numeracao_tipo_resultado,
                nome_tipo_resultado_filho: tipoResultado.nome_tipo_resultado_filho
            });
        });

        transaction.oncomplete = () => {
            console.log('tipos_resultados stored in IndexedDB');
        };

        transaction.onerror = () => {
            console.error('Error storing tipos_resultados in IndexedDB');
        };
    });
}

function storeTokensInDB(tokens) {
    //console.log('storeTokensInDB');
    openDatabaseOnce('papedins_db', 11).then(db => {
        const transaction = db.transaction(['tokens'], 'readwrite');
        const objectStore = transaction.objectStore('tokens');

        // Limpa os dados antigos antes de adicionar os novos
        objectStore.clear();
        tokens.forEach(token => {
            objectStore.add({
                id_chave_token: token.id_chave_token,
                nome_token: token.nome_token,
                id_tipo_token: token.id_tipo_token,
                id_tipo_flexao: token.id_tipo_flexao
            });
        });

        transaction.oncomplete = () => {
            console.log('tokens stored in IndexedDB');
        };

        transaction.onerror = () => {
            console.error('Error storing tokens in IndexedDB');
        };
    });
}

function storeFrasesInDB(frases) {
    //console.log('storeFrasesInDB');
    openDatabaseOnce('papedins_db', 11).then(db => {
        const transaction = db.transaction(['frases'], 'readwrite');
        const objectStore = transaction.objectStore('frases');

        // Limpa os dados antigos antes de adicionar os novos
        objectStore.clear();
        frases.forEach(frase => {
            objectStore.add({
                id_chave_frase: frase.id_chave_frase,
                id_token: frase.id_token,
                ordem: frase.ordem,
                id_tipo_acao: frase.id_tipo_acao
            });
        });

        transaction.oncomplete = () => {
            console.log('frases stored in IndexedDB');
        };

        transaction.onerror = () => {
            console.error('Error storing frases in IndexedDB');
        };
    });
}

function loadAllPerguntasIntoIndexedDB() {
    //console.log('loadAllPerguntasIntoIndexedDB');
    if (navigator.onLine) {
        fetch('./busca_perguntas.php')
            .then(response => response.json())
            .then(data => {
                storePerguntasInDB(data);
            })
            .catch(error => console.error('Error fetching perguntas:', error));
    }
}


function loadAllTiposAcoesIntoIndexedDB() {
    //console.log('loadAllTiposAcoesIntoIndexedDB');
    if (navigator.onLine) {
        fetch('./fetch-tipos-acoes-pdo.php')
            .then(response => response.json())
            .then(data => {
                storeTiposAcoesInDB(data);
            })
            .catch(error => console.error('Error fetching tipos_acoes:', error));
    }
}

function loadAllTiposResultadosIntoIndexedDB() {
    //console.log('loadAllTiposResultadosIntoIndexedDB');
    if (navigator.onLine) {
        fetch('./fetch-tipos-resultados-pdo.php')
            .then(response => response.json())
            .then(data => {
                storeTiposResultadosInDB(data);
            })
            .catch(error => console.error('Error fetching tipos_resultados:', error));
    }
}

function loadAllTokensIntoIndexedDB() {
    //console.log('loadAllTokensIntoIndexedDB');
    if (navigator.onLine) {
        fetch('./fetch-tokens-pdo.php')
            .then(response => response.json())
            .then(data => {
                storeTokensInDB(data);
            })
            .catch(error => console.error('Error fetching tokens:', error));
    }
}

function loadAllFrasesIntoIndexedDB() {
    //console.log('loadAllFrasesIntoIndexedDB');
    if (navigator.onLine) {
        fetch('./fetch-frases-pdo.php')
            .then(response => response.json())
            .then(data => {
                storeFrasesInDB(data);
            })
            .catch(error => console.error('Error fetching frases:', error));
    }
}



// quase quase

async function queryIndexedDB({ query, tokenIndex, previousTokens = [] }) {

    if (tokenIndex === undefined) {
        throw new Error('Faltam Parâmetros: query e tokenIndex são obrigatórios');
    }

    const db = await openDatabaseOnce('papedins_db', 11);
    const transaction = db.transaction(['tokens', 'frases'], 'readonly');
    const tokensStore = transaction.objectStore('tokens');
    const frasesStore = transaction.objectStore('frases');
    const regexQuery = new RegExp(`^${query}`); // Verificar se a frase começa com `query`
    // Etapa 1: Reconstruir frases relevantes
    const relevantFrases = await new Promise((resolve, reject) => {
    const results = new Map(); // Map para agrupar frases por `id_tipo_acao`
    const request = frasesStore.openCursor();
        request.onsuccess = (event) => {
            const cursor = event.target.result;
            if (cursor) {
                const { id_tipo_acao, id_token, ordem } = cursor.value;

                // Buscar tokens e agrupar por id_tipo_acao
                const tokenRequest = tokensStore.get(id_token);
                tokenRequest.onsuccess = () => {
                    const token = tokenRequest.result;
                    if (token) {
                        if (!results.has(id_tipo_acao)) {
                            results.set(id_tipo_acao, []);
                        }
                        results.get(id_tipo_acao).push({ ordem, nome_token: token.nome_token });
                    }
                    cursor.continue();
                };
                tokenRequest.onerror = () => {
                    cursor.continue();
                };
            } else {
                resolve(results);
            }
        };

        request.onerror = () => reject(request.error);
    });
    //console.log('relevantFrases:', relevantFrases , 'previousTokens:', previousTokens, 'tamanho relevantFrases:', relevantFrases.size);
    
    // Etapa 2: Filtrar frases que começam com `query` ou `previousTokens`

    const filteredFrases = [];
    for (const [id_tipo_acao, tokens] of relevantFrases.entries()) {
        // Ordenar tokens por ordem
        tokens.sort((a, b) => a.ordem - b.ordem);

        // Montar a frase completa
        const phrase = tokens.map((t) => t.nome_token).join(' ');

        // Quando previousTokens está vazio, usamos apenas o query
        if (
            (previousTokens.length === 0 && regexQuery.test(phrase)) ||
            (previousTokens.length > 0 && phrase.startsWith(previousTokens.join(' ')))
        ) {
            filteredFrases.push({ id_tipo_acao, phrase, tokens });
        }
    }

    // Etapa 3: Buscar tokens na posição `tokenIndex`
const selectedTokens = new Set(); // Conjunto para armazenar os tokens selecionados

for (const { tokens } of filteredFrases) { // Itera pelas frases e seus arrays de tokens
    if (tokens?.[tokenIndex - 1]?.nome_token.startsWith(query)) { // Acessa o tokenIndex-ésimo token
        selectedTokens.add(tokens[tokenIndex - 1].nome_token); // Adiciona ao conjunto se começar com `query`
    }
}

    return { tokens: Array.from(selectedTokens), phrases: filteredFrases };
}

async function queryIndexedDBfrases(previousTokens = []) {
    if (!Array.isArray(previousTokens)) {
        throw new Error("Parâmetro `previousTokens` deve ser um array.");
    }

    const subphrase = previousTokens.length > 0 ? previousTokens.join(' ') : ""; // Construir a subfrase

    const db = await openDatabaseOnce('papedins_db', 11);

    const transaction = db.transaction(['tokens', 'frases', 'tipos_resultados', 'tipos_acoes'], 'readonly');
    const tokensStore = transaction.objectStore('tokens');
    const frasesStore = transaction.objectStore('frases');
    const tiposResultadosStore = transaction.objectStore('tipos_resultados');
    const tiposAcoesStore = transaction.objectStore('tipos_acoes');
    const perguntasStore = transaction.objectStore('perguntas');

    const phrases = [];

    // Iterar sobre frases para reconstruir os dados necessários
    await new Promise((resolve, reject) => {
        const request = frasesStore.openCursor();

        request.onsuccess = async (event) => {
            const cursor = event.target.result;
            if (cursor) {
                const { id_tipo_acao, id_token, ordem } = cursor.value;
                const tokenRequest = tokensStore.get(id_token);
                const tipoAcaoRequest = tiposAcoesStore.get(id_tipo_acao);

                tokenRequest.onsuccess = () => {
                    tipoAcaoRequest.onsuccess = async () => {
                        const token = tokenRequest.result;
                        const tipoAcao = tipoAcaoRequest.result;
                        if (token && tipoAcao) {
                            const tipoResultadoFilhoRequest = tiposResultadosStore.get(tipoAcao.id_tipo_resultado);
                            tipoResultadoFilhoRequest.onsuccess = () => {
                                const tipoResultadoFilho = tipoResultadoFilhoRequest.result;
                                if (tipoResultadoFilho) {
                                    const tipoResultadoPaiRequest = tiposResultadosStore.get(tipoResultadoFilho.id_tipo_resultado_pai);
                                    tipoResultadoPaiRequest.onsuccess = () => {
                                        const tipoResultadoPai = tipoResultadoPaiRequest.result;

                                        if (tipoResultadoPai) {
                                            const phrase = phrases.find((p) => p.id_tipo_acao === id_tipo_acao);
                                            const nomeToken = token.nome_token;
                                            if (phrase) {
                                                phrase.tokens.push({ ordem, nome_token: nomeToken });
                                            } else {
                                                phrases.push({
                                                    id_tipo_acao,
                                                    id_tipo_resultado_filho: tipoResultadoFilho.id_chave_tipo_resultado,
                                                    id_tipo_resultado_pai: tipoResultadoPai.id_chave_tipo_resultado,
                                                    nome_tipo_resultado_filho: tipoResultadoFilho.nome_tipo_resultado_filho,
                                                    nome_tipo_resultado_pai: tipoResultadoPai.nome_tipo_resultado_pai,
                                                    tokens: [{ ordem, nome_token: nomeToken }]
                                                });
                                            }
                                        }
                                    };
                                }
                            };
                        }
                    };
                };

                cursor.continue();
            } else {
                resolve();
	      }
        };

        request.onerror = () => reject(request.error);
    });
//console.log('phrases:', phrases);
    // Reorganizar frases, filtrar e ordenar os resultados
    const result = phrases
        .map((p) => ({
            id_tipo_acao: p.id_tipo_acao,
            id_tipo_resultado_filho: p.id_tipo_resultado_filho,
            id_tipo_resultado_pai: p.id_tipo_resultado_pai,
            nome_tipo_resultado_filho: p.nome_tipo_resultado_filho,
            nome_tipo_resultado_pai: p.nome_tipo_resultado_pai,
            phrase: p.tokens
                .sort((a, b) => a.ordem - b.ordem)
                .map((t) => t.nome_token)
                .join(' ')
        }))
        .filter((p) => p.phrase.startsWith(subphrase)) // Aplicar o filtro de subfrase
        .sort((a, b) => a.id_tipo_resultado_filho - b.id_tipo_resultado_filho || a.phrase.localeCompare(b.phrase));

    return result;
}

// **Exemplo de Uso**
//console.log('queryIndexedDBfrases entrada');
const start = performance.now();

//queryIndexedDBfrases(['analisei'])
//    .then((result) => {
//        const end = performance.now();
//        console.log("Result:", JSON.stringify(result, null, 2));
//        console.log(`Tempo de execução: ${(end - start).toFixed(2)} ms`);
//    })
//    .catch((error) => {
//        const end = performance.now();
//        console.error("Error:", error);
//        console.log(`Tempo de execução até o erro: ${(end - start).toFixed(2)} ms`);
//    });

async function queryCachefrases(previousTokens = []) {
    if (!Array.isArray(previousTokens)) {
        throw new Error("Parâmetro `previousTokens` deve ser um array.");
    }

    const subphrase = previousTokens.length > 0 ? previousTokens.join(' ') : ""; // Construir a subfrase

    // Garantir que o cache esteja carregado
    if (!cache.tokens || !cache.frases || !cache.tipos_resultados || !cache.tipos_acoes) {
        throw new Error("O cache ainda não foi carregado. Certifique-se de que preloadIndexedDBData foi executado.");
    }

    const phrases = [];

    // Iterar sobre frases no cache
    for (const frase of cache.frases) {
        const { id_tipo_acao, id_token, ordem } = frase;

        // Recuperar dados relacionados diretamente do cache
        const token = cache.tokens.find(t => t.id_chave_token === id_token);
        const tipoAcao = cache.tipos_acoes.find(a => a.id_chave_tipo_acao === id_tipo_acao);
        const tipoResultadoFilho = cache.tipos_resultados.find(r => r.id_chave_tipo_resultado === tipoAcao?.id_tipo_resultado);
        const tipoResultadoPai = cache.tipos_resultados.find(r => r.id_chave_tipo_resultado === tipoResultadoFilho?.id_tipo_resultado_pai);

        if (token && tipoAcao && tipoResultadoFilho && tipoResultadoPai) {
            const phrase = phrases.find(p => p.id_tipo_acao === id_tipo_acao);
            const nomeToken = token.nome_token;

            if (phrase) {
                phrase.tokens.push({ ordem, nome_token: nomeToken });
            } else {
                phrases.push({
                    id_tipo_acao,
                    id_tipo_resultado_filho: tipoResultadoFilho.id_chave_tipo_resultado,
                    id_tipo_resultado_pai: tipoResultadoPai.id_chave_tipo_resultado,
                    nome_tipo_resultado_filho: tipoResultadoFilho.nome_tipo_resultado_filho,
                    nome_tipo_resultado_pai: tipoResultadoPai.nome_tipo_resultado_pai,
                    tokens: [{ ordem, nome_token: nomeToken }]
                });
            }
        }
    }

    // Reorganizar frases, filtrar e ordenar os resultados
    const result = phrases
        .map((p) => ({
            id_tipo_acao: p.id_tipo_acao,
            id_tipo_resultado_filho: p.id_tipo_resultado_filho,
            id_tipo_resultado_pai: p.id_tipo_resultado_pai,
            nome_tipo_resultado_filho: p.nome_tipo_resultado_filho,
            nome_tipo_resultado_pai: p.nome_tipo_resultado_pai,
            phrase: p.tokens
                .sort((a, b) => a.ordem - b.ordem)
                .map((t) => t.nome_token)
                .join(' ')
        }))
        .filter((p) => p.phrase.startsWith(subphrase)) // Aplicar o filtro de subfrase
        .sort((a, b) => a.id_tipo_resultado_filho - b.id_tipo_resultado_filho || a.phrase.localeCompare(b.phrase));

    return result;
}

async function queryCacheMapSuggestions({ query, tokenIndex, previousTokens = [] }) {
    if (!frases_montadas || tokenIndex === undefined) {
        throw new Error('Faltam Parâmetros: frases_montadas, query e tokenIndex são obrigatórios');
    }

    const regexQuery = new RegExp(`^${query}`); // Verificar se a frase começa com `query`

    // Etapa 1: Filtrar frases que começam com `query` ou `previousTokens`
    const filteredFrases = [];

    for (const frase of frases_montadas) {
        const { tokens, id_tipo_acao } = frase;

        // Montar a frase completa
        const phrase = tokens.map((t) => t.nome_token).join(' ');

        // Quando previousTokens está vazio, usamos apenas o query
        if (
            (previousTokens.length === 0 && regexQuery.test(phrase)) ||
            (previousTokens.length > 0 && phrase.startsWith(previousTokens.join(' ')))
        ) {
            filteredFrases.push({ id_tipo_acao, phrase, tokens });
        }
    }

    // Etapa 2: Buscar tokens na posição `tokenIndex`
    const selectedTokens = new Set(); // Conjunto para armazenar os tokens selecionados

    for (const { tokens } of filteredFrases) { // Itera pelas frases e seus arrays de tokens
        if (tokens?.[tokenIndex - 1]?.nome_token.startsWith(query)) { // Acessa o tokenIndex-ésimo token
            selectedTokens.add(tokens[tokenIndex - 1].nome_token); // Adiciona ao conjunto se começar com `query`
        }
    }

    return { tokens: Array.from(selectedTokens), phrases: filteredFrases };
}

async function queryCacheMapfrases() {
    // Garantir que o cache_map esteja carregado
    if (!cache_map.tokens || !cache_map.frases || !cache_map.tipos_resultados || !cache_map.tipos_acoes) {
        throw new Error("O cache_map ainda não foi carregado. Certifique-se de que preloadCacheMap foi executado.");
    }

    const phrases = [];

    // Iterar sobre frases no cache_map
    for (const [id, frase] of cache_map.frases) {
        const { id_tipo_acao, id_token, ordem } = frase;

        // Recuperar dados relacionados diretamente do cache_map
        const token = cache_map.tokens.get(id_token);
        const tipoAcao = cache_map.tipos_acoes.get(id_tipo_acao);
        const tipoResultadoFilho = tipoAcao ? cache_map.tipos_resultados.get(tipoAcao.id_tipo_resultado) : null;
        const tipoResultadoPai = tipoResultadoFilho ? cache_map.tipos_resultados.get(tipoResultadoFilho.id_tipo_resultado_pai) : null;

        if (token && tipoAcao && tipoResultadoFilho && tipoResultadoPai) {
            const phrase = phrases.find(p => p.id_tipo_acao === id_tipo_acao);
            const nomeToken = token.nome_token;

            if (phrase) {
                phrase.tokens.push({ ordem, nome_token: nomeToken });
            } else {
                phrases.push({
                    id_tipo_acao,
                    id_tipo_resultado_filho: tipoResultadoFilho.id_chave_tipo_resultado,
                    id_tipo_resultado_pai: tipoResultadoPai.id_chave_tipo_resultado,
                    nome_tipo_resultado_filho: tipoResultadoFilho.nome_tipo_resultado_filho,
                    nome_tipo_resultado_pai: tipoResultadoPai.nome_tipo_resultado_pai,
                    tokens: [{ ordem, nome_token: nomeToken }]
                });
            }
        }
    }
return phrases;
}

async function acha_frase(previousTokens = []) {
    if (!Array.isArray(previousTokens)) {
        throw new Error("Parâmetro `previousTokens` deve ser um array.");
    }

    const subphrase = previousTokens.length > 0 ? previousTokens.join(' ') : ""; // Construir a subfrase

    // Reorganizar frases, filtrar e ordenar os resultados
    const result = frases_montadas 
        .map((p) => ({
            id_tipo_acao: p.id_tipo_acao,
            id_tipo_resultado_filho: p.id_tipo_resultado_filho,
            id_tipo_resultado_pai: p.id_tipo_resultado_pai,
            nome_tipo_resultado_filho: p.nome_tipo_resultado_filho,
            nome_tipo_resultado_pai: p.nome_tipo_resultado_pai,
            phrase: p.tokens
                .sort((a, b) => a.ordem - b.ordem)
                .map((t) => t.nome_token)
                .join(' ')
        }))
        .filter((p) => p.phrase.startsWith(subphrase)) // Aplicar o filtro de subfrase
        .sort((a, b) => a.id_tipo_resultado_filho - b.id_tipo_resultado_filho || a.phrase.localeCompare(b.phrase));

    return result;
}


const previousTokens2 = ['analisei', 'dados']; // Substitua pelos tokens desejados

// Iniciar medição do tempo
const start2 = performance.now();

queryCachefrases(previousTokens2)
    .then((result) => {
        // Fim da medição do tempo
        const end = performance.now();

        // Exibir o tempo de execução
        console.log(`Tempo de execução: ${(end - start2).toFixed(2)} ms`);

        // Exibir o resultado
        console.log('Resultado da consulta:', JSON.stringify(result, null, 2));
    })
    .catch((error) => {
        // Fim da medição do tempo em caso de erro
        const end = performance.now();

        // Exibir o tempo de execução até o erro
        console.error(`Erro ao executar a consulta: ${error.message}`);
        console.log(`Tempo até o erro: ${(end - start2).toFixed(2)} ms`);
    });


const previousTokens3 = ['analisei', 'dados']; // Substitua pelos tokens desejados


const start3 = performance.now();

queryCacheMapfrases(previousTokens3)
    .then((result) => {
        // Fim da medição do tempo
        const end = performance.now();

        // Exibir o tempo de execução
        console.log(`Tempo de execução: ${(end - start3).toFixed(2)} ms`);

        // Exibir o resultado
        console.log('Resultado da consulta:', JSON.stringify(result, null, 2));
    })
    .catch((error) => {
        // Fim da medição do tempo em caso de erro
        const end = performance.now();

        // Exibir o tempo de execução até o erro
        console.error(`Erro ao executar a consulta: ${error.message}`);
        console.log(`Tempo até o erro: ${(end - start3).toFixed(2)} ms`);
    });

