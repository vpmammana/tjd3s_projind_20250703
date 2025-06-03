<?php
include 'identifica.cripto.php';

$conn = new mysqli($servername, $username, $password, $dbname);
$conn->set_charset("utf8mb4");

// Inserção da nova mensagem
if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $nome_mensagem = $_POST["nome_mensagem"];
    $texto_mensagem = $_POST["texto_mensagem"];
    $id_usuario_remetente = $_POST["id_usuario_remetente"] !== '-1' ? intval($_POST["id_usuario_remetente"]) : null;
    $id_usuario_destinatario = $_POST["id_usuario_destinatario"] !== '-1' ? intval($_POST["id_usuario_destinatario"]) : null;

    $stmt = $conn->prepare("INSERT INTO mensagens (nome_mensagem, texto_mensagem, id_usuario_remetente, id_usuario_destinatario) VALUES (?, ?, ?, ?)");
    $stmt->bind_param("ssii", $nome_mensagem, $texto_mensagem, $id_usuario_remetente, $id_usuario_destinatario);
    $stmt->execute();
    $stmt->close();
}

// Lista mensagens
$sql = "SELECT m.*, u.nome_usuario as nome_usuario_remetente, p.nome_pessoa as nome_pessoa_remetente, u2.nome_usuario as nome_usuario_destinatario, p2.nome_pessoa as nome_pessoa_destinatario
        FROM mensagens m
        LEFT JOIN usuarios u ON m.id_usuario_remetente = u.id_chave_usuario
        LEFT JOIN usuarios u2 ON m.id_usuario_destinatario = u2.id_chave_usuario
        LEFT JOIN pessoas p ON u.id_pessoa = p.id_chave_pessoa
        LEFT JOIN pessoas p2 ON u2.id_pessoa = p2.id_chave_pessoa
        ORDER BY m.data_mensagem DESC";
$mensagens = $conn->query($sql);

// Carrega usuários com pessoas vinculadas
$usuarios_remetentes = $conn->query("
    SELECT u.id_chave_usuario, CONCAT(p.nome_pessoa, ' (', u.nome_usuario, ')') AS nome
    FROM usuarios u
    JOIN pessoas p ON u.id_pessoa = p.id_chave_pessoa WHERE u.pode_msg = 'sim'
    ORDER BY p.nome_pessoa
");
$usuarios_destinatarios = $conn->query("
    SELECT u.id_chave_usuario, CONCAT(p.nome_pessoa, ' (', u.nome_usuario, ')') AS nome
    FROM usuarios u
    JOIN pessoas p ON u.id_pessoa = p.id_chave_pessoa 
    ORDER BY p.nome_pessoa
");
?>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Mensagens</title>
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    <style>
        table { border-collapse: collapse; width: 100%; }
        th, td { padding: 8px 12px; border: 1px solid #ccc; }
    </style>
</head>
<body>
    <h1>Mensagens</h1>

    <form method="POST">
        <label>Título:</label><br>
        <input type="text" name="nome_mensagem" required><br><br>

        <label>Mensagem:</label><br>
        <textarea name="texto_mensagem" rows="4" cols="60" required></textarea><br><br>

        <label>Remetente:</label><br>
        <select id="id_usuario_remetente" name="id_usuario_remetente" style="width: 300px;">
	    <?php
		$usuarios_remetentes_array = [];
		while ($row = $usuarios_remetentes->fetch_assoc()) {
		    $usuarios_remetentes_array[] = $row;
		}
		$usuarios_destinatarios_array = [];
		while ($row = $usuarios_destinatarios->fetch_assoc()) {
		    $usuarios_destinatarios_array[] = $row;
		}
	    ?>
            <?php foreach($usuarios_remetentes_array as $row): ?>
                <option value="<?= htmlspecialchars($row["id_chave_usuario"]) ?>">
                    <?= htmlspecialchars($row["nome"]) ?>
                </option>
            <?php endforeach; ?>
        </select><br><br>
        <label>Destinatário:</label><br>
        <select id="id_usuario_destinatario" name="id_usuario_destinatario" style="width: 300px;">
	<option value="-1">Todos</option>
            <?php foreach ($usuarios_destinatarios_array as $row): ?>
                <option value="<?= htmlspecialchars($row["id_chave_usuario"]) ?>">
                    <?= htmlspecialchars($row["nome"]) ?>
                </option>
            <?php endforeach; ?>
        </select><br><br>

        <button type="submit">Enviar Mensagem</button>
    </form>

    <h2>Mensagens Existentes</h2>
    <table>
        <thead>
            <tr>
                <th>Data</th>
                <th>Remetente</th>
                <th>Destinatário</th>
                <th>Título</th>
                <th>Mensagem</th>
            </tr>
        </thead>
        <tbody>
            <?php while ($msg = $mensagens->fetch_assoc()): ?>
                <tr>
                    <td><?= htmlspecialchars($msg["data_mensagem"]) ?></td>
                    <td><?= $msg["id_usuario_remetente"] ? htmlspecialchars($msg["nome_pessoa_remetente"] . ' (' . $msg["nome_usuario_remetente"] . ')') : 'Todos' ?></td>
                    <td><?= $msg["id_usuario_destinatario"] ? htmlspecialchars($msg["nome_pessoa_destinatario"] . ' (' . $msg["nome_usuario_destinatario"] . ')') : 'Todos' ?></td>
                    <td><?= htmlspecialchars($msg["nome_mensagem"]) ?></td>
                    <td><?= nl2br(htmlspecialchars($msg["texto_mensagem"])) ?></td>
                </tr>
            <?php endwhile; ?>
        </tbody>
    </table>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    <script>
$('#id_usuario_remetente').select2({
    placeholder: "Escolha um remetente",
    allowClear: true,
    matcher: function(params, data) {
        if (!data.text) return null;

        const term = params.term ? params.term.toLowerCase() : "";
        const text = data.text.toLowerCase();

        return text.includes(term) ? data : null;
    }
});

$('#id_usuario_destinatario').select2({
    placeholder: "Escolha um destinatário",
    allowClear: true,
    matcher: function(params, data) {
        if (!data.text) return null;

        const term = params.term ? params.term.toLowerCase() : "";
        const text = data.text.toLowerCase();

        if (
            text.includes(term) ||
            ["todos", "*", "qualquer", "geral", "nenhum"].includes(term)
        ) {
            return data;
        }

        return null;
    }
});
    </script>
</body>
</html>

