<?php

$arquivos = glob("frases_tarefa_*_grupo_*.csv");

foreach ($arquivos as $arquivo) {
    $linhas = file($arquivo, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
    $contador = array_count_values($linhas);
    $repetidas = array_filter($contador, fn($count) => $count > 1);

    if (!empty($repetidas)) {
        echo "$arquivo\n";
        foreach ($repetidas as $linha => $quantidade) {
            echo "\t$linha\n";
        }
        echo "\n";
    }
}
