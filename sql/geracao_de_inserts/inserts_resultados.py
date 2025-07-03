# Desenvolvido por Victor Mammana
# VPM 20250512 - Importante colocar na ordem de numeração, sem pulos...1 seguido de 1.X, depois 2 seguido de 2.x, e assim por diante 
# EVITE colocar símbolos como - /.... a busca nos selects ocorrerá pelo texto contido no array abaixo e esses símbolos podem prejudicar o match
import re

data = [
    [
        "Diagnóstico Territorial e Reconhecimento de Iniciativas",
        "Apoiar o processo de mapeamento e cadastramento das iniciativas econômicas populares e solidárias no CADSOL",
        "1.1",
        "Descrição da tarefa 'Apoiar o processo de mapeamento e cadastramento das iniciativas', com foco em reconhecimento e cadastro de iniciativas de economia popular e solidária nos territórios."
    ],
    [
        "Diagnóstico Territorial e Reconhecimento de Iniciativas",
        "Realizar a identificação, sensibilização, mobilização e organização dos Empreendimentos de Economia Solidária e Coletivos de Economia Popular e suas redes e cadeias nos territórios",
        "1.2",
        "Descrição da tarefa 'Realizar a identificação, sensibilização, mobilização e organização dos Empreendimentos', com foco em reconhecer e articular redes e coletivos locais."
    ],
    [
        "Diagnóstico Territorial e Reconhecimento de Iniciativas",
        "Realizar Pesquisa Ação para reconhecimento das realidades das comunidades e segmentos que compõem os territórios do Programa",
        "1.3",
        "Descrição da tarefa 'Realizar Pesquisa Ação', com foco em levantamento de potencialidades, problemas e vocações territoriais."
    ],
    [
        "Educação Popular e Formação em Economia Solidária",
        "Implementar ações de formação contínua, pesquisa, extensão, assessoramento, com base na tecnologia social e nos saberes comunitários",
        "2.1",
        "Descrição da tarefa 'Implementar ações de formação contínua', com foco em educação popular e fortalecimento de capacidades técnicas e comunitárias."
    ],
    [
        "Educação Popular e Formação em Economia Solidária",
        "Promover formação continuada sobre trabalho justo, digno, seguro e saudável em empreendimentos de economia popular e solidária",
        "2.2",
        "Descrição da tarefa 'Promover formação continuada sobre trabalho digno', com foco em qualificação dos trabalhadores da economia popular e solidária."
    ],
    [
        "Incidência Política e Articulação Institucional",
        "Articular as políticas públicas e os programas sociais com os/as demais agentes populares do governo federal, estadual e municipal, fundamentado na educação popular",
        "3.1",
        "Descrição da tarefa 'Articular políticas públicas com agentes populares', com foco em articulação interinstitucional e fortalecimento da economia popular e solidária na política pública."
    ],
    [
        "Incidência Política e Articulação Institucional",
        "Organizar e promover fóruns e conselhos de Economia Popular e Solidária, fortalecendo o movimento e sua incidência na formulação de políticas públicas",
        "3.2",
        "Descrição da tarefa 'Organizar e promover fóruns e conselhos de EPS', com foco em espaços de participação social e incidência política coletiva."
    ],
    [
        "Valorização do Trabalho Justo e Digno",
        "Identificar e sensibilizar o trabalho justo, digno, seguro e saudável em empreendimentos de economia popular e solidária",
        "4.1",
        "Descrição da tarefa 'Identificar e sensibilizar para o trabalho justo, digno e seguro', com foco em direitos do trabalho e condições adequadas nos empreendimentos solidários."
    ]
]


# Variável para armazenar o valor anterior do campo 0
previous_field0 = None
conta=0
# Loop pelos dados para imprimir com formatação solicitada
for row in data:
    field0, field1, field2, field3 = row
    conta+=1
    # Imprime o campo 0 apenas se ele for diferente do anterior
    field0_limpo = field0.replace("[", "").replace("]", "");
    field1_limpo = field1.replace("[", "").replace("]", "");


    if field0 != previous_field0:
        integer_part = re.match(r"(\d+)\.\d", field2).group(1)
        print(f"\nINSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai) VALUES (\"{field0_limpo}\",\"{integer_part}\", NULL);\n", end='')
        previous_field0 = field0
    
   # Imprime os outros campos com a formatação especificada
    #print(f"\tINSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai) VALUES (\"{field1_limpo}\",\"{field2}\",(SELECT id_chave_tipo_resultado FROM tipos_resultados WHERE nome_tipo_resultado=\"{field0_limpo}\"));\n")
   #print(f"\n\nquantidade{conta}")
    
    print(f"""
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = \"{field0_limpo}\"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            \"{field1_limpo}\",
            \"{field2}\",
            @id_tipo
        );\n
    """, end='')
