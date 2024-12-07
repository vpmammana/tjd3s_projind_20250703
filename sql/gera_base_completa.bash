echo "Gerando base de dados completa"
echo "Limpando arquivos temporarios"

rm -f ./geracao_de_inserts/frases_temp*
rm -f ./geracao_de_inserts/insert_tokens.sql
rm -f insert_resultados.sql
rm -f insert_frases.sql


# voce pode mudar o nome do arquivo no for para o que desejari, POR EXEMPLO: for arquivo in frases_gpt/frases_8*.txt; do

echo "Copiando arquivos de frases_* presentes no diretório frases_gpt para geracao_de_inserts com o nome frases_temp_*"
for arquivo in frases_gpt/frases_*.txt; do
    cp "$arquivo" "./geracao_de_inserts/${arquivo/frases_gpt\/frases_/frases_temp_}"
done

echo "Corrigindos erros gerados pelo GPT nas frases"
./geracao_de_inserts/troca_feminino_por_masculino.bash

echo "Gerando inserts de resultados"
python3 ./geracao_de_inserts/inserts_resultados.py > insert_resultados.sql

echo "Gerando inserts de frases"
./geracao_de_inserts/insert_tokens_unicos_no_sql.bash

echo "Copiando arquivo insert_tokens.sql para a raiz do projeto"
cp -f ./geracao_de_inserts/insert_tokens.sql .

echo "Numero de linhas do arquivo insert_tokens.sql: "
cat insert_tokens.sql | wc -l

echo "Gerando inserts de frases"
./geracao_de_inserts/insert_frases.bash > insert_frases.sql

echo "Criando banco de dados e inserindo dados"
echo "Criando banco de dados papedins_db"
mysql -u root -proot papedins_db < cria_banco_mvp.sql
echo "Inserindo tipos_resultados"
mysql -u root -proot papedins_db < insert_resultados.sql 
echo "Inserindo dados"
mysql -u root -proot papedins_db < insert_dados.sql 
echo "Inserindo tokens"
mysql -u root -proot papedins_db < insert_tokens.sql 
echo "Inserindo frases"
mysql -u root -proot papedins_db < insert_frases.sql

