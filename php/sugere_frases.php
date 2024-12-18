<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Token Selector</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

#container {
    width: 100%;
    max-width: 400px;
    margin: 20px auto;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 8px;
    overflow-y: auto;
    display: flex;
    flex-direction: row; /* Organiza os itens em uma coluna */
    gap: 5px; /* Espaçamento entre os itens */
    flex-wrap: wrap; /* Quebra a linha quando não há mais espaço */
}

.interno {
    flex: 0 1 auto; /* Garante que os elementos se comportem como itens Flex */
    width: 100%; /* Opcional: ocupa toda a largura do container */
}

        .chip {
            display: inline-block;
            margin: 5px;
            padding: 10px;
            background-color: #e0e0e0;
            border-radius: 16px;
            position: relative;
        }

        .chip .delete {
            position: absolute;
            top: 2px;
            right: 2px;
            width: 16px;
            height: 16px;
            background: red;
            color: white;
            border: none;
            border-radius: 50%;
            font-size: 12px;
            cursor: pointer;
        }

        .input-wrapper {
            margin: 5px 0;
            display: flex;
            align-items: center;
    display: flex;
    flex-direction: column; /* Organiza os itens em uma coluna */
    gap: 5px; /* Espaçamento entre os itens */
        }

        .input-wrapper input {
            flex: 1;
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 8px;
        }

        .dropdown {
            position: absolute;
            background: white;
            border: 1px solid #ccc;
            width: 100%;
            max-width: 400px;
	    max-height: 80vh;
            z-index: 10;
            display: none;
	    overflow-y: scroll;
        }

        .dropdown div {
            padding: 10px;
            cursor: pointer;
        }

        .dropdown div:hover {
            background-color: #f0f0f0;
        }
    </style>
</head>
<body>
    <div id="container">
        <!-- Chips serão adicionados dinamicamente aqui -->
    </div>
    <div class="dropdown" id="dropdown"></div>

    <script>
        const container = document.getElementById('container');
        const dropdown = document.getElementById('dropdown');
        let tokenIndex = 1;
        let previousTokens = [];
	var perguntas = []; // Variável global

	carregarPerguntas();

function showLoadingIndicator(inputWrapper) {
    // Cria o elemento de carregamento (rodinha)
    const loadingSpinner = document.createElement('div');
    loadingSpinner.id = 'loading-spinner';
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
	        
	        // Retornar um array contendo apenas os valores de 'nome_token'
	        return data.map(row => row.nome_token);
	    } catch (error) {
	        console.error('Erro:', error);
	        return [];
	    }
	}


        function fetchSuggestions(query) {
            const url = `fetch_tokens_chip.php?query=${query}&tokenIndex=${tokenIndex}&previousTokens=${JSON.stringify(previousTokens)}`;
            return fetch(url).then(res => res.json());
        }

        function createChip(token) {
            const chip = document.createElement('div');
            chip.className = 'chip';
            chip.textContent = token;

            const deleteBtn = document.createElement('button');
            deleteBtn.className = 'delete';
            deleteBtn.textContent = '×';
            deleteBtn.onclick = () => {
                chip.remove();
                previousTokens.pop();
                tokenIndex--;
                //updateInputPosition();
            };

            chip.appendChild(deleteBtn);
            container.appendChild(chip);
        }

        function updateInputPosition() {
console.log('tokenIndex:', tokenIndex);
            const inputWrapper = document.createElement('div');
            inputWrapper.className = 'input-wrapper';
             

	   if (perguntas.length >0 && tokenIndex <= perguntas.length) {
		pergunta = perguntas[tokenIndex-1];
	   } else { pergunta = 'Carregando pergunta';}

	    inputWrapper.innerHTML = "<div id='pergunta' class='interno'>"+pergunta+"</div>" 
            
            const input = document.createElement('input');

            input.type = 'text';
	    input.className = 'interno';
            input.placeholder = 'Digite aqui...';


	    let handleInput = async () => {
	        const suggestions = await fetchSuggestions(input.value);
 		console.log('suggestions:', suggestions);
	        if (suggestions.length === 0) {
	            input.value = input.value.slice(0, -1); // Atualiza o valor do input se necessário
	        } else {
	            showDropdown(suggestions, input, inputWrapper);
	        }
	    };

	
            input.oninput = async () => {
		handleInput(event);
            };
            input.onclick = async () => {
		handleInput(event);
            };


            inputWrapper.appendChild(input);
            container.appendChild(inputWrapper);
            input.focus();
        }

        function showDropdown(suggestions, input, inputWrapper) {
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
	    perguntas = await retorna_perguntas(); // Aguardar a resolução da Promise
	    document.getElementById('pergunta').innerHTML = perguntas[0];
	    console.log('Perguntas carregadas:', perguntas);
	}
	
	// Chame a função para carregar as perguntas



    </script>
</body>
</html>

