document.getElementById('login-form').addEventListener('submit', function (e) {
    e.preventDefault();
    showLoading();
    const url = new URL(window.location.href);

    url.searchParams.delete("usuario");
    url.searchParams.delete("senha");
    const usuario = document.getElementById('usuario').value;
    const senha = document.getElementById('senha').value;
    const formData = new FormData();
    formData.append('usuario', usuario);
    formData.append('senha', senha);
    console.log(usuario, senha);
    fetch('./php/login.php', {
        method: 'POST',
        body: formData
    })
        .then(async (response) => {
            const jsonResponse = await response.json(); // Parse the response as JSON
            if (!response.ok) {
		    
		    console.log("não passou");
                throw {
                    ...jsonResponse
                }
            }
            hideLoading()
		    console.log("passou");

            return jsonResponse
        })
        .then((res) => {
            hideLoading()
            console.log(res)
            setTimeout(() => {
		    alert('FUNDACENTRO\n\nAguarde enquanto redirecionamos você para a aplicação.');
                localStorage.setItem('authenticated', 'true');
                localStorage.setItem('nome_usuario', res.nome_pessoa)

                if (!localStorage.getItem('terms_cond')) {
                    window.location.replace("./termos.html");
                } else {
                    window.location.replace("/");
                }

            }, 1000)
        })
        .catch(error => {
            hideLoading()

            setTimeout(function () {
                if (error.type === 'access_failure') {
                    alert('FUNDACENTRO\n\nFalha de acesso\n\nUsuário ou senha inválidos. Verifique e tente novamente.');
                }
            }, 500)

        });

})

document.getElementById('dados-acesso').addEventListener('click', function () {
    alert('FUNDACENTRO\nObter dados de acesso\n\nPor favor entre em contato com a sua coordenadora ou coordenador direito para obter os dados de acesso à aplicação.')
})
