#!/bin/bash

# corrige erros introduzidos pelo GPT nos arquivos de frases

cd "$(dirname "$0")"

#gerundio
#infinitivo
#locucao_adjetiva_plural_feminino
#locucao_adjetiva_plural_masculina
#locucao_adjetiva_singular_feminina
#locucao_adjetiva_singular_masculina
#locucao_substantiva_plural_feminino
#locucao_substantiva_plural_masculina
#locucao_substantiva_singular_feminina
#locucao_substantiva_singular_masculina
#modo
#passado
#plural_feminino
#plural_femininos
#plural_masculina
#plural_masculino
#plural_masculinos
#singular_femina
#singular_feminina
#singular_feminino
#singular_masculina
#singular_masculino



find . -type f -name "frases_temp_*" -exec sed -i 's/singular_feminina/singular_feminino/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/singular_feminina/singular_feminino/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/singular_feminina/singular_feminino/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/plural_feminina/plural_feminino/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/plural_femininos/plural_feminino/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/plural_masculina/plural_masculino/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/plural_masculinos/plural_masculino/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/singular_feminina/singular_feminino/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/singular_femina/singular_feminino/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/singular_masculina/singular_masculino/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/locucao_substantiva_singular_feminino/locucao_substantiva_singular_feminina/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/locucao_adjetiva_singular_feminino/locucao_adjetiva_singular_feminina/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/locucao_substantiva_plural_feminino/locucao_substantiva_plural_feminina/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/locucao_adjetiva_plural_feminino/locucao_adjetiva_plural_feminina/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/locucao_substantiva_singular_masculino/locucao_substantiva_singular_masculina/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/locucao_adjetiva_singular_masculino/locucao_adjetiva_singular_masculina/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/locucao_substantiva_plural_masculino/locucao_substantiva_plural_masculina/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/locucao_adjetiva_plural_masculino/locucao_adjetiva_plural_masculina/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/locucao_adjetiva_plural_feminina/plural_feminino/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/locucao_adjetiva_singular_feminina/singular_feminino/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/locucao_adjetiva_plural_masculina/plural_masculino/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/locucao_adjetiva_singular_masculina/singular_masculino/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/locucao_substantiva_plural_feminina/plural_feminino/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/locucao_substantiva_singular_feminina/singular_feminino/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/locucao_substantiva_plural_masculina/plural_masculino/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/locucao_substantiva_singular_masculina/singular_masculino/g' {} +



find . -type f -name "frases_temp_*" -exec sed -i 's/\[//g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/\]//g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|agrícola|adjetivo|singular_feminino|/|agrícola|adjetivo|singular_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|agrícola|adjetivo|singular_masculino|/|agrícola|adjetivo|singular_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|agrícolas|adjetivo|plural_feminino|/|agrícolas|adjetivo|plural_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|agrícolas|adjetivo|plural_masculino|/|agrícolas|adjetivo|plural_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|acessível|adjetivo|singular_feminino|/|acessível|adjetivo|singular_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|acessível|adjetivo|singular_masculino|/|acessível|adjetivo|singular_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|acessíveis|adjetivo|plural_feminino|/|acessíveis|adjetivo|plural_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|acessíveis|adjetivo|plural_masculino|/|acessíveis|adjetivo|plural_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|ações de comércio justo|locucao_substantiva|singular_masculino|/|ações de comércio justo|locucao_substantiva|plural_feminino|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|alvo|adjetivo|plural_feminino|/|alvo|adjetivo|singular_masculino|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|alvo|adjetivo|singular_feminino|/|alvo|adjetivo|singular_masculino|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|anteriores|adjetivo|plural_feminino|/|anteriores|adjetivo|plural_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|anteriores|adjetivo|plural_masculino|/|anteriores|adjetivo|plural_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/^apoiei|verbo|gerundio|/apoiei|verbo|passado|/g' {} + # no caso e verbo não começa com | porque é o primeiro

find . -type f -name "frases_temp_*" -exec sed -i 's/|artesanais|adjetivo|plural_feminino|/|artesanais|adjetivo|plural_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|artesanais|adjetivo|plural_masculino|/|artesanais|adjetivo|plural_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|artesanal|adjetivo|singular_feminino|/|artesanal|adjetivo|singular_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|artesanal|adjetivo|singular_masculino|/|artesanal|adjetivo|singular_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|atividades de bioconstrução|locucao_substantiva|singular_feminino|/|atividades de bioconstrução|locucao_substantiva|plural_feminino|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|atividades de bioconstrução|substantivo|singular_feminino|/|atividades de bioconstrução|locucao_substantiva|plural_feminino|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|atividades de carpintaria|substantivo|singular_feminino|/|atividades de carpintaria|locucao_substantiva|plural_feminino|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|atuantes|adjetivo|plural_feminino|/|atuantes|adjetivo|plural_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|atuantes|adjetivo|plural_masculino|/|atuantes|adjetivo|plural_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|com foco|adverbio|modo|/|com foco|locucao_adverbial|modo|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|comissão de decisões|locucao_substantiva|plural_feminino|/|comissão de decisões|locucao_substantiva|singular_feminino|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|competentes|adjetivo|plural_feminino|/|competentes|adjetivo|plural_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|competentes|adjetivo|plural_masculino|/|competentes|adjetivo|plural_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|completa|adjetivo|plural_feminino|/|completa|adjetivo|singular_feminino|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|completa|adjetivo|plural_masculino|/|completa|adjetivo|singular_feminino|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|comunitários|adjetivo|plural_feminino|/|comunitários|adjetivo|plural_masculino|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|comunitários|adjetivo|plural_masculino|/|comunitários|adjetivo|plural_masculino|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|consistentes|adjetivo|plural_feminino|/|consistentes|adjetivo|plural_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|consistentes|adjetivo|plural_masculino|/|consistentes|adjetivo|plural_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|cooperativas de reciclagem|locucao_substantiva|singular_feminino|/|cooperativas de reciclagem|locucao_substantiva|plural_feminino|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|cooperativas|locucao_substantiva|plural_feminino|/|cooperativas|substantivo|plural_feminino|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|culturais|adjetivo|plural_feminino|/|culturais|adjetivo|plural_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|culturais|adjetivo|plural_masculino|/|culturais|adjetivo|plural_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|cultural|adjetivo|singular_feminino|/|cultural|adjetivo|singular_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|cultural|adjetivo|singular_masculino|/|cultural|adjetivo|singular_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|dados culturais|locucao_substantiva|locucao_substantiva_plural_masculina|/|dados culturais|locucao_substantiva|plural_masculino|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|dados de comunidades|locucao_substantiva|plural_feminino|/|dados de comunidades|locucao_substantiva|plural_masculino|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|dados demográficos|locucao_substantiva|locucao_substantiva_plural_masculina|/|dados demográficos|locucao_substantiva|plural_masculino|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|dados de redes sociais|locucao_substantiva|plural_feminino|/|dados de redes sociais|locucao_substantiva|plural_masculino|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|dados populacionais|locucao_substantiva|locucao_substantiva_plural_masculina|/|dados populacionais|locucao_substantiva|plural_masculino|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|dados sobre horticultura|locucao_substantiva|locucao_substantiva_plural_masculina|/|dados sobre horticultura|locucao_substantiva|plural_masculino|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|detalhada|adjetivo|plural_feminino|/|detalhada|adjetivo|singular_feminino|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|detalhado|adjetivo|singular_feminino|/|detalhado|adjetivo|singular_masculino|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|digitais|adjetivo|plural_feminino|/|digitais|adjetivo|plural_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|digitais|adjetivo|plural_masculino|/|digitais|adjetivo|plural_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|digital|adjetivo|singular_feminino|/|digital|adjetivo|singular_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|digital|adjetivo|singular_masculino|/|digital|adjetivo|singular_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|documento de atividades|locucao_substantiva|singular_feminino|/|documento de atividades|locucao_substantiva|singular_masculino|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|econômicos|adjetivo|plural_feminino|/|econômicos|adjetivo|plural_masculino|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|eficaz|adjetivo|singular_feminino|/|eficaz|adjetivo|singular_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|eficaz|adjetivo|singular_masculino|/|eficaz|adjetivo|singular_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|eficazes|adjetivo|plural_feminino|/|eficazes|adjetivo|plural_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|eficazes|adjetivo|plural_masculino|/|eficazes|adjetivo|plural_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|estrutura de eventos|locucao_substantiva|plural_masculino|/|estrutura de eventos|locucao_substantiva|singular_feminino|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|estrutura de vendas|locucao_substantiva|plural_feminino|/|estrutura de vendas|locucao_substantiva|singular_feminino|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|federais|adjetivo|plural_feminino|/|federais|adjetivo|plural_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|federais|adjetivo|plural_masculino|/|federais|adjetivo|plural_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|governamentais|adjetivo|plural_feminino|/|governamentais|adjetivo|plural_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|governamentais|adjetivo|plural_masculino|/|governamentais|adjetivo|plural_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|grupos comunitários|substantivo|plural_masculino|/|grupos comunitários|locucao_substantiva|plural_masculino|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|grupos de apoio|substantivo|plural_masculino|/|grupos de apoio|locucao_substantiva|plural_masculino|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|condições dos bolsistas|locucao_substantiva|singular_feminino|/|condições dos bolsistas|locucao_substantiva|plural_feminino|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|situação dos bolsistas|locucao_substantiva|plural_feminino|/|situação dos bolsistas|locucao_substantiva|singular_feminino|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|situação dos bolsistas|locucao_substantiva|plural_masculino|/|situação dos bolsistas|locucao_substantiva|singular_feminino|/g' {} +



find . -type f -name "frases_temp_*" -exec sed -i 's/|importantes|adjetivo|plural_feminino|/|importantes|adjetivo|plural_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|importantes|adjetivo|plural_masculino|/|importantes|adjetivo|plural_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|infraestrutura de eventos|locucao_substantiva|plural_masculino|/|infraestrutura de eventos|locucao_substantiva|singular_feminino|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|infraestrutura de feiras|locucao_substantiva|plural_feminino|/|infraestrutura de feiras|locucao_substantiva|singular_feminino|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|inicial|adjetivo|singular_feminino|/|inicial|adjetivo|singular_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|inicial|adjetivo|singular_masculino|/|inicial|adjetivo|singular_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|iniciativas de ecoturismo|locucao_substantiva|singular_feminino|/|iniciativas de ecoturismo|locucao_substantiva|plural_feminino|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|iniciativas de marcenaria|locucao_substantiva|singular_feminino|/|iniciativas de marcenaria|locucao_substantiva|plural_feminino|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|iniciativas|locucao_substantiva|plural_feminino|/|iniciativas|substantivo|plural_feminino|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|integral|adjetivo|singular_feminino|/|integral|adjetivo|singular_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|integral|adjetivo|singular_masculino|/|integral|adjetivo|singular_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|levantados|adjetivo|plural_feminino|/|levantados|adjetivo|plural_masculino|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|líderes comunitários|substantivo|plural_masculino|/|líderes comunitários|locucao_substantiva|plural_masculino|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|locais|locucao_substantiva|plural_feminino|/|locais|substantivo|plural_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|locais|locucao_substantiva|singular_feminino|/|locais|substantivo|plural_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|locais|adjetivo|singular_feminino|/|locais|adjetivo|plural_feminino|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|local|adjetivo|singular_feminino|/|local|adjetivo|singular_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|local|adjetivo|singular_masculino|/|local|adjetivo|singular_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|locais|adjetivo|plural_feminino|/|locais|adjetivo|plural_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|locais|adjetivo|plural_masculino|/|locais|adjetivo|plural_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|mensal|adjetivo|singular_feminino|/|mensal|adjetivo|singular_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|mensal|adjetivo|singular_masculino|/|mensal|adjetivo|singular_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|mesa de conselhos|locucao_substantiva|plural_feminino|/|mesa de conselhos|locucao_substantiva|singular_feminino|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|motivacional|adjetivo|singular_feminino|/|motivacional|adjetivo|singular_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|motivacional|adjetivo|singular_masculino|/|motivacional|adjetivo|singular_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|nacionais|adjetivo|plural_feminino|/|nacionais|adjetivo|plural_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|nacionais|adjetivo|plural_masculino|/|nacionais|adjetivo|plural_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|nacional|adjetivo|singular_feminino|/|nacional|adjetivo|singular_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|nacional|adjetivo|singular_masculino|/|nacional|adjetivo|singular_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|naturais|adjetivo|plural_feminino|/|naturais|adjetivo|plural_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|naturais|adjetivo|plural_masculino|/|naturais|adjetivo|plural_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|oficial|adjetivo|singular_feminino|/|oficial|adjetivo|singular_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|oficial|adjetivo|singular_masculino|/|oficial|adjetivo|singular_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|online|adjetivo|singular_feminino|/|online|adjetivo|singular_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|online|adjetivo|singular_masculino|/|online|adjetivo|singular_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|organizada|adjetivo|plural_feminino|/|organizada|adjetivo|singular_feminino|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|pertinentes|adjetivo|plural_feminino|/|pertinentes|adjetivo|plural_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|pertinentes|adjetivo|plural_masculino|/|pertinentes|adjetivo|plural_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|popular|adjetivo|singular_feminino|/|popular|adjetivo|singular_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|popular|adjetivo|singular_masculino|/|popular|adjetivo|singular_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|populares|adjetivo|plural_feminino|/|populares|adjetivo|plural_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|populares|adjetivo|plural_masculino|/|populares|adjetivo|plural_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|preparação de edital|locucao_substantiva|singular_feminino|/|preparação de edital|locucao_substantiva|singular_masculino|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|presentes|adjetivo|plural_feminino|/|presentes|adjetivo|plural_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|presentes|adjetivo|plural_masculino|/|presentes|adjetivo|plural_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|processo de inscrição|locucao_substantiva|singular_feminino|/|processo de inscricao|locucao_substantiva|singular_masculino|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|produção agrícola|substantivo|singular_feminino|/|produção agrícola|locucao_substantiva|singular_feminino|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|redes de apoio comunitário|substantivo|plural_feminino|/|redes de apoio comunitário|locucao_substantiva|plural_feminino|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|redes de apoio|substantivo|plural_feminino|/|redes de apoio|locucao_substantiva|plural_feminino|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|redes de colaboração|substantivo|plural_feminino|/|redes de colaboração|locucao_substantiva|plural_feminino|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|redes de suporte|substantivo|plural_feminino|/|redes de suporte|locucao_substantiva|plural_feminino|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|regionais|locucao_substantiva|singular_feminino|/|regionais|substantivo|plural_feminino|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|regionais|locucao_substantiva|plural_feminino|/|regionais|substantivo|plural_feminino|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|regionais|adjetivo|singular_feminino|/|regionais|adjetivo|plural_feminino|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|regionais|adjetivo|plural_feminino|/|regionais|adjetivo|plural_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|regionais|adjetivo|plural_masculino|/|regionais|adjetivo|plural_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|regional|adjetivo|singular_feminino|/|regional|adjetivo|singular_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|regional|adjetivo|singular_masculino|/|regional|adjetivo|singular_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|regulares|adjetivo|plural_feminino|/|regulares|adjetivo|plural_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|regulares|adjetivo|plural_masculino|/|regulares|adjetivo|plural_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|relevantes|adjetivo|plural_feminino|/|relevantes|adjetivo|plural_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|relevantes|adjetivo|plural_masculino|/|relevantes|adjetivo|plural_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|responsáveis|adjetivo|plural_feminino|/|responsáveis|adjetivo|plural_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|responsáveis|adjetivo|plural_masculino|/|responsáveis|adjetivo|plural_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|rural|adjetivo|singular_feminino|/|rural|adjetivo|singular_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|rural|adjetivo|singular_masculino|/|rural|adjetivo|singular_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|semanal|adjetivo|singular_feminino|/|semanal|adjetivo|singular_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|semanal|adjetivo|singular_masculino|/|semanal|adjetivo|singular_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|seminário de finanças|locucao_substantiva|plural_feminino|/|seminário de finanças|locucao_substantiva|singular_feminino|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|significativos|adjetivo|plural_feminino|/|significativos|adjetivo|plural_masculino|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|sob estudo|adjetivo|singular_masculino|/|sob estudo|locucao_adjetiva|singular_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|completo|adjetivo|singular_feminino|/|completo|adjetivo|singular_masculino|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|sob estudo|adjetivo|singular_masculino|/|sob estudo|locucao_adjetiva|singular_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|sob estudo|locucao_adjetiva|singular_masculino|/|sob estudo|locucao_adjetiva|singular_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|sob estudo|locucao_adjetiva|singular_feminino|/|sob estudo|locucao_adjetiva|singular_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|sob foco|locucao_adjetiva|singular_feminino|/|sob foco|locucao_adjetiva|singular_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|sob foco|locucao_adjetiva|singular_masculino|/|sob foco|locucao_adjetiva|singular_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|sustentáveis|adjetivo|plural_feminino|/|sustentáveis|adjetivo|plural_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|sustentáveis|adjetivo|plural_masculino|/|sustentáveis|adjetivo|plural_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|sustentável|adjetivo|singular_feminino|/|sustentável|adjetivo|singular_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|sustentável|adjetivo|singular_masculino|/|sustentável|adjetivo|singular_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|territoriais|adjetivo|plural_feminino|/|territoriais|adjetivo|plural_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|territoriais|adjetivo|plural_masculino|/|territoriais|adjetivo|plural_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|urbanos|adjetivo|plural_feminino|/|urbanos|adjetivo|plural_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|urbanos|adjetivo|plural_masculino|/|urbanos|adjetivo|plural_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|virtual|adjetivo|singular_feminino|/|virtual|adjetivo|singular_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|virtual|adjetivo|singular_masculino|/|virtual|adjetivo|singular_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|voltadas para|locucao_verbal|infinitivo|/|voltadas para|locucao_adjetiva|singular_feminino|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|voltadas para|locucao_adjetiva|infinitivo|/|voltadas para|locucao_adjetiva|singular_feminino|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|de reciclagem|locucao_adjetiva|singular_masculino|/|de reciclagem|locucao_adjetiva|singular_feminino|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|de reciclagem|locucao_adjetiva|singular_masculino|/|de reciclagem|locucao_adjetiva|singular_feminino|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|em execução|locucao_adjetiva|singular_masculino|/|em execução|locucao_adjetiva|singular_feminino|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|essenciais|adjetivo|plural_feminino|/|essenciais|adjetivo|plural_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|essenciais|adjetivo|plural_masculino|/|essenciais|adjetivo|plural_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|existentes|adjetivo|plural_feminino|/|existentes|adjetivo|plural_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|existentes|adjetivo|plural_masculino|/|existentes|adjetivo|plural_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|final|adjetivo|singular_feminino|/|final|adjetivo|singular_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|final|adjetivo|singular_masculino|/|final|adjetivo|singular_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|formais|adjetivo|plural_feminino|/|formais|adjetivo|plural_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|formais|adjetivo|plural_masculino|/|formais|adjetivo|plural_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|funcional|adjetivo|singular_feminino|/|funcional|adjetivo|singular_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|funcional|adjetivo|singular_masculino|/|funcional|adjetivo|singular_comum|/g' {} +


find . -type f -name "frases_temp_*" -exec sed -i 's/|solidários|adjetivo|plural_feminino|/|solidários|adjetivo|plural_masculino|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|vigente|adjetivo|singular_feminino|/|vigente|adjetivo|singular_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|vigente|adjetivo|singular_masculino|/|vigente|adjetivo|singular_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|vigentes|adjetivo|plural_feminino|/|vigentes|adjetivo|plural_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|vigentes|adjetivo|plural_masculino|/|vigentes|adjetivo|plural_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|cadastral|adjetivo|singular_feminino|/|cadastral|adjetivo|singular_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|cadastral|adjetivo|singular_masculino|/|cadastral|adjetivo|singular_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|comercial|adjetivo|singular_feminino|/|comercial|adjetivo|singular_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|comercial|adjetivo|singular_masculino|/|comercial|adjetivo|singular_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|educacional|adjetivo|singular_feminino|/|educacional|adjetivo|singular_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|educacional|adjetivo|singular_masculino|/|educacional|adjetivo|singular_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|estruturante|adjetivo|singular_feminino|/|estruturante|adjetivo|singular_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|estruturante|adjetivo|singular_masculino|/|estruturante|adjetivo|singular_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|familiar|adjetivo|singular_feminino|/|familiar|adjetivo|singular_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|familiar|adjetivo|singular_masculino|/|familiar|adjetivo|singular_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|federal|adjetivo|singular_feminino|/|federal|adjetivo|singular_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|federal|adjetivo|singular_masculino|/|federal|adjetivo|singular_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|gerencial|adjetivo|singular_feminino|/|gerencial|adjetivo|singular_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|gerencial|adjetivo|singular_masculino|/|gerencial|adjetivo|singular_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|governamental|adjetivo|singular_feminino|/|governamental|adjetivo|singular_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|governamental|adjetivo|singular_masculino|/|governamental|adjetivo|singular_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|horizontal|adjetivo|singular_feminino|/|horizontal|adjetivo|singular_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|horizontal|adjetivo|singular_masculino|/|horizontal|adjetivo|singular_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|institucional|adjetivo|singular_feminino|/|institucional|adjetivo|singular_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|institucional|adjetivo|singular_masculino|/|institucional|adjetivo|singular_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|instrucional|adjetivo|singular_feminino|/|instrucional|adjetivo|singular_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|instrucional|adjetivo|singular_masculino|/|instrucional|adjetivo|singular_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|interinstitucional|adjetivo|singular_feminino|/|interinstitucional|adjetivo|singular_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|interinstitucional|adjetivo|singular_masculino|/|interinstitucional|adjetivo|singular_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|intermunicipal|adjetivo|singular_feminino|/|intermunicipal|adjetivo|singular_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|intermunicipal|adjetivo|singular_masculino|/|intermunicipal|adjetivo|singular_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|medicinal|adjetivo|singular_feminino|/|medicinal|adjetivo|singular_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|medicinal|adjetivo|singular_masculino|/|medicinal|adjetivo|singular_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|multissetorial|adjetivo|singular_feminino|/|multissetorial|adjetivo|singular_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|multissetorial|adjetivo|singular_masculino|/|multissetorial|adjetivo|singular_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|municipal|adjetivo|singular_feminino|/|municipal|adjetivo|singular_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|municipal|adjetivo|singular_masculino|/|municipal|adjetivo|singular_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|natural|adjetivo|singular_feminino|/|natural|adjetivo|singular_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|natural|adjetivo|singular_masculino|/|natural|adjetivo|singular_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|operacional|adjetivo|singular_feminino|/|operacional|adjetivo|singular_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|operacional|adjetivo|singular_masculino|/|operacional|adjetivo|singular_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|organizacional|adjetivo|singular_feminino|/|organizacional|adjetivo|singular_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|organizacional|adjetivo|singular_masculino|/|organizacional|adjetivo|singular_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|presencialmente|adverbio|radical|/|presencialmente|adverbio|singular_neutro|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|presencialmente|advérbio|radical|/|presencialmente|adverbio|singular_neutro|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|presencialmente|advérbio|singular_neutro|/|presencialmente|adverbio|singular_neutro|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|profissionalizante|adjetivo|singular_feminino|/|profissionalizante|adjetivo|singular_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|profissionalizante|adjetivo|singular_masculino|/|profissionalizante|adjetivo|singular_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|relevante|adjetivo|singular_feminino|/|relevante|adjetivo|singular_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|relevante|adjetivo|singular_masculino|/|relevante|adjetivo|singular_comum|/g' {} +


find . -type f -name "frases_temp_*" -exec sed -i 's/|remotamente|adverbio|radical|/|remotamente|adverbio|singular_neutro|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|remotamente|advérbio|radical|/|remotamente|adverbio|singular_neutro|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|remotamente|advérbio|singular_neutro|/|remotamente|adverbio|singular_neutro|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|setorial|adjetivo|singular_feminino|/|setorial|adjetivo|singular_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|setorial|adjetivo|singular_masculino|/|setorial|adjetivo|singular_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|territorial|adjetivo|singular_feminino|/|territorial|adjetivo|singular_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|territorial|adjetivo|singular_masculino|/|territorial|adjetivo|singular_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|tradicional|adjetivo|singular_feminino|/|tradicional|adjetivo|singular_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|tradicional|adjetivo|singular_masculino|/|tradicional|adjetivo|singular_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|vegetal|adjetivo|singular_feminino|/|vegetal|adjetivo|singular_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|vegetal|adjetivo|singular_masculino|/|vegetal|adjetivo|singular_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/|visual|adjetivo|singular_feminino|/|visual|adjetivo|singular_comum|/g' {} +
find . -type f -name "frases_temp_*" -exec sed -i 's/|visual|adjetivo|singular_masculino|/|visual|adjetivo|singular_comum|/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/EPS/economia popular e solidária/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i 's/Explicar como preencher os questionários/Explicar função do questionário de diagnóstico/g' {} +



find . -type f -name "frases_temp_*" -exec sed -i 's/|locução_/|locucao_/g' {} +

find . -type f -name "frases_temp_*" -exec sed -i -E 's/(\/a) *- *(consumidor\/a)/\1-\2/g' {} +

# comando abaixo deleta todas as linhas que tiverem menos ou mais do que 15 | (16 campos)
find . -type f -name "frases_temp_*" -exec bash -c '
for file; do
    awk -F"|" "NF == 16" "$file" > "$file.tmp" && mv "$file.tmp" "$file"
done
' bash {} +
