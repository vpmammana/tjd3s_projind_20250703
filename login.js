document.getElementById('login-form').addEventListener('submit', function (e) {
    e.preventDefault();
    showLoading();

    const url = new URL(window.location.href);

    url.searchParams.delete("usuario");
    url.searchParams.delete("senha");
    localStorage.setItem('authenticated', 'true');
    localStorage.setItem('nome_usuario', 'Francisca Da Silva')

    if (!localStorage.getItem('terms_cond')) {
        window.location.replace("/termos.html");
    } else {
        window.location.replace("/");
    }
})

document.getElementById('dados-acesso').addEventListener('click', function () {
    alert('FUNDACENTRO\nObter dados de acesso\n\nPor favor entre em contato com a sua coordenadora ou coordenador direito para obter os dados de acesso à aplicação.')
})