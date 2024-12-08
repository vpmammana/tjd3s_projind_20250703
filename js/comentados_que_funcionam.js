//queryIndexedDBfrases(['analisei'])
//    .then((result) => {
//        console.log("Result:", JSON.stringify(result, null, 2));
//    })
//    .catch((error) => {
//        console.error("Error:", error);
//    });
//console.log('queryIndexedDBfrases saída');


// **Exemplo de uso**
//queryIndexedDB({
//    query: 'c',
//    tokenIndex: 2,
//    previousTokens: ['analisei'], // Teste com []
//})
//    .then((result) => {
//        console.log('Result:', JSON.stringify(result, null, 2));
//    })
//    .catch((error) => {
//        console.error('Error:', error);
//    });

//async function queryIndexedDB({ query, tokenIndex, previousTokens = [] }) {
//    if (!query || tokenIndex === undefined) {
//        throw new Error('Missing parameters: query and tokenIndex are required');
//    }
//
//    const db = await openDatabaseOnce('papedins_db', 11);
//
//    const transaction = db.transaction(['tokens', 'frases'], 'readonly');
//    const tokensStore = transaction.objectStore('tokens');
//    const frasesStore = transaction.objectStore('frases');
//
//    // Etapa 1: Reconstruir frases relevantes
//    const relevantFrases = await new Promise((resolve, reject) => {
//        const results = new Map(); // Map para agrupar frases por `id_tipo_acao`
//        const request = frasesStore.openCursor();
//
//        request.onsuccess = (event) => {
//            const cursor = event.target.result;
//            if (cursor) {
//                const { id_tipo_acao, id_token, ordem } = cursor.value;
//
//                // Buscar tokens e agrupar por id_tipo_acao
//                const tokenRequest = tokensStore.get(id_token);
//                tokenRequest.onsuccess = () => {
//                    const token = tokenRequest.result;
//                    if (token) {
//                        if (!results.has(id_tipo_acao)) {
//                            results.set(id_tipo_acao, []);
//                        }
//                        results.get(id_tipo_acao).push({ ordem, nome_token: token.nome_token });
//                    }
//                    cursor.continue();
//                };
//                tokenRequest.onerror = () => {
//                    cursor.continue();
//                };
//            } else {
//                resolve(results);
//            }
//        };
//
//        request.onerror = () => reject(request.error);
//    });
//
//    // Etapa 2: Filtrar frases que começam com `previousTokens` ou reconstruir todas se `previousTokens` for vazio
//    const filteredFrases = [];
//    for (const [id_tipo_acao, tokens] of relevantFrases.entries()) {
//        // Ordenar tokens por ordem
//        tokens.sort((a, b) => a.ordem - b.ordem);
//
//        // Montar a frase completa
//        const phrase = tokens.map((t) => t.nome_token).join(' ');
//
//        if (previousTokens.length === 0 || phrase.startsWith(previousTokens.join(' '))) {
//            filteredFrases.push({ id_tipo_acao, phrase });
//        }
//    }
//
//    // Etapa 3: Buscar tokens na posição `tokenIndex`
//    const tokens = new Set();
//    for (const [id_tipo_acao, tokenList] of relevantFrases.entries()) {
//        for (const token of tokenList) {
//            if (token.ordem === tokenIndex) {
//                tokens.add(token.nome_token);
//            }
//        }
//    }
//
//    return { tokens: Array.from(tokens), phrases: filteredFrases };
//}
//
//// **Exemplo de uso**
//queryIndexedDB({
//    query: 'vi',
//    tokenIndex: 1,
//    previousTokens: [], // Teste com [] vazio
//})
//    .then((result) => {
//        console.log('Result:', JSON.stringify(result, null, 2));
//    })
//    .catch((error) => {
//        console.error('Error:', error);
//    });


// quase funciona

//async function queryIndexedDB({ query, tokenIndex, previousTokens = [] }) {
//    if (!query || tokenIndex === undefined) {
//        throw new Error('Missing parameters: query and tokenIndex are required');
//    }
//
//    const db = await openDatabaseOnce('papedins_db', 11);
//
//    const transaction = db.transaction(['tokens', 'frases'], 'readonly');
//    const tokensStore = transaction.objectStore('tokens');
//    const frasesStore = transaction.objectStore('frases');
//
//    // Etapa 1: Reconstruir frases relevantes
//    const relevantFrases = await new Promise((resolve, reject) => {
//        const results = new Map(); // Map para agrupar frases por `id_tipo_acao`
//        const request = frasesStore.openCursor();
//
//        request.onsuccess = (event) => {
//            const cursor = event.target.result;
//            if (cursor) {
//                const { id_tipo_acao, id_token, ordem } = cursor.value;
//
//                // Buscar tokens e agrupar por id_tipo_acao
//                const tokenRequest = tokensStore.get(id_token);
//                tokenRequest.onsuccess = () => {
//                    const token = tokenRequest.result;
//                    if (token) {
//                        if (!results.has(id_tipo_acao)) {
//                            results.set(id_tipo_acao, []);
//                        }
//                        results.get(id_tipo_acao).push({ ordem, nome_token: token.nome_token });
//                    }
//                    cursor.continue();
//                };
//                tokenRequest.onerror = () => {
//                    cursor.continue();
//                };
//            } else {
//                resolve(results);
//            }
//        };
//
//        request.onerror = () => reject(request.error);
//    });
//
//    // Etapa 2: Filtrar frases que começam com `previousTokens` ou reconstruir todas se `previousTokens` for vazio
//    const filteredFrases = [];
//    for (const [id_tipo_acao, tokens] of relevantFrases.entries()) {
//        // Ordenar tokens por ordem
//        tokens.sort((a, b) => a.ordem - b.ordem);
//
//        // Montar a frase completa
//        const phrase = tokens.map((t) => t.nome_token).join(' ');
//
//        if (previousTokens.length === 0 || phrase.startsWith(previousTokens.join(' '))) {
//            filteredFrases.push({ id_tipo_acao, phrase });
//        }
//    }
//
//    // Etapa 3: Buscar tokens na posição `tokenIndex`
//    const tokens = new Set();
//    for (const [id_tipo_acao, tokenList] of relevantFrases.entries()) {
//        for (const token of tokenList) {
//            if (token.ordem === tokenIndex) {
//                tokens.add(token.nome_token);
//            }
//        }
//    }
//
//    return { tokens: Array.from(tokens), phrases: filteredFrases };
//}
//
//// **Exemplo de uso**
//queryIndexedDB({
//    query: 'c',
//    tokenIndex: 2,
//    previousTokens: ['visitei'], // Teste com [] vazio
//})
//    .then((result) => {
//        console.log('Result:', JSON.stringify(result, null, 2));
//    })
//    .catch((error) => {
//        console.error('Error:', error);
//    });


// FUNCIONA sem previousTokens definido, mas não com previousTokens definido

//async function queryIndexedDB({ query, tokenIndex, previousTokens = [] }) {
//    if (!query || tokenIndex === undefined) {
//        throw new Error('Missing parameters: query and tokenIndex are required');
//    }
//
//    const db = await openDatabaseOnce('papedins_db', 11);
//
//    const transaction = db.transaction(['tokens', 'frases'], 'readonly');
//    const tokensStore = transaction.objectStore('tokens');
//    const frasesStore = transaction.objectStore('frases');
//
//    const regexQuery = new RegExp(`(^|\\s)${query}`);
//
//    // Fetch matching tokens based on query and ordem
//    const tokens = await new Promise((resolve, reject) => {
//        const results = [];
//        const request = frasesStore.openCursor();
//
//        request.onsuccess = (event) => {
//            const cursor = event.target.result;
//            if (cursor) {
//                const { id_token, ordem } = cursor.value;
//
//                if (ordem == tokenIndex) {
//                    const tokenRequest = tokensStore.get(id_token);
//                    tokenRequest.onsuccess = () => {
//                        const token = tokenRequest.result;
//                        if (token && regexQuery.test(token.nome_token)) {
//                            results.push(token.nome_token);
//                        }
//                        cursor.continue();
//                    };
//                    tokenRequest.onerror = () => {
//                        cursor.continue();
//                    };
//                } else {
//                    cursor.continue();
//                }
//            } else {
//                resolve([...new Set(results)]); // Remove duplicados
//            }
//        };
//
//        request.onerror = () => reject(request.error);
//    });
//
//    // Fetch matching phrases based on previousTokens
//    let phrases = [];
//    if (previousTokens.length > 0) {
//        const subphrase = previousTokens.join(' ');
//console.log('subphrase:', subphrase);
//        phrases = await new Promise((resolve, reject) => {
//            const results = [];
//            const request = frasesStore.openCursor();
//
//            request.onsuccess = (event) => {
//                const cursor = event.target.result;
//                if (cursor) {
//                    const { id_tipo_acao, ordem, id_token } = cursor.value;
//
//                    if (id_token) {
//                        const tokenRequest = tokensStore.get(id_token);
//                        tokenRequest.onsuccess = () => {
//                            const token = tokenRequest.result;
//
//                            if (token) {
//                                const phrase = token.nome_token;
//                                if (phrase.startsWith(subphrase)) { // Simula LIKE com %
//                                    results.push({
//                                        id_tipo_acao,
//                                        phrase,
//                                    });
//                                }
//                            }
//                            cursor.continue();
//                        };
//                    } else {
//                        cursor.continue();
//                    }
//                } else {
//                    resolve(results);
//                }
//            };
//
//            request.onerror = () => reject(request.error);
//        });
//    }
//
//    return { tokens, phrases };
//}
//
//
//// **Exemplo de uso**
//queryIndexedDB({
//    query: 'c',
//    tokenIndex: 2,
//    previousTokens: ['visitei'],
//})
//    .then((result) => {
//        console.log('Result:', JSON.stringify(result));
//    })
//    .catch((error) => {
//        console.error('Error:', error);
//    });

// FUNCIONA sem previousTokens definido, mas não com previousTokens definido
//async function queryIndexedDB({ query, tokenIndex }) {
//    if (!query || tokenIndex === undefined) {
//        throw new Error('Missing parameters: query and tokenIndex are required');
//    } else { console.log('query:', query, 'tokenIndex:', tokenIndex); }
//
//    const db = await openDatabaseOnce('papedins_db', 11);
//
//    const transaction = db.transaction(['tokens', 'frases'], 'readonly');
//    const tokensStore = transaction.objectStore('tokens');
//    const frasesStore = transaction.objectStore('frases');
//
//    const regexQuery = new RegExp(`(^|\\s)${query}`);
//
//    // Fetch matching tokens based on query and ordem
//    const tokens = await new Promise((resolve, reject) => {
//        const results = [];
//        const request = frasesStore.openCursor();
//        request.onsuccess = (event) => {
//            const cursor = event.target.result;
//            if (cursor) {
//                const { id_token, ordem } = cursor.value;
//	        
//                if (ordem == tokenIndex) {
//		console.log('tokenIndex:', tokenIndex, 'ordem:', ordem, 'id_token:', id_token, 'id_chave_frase:', cursor.value.id_chave_frase);
//                    const tokenRequest = tokensStore.get(id_token);
//                    tokenRequest.onsuccess = () => {
//                        const token = tokenRequest.result;
//			console.log('token:', token);
//                        if (token && regexQuery.test(token.nome_token)) {
//                            results.push(token.nome_token);
//                        }
//                        cursor.continue();
//                    };
//                    tokenRequest.onerror = () => {
//                        cursor.continue();
//                    };
//                } else {
//                    cursor.continue();
//                }
//            } else {
//                resolve([...new Set(results)]); // Remove duplicados
//            }
//        };
//
//        request.onerror = () => reject(request.error);
//    });
//
//    return { tokens };
//}
//
//// Usage Example
//queryIndexedDB({ query: 'vi', tokenIndex: 1 })
//    .then((result) => {
//        console.log('Result:', JSON.stringify(result));
//    })
//    .catch((error) => {
//        console.error('Error:', error);
//    });


//    // Iniciar o carregamento do Cache durante o download do script
//    preloadIndexedDBData().then(() => {
//        console.log("Dados do IndexedDB carregados com sucesso.");
//    }).catch((error) => {
//        console.error("Erro ao carregar dados do IndexedDB:", error);
//    });

//    // Função para carregar todos os dados
//    async function preloadIndexedDBData() {
//        const db = await openDatabaseOnce('papedins_db', 11);
//        const stores = ['tokens', 'frases', 'tipos_resultados', 'tipos_acoes'];
//
//        for (const storeName of stores) {
//            const transaction = db.transaction([storeName], 'readonly');
//            const objectStore = transaction.objectStore(storeName);
//
//            cache[storeName] = await new Promise((resolve, reject) => {
//                const items = [];
//                const request = objectStore.openCursor();
//
//                request.onsuccess = (event) => {
//                    const cursor = event.target.result;
//                    if (cursor) {
//                        items.push(cursor.value);
//                        cursor.continue();
//                    } else {
//                        resolve(items);
//                    }
//                };
//
//                request.onerror = () => reject(request.error);
//            });
//        }
//        console.log("IndexedDB carregado:", cache);
//    }
//

