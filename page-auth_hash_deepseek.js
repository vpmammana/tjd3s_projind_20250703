(function () {
    if (typeof window === 'undefined' || typeof document === 'undefined') return;
    if (window.__authModuleInitialized) return;
    window.__authModuleInitialized = true;

    const MOBILE_MAX_WIDTH = 768;
    const AUTH_TIMEOUT = 5000;

    const aceitoBtn = document.getElementById('aceito');
    const naoAceitoBtn = document.getElementById('nao-aceito');

    function isMobileDevice() {
        const isMobile = window.innerWidth <= MOBILE_MAX_WIDTH;
        console.log(`[isMobileDevice] innerWidth=${window.innerWidth} → ${isMobile}`);
        return isMobile;
    }

    const isLocalStorageAvailable = () => {
        try {
            const testKey = 'test_' + Math.random().toString(36).substring(2);
            localStorage.setItem(testKey, testKey);
            localStorage.removeItem(testKey);
            return true;
        } catch (e) {
            return false;
        }
    };

    const getUrlParams = () => {
        const path = window.location.pathname.split('/').pop() || 'index.html';
        const hashParam = new URLSearchParams(window.location.search).get('hash');
        return { path, hashParam };
    };

    const redirectTo = (path) => {
        window.location.href = path;
    };

    const clearAuthData = () => {
        localStorage.removeItem('auth_hash');
        localStorage.removeItem('authenticated');
        localStorage.removeItem('terms_accepted');
	localStorage.removeItem('id_pessoa'); // NOVO 
	localStorage.removeItem('nome_pessoa'); // NOVO 
	localStorage.removeItem('nome_usuario'); // NOVO 
    };

async function validateHashWithServer(hash) {
    if (!hash || !isLocalStorageAvailable()) {
        clearAuthData();
        redirectTo('login.html');
        return false;
    }

    try {
        const verifyResponse = await fetch('verifica_hash.php', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: `hash=${encodeURIComponent(hash)}`
        });

        const rawText = await verifyResponse.text();
        console.log('[verifica_hash.php] Status:', verifyResponse.status);
        console.log('[verifica_hash.php] Resposta crua:', rawText);

        if (!verifyResponse.ok || !rawText) {
            throw new Error('Resposta inválida do servidor');
        }

        let verifyData;
        try {
            verifyData = JSON.parse(rawText);
        } catch (e) {
            throw new Error('Erro ao fazer parse da resposta: ' + rawText);
        }

        if (verifyData.erro) throw new Error('Erro verificacao: '+verifyData.erro);
if (verifyData.tem_local_storage === 'sim') {
    // alert(localStorage.getItem('auth_hash') + ' ' + hash);
    if (localStorage.getItem('auth_hash') !== hash) {
        alert('Este usuário já foi vinculado a outro dispositivo móvel.');

        // 🧹 Faz chamada para limpar o registro no banco
        await fetch('limpa_auth_hash.php', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: `hash=${encodeURIComponent(hash)}`
        });
        clearAuthData();
        throw new Error('Este hash já está em uso em outro dispositivo');
    }

    localStorage.setItem('id_pessoa', verifyData.id_pessoa); // NOVO
    localStorage.setItem('nome_pessoa', verifyData.nome_pessoa); // NOVO
    localStorage.setItem('nome_usuario', verifyData.nome_usuario); // NOVO
    return true;
}

        // Se ainda não registrado, atualiza
        const updateResponse = await fetch('atualiza_local_storage.php', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: `hash=${encodeURIComponent(hash)}`
        });

        const updateRaw = await updateResponse.text();
        console.log('[atualiza_local_storage.php] Resposta crua:', updateRaw);

        let updateData;
        try {
            updateData = JSON.parse(updateRaw);
        } catch (e) {
            throw new Error('Erro ao parsear resposta de atualização: ' + updateRaw);
        }
  //	alert('update.sucesso'+ updateData.sucesso);
        if (!updateData.sucesso) throw new Error('Falha ao registrar dispositivo');
        localStorage.setItem('auth_hash', hash);
        localStorage.setItem('authenticated', 'true');
	localStorage.setItem('id_pessoa', verifyData.id_pessoa); // NOVO
	localStorage.setItem('nome_pessoa', verifyData.nome_pessoa); // NOVO
	localStorage.setItem('nome_usuario', verifyData.nome_usuario); // NOVO
        return true;

    } catch (error) {
        console.error('Hash validation failed:', error);
        clearAuthData();
        redirectTo('login.html');
        return false;
    }
}


    async function handleAppFlow() {
        const { path, hashParam } = getUrlParams();
        const isAuth = localStorage.getItem('authenticated') === 'true';
        const termsAccepted = localStorage.getItem('terms_accepted') === 'true';

        if (!isMobileDevice() && hashParam) {
            redirectTo('desktop-not-allowed.html');
            return;
        }

        if (path === 'termos.html') {
            if (!localStorage.getItem('auth_hash')) {
                redirectTo('login.html');
                return;
            }

//            if (aceitoBtn && naoAceitoBtn) {
//                aceitoBtn.addEventListener('click', () => {
//                    localStorage.setItem('terms_accepted', 'true');
//                    redirectTo('./');
//                });
//                naoAceitoBtn.addEventListener('click', () => {
//                    //clearAuthData();
//                    redirectTo('login.html');
//                });
//            }

            document.body.style.display = 'block';
            return;
        }

        if (path === 'login.html') {
            if (isAuth && !isMobileDevice()) {
                redirectTo(termsAccepted ? './' : 'termos.html');
            } else {
                document.body.style.display = 'block';
            }
            return;
        }

        if (path === '' || path === 'index.html') {
            if (hashParam && isMobileDevice()) {
                const valid = await validateHashWithServer(hashParam);
                if (valid) {
                    window.history.replaceState({}, document.title, window.location.pathname);
                    if (!termsAccepted) {
                        redirectTo('termos.html');
                        return;
                    }
                    document.body.style.display = 'block';
                } else {redirectTo('login.html'); return;}
                return;
            }

            if (!isAuth && !isMobileDevice()) {
                redirectTo('login.html');
                return;
            }

            if (!termsAccepted) {
                redirectTo('termos.html');
                return;
            }

            document.body.style.display = 'block';
            return;
        }

        if (!isAuth && !isMobileDevice()) {
            redirectTo('login.html');
        } else if (!termsAccepted) {
            redirectTo('termos.html');
        } else {
            document.body.style.display = 'block';
        }
    }

    document.addEventListener('DOMContentLoaded', () => {
        if (!isLocalStorageAvailable()) {
            alert('Este aplicativo requer localStorage habilitado');
            redirectTo('login.html');
            return;
        }

        if (location.pathname.endsWith('index.html') || location.pathname.endsWith('/')) {
            document.getElementById('logoutBtn')?.addEventListener('click', (e) => {
                e.preventDefault();
                //clearAuthData();
                redirectTo('login.html');
            });
        }
    });

    if (document.readyState === 'complete') {
        handleAppFlow();
    } else {
        window.addEventListener('load', handleAppFlow);
    }

    window.addEventListener('resize', () => {
        if (!isMobileDevice() && localStorage.getItem('auth_hash')) {
            redirectTo('desktop-not-allowed.html');
        }
    });

})();
