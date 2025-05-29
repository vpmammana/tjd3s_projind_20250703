alert("page-auth_hash.js");

const isMobile = window.innerWidth <= 768;
const path = window.location.pathname.replace(/^.*\//, ''); // correcao de VPM
const hashParam = new URLSearchParams(window.location.search).get('hash');
const localHash = localStorage.getItem('auth_hash');
alert('teste4');
    const isAuthext = localStorage.getItem('authenticated');
    const terms_cond = localStorage.getItem('terms_cond');


if (!hashParam && isAuthext && terms_cond) {} else {

// Redireciona se não for mobile
alert('isMobile'+isMobile);
alert("hash: "+hashParam);
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
		return;
            } else if (localHash !== hashParam) {
                alert("Hash inválido ou diferente do autorizado.");
                window.location.replace('login.html');
                return;
            }
        } else {
	    if (localHash === hashParam) {
		    alert('Bem vindo!');
		    return
	    } else {
            alert("Este usuário não está autorizado a usar localStorage.");
            window.location.replace('login.html');
            return;
            }
        }

        handlePages();
    } catch (e) {
	    alert('erro ao verificar hash:');
        console.error("Erro ao verificar hash:", e);
        window.location.replace('login.html');
    }
}
// Valida hash antes de tudo
alert('Path: '+path);
if ((path === "index.html" || path === "")) {
	alert("index.html nao vem de login 2");
    if (!hashParam) {
        alert("Hash ausente na URL. isAuthext: "+isAuthext);
	if (isAuthext) {
        window.location.replace('./');
	} else {
        window.location.replace('login.html');
	}
    } else {
	    alert('validar');
	if (!isAuthext && hashParam) {
		alert('vai chamar validar');
        validarHashComServidor(hashParam);
	}
	}
} else {
	alert('handle');
    handlePages(); // continua com a lógica existente para outras páginas
}

function handlePages() {
	alert('entrou handle');
    const isAuth = localStorage.getItem('authenticated');
    const terms_cond = localStorage.getItem('terms_cond');
alert('isAuth: '+isAuth+' path: '+ path+' terms_cond: '+terms_cond);
    if (!isAuth && path !== 'login.html') {
	    alert('vai para login.html');
        window.location.replace("login.html");
        return;
    }

    if (isAuth && !terms_cond && path !== 'termos.html') {
            window.location.replace("termos.html");
        return;
    }

    if (isAuth && path === 'login.html' && path !=='') {
	    alert('vai para raiz');
        window.location.replace("");
        return;
    }

    if (terms_cond && isAuth) {
        if (path !== "" && path !== "index.html") {
		alert('vai para ./');
            window.location.replace("./");
        }
    }
}


}
