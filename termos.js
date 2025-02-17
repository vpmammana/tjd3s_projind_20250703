const aceito = document.getElementById('aceito');
const naoAceito = document.getElementById('nao-aceito');

function handleTerms(term) {
    showLoading();
    const formData = new FormData();
    formData.append('accept', term)
    fetch('/php/termos.php', {
        method: 'POST',
        body: formData
    })
        .then(async (response) => {
            const jsonResponse = await response.json(); // Parse the response as JSON

            if (!response.ok) {
                throw {
                    ...jsonResponse
                }
            }
            return jsonResponse
        })
        .then(res => {
            if (res.success) {
                if (res.terms) {
                    localStorage.setItem('terms_cond', term);
                    window.location.href = '/'
                } else {
                    localStorage.removeItem('authenticated');
                    window.location.href = '/login.html'
                }

            }
        })
        .catch(err => alert('Tenta Novamente'))
        .finally(() => showLoading())

}
aceito.addEventListener('click', function (e) {
    e.preventDefault();
    handleTerms('true')

})

naoAceito.addEventListener('click', function (e) {
    e.preventDefault();
    handleTerms('false')
})