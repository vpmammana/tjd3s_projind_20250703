alert("page-auth_hash.js");

const isMobile = window.innerWidth <= 768;
const path = window.location.pathname.replace(/^.*\//, '');
const hashParam = new URLSearchParams(window.location.search).get('hash');
const localHash = localStorage.getItem('auth_hash');
alert('teste');

// Redireciona se não for mobile
if (!isMobile && hashParam) {
	alert('vai replace');
    window.location.replace('apenas-mobile.html');
}


// Função para validar hash com servidor
async function validarHashComServidor(hashParam) {
    try {
        const res = await fetch('verifica_hash.php?hash=' + encodeURIComponent(hashParam));
        const data = await res.json();

        if (data.tem_local_storage === 'sim') {
            if (!localHash) {
                localStorage.setItem('auth_hash', hashParam);
            } else if (localHash !== hashParam) {
                alert("Hash inválido ou diferente do autorizado.");
                window.location.replace('login.html');
                return;
            }
        } else {
            alert("Este usuário não está autorizado a usar localStorage.");
            window.location.replace('login.html');
            return;
        }

        handlePages();
    } catch (e) {
        console.error("Erro ao verificar hash:", e);
        window.location.replace('login.html');
    }
}

// Valida hash antes de tudo
alert(path);
if (path === "index.html" || path === "") {
	alert("index.html");
    if (!hashParam) {
        alert("Hash ausente na URL.");
        window.location.replace('login.html');
    } else {
        validarHashComServidor(hashParam);
    }
} else {
    handlePages(); // continua com a lógica existente para outras páginas
}

function handlePages() {
    const isAuth = localStorage.getItem('authenticated');
    const terms_cond = localStorage.getItem('terms_cond');

    if (!isAuth && path !== 'login.html') {
        window.location.replace("login.html");
        return;
    }

    if (isAuth && !terms_cond) {
        if (path !== 'termos.html')
            window.location.replace("termos.html");
        return;
    }

    if (isAuth && path === 'login.html') {
        window.location.replace("/");
        return;
    }

    if (terms_cond && isAuth) {
        if (path !== "" && path !== "index.html") {
            window.location.replace("./");
        }
    }
}

