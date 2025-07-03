let imagesArray = [];
let suggestionSelected = "";
let selectedPhraseId = 0;
let chipCount = 0;
//-----------cODIGO DE FRASES -----------------------------------------------------------------------------
// o presente código foi desenvolvido por Victor Mammana, com auxílio de chatbots 
const container = document.getElementById('container');
const dropdown = document.getElementById('dropdown');
const maximo_frases = 16;
let frases_montadas;
let tokenIndex = 1;
let previousTokens = [];
velhoDeleteBtn = 'delete_nulo';
var perguntas = []; // Variável global
let resultsActioned = false;

function dataHoraAtualFormatada() {
    const agora = new Date();
    const pad = n => String(n).padStart(2, '0');

    return agora.getFullYear() + '-' +
           pad(agora.getMonth() + 1) + '-' +
           pad(agora.getDate()) + 'T' +
           pad(agora.getHours()) + ':' +
           pad(agora.getMinutes());
}

const btn = document.getElementById('confirmar-data');
btn.addEventListener('mousedown', () => {
  btn.style.transform = 'translateY(1px)';
  btn.style.boxShadow = '0 1px 2px rgba(0,0,0,0.2), inset 0 0 0 rgba(0,0,0,0)';
});
btn.addEventListener('mouseup', () => {
  btn.style.transform = 'translateY(0)';
  btn.style.boxShadow = '0 2px 4px rgba(0,0,0,0.2), inset 0 -2px 0 rgba(0,0,0,0.1)';
});

const inputs = document.querySelectorAll('input');

function handleFormOrder(input) {
    const currentValue = input.value.trim();
    const nextId = input.dataset.next; // Get the ID of the next field
    if (currentValue !== "" && nextId) {
	    //alert('Frase selecionada: ' + currentValue);
        const nextInput = document.getElementById(nextId);
        if (nextInput) {
	    console.log(nextInput);
	    if (nextInput.id == 'data') {
		    if (nextInput) {
		        nextInput.value = dataHoraAtualFormatada();
			document.getElementById('confirmar-data').disabled = false;
    		    }
	    }
            nextInput.disabled = false; // Enable the next field
        }
    }
}

botao_confirmar = document.getElementById('confirmar-data');

botao_confirmar.addEventListener('click', (e) => {

	const current = e.currentTarget; // pega o botão clicado
        const nextInput = document.getElementById(current.dataset.next);
        if (nextInput) {
		
            console.log(nextInput);
            if (nextInput.id == 'edit_box_pergunta') {

                        current.style.display = 'none';
            }
            nextInput.disabled = false; // Enable the next field
        }

});


inputs.forEach(input => {
    input.addEventListener('input', (e) => {
        if (input.value.length > 5) {
            e.preventDefault(); // Prevent form submission
            handleFormOrder(input)
        }
    });
    input.addEventListener('keypress', (e) => {
        if (e.key === "Enter") {
            e.preventDefault(); // Prevent form submission
            handleFormOrder(input)
        }
    });
    input.addEventListener('blur', (e) => {
        e.preventDefault(); // Prevent form submission
        handleFormOrder(input)
    });
});

// Pegar nome do usario do Hash e salvar no localstorage na carrega de pagina
window.addEventListener('load', function () {
    
    let nomeUsuario = "";
    if (!localStorage.getItem('nome_usuario')) {
        nomeUsuario = getNomeUsusario('nome_usuario');
    } else {
        nomeUsuario = localStorage.getItem('nome_usuario');
    }
    document.getElementById('nome-usuario').innerText = `${nomeUsuario},`;
    localStorage.setItem('nome_usuario', nomeUsuario);
})


async function handleMutation(mutation) {
    if (mutation.type === "childList") {
        try {
            // Fetch sugestões de uma API ou outra fonte
            const frases = await fetchFrases();
            if (frases.length > maximo_frases) {
                selectedPhraseId = 0;
                document.getElementById('frases').innerHTML = "<div class='chip_tipo_resultado muitas-frases'>Muitas frases retornadas. Responda mais perguntas para refinar a busca.</div>";
                if (frases.length > 0) {
                    document.getElementById('frases').style.display = 'flex';
                }
                resultsActioned = true;
            } else {
                resultsActioned = true;

                // Atualizar o HTML com as frases obtidas
                let velho_id_tipo_resultado = "";
                if (frases.length == 1 && document.getElementById('inputWrapper')) {
                    document.getElementById('inputWrapper').remove();
                }
                if (frases.length > 0) {
                    document.getElementById('frases').style.display = 'flex';
                }
                let str_tipo_resultado = ""; // Declare no escopo da função do map
                let phrasesHTML = frases.map(frase => {
                    if (velho_id_tipo_resultado != frase.id_tipo_resultado_pai) {
                        str_tipo_resultado = "<div id='chip-resultado-label'><span>A sua atividade foi classificada como:</span></div><div id='tipo_resultado_" + frase.id_tipo_resultado_pai + "' class='chip_tipo_resultado tipo_classificacao' data-id_acao='" + frase.id_tipo_acao + "'>" + frase.nome_tipo_resultado_pai + "</div>";
                    }
                    velho_id_tipo_resultado = frase.id_tipo_resultado_pai;
                    return "<div class='chip_frase' data-id_acao='" + frase.id_tipo_acao + "' onclick='this.children[0].click();'><input id='radio_" + frase.id_tipo_acao + "' type='radio' name='frases' onclick='handleSelectedPhrase(" + frase.id_tipo_acao + ");'/><span>" + frase.phrase + "</span></div>";
                }).join("");
                document.getElementById('frases').innerHTML = phrasesHTML + str_tipo_resultado;
            }
        } catch (error) {
            console.error("Erro ao buscar frases:", error);
        }
    }
}

function handleSelectedPhrase(id) {
    selectedPhraseId = id
    const atividadeRealizada = document.getElementById('atividade-realizada');
    atividadeRealizada.disabled = false;
    atividadeRealizada.addEventListener('keypress', (e) => {
        if (e.key === "Enter") {
            e.preventDefault(); // Prevent form submission
            handleFormOrder(atividadeRealizada)
        }
    });

    atividadeRealizada.addEventListener('blur', (e) => {
        e.preventDefault(); // Prevent form submission
        handleFormOrder(atividadeRealizada)
    });

}

// Seleciona o elemento onde deseja monitorar mudanças
const targetElement = document.getElementById("container");

// Configura o observer para detectar adição de filhos
const observer = new MutationObserver((mutationsList, observer) => {
    for (let mutation of mutationsList) {
        handleMutation(mutation); // Chamar a função assíncrona separadamente
    }
});

// Configurações para o observer
const config = {
    childList: true
};

// Inicia a observação
observer.observe(targetElement, config);

// Para encerrar a observação (se necessário):
// observer.disconnect();

document.addEventListener('click', (event) => {
    if (event.target.classList.contains('interno')) {
        return;
    }

    const excludedElement = document.getElementById('dropdown');

    if (!excludedElement.contains(event.target)) {
        // Executa a ação se o clique NÃO for no elemento excluído ou dentro dele
        excludedElement.innerHTML = '';
        excludedElement.style.display = 'none';
    }

});

function showErrorMessage(message) {
    // Verifica se já existe uma mensagem de erro exibida
    let errorContainer = document.getElementById('error-message');
    if (!errorContainer) {
        // Cria um novo elemento para exibir a mensagem de erro
        errorContainer = document.createElement('div');
        errorContainer.id = 'error-message';
        errorContainer.style.position = 'absolute';
        errorContainer.style.top = '10px';
        errorContainer.style.left = '50%';
        errorContainer.style.transform = 'translateX(-50%)';
        errorContainer.style.backgroundColor = '#f8d7da';
        errorContainer.style.color = '#721c24';
        errorContainer.style.padding = '10px';
        errorContainer.style.border = '1px solid #f5c6cb';
        errorContainer.style.borderRadius = '5px';
        errorContainer.style.fontSize = '14px';
        errorContainer.style.zIndex = '1000';
        document.body.appendChild(errorContainer);
    }

    // Atualiza o texto da mensagem de erro
    errorContainer.textContent = message;

    // Remove a mensagem automaticamente após 5 segundos
    setTimeout(() => {
        if (errorContainer) {
            errorContainer.remove();
        }
    }, 5000);
}

function showLoadingIndicator(inputWrapper) {
    // Cria o elemento de carregamento (rodinha)
    const loadingSpinner = document.createElement('div');
    loadingSpinner.id = 'loading-spinner';
    loadingSpinner.classList.add('loading-spinner'); // Use a classe CSS
    loadingSpinner.textContent = '⏳'; // Aqui você pode usar um ícone ou animação CSS
    loadingSpinner.style.marginLeft = '10px'; // Ajuste o estilo como preferir
    inputWrapper.appendChild(loadingSpinner);
}

function hideLoadingIndicator() {
    const loadingSpinner = document.getElementById('loading-spinner');
    if (loadingSpinner) {
        loadingSpinner.remove();
    }
}

async function retorna_perguntas() {
    try {
        const response = await fetch('busca_perguntas.php');

        if (!response.ok) {
            throw new Error('Erro ao buscar perguntas: ' + response.statusText);
        }

        const data = await response.json();

        // Retornar um array de objetos contendo 'nome_pergunta', 'placeholder', 'help'
        return data.map(row => ({
            nome_pergunta: row.nome_pergunta,
            placeholder: row.placeholder,
            help: row.help
        }));
    } catch (error) {
        console.error('Erro:', error);
        return [];
    }
}


function fetchFrases(query) {
    const url = `./php/fetch_frases.php?query=${query}&tokenIndex=${tokenIndex}&previousTokens=${JSON.stringify(previousTokens)}`;

    if (!navigator.onLine) {
        console.warn("Sem conexão com a internet. Usando IndexedDB.");
        return fetchPhrasesFromIndexedDB()
            .then((result) => {
                let filteredData = [];

                if (previousTokens.length > 0) {
                    filteredData = result.filter((data) => data.phrase.startsWith(previousTokens.join(' ')));
                }
                return filteredData;
            })
            .catch((error) => {
                console.error('Erro ao consultar IndexedDB (frases):', error);
                throw error;
            });
    }

    // Se online, faz o fetch normalmente
    return fetch(url)
        .then((res) => {
            if (!res.ok) {
                throw new Error(`Erro na resposta de frases do servidor: ${res.status}`);
            }
            return res.json();
        })
        .catch((error) => {
            console.error('Erro no fetch:', error);
            throw error;
        });
}

function fetchTokensFromIndexedDB() {
    return new Promise((resolve, reject) => {
        openDatabase('TokensDB', 1, upgradeTokensDB)
            .then((db) => {
                const transaction = db.transaction(['tokens'], 'readonly');
                const objectStore = transaction.objectStore('tokens');
                const request = objectStore.getAll();

                request.onsuccess = (event) => {
                    resolve(event.target.result); // Resolve with the fetched data
                };

                request.onerror = () => {
                    reject('Error fetching data from IndexedDB');
                };
            })
            .catch((error) => reject(error));
    });
}

function fetchPhrasesFromIndexedDB() {
    return new Promise((resolve, reject) => {
        openDatabase('PhrasesDB', 1, upgradeTokensDB)
            .then((db) => {
                const transaction = db.transaction(['phrases'], 'readonly');
                const objectStore = transaction.objectStore('phrases');
                const request = objectStore.getAll();

                request.onsuccess = (event) => {
                    resolve(event.target.result); // Resolve with the fetched data
                };

                request.onerror = () => {
                    reject('Error fetching data from IndexedDB');
                };
            })
            .catch((error) => reject(error));
    });
}




function fetchSuggestions(query) {
    const url = `./php/fetch_tokens_chip.php?query=${query}&tokenIndex=${tokenIndex}&previousTokens=${JSON.stringify(previousTokens)}`;
    if (!navigator.onLine) {
        return fetchTokensFromIndexedDB()
            .then((tokensDbData) => {
                //-------------------------------------------------------------
                const frases = tokensDbData[0].tokens.frases
                const tokens = tokensDbData[0].tokens.tokens
                // Step 1: Construct 'phrase' for each id_tipo_acao
                const phrases = frases.reduce((acc, frase) => {
                    const token = tokens.find(t => t.id_chave_token === frase.id_token);
                    if (token) {
                        const key = frase.id_tipo_acao;
                        acc[key] = acc[key] || [];
                        acc[key].push({ ordem: frase.ordem, nome_token: token.nome_token });
                    }
                    return acc;
                }, {});

                // Format phrases and filter by the LIKE condition
                const searchPattern = previousTokens.length === 0 ? "" : previousTokens.join(" "); // Example LIKE pattern
                const matchingTipoAcao = Object.entries(phrases)
                    .filter(([_, tokens]) => {
                        const phrase = tokens
                            .sort((a, b) => a.ordem - b.ordem)
                            .map(t => t.nome_token)
                            .join(' ');
                        return phrase.startsWith(searchPattern.replace('%', '')); // Simulate LIKE
                    })
                    .map(([id_tipo_acao]) => parseInt(id_tipo_acao));

                // Step 2: Filter frases and join with tokens
                const ordem = tokenIndex; // Example "ordem"
                const result = frases
                    .filter(f => f.ordem === ordem && matchingTipoAcao.includes(f.id_tipo_acao))
                    .map(f => {
                        const token = tokens.find(t => t.id_chave_token === f.id_token);
                        return token ? token.nome_token : null;
                    })
                    .filter(nome_token => nome_token);
                const resultList = [...new Set(result)];
                const resultListFiltered = resultList.filter((x) => x.startsWith(query))

                return { tokens: resultListFiltered };
            })
            .catch((error) => {
                console.error(error);
            });
    }

    // Se online, faz o fetch normalmente
    return fetch(url)
        .then((res) => {
            if (!res.ok) {
                throw new Error(`Erro na resposta de tokens do servidor: ${res.status}`);
            }
            return res.json();
        }).then(data => {
            return data
        })
        .catch((error) => {
            console.error('Erro no fetch:', error);
            throw error;
        });
}

function createChip(token) {
    const chip = document.createElement('div');
    chip.className = 'chip';
    document.querySelectorAll('.delete').forEach(el => el.style.display = 'none');
    const deleteBtn = document.createElement('div');
    deleteBtn.id = 'delete_' + tokenIndex;
    velhoDeleteBtn = 'delete_' + (tokenIndex - 1); // sem parenteses dah NaN
    if (velhoDeleteBtn == 'delete_0') {
        velhoDeleteBtn = 'delete_nulo';
    }
    deleteBtn.setAttribute('data-anterior', velhoDeleteBtn);
    chip.setAttribute('data-companion', deleteBtn.id);
    deleteBtn.className = 'delete';
    deleteBtn.innerHTML = 'X';
    deleteBtn.onclick = () => {
        if (deleteBtn.getAttribute("data-anterior") != "delete_nulo") {
            document.getElementById(deleteBtn.getAttribute('data-anterior')).style.display = 'flex';
        }
        chip.remove();
        previousTokens.pop();
        tokenIndex--;
        selectedPhraseId = "";
        chipCount--;
        updateInputPosition();
    };

    chip.innerHTML = "<div class='token'>" + token + "</div>";
    chip.appendChild(deleteBtn);
    container.appendChild(chip);
    chipCount++;
}

function handleQuestion(chipCount) {
    const inputWrapper = document.getElementById('pergunta')

    if (chipCount === 1) {
        inputWrapper.innerHTML = "<div id='pergunta' class='interno'>Test 1</div>"
    }

}

function updateInputPosition() {
    let pergunta;
    let placeholder;
    if (tokenIndex == 1) {
        velhoDeleteBtn = 'delete_nulo';
    }
    if (document.getElementById("inputWrapper")) {
        document.getElementById("inputWrapper").remove();
    }
    const inputWrapper = document.createElement('div');
    inputWrapper.className = 'input-wrapper';
    inputWrapper.id = 'inputWrapper';

    if (perguntas.length > 0 && tokenIndex <= perguntas.length) {
        pergunta = perguntas[tokenIndex - 1].nome_pergunta;
        placeholder = perguntas[tokenIndex - 1].placeholder;
    } else {
        pergunta = 'Frase que melhor descreve essa ação';
        placeholder = '[Lista frases relacionadas]';
    }


    const input = document.createElement('input');
    input.id = 'edit_box_pergunta';
    input.type = 'text';
    input.className = 'interno';
    input.placeholder = placeholder;
    input.disabled = resultsActioned ? false : true;
    input.dataNext = "atividade-realizada"



    let handleInput = async () => {
        try {
            showLoadingIndicator(inputWrapper); // Mostra o indicador de carregamento
            const suggestions_full = await fetchSuggestions(input.value.toLowerCase());

            const suggestions = suggestions_full.tokens;
            const frases = suggestions_full.phrases;
            if (suggestions.length === 0) {
                input.value = input.value.slice(0, -1).toLowerCase(); // Atualiza o valor do input se necessário
            } else {
                showDropdown(suggestions, input, inputWrapper);
            }
        } catch (error) {
            console.error('Erro ao buscar sugestões:', error);
            showErrorMessage('Erro de conexão. Por favor, verifique sua rede.');
        } finally {
            hideLoadingIndicator(); // Sempre esconde o indicador, mesmo que haja erro
        }
    };


    input.oninput = async (event) => {
	input.value = input.value.toLowerCase();
        handleInput(event);
    };
    input.onclick = async (event) => {
	input.value = input.value.toLowerCase();
        handleInput(event);
    };

    if (chipCount === 1) {
        inputWrapper.innerHTML = "<div id='pergunta' class='interno'>Sobre quem ou o que você agiu</div>"
    } else if (chipCount === 2) {
        inputWrapper.innerHTML = "<div id='pergunta' class='interno'>Que caracteristicas você percebe no objeto da sua ação</div>"
    } else if (chipCount === 3) {
        inputWrapper.innerHTML = "<div id='pergunta' class='interno'>Indique um destino ou finalidade da sua ação</div>"
    }
    else if (chipCount === 4) {
        inputWrapper.innerHTML = "<div id='pergunta' class='interno'>Indique as caracteristicas desse destino ou finalidade</div>"
    }
    else {
        pergunta = 'Qual foi a sua ação';
        placeholder = 'Digite Aqui...';
        inputWrapper.innerHTML = "<div id='pergunta' class='interno'>" + pergunta + "</div>"
    }

    inputWrapper.appendChild(input);
    container.appendChild(inputWrapper);
    input.focus();
}

function showDropdown(suggestions, input, inputWrapper) {
    document.getElementById('frases').style.opacity = "0.5";
    dropdown.innerHTML = '';
    suggestions.forEach(token => {
        const item = document.createElement('div');
        item.textContent = token;
        item.onclick = () => {
            previousTokens.push(token);
            createChip(token);
            dropdown.style.display = 'none';
            inputWrapper.remove();
            tokenIndex++;
            document.getElementById('frases').style.opacity = "1.0";
            if (tokenIndex <= 5) {
                updateInputPosition();
            }
        };
        dropdown.appendChild(item);
    });

    const rect = inputWrapper.getBoundingClientRect();
    dropdown.style.top = `${rect.bottom + window.scrollY}px`;
    dropdown.style.left = `${rect.left}px`;
    dropdown.style.display = 'block';
}

updateInputPosition();

async function carregarPerguntas() {
    try {
        // Tentar buscar perguntas pela internet
        perguntas = await retorna_perguntas(); // Aguardar a resolução da Promise da função retorna_perguntas
        document.getElementById('pergunta').innerHTML = perguntas[0].nome_pergunta;
        document.getElementById('edit_box_pergunta').placeholder = perguntas[0].placeholder;
    } catch (error) {
        console.warn('Falha ao buscar perguntas pela internet, tentando carregar do IndexedDB...', error);

        // Tentar carregar perguntas do IndexedDB
        try {
            const db = await openIndexedDB(); // Abre a conexão com o IndexedDB
            const transaction = db.transaction('perguntas', 'readonly');
            const store = transaction.objectStore('perguntas');

            // Obter todas as perguntas do IndexedDB
            const perguntasIndexedDB = await new Promise((resolve, reject) => {
                const request = store.getAll();
                request.onsuccess = () => {
                    if (request.result.length > 0) {
                        resolve(request.result);
                    } else {
                        reject(new Error('Elemento "perguntas" não encontrado no IndexedDB.'));
                    }
                };
                request.onerror = () => reject(new Error('Erro ao acessar o IndexedDB.'));
            });

            perguntas = perguntasIndexedDB;
            document.getElementById('pergunta').innerHTML = perguntas[0].nome_pergunta;
            document.getElementById('edit_box_pergunta').placeholder = perguntas[0].placeholder;
        } catch (indexedDBError) {
            console.error('Erro ao carregar perguntas do IndexedDB:', indexedDBError);
        }
    }
}
//--------------------------------Main JS----------------------------------------------------------------------
function showLoading() {
    document.getElementById("loading").style.display = "block";
}

// Esconde o div loading
function hideLoading() {
    document.getElementById("loading").style.display = "none";
}

// Pegar o nome do usuaurio do Hash
function getNomeUsusario(param) {
    const urlParams = new URLSearchParams(window.location.search);
    return urlParams.get(param) ? urlParams.get(param).replaceAll('_', ' ') : "";
}

// // Pegar nome do usario do Hash e salvar no localstorage na carrega de pagina
// window.addEventListener('load', function () {
//     let nomeUsuario = "";
//     if (localStorage.getItem('nome_usuario')) {
//         nomeUsuario = localStorage.setItem('nome_usuario', nomeUsuario);
//         document.getElementById('nome-usuario').innerText = `${nomeUsuario},`;
//     }
// })

// Configurar a mapa na carrega da pagina
window.addEventListener('load', function () {
    navigator.geolocation.getCurrentPosition(showPosition2, showError, {
        enableHighAccuracy: true,
        timeout: 10000,
        maximumAge: 60000
    });

    function showPosition2(position) {
        var lat = position.coords.latitude;
        var lon = position.coords.longitude;
        localStorage.setItem('latitude', lat);
        localStorage.setItem('longitude', lon);
    }

    function showError(error) {
        console.error('Error in geolocation');
    }
});

//Config de Service worker
//if ('serviceWorker' in navigator) {
//    const protocol = window.location.protocol;
//    const host = window.location.host;
//    const swUrl = `${protocol}//${host}/sw.js`;
//
//    navigator.serviceWorker.register(swUrl, {
//        scope: './'
//    })
//        .then(function (registration) {
//            console.log('Service Worker registered with scope:', registration.scope);
//        })
//        .catch(function (error) {
//            console.log('Service Worker registration failed:', error);
//        });
//}

if ('serviceWorker' in navigator) {
    const swUrl = './sw.js'; // relativo à URL atual (funciona dentro do app)
    
    navigator.serviceWorker.register(swUrl, {
        scope: './' // restringe ao app atual
    })
        .then(function (registration) {
            console.log('Service Worker registered with scope:', registration.scope);
        })
        .catch(function (error) {
            console.error('Service Worker registration failed:', error);
        });
}

// Verificar se aparelho é Mobile
function isMobileDevice() {
    return /Mobi|Android/i.test(navigator.userAgent);
}

// Ligar Camera
function openCamera() {
    if (isMobileDevice()) {
        document.getElementById("cameraInput2").click()
    } else {
        const video = document.getElementById('cameraStream');
        const constraints = {
            video: {
                facingMode: 'environment'
            }
        };

        navigator.mediaDevices.getUserMedia(constraints)
            .then((stream) => {
                video.srcObject = stream;
                video.style.display = 'block';
                video.addEventListener('click', captureImage);
            })
            .catch((err) => {
                console.error('Error accessing camera: ', err);
            });
    }


}
/**
 * Comprime imagens grandes (2MB+) para um tamanho máximo (ex.: 500KB)
 * @param {File} file - Arquivo original
 * @param {number} [maxSizeBytes=500000] - Tamanho máximo em bytes (opcional)
 * @returns {Promise<File>} - Imagem comprimida como File (não Blob)
 */

async function compressImage(file) {
  const MAX_SIZE_BYTES = 500 * 1024; // 500KB
  const MAX_WIDTH = 1600;            // Aumentei para preservar detalhes
  const MAX_HEIGHT = 1600;           // Aumentei para preservar detalhes
  const MIN_QUALITY = 0.6;           // Limite mínimo de qualidade

  // Carrega a imagem
  const img = await new Promise((resolve) => {
    const img = new Image();
    img.onload = () => resolve(img);
    img.src = URL.createObjectURL(file);
  });

  // Calcula o ratio (sem ampliar)
  const ratio = Math.min(
    1,
    MAX_WIDTH / img.width,
    MAX_HEIGHT / img.height
  );

  // Redimensiona apenas se necessário
  const canvas = document.createElement('canvas');
  const ctx = canvas.getContext('2d');
  
  // Se a imagem já é pequena, usa o tamanho original
  if (ratio >= 1) {
    canvas.width = img.width;
    canvas.height = img.height;
  } else {
    canvas.width = Math.floor(img.width * ratio);
    canvas.height = Math.floor(img.height * ratio);
  }
  
  ctx.drawImage(img, 0, 0, canvas.width, canvas.height);

  // Otimização inteligente:
  // 1. Primeiro tenta com qualidade mais alta
  // 2. Só reduz dimensões se realmente necessário
  let quality = 0.85; // Começa com qualidade alta
  
  // Primeira tentativa com qualidade alta
  let blob = await new Promise(resolve =>
    canvas.toBlob(resolve, 'image/jpeg', quality)
  );

  // Se ainda grande, reduz qualidade gradualmente (até 60%)
  while (blob.size > MAX_SIZE_BYTES && quality > MIN_QUALITY) {
    quality -= 0.05;
    blob = await new Promise(resolve =>
      canvas.toBlob(resolve, 'image/jpeg', quality)
    );
  }

  // Se ainda grande após reduzir qualidade, tenta redimensionar um pouco mais
  if (blob.size > MAX_SIZE_BYTES && ratio > 0.5) {
    const newRatio = ratio * 0.9; // Reduz apenas 10% do ratio original
    canvas.width = Math.floor(img.width * newRatio);
    canvas.height = Math.floor(img.height * newRatio);
    ctx.drawImage(img, 0, 0, canvas.width, canvas.height);
    
    blob = await new Promise(resolve =>
      canvas.toBlob(resolve, 'image/jpeg', 0.7) // Qualidade média
    );
  }

  // Fallback para WebP (se suportado)
  if (blob.size > MAX_SIZE_BYTES && await supportsWebP()) {
    blob = await new Promise(resolve =>
      canvas.toBlob(resolve, 'image/webp', 0.75) // Qualidade um pouco maior
    );
  }
//  alert('Tamanho final:'+ (blob.size / 1024).toFixed(1)+ 'KB'+
//              'Dimensões:'+ canvas.width+ 'x'+ canvas.height+
//              'Qualidade:'+ quality + ' filename: '+file.name);

  console.log('Tamanho final:', (blob.size / 1024).toFixed(1), 'KB',
              'Dimensões:', canvas.width, 'x', canvas.height,
              'Qualidade:', quality);

  return new File([blob], file.name, {
    type: blob.type,
    lastModified: Date.now()
  });
}

//async function compressImage(file) {
//  const MAX_SIZE_BYTES = 500 * 1024; // 500KB
//  const MAX_WIDTH = 1000;             // Largura máxima desejada
//  const MAX_HEIGHT = 1000;            // Altura máxima desejada
//
//  // Carrega a imagem
//  const img = await new Promise((resolve) => {
//    const img = new Image();
//    img.onload = () => resolve(img);
//    img.src = URL.createObjectURL(file);
//  });
//
//  // Calcula o ratio SEMPRE <= 1 (evita aumento)
//  const ratio = Math.min(
//    1,                              // ← Garante que a imagem não será ampliada
//    MAX_WIDTH / img.width,
//    MAX_HEIGHT / img.height
//  );
//
//  // Redimensiona
//  const canvas = document.createElement('canvas');
//  const ctx = canvas.getContext('2d');
//  canvas.width = Math.floor(img.width * ratio);
//  canvas.height = Math.floor(img.height * ratio);
//  ctx.drawImage(img, 0, 0, canvas.width, canvas.height);
//
//  // Comprime (JPEG 70% → 50% se necessário)
//  let quality = 0.7;
//  let blob = await new Promise(resolve =>
//    canvas.toBlob(resolve, 'image/jpeg', quality)
//  );
//
//  // Reduz qualidade progressivamente (se ainda estiver grande)
//  while (blob.size > MAX_SIZE_BYTES && quality > 0.5) {
//    quality -= 0.05;
//    blob = await new Promise(resolve =>
//      canvas.toBlob(resolve, 'image/jpeg', quality)
//    );
//  }
//
//  // Fallback para WebP (se suportado e JPEG ainda grande)
//  if (blob.size > MAX_SIZE_BYTES && await supportsWebP()) {
//    blob = await new Promise(resolve =>
//      canvas.toBlob(resolve, 'image/webp', 0.7)
//    );
//  }
//
//  return new File([blob], file.name, {
//    type: blob.type,
//    lastModified: Date.now()
//  });
//}

//async function compressImage(file, maxSizeBytes = 500000) {
//  // Converte File para Blob (para processamento)
//  const blob = await new Promise(resolve => {
//    const reader = new FileReader();
//    reader.onload = () => resolve(new Blob([reader.result], { type: file.type }));
//    reader.readAsArrayBuffer(file);
//  });
//
//  // Redimensiona e comprime (usando as funções auxiliares abaixo)
//  const compressedBlob = await compressImageToSize(blob, maxSizeBytes, 1000, 1000);
//  
//  // Converte Blob de volta para File (mantendo o nome original)
//  return new File([compressedBlob], file.name, {
//    type: compressedBlob.type,
//    lastModified: Date.now()
//  });
//}

async function compressImageToSize(blob, maxSizeBytes, maxWidth, maxHeight) {
  const img = await loadImage(blob);
  const canvas = document.createElement('canvas');
  const ctx = canvas.getContext('2d');

  // Reduz dimensões
  const { width, height } = calculateNewSize(img.width, img.height, maxWidth, maxHeight);
  canvas.width = width;
  canvas.height = height;
  ctx.drawImage(img, 0, 0, width, height);

  // Tenta JPEG (75% → 50%)
  let compressedBlob = await tryCompress(canvas, 'image/jpeg', maxSizeBytes, 0.75);

  // Fallback para WebP
  if (compressedBlob.size > maxSizeBytes && await supportsWebP()) {
    compressedBlob = await tryCompress(canvas, 'image/webp', maxSizeBytes, 0.75);
  }

  return compressedBlob;
}

function loadImage(blob) {
  return new Promise((resolve) => {
    const img = new Image();
    img.onload = () => resolve(img);
    img.src = URL.createObjectURL(blob);
  });
}

function calculateNewSize(originalWidth, originalHeight, maxWidth, maxHeight) {
  const ratio = Math.min(maxWidth / originalWidth, maxHeight / originalHeight);
  return {
    width: Math.floor(originalWidth * ratio),
    height: Math.floor(originalHeight * ratio)
  };
}

async function tryCompress(canvas, mimeType, maxSizeBytes, initialQuality = 0.75, maxAttempts = 3) {
  let quality = initialQuality;
  let blob = await canvasToBlob(canvas, mimeType, quality);

  for (let i = 0; i < maxAttempts && blob.size > maxSizeBytes && quality >= 0.5; i++) {
    quality -= 0.1;
    blob = await canvasToBlob(canvas, mimeType, quality);
	      console.log(`Tentativa ${i + 1}: qualidade ${quality.toFixed(2)}, tamanho: ${(blob.size / 1024).toFixed(1)} KB`);
  }

  return blob;
}

function canvasToBlob(canvas, mimeType, quality) {
  return new Promise((resolve) => {
    canvas.toBlob(resolve, mimeType, quality);
  });
}

function supportsWebP() {
  return new Promise((resolve) => {
    const img = new Image();
    img.onload = () => resolve(true);
    img.onerror = () => resolve(false);
    img.src = 'data:image/webp;base64,UklGRh4AAABXRUJQVlA4TBEAAAAvAAAAAAfQ//73v/+BiOh/AAA=';
  });
}

function captureImage() {
    const video = document.getElementById('cameraStream');
    const canvas = document.getElementById('cameraCanvas');
    const context = canvas.getContext('2d');

    // Para a câmera e esconde o vídeo
    video.srcObject.getTracks().forEach(track => track.stop());
    video.style.display = 'none';

    // Detecta orientação (mobile)
//    const isPortrait = window.matchMedia('(orientation: portrait)').matches;

    // Ajusta dimensões do canvas (inverte se portrait)
//    canvas.width = isPortrait ? video.videoHeight : video.videoWidth;
//    canvas.height = isPortrait ? video.videoWidth : video.videoHeight;

    // Rotaciona e desenha a imagem
    context.clearRect(0, 0, canvas.width, canvas.height);
 //   if (isPortrait) {
 //       context.translate(canvas.width / 2, canvas.height / 2);
 //       context.rotate(Math.PI / 2);
 //       context.drawImage(video, -video.videoWidth / 2, -video.videoHeight / 2, video.videoWidth, video.videoHeight);
 //   } else {
 //       context.drawImage(video, 0, 0, canvas.width, canvas.height);
 //   }

    // Converte canvas para File (PNG) e comprime
    canvas.toBlob(async (blob) => {
        const file = new File([blob], 'captured-image.png', { type: 'image/png' });

        try {
            const compressedFile = await compressImage(file);
            imagesArray = [compressedFile];
            displayImagePreview(compressedFile);
        } catch (error) {
		alert('paradinha erro ao comprimir imagem')
            console.error("Erro ao comprimir imagem:", error);
            // Fallback: usa a imagem original
            imagesArray = [file];
            displayImagePreview(file);
        }
    }, 'image/png');
}


//// Captura imagem de camera
//function captureImage() {
//    const video = document.getElementById('cameraStream');
//    const canvas = document.getElementById('cameraCanvas');
//    const context = canvas.getContext('2d');
//
//    canvas.width = video.videoWidth;
//    canvas.height = video.videoHeight;
//    context.drawImage(video, 0, 0, canvas.width, canvas.height);
//
//    video.srcObject.getTracks().forEach(track => track.stop());
//    video.style.display = 'none';
//
//    const dataURL = canvas.toDataURL('image/png');
//
//    // Convert dataURL to a File object
//    fetch(dataURL)
//        .then(res => res.blob())
//        .then(blob => {
//            const file = new File([blob], 'captured-image.png', {
//                type: 'image/png'
//            });
//		//alert(`Imagem capturada tem ${file.size} bytes (${(file.size/1024).toFixed(1)} KB)`);
//            imagesArray = [file]; // Replace previous image with the new one
//            displayImagePreview(file);
//        });
//}

async function addImageToArray(event) {
    const files = event.target.files;
    if (files.length > 0) {
        const file = files[0];
        if (!file.type.includes("image/")) {
            alert("O arquivo não é uma imagem");
            return;
        } else {
            // Comprime a imagem antes de exibir/adicionar ao array
            try {
                const compressedFile = await compressImage(file);
                imagesArray = [compressedFile];
                displayImagePreview(compressedFile);
            } catch (error) {
                console.error("Erro ao comprimir imagem:", error);
                // Fallback: usa a imagem original
                imagesArray = [file];
                displayImagePreview(file);
            }

            // Limpa o input
            event.target.value = '';
        }
    }
}


// Pegar imagem e verificar se o arquivo é imagem
//function addImageToArray(event) {
//    const files = event.target.files;
//    if (files.length > 0) {
//        const file = files[0];
//        if (!file.type.includes("image/")) {
//            alert("O arquivo não é uma imagem");
//            return;
//        } else {
//		           // alert(`Imagem selecionada tem ${file.size} bytes (${(file.size / 1024).toFixed(1)} KB)`); // ← AQUI
//            imagesArray = [file]; // Replace previous image with the new one
//            displayImagePreview(file);
//
//            // Clear the input value to allow re-upload of the same file
//            event.target.value = '';
//        }
//
//    }
//}

// Mostrar imagem na tela
function displayImagePreview(file) {
    const previewContainer = document.getElementById('imagePreviews');
    previewContainer.innerHTML = '';
    const reader = new FileReader();
    reader.onload = function (e) {
        const img = document.createElement('img');
        img.src = e.target.result;
        img.style.display = 'block'
        img.style.width = '100%';
        img.style.height = '100%';
        img.style.margin = '0px auto 2rem auto';
        img.style.objectFit = 'contain';
        document.getElementById('imagePreviews').appendChild(img);
    };
    reader.readAsDataURL(file);
}


function showCustomAlert() {
    document.getElementById('customModal').style.display = 'block';
}

// Pop-up de Camera/Buscar Imagem
function closeCustomAlert() {
    document.getElementById('customModal').style.display = 'none';
}

// Fechar o pop-upde imagem
function promptUserForAction() {
    document.getElementById('notificationBox').style.display = 'block';

}

// Function to hide the small notification box
function hideNotification() {
    document.getElementById('notificationBox').style.display = 'none';
}

// Function to handle user choices
function handleChoice(choice) {
    if (choice === 'folder') {
        document.getElementById('fileInput').click();
    } else if (choice === 'camera') {
        openCamera()
    }
    hideNotification();
}

// Função para gereneciar o IndexedDB para salvar os phrases
function openDatabase(dbName, version, upgradeCallback) {
    return new Promise((resolve, reject) => {
        const request = indexedDB.open(dbName, version);

        request.onupgradeneeded = (event) => {
            const db = event.target.result;
            if (upgradeCallback) {
                upgradeCallback(db);
            }
        };

        request.onsuccess = (event) => {
            resolve(event.target.result);
        };

        request.onerror = (event) => {
            reject('Error opening database: ' + event.target.errorCode);
        };
    });
}

// Atualiza o indexeddb
function upgradePhrasesDB(db) {
    if (!db.objectStoreNames.contains('phrases')) {
        db.createObjectStore('phrases', {
            keyPath: 'id',
            autoIncrement: true
        });
    }
}

function upgradeTokensDB(db) {
    if (!db.objectStoreNames.contains('tokens')) {
        db.createObjectStore('tokens', {
            keyPath: 'id',
            autoIncrement: true
        });
    }
}

// Atualiza o db offline
function upgradeOfflineDataDB(db) {
    if (!db.objectStoreNames.contains('offlineData')) {
        db.createObjectStore('offlineData', {
            keyPath: 'id',
            autoIncrement: true
        });
    }
}

// Armenizar os Phrases no IndexedDB
function storePhrasesInDB(phrases) {
    openDatabase('PhrasesDB', 1, upgradePhrasesDB).then(db => {
        const transaction = db.transaction(['phrases'], 'readwrite');
        const objectStore = transaction.objectStore('phrases');

        objectStore.clear();
        phrases.forEach(phrase => {
            objectStore.add({
                ...phrase
            });
        });

        transaction.oncomplete = () => {
        };

        transaction.onerror = () => {
            console.error('Error storing phrases in IndexedDB');
        };
    });
}

function storeTokensInDB(data) {
    openDatabase('TokensDB', 1, upgradeTokensDB).then(db => {
        const transaction = db.transaction(['tokens'], 'readwrite');
        const objectStore = transaction.objectStore('tokens');

        objectStore.clear();
        objectStore.add({ tokens: data.tokens });

        transaction.oncomplete = () => {
        };

        transaction.onerror = () => {
            console.error('Error storing tokens in IndexedDB');
        };
    });
}
// Pegar os phrases do indexeddb basedo no input de usuario
function getPhrasesFromDB(query) {
    return new Promise((resolve, reject) => {
        openDatabase('PhrasesDB', 1, upgradePhrasesDB).then(db => {
            const transaction = db.transaction(['phrases'], 'readonly');
            const objectStore = transaction.objectStore('phrases');
            const request = objectStore.getAll();

            request.onsuccess = (event) => {
                const phrases = event.target.result;
                const filteredPhrases = phrases
                    .map(phrase => phrase.nome_frase)
                    .filter(phrase => phrase.toLowerCase().includes(query.toLowerCase()))
                resolve(filteredPhrases);
            };

            request.onerror = () => {
                reject('Error retrieving phrases from IndexedDB');
            };
        });
    });
}

// Armenizar dados de formulario offline para o indexeddb
function storeDataOffline(data) {
    openDatabase('OfflineDataDB', 1, upgradeOfflineDataDB).then(db => {
        const transaction = db.transaction(['offlineData'], 'readwrite');
        const objectStore = transaction.objectStore('offlineData');

        const request = objectStore.getAll();
        request.onsuccess = () => {
            const dataToStore = {
                ...data,
            };

            objectStore.add(dataToStore);

            transaction.oncomplete = () => {
                document.getElementById('criar-evidencia-form').reset();
                document.getElementById('imagePreviews').innerHTML = '';
                suggestionSelected = "";
                imagePreviews = [];
                alert('Dados salvos. Serão enviados quando houver conexão.');
                hideLoading();
                window.location.href = "/"
            };

            transaction.onerror = () => {
                console.error('Error storing new data offline');
                alert('Erro');
            };
        };

        request.onerror = () => {
            console.error('Error checking existing data in IndexedDB');
        };
    });
}

//Syncronizar os dados para o servidor quando estiver online
function syncDataWithServer() {
    showLoading();
    setTimeout(() => {
        openDatabase('OfflineDataDB', 1, upgradeOfflineDataDB).then(db => {
            const transaction = db.transaction(['offlineData'], 'readonly');
            const objectStore = transaction.objectStore('offlineData');
            const request = objectStore.getAll();
            const fetchStatusArr = []

            request.onsuccess = (event) => {
                const offlineDataArray = event.target.result;

                if (offlineDataArray.length === 0) {
                    hideLoading();
                    return;
                } else {
                    offlineDataArray.forEach(offlineData => {
                        const formData = new FormData();

                        for (const key in offlineData) {
                            if (key === 'files') {
                                for (const file of offlineData.files) {
                                    formData.append('files[]', file);
                                }
                            } else {
                                formData.append(key, offlineData[key]);
                            }
                        }

                        fetch('./php/CriarEvidencia.php', {
                            method: 'POST',
                            body: formData
                        })
                            .then(response => {
                                if (!response.ok) {
                                    hideLoading();
                                    throw new Error('Network response was not ok: ' + response.statusText);
                                }
                                fetchStatusArr.push(true)
                                clearOfflineData(db, offlineData.id);
                                hideLoading();
                                // window.location.href = "/"
                                return response.json();
                            })
                            .catch(error => {
                                fetchStatusArr.push(false)
                                hideLoading();
                                console.error('Error syncing data:', error);
                            });
                    });
                }
                if (!fetchStatusArr.includes(false)) {
                    hideLoading();
                    alert('Dados enviados com sucesso!');
                    window.location.href = "/tjd3s_projind_20250703/"
                } else {
                    alert('Erro tente novamente!')
                }

            };



            request.onerror = () => {
                console.error('Error fetching data from IndexedDB');
            };
        });
    }, 10000);
}

// Remover os dados de formulario de indexeddb depois de syncronizar com servidor
function clearOfflineData(db, id) {
    const transaction = db.transaction(['offlineData'], 'readwrite');
    const objectStore = transaction.objectStore('offlineData');
    const deleteRequest = objectStore.delete(id);

    deleteRequest.onsuccess = () => {
    };

    deleteRequest.onerror = () => {
        console.error(`Error clearing offline data with id ${id}`);
    };
}


function removeSyncedDataFromDB(id) {
    openDatabase('OfflineDataDB', 1, upgradeOfflineDataDB).then(db => {
        const transaction = db.transaction(['offlineData'], 'readwrite');
        const objectStore = transaction.objectStore('offlineData');
        objectStore.delete(id);

        transaction.oncomplete = () => {
        };

        transaction.onerror = () => {
            console.error('Error removing synced data from IndexedDB');
        };
    });
}

// Carregar todos os phrases para o IndexedDB
function loadAllPhrasesIntoIndexedDB() {
    if (navigator.onLine) {
        fetch('./fetch-all-frases.php')
            .then(response => response.json())
            .then(data => {
                storePhrasesInDB(data);
            })
            .catch(error => console.error('Error fetching all phrases:', error));
    }
}

function loadAllTokensIntoIndexedDB() {
    if (navigator.onLine) {
        fetch('./php/fetch_tokens_chip2.php?query=&tokenIndex=1&previousTokens=[]')
            .then(response => response.json())
            .then(data => {
                storeTokensInDB({ tokens: data });
            })
            .catch(error => console.error('Error fetching all Tokens:', error));
    }
}

// Formatr os palavaras para no ter acentos
function removerAcentos(str) {
    return str.normalize('NFD').replace(/[\u0300-\u036f]/g, '');
}

const stopwords = ['eu', 'nos', 'fui', 'estava', 'eles', 'elas', 'e', 'o', 'a', 'do', 'da', 'em', 'um', 'uma', 'que', 'para', 'com', 'por', 'se', 'de', 'no', 'na'];


function getCurrentWord(input) {
    const words = input.split(' ');
    return words[words.length - 1];
}

// Pegar input do frase digitado 
function isStopword(word) {
    return stopwords.includes(word);
}

// Remover sugestoes
function clearSuggestions() {
    const container = document.getElementById('suggestions-container');
    container.innerHTML = '';
}

document.addEventListener('DOMContentLoaded', function () {
    loadAllPhrasesIntoIndexedDB();
    loadAllTokensIntoIndexedDB();

});

document.getElementById('fileInput').addEventListener('change', function (event) {
});

// Funçoes para quando mandar os dados de formaulario para o servidor
document.getElementById('criar-evidencia-form').addEventListener('submit', function (event) {
    event.preventDefault();
    showLoading();
    const formElement = document.getElementById('criar-evidencia-form');
    const formData = new FormData();

    const nomeAtividade = document.getElementById('nome-atividade');
    const data = document.getElementById('data');
    const atividadeRealizada = document.getElementById('atividade-realizada');
    const tipoAtividade = document.getElementById('edit_box_pergunta');

    const fields = {
        nomeAtividade,
        data,
        atividadeRealizada,
    }
    const errorFields = []

    if (!localStorage.getItem('longitude') || !localStorage.getItem('longitude')) {
        alert('Erro ao enviar dados, não consegue encontrar sua localização');
        hideLoading();
        return;
    }

    if (!localStorage.getItem('nome_usuario')) {
        alert('Erro ao enviar dados, precisa ter uma usuario vinculado com esta pesquisa');
        hideLoading();
        return;
    }

    Object.keys(fields).map((key) => {
        const field = fields[key];
        if (!field.value.trim()) {
            field.classList.add('error-input')
            errorFields.push(field)
        } else {
            field.classList.remove('error-input')
        }
    })

    if (!selectedPhraseId || selectedPhraseId === "" || selectedPhraseId === 0) {
        if (tipoAtividade) {
            tipoAtividade.classList.add('error-input');
            alert("Por favor, preencha todos os campos");

        } else {
            alert("Por favor, clique no botão para selecionar a frase escolhida.");
        }
        hideLoading()
        return;
    }

    if (errorFields.length > 0) {
        const focusField = errorFields[0];
        focusField.focus();
        alert("Por favor, preencha todos os campos");
        hideLoading();
        return;
    }

    if (errorFields.length > 0) {
        const focusField = errorFields[0];
        focusField.focus();
        alert("Por favor, preencha todos os campos");
        hideLoading();
        return;
    }

    if (imagesArray.length === 0) {
        alert("Por favor, carregue ou tire uma foto")
        hideLoading();
        return;
    }
    formData.append('nome-atividade', nomeAtividade.value);
    formData.append('tipo-atividade', selectedPhraseId);
    formData.append('data', data.value);
    formData.append('atividade-realizada', atividadeRealizada.value);
    formData.append('data-acao', data.value.split('T')[0]);
    formData.append('hora-acao', data.value.split('T')[1]);
    formData.append('longitude', localStorage.getItem('longitude'));
    formData.append('latitude', localStorage.getItem('latitude'));
    formData.append('nome-usuario', localStorage.getItem('nome_usuario'));
    formData.append('nome-pessoa', localStorage.getItem('nome_pessoa'));

    if (imagesArray.length > 0) {
        formData.append('files[]', imagesArray[0]);
    }
for (let [key, value] of formData.entries()) {
    console.log(`${key}: ${value}`);
}
//alert('paradinha para respirar');
setTimeout(function () {
    if (navigator.onLine) {
	    //alert('settimeout');
        fetch('./php/CriarEvidencia.php', {
            method: 'POST',
            body: formData
        })
            .then(async (response) => {
                const jsonResponse = await response.json(); // Parse the response as JSON

                if (!response.ok) {
                    throw {
                        ...jsonResponse
                    }
                }
                return jsonResponse
            })
            .then((res) => {
                formElement.reset();
                suggestionSelected = "";
                document.getElementById('imagePreviews').innerHTML = '';
                loading.style.display = "none"
                hideLoading()
                setTimeout(() => {
                    alert('Dados enviados com sucesso!');
                    window.location.href = "./"
                }, 1000)
                // loading.style.display = "none"

            })
            .catch(error => {
                if (error.faceDetected === 'false' || error.extensionError === 'false') {
                    alert(error.message);
                }
                else {
                    alert('Erro ao enviar dados, tente novamente.'+error.message);
                }
                hideLoading();
            });
    } else {
        const plainData = Object.fromEntries(formData.entries());
        storeDataOffline(plainData);
    }}, 4000);
});

window.addEventListener('online', () => {
    syncDataWithServer();
});




