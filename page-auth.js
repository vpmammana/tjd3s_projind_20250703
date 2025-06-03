const isAuth = localStorage.getItem('authenticated');
const terms_cond = localStorage.getItem('terms_cond');
//const path = window.location.pathname;

const path = window.location.pathname.replace(/^.*\//, ''); // Correção de VPM

function handlePages() {
    if (!isAuth && path !== 'login.html') {
        window.location.replace("login.html");
        return;
    }
    if (isAuth && !terms_cond) {
        if (path !== 'termos.html')
            window.location.replace("termos.html");
        return;
    }

    if (isAuth && path === 'login.html') {
        window.location.replace("/");
        return;
    }

if (terms_cond && isAuth) {
    if (path !== "" && path !== "index.html") {
        window.location.replace("./");
    }
    return;
}
}
handlePages()


