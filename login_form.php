<?php 
include "./php/database.php";

if(isset($_POST['usuario']) || isset($_POST['senha'])){
    if(strlen($_POST['usuario']) == 0){
        echo "Preencha email";
    }
    else if(strlen($_POST['senha'])==0){
        echo "Preencha senha";
    } else {
        $user = $conn->real_escape_string($_POST['usuario']);
        $senha = $conn->real_escape_string($_POST['senha']);

        $sql_code = "SELECT * FROM USUARIO WHERE USERNAME='$user' LIMIT 1";

        $sql_query = $conn->query($sql_code) or die("Falha na conexao" . $conn->error);

        $usuario = $sql_query->fetch_assoc();

        if(password_verify($senha, $usuario['SENHA'])){

            if(!isset($_SESSION)){
                session_start();
            }

            $_SESSION['user'] = $usuario['USERNAME'];

            header("Location: index.php");
        } else {
            echo "Erro ao buscar usuario";
        }
    }
}

?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="/autentica_mobile.js"></script>

    <link rel="icon" href="/assets/fundacentro-16x16.png" sizes="16x16" type="image/png">
    <link rel="icon" href="/assets/fundacentro-32x32.png" sizes="32x32" type="image/png">
    <link rel="icon" href="/assets/fundacentro-64x64.png" sizes="64x64" type="image/png">

    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <link rel="manifest" href="/manifest.json">
    <script src="https://cdn.jsdelivr.net/npm/keycloak-js@22.0.3/dist/keycloak.min.js"></script>
    <!-- <script type="text/javascript" src="./keycloak-script.js"></script> -->
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="login.css">
    <title>TJD3S</title>
</head>

<body id="login-page">
    <div id="loading">
        <div class="loader-container">
            <div class="loader" id="loader"></div>
        </div>
    </div>
    <div id="notificationBox" class="notification-box">
        <span class="close" onclick="hideNotification()">&times;</span>
        <p>Deseja abrir a pasta de imagens ou usar a câmera?</p>
        <button onclick="handleChoice('folder')">Abrir pasta de imagens</button>
        <button onclick="handleChoice('camera')">Usar câmera</button>
    </div>
    <div class="top-header">
        <img src="/assets/top-logo.svg" alt="top-logo">
        <span class="top-header-phrase">Trabalho Justo, Digno, Solidário, Saudável e Seguro</span>
    </div>
    <div class="header">
        <div class="header-icon">
            <img src="/assets/fundacentro.png" alt="fundacentro">
        </div>
        <div class="header-text">
            <span>Registro de Ação</span>
        </div>
    </div>
    <section class="login-banner-section">
        <div class="banner-image2">
            <div class="banner-image-img2">
                <img src="/assets/logo-formacao.svg" alt="logo-formacao">
            </div>
        </div>
    </section>
    <section class="form-section">
        <form id="login-form" action="" method="POST">
            <div class="form-atividade">
                <div class="form-atividade-inputs">
                    <h2 id="acesso-header">Acesso</h2>

                    <div class="form-row-1">
                        <div class="form-input">
                            <label for="usuario">Usuário</label>
                            <input type="text" id="usuario" name="usuario" placeholder="seuemail@conato.com">
                        </div>

                        <div class="form-input">
                            <label for="senha">Senha</label>
                            <input type="password" id="senha" name="senha" placeholder="123456">
                        </div>
                    </div>
                </div>
            </div>
            <div class="form-section2">
                <div class="form-section2a">
                    <div class="submit">
                        <button>Entrar</button>
                    </div>
                    <div id="dados-acesso">
                        <span>Não recebi meus dados de acesso</span>
                    </div>
                </div>
            </div>
        </form>
    </section>

    <div class="footer">
        <div class="contatos">
            <h3>Endereços e contato:</h3>
            <a href="https://www.gov.br/fundacentro/pt-br">gov.br/fundacentro</a>
            <a href="https://www.gov.br/trabalho-e-emprego/pt-br">gov.br/trabalho-e-emprego</a>
            <span>selecao0124@fundacentro.gov.br</span>
        </div>
        <div>
            <img src="/assets/footer-logo.svg" alt="footer-logo">
        </div>
    </div>
    <script src="shared.js"></script>
    <script src="login.js"></script>
</body>

</html>
