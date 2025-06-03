document.addEventListener("DOMContentLoaded", function () {
    // Initialize Keycloak
    const keycloak = new Keycloak({
        url: 'http://localhost:8093',
        realm: 'tjd3s-realm',
        clientId: 'tjd3s-client'
    });

    const outputTextarea = document.getElementById('output');

    function logToTextarea(message) {
        const now = new Date();
        const timestamp = now.toLocaleString();
        outputTextarea.value += `[${timestamp}] ${message}\n`;
    }

    keycloak.init({
        onLoad: 'login-required'
    }).then(function (authenticated) {
        if (keycloak.authenticated && !localStorage.getItem('nome_usuario')) {
            let nomeUsuario = "";

            nomeUsuario = keycloak.idTokenParsed.name;
            document.getElementById('nome-usuario').innerText = `${nomeUsuario},`;
            localStorage.setItem('nome_usuario', nomeUsuario);
        }

        document.getElementById('logoutBtn').addEventListener('click', function () {
            keycloak.logout();
        });
    }).catch(function () {
        console.log('Failed to initialize');
    });
});