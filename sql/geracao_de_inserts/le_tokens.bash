find . -name "frases_*.txt" -exec cat {} \; | awk "NF" | awk '

BEGIN{FS="|"}

{
	print "INSERT INTO tipos_acoes (nome_tipo_acao, ) "$1" "$4" "$7" "$10" "$13; 
	print $1; 
	print $4; 
	print $7; 
	print $10; 
	print $13;  
	print "#######\n\n";
}

'
