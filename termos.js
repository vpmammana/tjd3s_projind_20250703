// alert('paradinha vai termo');
const aceito = document.getElementById('aceito');
const naoAceito = document.getElementById('nao-aceito');

function handleTerms(term) {
//	alert('paradinha handle');
    showLoading();
    const formData = new FormData();
    formData.append('accept', term);

    const idPessoa = localStorage.getItem('id_pessoa');
//	alert('paradinha id_pessoa '+idPessoa);
    if (!idPessoa) {
        alert('Erro: id_pessoa não encontrado no localStorage');
        return;
    }
    formData.append('id_pessoa', idPessoa);

    fetch('php/termos.php', {
        method: 'POST',
        body: formData
    })
        .then(async (response) => {
            const jsonResponse = await response.json();
            if (!response.ok) {
                console.error('Error:', jsonResponse);
                throw { ...jsonResponse };
            }
            return jsonResponse;
        })
        .then(res => {
            if (res.success) {
                if (res.terms) {
//			alert('paradinha terms '+term);
                    localStorage.setItem('terms_accepted', term);
                    window.location.href = './';
                } else {
                    localStorage.removeItem('authenticated');
                    window.location.href = './login.html';
                }
            }
        })
        .catch(err => alert('Tenta Novamente'))
        .finally(() => showLoading());
}

aceito.addEventListener('click', function (e) {
    e.preventDefault();
    handleTerms('true');
});

naoAceito.addEventListener('click', function (e) {
    e.preventDefault();
    handleTerms('false');
});



