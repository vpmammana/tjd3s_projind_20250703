const logoutBtn = document.getElementById('logoutBtn')

//if (logoutBtn) {
//    logoutBtn.addEventListener('click', function (e) {
//        localStorage.removeItem('nome_usuario');
//        localStorage.removeItem('authenticated');
//        localStorage.removeItem('terms_cond');
//        window.location.href = "/login.html"
//    });
//
//}

function showLoading() {
    document.getElementById("loading").style.display = "block";
}

function hideLoading() {
    document.getElementById("loading").style.display = "none";
}
