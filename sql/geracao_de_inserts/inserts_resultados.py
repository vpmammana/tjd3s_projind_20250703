# Desenvolvido por Victor Mammana
# VPM 20250512 - Importante colocar na ordem de numeração, sem pulos...1 seguido de 1.X, depois 2 seguido de 2.x, e assim por diante 
# EVITE colocar símbolos como - /.... a busca nos selects ocorrerá pelo texto contido no array abaixo e esses símbolos podem prejudicar o match
import re

data = [
    [
        "Políticas Públicas Municipais de economia popular e solidária",
        "Articular e atuar na implementação e monitoramento de políticas públicas municipais de economia popular e solidária",
        "1.1",
        "Descrição da tarefa 'articular e atuar na implementação e monitoramento de políticas públicas municipais de economia popular e solidária', com foco em incidência política e realizada por gestores públicos."
    ],
    [
        "Políticas Públicas Municipais de economia popular e solidária",
        "Catalogar legislação municipal de economia popular e solidária e respectivos municípios",
        "1.2",
        "Descrição da tarefa 'catalogar legislação municipal de economia popular e solidária e respectivos municípios', com foco em diagnóstico e realizada por gestores públicos."
    ],
    [
        "Políticas Públicas Municipais de economia popular e solidária",
        "Catalogar programas municipais de economia popular e solidária e respectivos municípios",
        "1.3",
        "Descrição da tarefa 'catalogar programas municipais de economia popular e solidária e respectivos municípios', com foco em diagnóstico e realizada por gestores públicos."
    ],
    [
        "Políticas Públicas Municipais de economia popular e solidária",
        "Reuniões com gestores para discutir implementação da política pública de economia popular e solidária",
        "1.4",
        "Descrição da tarefa 'reuniões com gestores para discutir implementação da política pública de economia popular e solidária', com foco em incidência política e realizada por gestores públicos."
    ],
    [
        "Políticas Públicas Municipais de economia popular e solidária",
        "Reunir com empreendimentos para discutir papel das políticas municipais",
        "1.5",
        "Descrição da tarefa 'reunir com empreendimentos para discutir papel das políticas municipais', com foco em diagnóstico e realizada por empreendimentos economia popular e solidária."
    ],
    [
        "Políticas Públicas Municipais de economia popular e solidária",
        "Planejar formas de acesso às políticas municipais de economia popular e solidária",
        "1.6",
        "Descrição da tarefa 'planejar formas de acesso às políticas municipais de economia popular e solidária', com foco em infraestrutura/apoio e realizada por empreendimentos economia popular e solidária."
    ],
    [
        "Políticas Públicas Municipais de economia popular e solidária",
        "Monitorar o acesso às políticas municipais de economia popular e solidária",
        "1.7",
        "Descrição da tarefa 'monitorar o acesso às políticas municipais de economia popular e solidária', com foco em monitoramento/avaliação e realizada por empreendimentos economia popular e solidária."
    ],
    [
        "Políticas Públicas Municipais de economia popular e solidária",
        "Catalogar espaços de comercialização dos produtos da economia popular e solidária",
        "1.8",
        "Descrição da tarefa 'catalogar espaços de comercialização dos produtos da economia popular e solidária', com foco em infraestrutura/apoio e realizada por empreendimentos economia popular e solidária."
    ],
    [
        "Políticas Públicas Municipais de economia popular e solidária",
        "Divulgar espaços de comercialização, aproximando produtor/a-consumidor/a",
        "1.9",
        "Descrição da tarefa 'divulgar espaços de comercialização, aproximando produtor/a-consumidor/a', com foco em infraestrutura/apoio e realizada por comunidade em geral."
    ],
    [
        "Formação e Qualificação com Empreendimentos",
        "Levantar demandas de formação, qualificação e assessoramento técnico",
        "2.1",
        "Descrição da tarefa 'levantar demandas de formação, qualificação e assessoramento técnico', com foco em formação/qualificação e realizada por empreendimentos economia popular e solidária."
    ],
    [
        "Formação e Qualificação com Empreendimentos",
        "Identificar parcerias para demandas de formação nos territórios",
        "2.2",
        "Descrição da tarefa 'identificar parcerias para demandas de formação nos territórios', com foco em formação/qualificação e realizada por instituições parceiras."
    ],
    [
        "Formação e Qualificação com Empreendimentos",
        "Sistematizar as informações sobre formação/qualificação pela equipe interna",
        "2.3",
        "Descrição da tarefa 'sistematizar as informações', com foco em formação/qualificação e realizada por equipe interna."
    ],
    [
        "Formação e Qualificação com Empreendimentos",
        "Propor reuniões com instituições parceiras",
        "2.4",
        "Descrição da tarefa 'propor reuniões com instituições parceiras', com foco em formação/qualificação e realizada por instituições parceiras."
    ],
    [
        "Formação e Qualificação com Empreendimentos",
        "Realizar planejamento com parceiros sobre execução das demandas",
        "2.5",
        "Descrição da tarefa 'realizar planejamento com parceiros sobre execução das demandas', com foco em formação/qualificação e realizada por instituições parceiras."
    ],
    [
        "Formação e Qualificação com Empreendimentos",
        "Organizar a realização das atividades",
        "2.6",
        "Descrição da tarefa 'organizar a realização das atividades', com foco em formação/qualificação e realizada por empreendimentos economia popular e solidária."
    ],
    [
        "Formação e Qualificação com Empreendimentos",
        "Acompanhar atividades relativas às demandas do Programa",
        "2.7",
        "Descrição da tarefa 'acompanhar atividades relativas às demandas do programa', com foco em monitoramento/avaliação e realizada por empreendimentos economia popular e solidária."
    ],
    [
        "Formação e Qualificação com Empreendimentos",
        "Elaborar documentos sobre andamento para Senaes",
        "2.8",
        "Descrição da tarefa 'elaborar documentos sobre andamento para senaes', com foco em monitoramento/avaliação e realizada por equipe interna."
    ],
    [
        "Formação e Qualificação com Empreendimentos",
        "Sistematizar experiências exitosas nos territórios",
        "2.9",
        "Descrição da tarefa 'sistematizar experiências exitosas nos territórios', com foco em formação/qualificação e realizada por equipe interna."
    ],
    [
        "Formação e Qualificação com Empreendimentos",
        "Desenvolver cursos sobre economia popular e solidária com integrantes de coletivos",
        "2.10",
        "Descrição da tarefa 'desenvolver cursos sobre economia popular e solidária com integrantes de coletivos', com foco em formação/qualificação e realizada por coletivos economia popular."
    ],
    [
        "Formação e Qualificação com Empreendimentos",
        "Reunir com redes de educação popular para discutir relação com economia popular e solidária",
        "2.11",
        "Descrição da tarefa 'reunir com redes de educação popular para discutir relação com economia popular e solidária', com foco em mobilização e realizada por coletivos economia popular."
    ],
    [
        "Diagnósticos Territoriais",
        "Visitar empreendimentos para apresentar o Programa",
        "3.1",
        "Descrição da tarefa 'visitar empreendimentos para apresentar o programa', com foco em diagnóstico e realizada por empreendimentos economia popular e solidária."
    ],
    [
        "Diagnósticos Territoriais",
        "Reunir movimentos para dialogar sobre desafios e potencialidades",
        "3.2",
        "Descrição da tarefa 'reunir movimentos para dialogar sobre desafios e potencialidades', com foco em diagnóstico e realizada por coletivos economia popular."
    ],
    [
        "Diagnósticos Territoriais",
        "Explicar função do questionário de diagnóstico",
        "3.3",
        "Descrição da tarefa 'explicar função do questionário de diagnóstico', com foco em diagnóstico e realizada por empreendimentos economia popular e solidária."
    ],
    [
        "Diagnósticos Territoriais",
        "Realizar diagnóstico dos empreendimentos (formas organizativas, gestão, etc.)",
        "3.4",
        "Descrição da tarefa 'realizar diagnóstico dos empreendimentos (formas organizativas, gestão, etc.)', com foco em diagnóstico e realizada por empreendimentos economia popular e solidária."
    ],
    [
        "Diagnósticos Territoriais",
        "Cadastrar empreendimentos no CADSOL",
        "3.5",
        "Descrição da tarefa 'cadastrar empreendimentos no cadsol', com foco em infraestrutura/apoio e realizada por empreendimentos economia popular e solidária."
    ],
    [
        "Diagnósticos Territoriais",
        "Levantar relações dos empreendimentos com outras organizações do território",
        "3.6",
        "Descrição da tarefa 'levantar relações dos empreendimentos com outras organizações do território', com foco em diagnóstico e realizada por empreendimentos economia popular e solidária."
    ],
    [
        "Diagnósticos Territoriais",
        "Identificar programas e políticas públicas existentes no território",
        "3.7",
        "Descrição da tarefa 'identificar programas e políticas públicas existentes no território', com foco em diagnóstico e realizada por gestores públicos."
    ],
    [
        "Diagnósticos Territoriais",
        "Gerar relatórios preliminares para subsidiar decisões",
        "3.8",
        "Descrição da tarefa 'gerar relatórios preliminares para subsidiar decisões', com foco em diagnóstico e realizada por equipe interna."
    ],
    [
        "Diagnósticos Territoriais",
        "Sistematizar dados classificando demandas",
        "3.9",
        "Descrição da tarefa 'sistematizar dados classificando demandas', com foco em diagnóstico e realizada por equipe interna."
    ],
    [
        "Diagnósticos Territoriais",
        "Identificar tipos de coletivos que comercializam em feiras locais",
        "3.10",
        "Descrição da tarefa 'identificar tipos de coletivos que comercializam em feiras locais', com foco em diagnóstico e realizada por coletivos economia popular."
    ],
    [
        "Diagnósticos Territoriais",
        "Levantar tipos de produtos comercializados em feiras populares",
        "3.11",
        "Descrição da tarefa 'levantar tipos de produtos comercializados em feiras populares', com foco em diagnóstico e realizada por coletivos economia popular."
    ],
    [
        "Diagnósticos Territoriais",
        "Levantar informações sobre redes de educação popular no território",
        "3.12",
        "Descrição da tarefa 'levantar informações sobre redes de educação popular no território', com foco em diagnóstico e realizada por coletivos economia popular."
    ],
    [
        "Mobilização e Sensibilização",
        "Reunir coletivos de produção sobre organização da economia popular e solidária",
        "6.1",
        "Descrição da tarefa 'reunir coletivos de produção sobre organização da economia popular e solidária', com foco em mobilização e realizada por coletivos economia popular."
    ],
    [
        "Mobilização e Sensibilização",
        "Visitar coletivos para conversar sobre fortalecimento da economia popular e solidária",
        "6.2",
        "Descrição da tarefa 'visitar coletivos para conversar sobre fortalecimento da economia popular e solidária', com foco em mobilização e realizada por coletivos economia popular."
    ],
    [
        "Monitoramento de Ações Formativas",
        "Levantar informações do andamento das ações do Programa",
        "4.3",
        "Descrição da tarefa 'levantar informações do andamento das ações do programa', com foco em monitoramento/avaliação e realizada por equipe interna."
    ],
    [
        "Monitoramento de Ações Formativas",
        "Organizar dados para subsidiar decisões da Senaes",
        "4.4",
        "Descrição da tarefa 'organizar dados para subsidiar decisões da senaes', com foco em monitoramento/avaliação e realizada por equipe interna."
    ],
    [
        "Monitoramento de Ações Formativas",
        "Apontar formas de resolução coletiva de desafios",
        "4.5",
        "Descrição da tarefa 'apontar formas de resolução coletiva de desafios', com foco em monitoramento/avaliação e realizada por equipe interna."
    ],
    [
        "Diálogo com Movimentos de economia popular e solidária",
        "Colaborar com espaços organizativos de economia popular e solidária conforme demandas",
        "5.1",
        "Descrição da tarefa 'colaborar com espaços organizativos de economia popular e solidária conforme demandas', com foco em incidência política e realizada por conselhos/fóruns."
    ],
    [
        "Diálogo com Movimentos de economia popular e solidária",
        "Participar de reuniões de fóruns, colegiados e conselhos quando convidados",
        "5.2",
        "Descrição da tarefa 'participar de reuniões de fóruns, colegiados e conselhos quando convidados', com foco em incidência política e realizada por conselhos/fóruns."
    ],
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
