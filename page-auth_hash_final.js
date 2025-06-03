const isMobile = window.innerWidth <= 768;
const path = window.location.pathname.replace(/^.*\//, '');
const hashParam = new URLSearchParams(window.location.search).get('hash');
const localHash = localStorage.getItem('auth_hash');
const isAuthext = localStorage.getItem('authenticated');
const terms_cond = localStorage.getItem('terms_cond');

alert('teste4');

// Redireciona se não for mobile
if (!isMobile && hashParam) {
    alert('vai replace');
    window.location.replace('apenas-mobile.html');
}

// Função para validar hash com servidor
async function validarHashComServidor(hashParam) {
    alert('entrou validar');
    try {
        const res = await fetch('verifica_hash.php?hash=' + encodeURIComponent(hashParam));
        const data = await res.json();

        if (data.tem_local_storage === 'nao') {
            if (!localHash) {
                localStorage.setItem('auth_hash', hashParam);

                // Atualiza o campo tem_local_storage para 'sim'
                await fetch('atualiza_local_storage.php?hash=' + encodeURIComponent(hashParam));

                return;
            }
            if (localHash !== hashParam) {
                alert("Hash inválido ou diferente do autorizado.");
                window.location.replace('login.html');
                return;
            }
        } else if (localHash === hashParam) {
            alert('Bem vindo!');
            return;
        } else {
            alert("Este usuário não está autorizado a usar localStorage.");
            window.location.replace('login.html');
            return;
        }

        handlePages();

    } catch (e) {
        alert('erro ao verificar hash:');
        console.error("Erro ao verificar hash:", e);
        window.location.replace('login.html');
    }
}

// Valida hash se for página index
alert('Path: ' + path);

if (path === "index.html" || path === "") {
    alert("index.html nao vem de login 2");

    if (!hashParam) {
        alert("Hash ausente na URL. isAuthext: " + isAuthext);
        window.location.replace(isAuthext ? './' : 'login.html');
    } else if (!isAuthext) {
        alert('vai chamar validar');
        validarHashComServidor(hashParam);
    }
} else {
    alert('handle');
    handlePages(); // continua com a lógica existente para outras páginas
}

function handlePages() {
    alert('entrou handle');
    const isAuth = localStorage.getItem('authenticated');
    const terms_cond = localStorage.getItem('terms_cond');
    alert('isAuth: ' + isAuth + ' path: ' + path + ' terms_cond: ' + terms_cond);

    if (!isAuth && path !== 'login.html') {
        alert('vai para login.html');
        window.location.replace("login.html");
        return;
    }

    if (isAuth && !terms_cond && path !== 'termos.html') {
        window.location.replace("termos.html");
        return;
    }

    if (isAuth && path === 'login.html') {
        alert('vai para raiz');
        window.location.replace("");
        return;
    }

    if (terms_cond && isAuth && path !== "" && path !== "index.html") {
        alert('vai para ./');
        window.location.replace("./");
    }
}

