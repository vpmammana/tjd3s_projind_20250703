(function() {
    // Prevenção contra múltiplas execuções e ambientes não-browser
    if (typeof window === 'undefined' || typeof document === 'undefined') return;
    if (window.__authModuleInitialized) return;
    window.__authModuleInitialized = true;

    // Configurações
    const MOBILE_MAX_WIDTH = 768;
    const AUTH_TIMEOUT = 5000;
    const MOBILE_HASH_EXPIRATION = 1000 * 24 * 60 * 60 * 1000; // 30 dias em ms

    // Elementos da interface
    const aceitoBtn = document.getElementById('aceito');
    const naoAceitoBtn = document.getElementById('nao-aceito');
    const logoutBtn = document.getElementById('logoutBtn');

    // Gera um identificador único para o dispositivo móvel
    const generateDeviceId = (baseHash) => {
        return `${baseHash}_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`;
    };

    // Verifica se é dispositivo móvel
    const isMobileDevice = () => {
        const isMobile = window.innerWidth <= MOBILE_MAX_WIDTH;
        console.log(`[Device Check] Screen: ${window.innerWidth}px, Mobile: ${isMobile}`);
        return isMobile;
    };

    // Verifica disponibilidade do localStorage
    const isLocalStorageAvailable = () => {
        try {
            const testKey = 'storage_test_' + Math.random().toString(36);
            localStorage.setItem(testKey, testKey);
            localStorage.removeItem(testKey);
            return true;
        } catch (e) {
            console.error('LocalStorage not available:', e);
            return false;
        }
    };

    // Limpa dados de autenticação
    const clearAuthData = () => {
        const keys = [
            'auth_hash',
            'auth_device_id',
            'authenticated',
            'terms_accepted',
            'id_pessoa',
            'nome_pessoa',
            'nome_usuario',
            'last_activity'
        ];
        
        keys.forEach(key => localStorage.removeItem(key));
        console.log('Auth data cleared');
    };

    // Redirecionamento seguro
    const redirectTo = (path) => {
        console.log(`Redirecting to: ${path}`);
        window.location.href = path;
    };

    // Extrai parâmetros da URL
    const getUrlParams = () => {
        const path = window.location.pathname.split('/').pop() || 'index.html';
        const hashParam = new URLSearchParams(window.location.search).get('hash');
        return { path, hashParam };
    };

    // Validação do token com o servidor
    const validateAuthToken = async () => {
        const authHash = localStorage.getItem('auth_hash');
        const deviceId = localStorage.getItem('auth_device_id');
        
        if (!authHash || !deviceId) {
            return false;
        }

try {
    const response = await fetch('verifica_sessao.php', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: `hash=${encodeURIComponent(authHash)}&device_id=${encodeURIComponent(deviceId)}`
    });

    const data = await response.json(); // <-- só agora você tem 'data'
//    alert('paradinha data.valid: ' + data.valid + ' dados '+authHash+ ' dados2'+deviceId );
    return data.valid === true;

} catch (error) {
//    alert('paradinha Session validation error: ' + error);
    console.error('Session validation error:', error);
    return false;
}
    };

    // Registra atividade do usuário
    const recordUserActivity = () => {
        localStorage.setItem('last_activity', Date.now().toString());
    };

    // Verifica sessão inativa
    const checkInactiveSession = () => {
        const lastActivity = localStorage.getItem('last_activity');
        if (lastActivity && (Date.now() - parseInt(lastActivity)) > MOBILE_HASH_EXPIRATION) {
            clearAuthData();
            return false;
        }
        return true;
    };

    // Processa autenticação por hash
    const processHashAuth = async (hash) => {
        if (!hash || !isLocalStorageAvailable()) {
            clearAuthData();
            redirectTo('login.html');
            return false;
        }

        try {
            // 1. Verificação inicial do hash
		// alert('paradinha1');
            const verifyResponse = await fetch('verifica_hash_mobile.php', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: `hash=${encodeURIComponent(hash)}`
            });

            const verifyData = await verifyResponse.json();
           console.log(verifyData);
	//	alert('verifyData Paradinha');
            if (verifyData.erro) {
                throw new Error(verifyData.erro);
            }

//		alert('paradinha2');
            const currentDeviceId = localStorage.getItem('auth_device_id');
//		alert('paradinha current_device '+currentDeviceId);
            const newDeviceId = generateDeviceId(hash);
//                alert('paradinha newDeviceId '+newDeviceId);
            // 2. Se já está registrado em outro dispositivo
            if (verifyData.dados.tem_local_storage === 'sim') {
//		    alert('paradinha deu sim para tem local '+ verifyData.dados.tem_local_storage);
                if (currentDeviceId !== verifyData.dados.hash_mobile) {
                    alert('Este usuário já está ativo em outro dispositivo. Você será desconectado.');
                    //clearAuthData();
		//	alert('device mismatch');
                    throw new Error('Device mismatch');
                } 
                
                // Atualiza dados do usuário
		// alert('vai setitem id_pessoa: '+verifyData.dados.id_pessoa);
                localStorage.setItem('id_pessoa', verifyData.dados.id_pessoa);
                localStorage.setItem('nome_pessoa', verifyData.dados.nome_pessoa);
                localStorage.setItem('nome_usuario', verifyData.dados.nome_usuario);
                recordUserActivity();
                
                return true;
            }
// alert('newDeviceId -> '+ newDeviceId);
            // 3. Registra novo dispositivo
            const registerResponse = await fetch('registra_dispositivo.php', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: `hash=${encodeURIComponent(hash)}&device_id=${encodeURIComponent(newDeviceId)}`
            });

            const registerData = await registerResponse.json();

            if (!registerData.sucesso) {
//		    alert('paradinha: Device registration failed');
                throw new Error('Device registration failed');
            }

// 3.5 antes de apagar os dados do usuario atual no dispositivo atual, tem que liberar no backend 
const oldHash = localStorage.getItem('auth_hash');
		alert('paradinha vou liberar esse: '+ oldHash);
if (oldHash) {
    try {
        await fetch('libera_dispositivo.php', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: `hash=${encodeURIComponent(oldHash)}`
        });
        console.log('🔓 Dispositivo anterior liberado com sucesso');
    } catch (e) {
        console.warn('⚠️ Falha ao liberar dispositivo anterior:', e);
    }
}
alert('paradinha veja o console');

            // 4. Armazena dados localmente
            localStorage.setItem('auth_hash', hash);
            localStorage.setItem('auth_device_id', newDeviceId);
            localStorage.setItem('authenticated', 'true');
            localStorage.setItem('id_pessoa', verifyData.dados.id_pessoa);
            localStorage.setItem('nome_pessoa', verifyData.dados.nome_pessoa);
            localStorage.setItem('nome_usuario', verifyData.dados.nome_usuario);
            recordUserActivity();
            
            return true;

        } catch (error) {
//		alert('paradinha Authentication error:', error);
            console.error('Authentication error:', error);
            //clearAuthData();
            redirectTo('login.html');
            return false;
        }
    };

    // Controle principal do fluxo de navegação
    const handleAppFlow = async () => {
        if (!isLocalStorageAvailable()) {
            alert('Este aplicativo requer localStorage habilitado');
            redirectTo('login.html');
            return;
        }

        const { path, hashParam } = getUrlParams();
        const isAuth = localStorage.getItem('authenticated') === 'true';
        const termsAccepted = localStorage.getItem('terms_accepted') === 'true';

        console.log(`Navigation: path=${path}, auth=${isAuth}, terms=${termsAccepted}`);

        // Bloqueia acesso desktop com hash
        if (!isMobileDevice() && hashParam) {
            redirectTo('desktop-not-allowed.html');
            return;
        }

        // Página de termos
        if (path === 'termos.html') {
            if (!isAuth) {
                redirectTo('login.html');
                return;
            }

//            if (aceitoBtn && naoAceitoBtn) {
//                aceitoBtn.onclick = () => {
//                    localStorage.setItem('terms_accepted', 'true');
//                    redirectTo('./');
//                };
//
//                naoAceitoBtn.onclick = () => {
//                    clearAuthData();
//                    redirectTo('login.html');
//                };
//            }

            document.body.style.display = 'block';
            return;
        }

        // Página de login
        if (path === 'login.html') {
            if (isAuth) {
                redirectTo(termsAccepted ? './' : 'termos.html');
                return;
            }
            
            document.body.style.display = 'block';
            return;
        }

        // Página principal
        if (path === '' || path === 'index.html') {
            // Autenticação por hash (mobile)
            if (hashParam && isMobileDevice()) {
                const valid = await processHashAuth(hashParam);
                if (valid) {
                    window.history.replaceState({}, document.title, window.location.pathname);
                    redirectTo(termsAccepted ? './' : 'termos.html');
                }
                return;
            }

            // Verificação de sessão para usuários autenticados
            if (isAuth) {
                if (!checkInactiveSession() || !(await validateAuthToken())) {
                    clearAuthData();
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

            // Redireciona para login se não autenticado
            redirectTo('login.html');
            return;
        }

        // Para outras páginas protegidas
        if (isAuth) {
            if (!checkInactiveSession() || !(await validateAuthToken())) {
                clearAuthData();
                redirectTo('login.html');
                return;
            }

            if (!termsAccepted) {
                redirectTo('termos.html');
                return;
            }

            document.body.style.display = 'block';
        } else {
            redirectTo('login.html');
        }
    };

    // Configura eventos
    const setupEventListeners = () => {
        if (logoutBtn) {
            logoutBtn.addEventListener('click', (e) => {
                e.preventDefault();
                clearAuthData();
                redirectTo('login.html');
            });
        }

        window.addEventListener('resize', () => {
            if (!isMobileDevice() && localStorage.getItem('auth_hash')) {
                redirectTo('desktop-not-allowed.html');
            }
        });

        // Monitora atividade do usuário
        document.addEventListener('click', recordUserActivity);
        document.addEventListener('keypress', recordUserActivity);
        document.addEventListener('scroll', recordUserActivity);
    };

    // Inicialização
    const init = () => {
        setupEventListeners();
        
        if (document.readyState === 'complete') {
            handleAppFlow();
        } else {
            window.addEventListener('load', handleAppFlow);
        }
    };

    init();
})();
