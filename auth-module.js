// auth-module.js
(function () {
  if (window.__authModuleInitialized) return;
  window.__authModuleInitialized = true;

  const MOBILE_MAX_WIDTH = 768;
  const AUTH_TIMEOUT = 5000;

  const getUrlParams = () => {
    const path = window.location.pathname.split('/').pop() || 'index.html';
    const hashParam = new URLSearchParams(window.location.search).get('hash');
    return { path, hashParam };
  };

  const isMobileDevice = () => {
    const result = window.innerWidth <= MOBILE_MAX_WIDTH;
    console.log(`[isMobileDevice] innerWidth=${window.innerWidth} → ${result}`);
    return result;
  };

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

  const redirectTo = (path) => {
    window.location.href = path;
  };

  const clearAuthData = () => {
    localStorage.removeItem('auth_hash');
    localStorage.removeItem('authenticated');
    localStorage.removeItem('terms_accepted');
  };

  async function validateHashWithServer(hash) {
    if (!hash || !isLocalStorageAvailable()) {
      clearAuthData();
      redirectTo('login.html');
      return false;
    }

    try {
      const controller = new AbortController();
      const timeoutId = setTimeout(() => controller.abort(), AUTH_TIMEOUT);

      const verifyResponse = await fetch(`verifica_hash.php?hash=${encodeURIComponent(hash)}`, {
        signal: controller.signal
      });

      clearTimeout(timeoutId);
      if (!verifyResponse.ok) throw new Error('Server response not OK');

      const verifyData = await verifyResponse.json();

      if (verifyData.erro) throw new Error(verifyData.erro);

      if (verifyData.tem_local_storage === 'sim') {
        if (localStorage.getItem('auth_hash') !== hash) {
          throw new Error('Hash usado em outro dispositivo');
        }
        return true;
      }

      const updateResponse = await fetch('atualiza_local_storage.php', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: `hash=${encodeURIComponent(hash)}`,
        signal: controller.signal
      });

      const updateData = await updateResponse.json();
      if (!updateData.sucesso) throw new Error('Falha ao registrar dispositivo');

      localStorage.setItem('auth_hash', hash);
      localStorage.setItem('authenticated', 'true');
      return true;
    } catch (err) {
      console.error('Erro na validação do hash:', err);
      clearAuthData();
      redirectTo('login.html');
      return false;
    }
  }

  function handleAppFlow() {
    const { path, hashParam } = getUrlParams();
    const isAuth = localStorage.getItem('authenticated') === 'true';
    const termsAccepted = localStorage.getItem('terms_accepted') === 'true';

    if (!isMobileDevice() && hashParam) {
      redirectTo('desktop-not-allowed.html');
      return;
    }

    if (path === 'termos.html') {
      if (!isAuth) {
        redirectTo('login.html');
        return;
      }
      const aceitoBtn = document.getElementById('aceito');
      const naoAceitoBtn = document.getElementById('nao-aceito');
      aceitoBtn?.addEventListener('click', () => {
        localStorage.setItem('terms_accepted', 'true');
        redirectTo('./');
      });
      naoAceitoBtn?.addEventListener('click', () => {
        clearAuthData();
        redirectTo('login.html');
      });
      return;
    }

    if (path === 'login.html') {
      if (isAuth) {
        redirectTo(termsAccepted ? './' : 'termos.html');
      }
      return;
    }

    if (path === '' || path === 'index.html') {
      if (hashParam && !isAuth) {
        validateHashWithServer(hashParam).then(valid => {
          if (valid && !termsAccepted) {
            window.history.replaceState({}, document.title, window.location.pathname);
            redirectTo('termos.html');
          }
        });
        return;
      }
      if (!isAuth) {
        redirectTo('login.html');
        return;
      }
      if (!termsAccepted) {
        redirectTo('termos.html');
        return;
      }
    }
  }

  document.addEventListener('DOMContentLoaded', () => {
    if (!isLocalStorageAvailable()) {
      redirectTo('login.html');
      return;
    }
    const logoutBtn = document.getElementById('logoutBtn');
    logoutBtn?.addEventListener('click', (e) => {
      e.preventDefault();
      clearAuthData();
      redirectTo('login.html');
    });
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

