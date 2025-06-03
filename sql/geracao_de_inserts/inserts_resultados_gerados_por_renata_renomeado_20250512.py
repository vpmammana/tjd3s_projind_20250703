# Desenvolvido por Victor Mammana
import re


data = [
    [
         "Diagnóstico Territorial de [Economia Solidária]",
         "Levantamento de potencialidades e vocações locais do território de atuação realizado por membros do projeto",
         "1.1",
         "Identificação de oportunidades e recursos naturais, culturais e/ou econômicos locais, incluindo vocações econômicas, dados demográficos, que possam apoiar a decisão de fomentar apoiar iniciativas de [economia solidária], exceto identificação de lideranças, de movimentos sociais e de serviços públicos. Exceto modelagens."
    ],
    [
         "Diagnóstico Territorial de [Economia Solidária]",
         "Levantamento dos problemas do território de atuação realizado por membros do projeto",
         "1.2",
         "Identificação de desafios locais que possam limitar o desenvolvimento de [economia solidária], incluindo questões de infraestrutura e serviços, limitações econômicas, limitações das vocações econômicas locais, limitações demográficas, exceto questões de saúde e segurança do trabalhador."
    ],
    [
         "Diagnóstico Territorial de [Economia Solidária]",
         "Levantamento de movimentos sociais e lideranças comunitárias atuantes no território realizado por membros do projeto",
         "1.3",
         "Mapeamento das redes de apoio e liderança já presentes para colaborar com iniciativas de [economia solidária], exceto recursos naturais, culturais e ou ecônomicos locais, exceto modelagens."
    ],
    [
         "Diagnóstico Territorial de [Economia Solidária]",
         "Identificação e visitação de equipamentos públicos no território que possam apoiar a [economia solidária] realizadas por membros do projeto",
         "1.4",
         "Identificação dos serviços públicos locais, organizados na forma de administração pública de qualquer esfera, representada por escolas de qualquer nível, hospitais e centros comunitários, como informação de suporte à [economia solidária], exceto informações sobre recursos naturais, culturais e ou ecônomicos locais. Exceto informações sobre serviços que não tenham características de administração pública. Exclui a etapa posterior de estabelecimento de parcerias ou articulações com esses equipamentos públicos."
    ],
    [
         "Diagnóstico Territorial de [Economia Solidária]",
         "Participação de membros do projeto como ouvinte ou observador de reuniões de conselhos ou colegiados de [economia solidária] no território",
         "1.5",
         "Participação passiva em conselhos ou equivalentes de [economia solidária] para obter insights sobre políticas e práticas locais de [economia solidária], exceto treinamentos regulares e atividades educativas. Exceto a participação como conselheiro ou membro do conselho."
    ],
    [
         "Diagnóstico Territorial de [Economia Solidária]",
         "Sistematização realizada por membros do projeto das informações obtidas previamente por meio de mapeamentos e levantamentos, e construção de um diagnóstico análitico das comunidades, bem como de sua segmentação",
         "1.6",
         "Organização analítica das informações sobre os segmentos comunitários obtidas de atividades de mapeamentos e levantamentos realizados anteriormente, com vistas a apoiar e fomentar as iniciativas de [economia solidária], exceto a realização dos levantamentos e mapeamentos de informação propriamente ditos."
    ],
    [
         "Diagnóstico Territorial de [Economia Solidária]",
         "Registro em plataforma do projeto das informações, dados, diagnósticos, conhecimentos, testemunhos, evidências que tenham sido levantados pelos membros do projeto",
         "1.7",
         "Arquivamento digital na plataforma do projeto por membros do projeto dos diagnósticos para análises futuras e monitoramento, com registro de fotos, documentos, frases descritivas, pdfs, data do evento. Não envolve a análise dos dados registrados."
    ],
    [
         "Diagnóstico Territorial de [Economia Solidária]",
         "Identificação por membros do projeto de iniciativas de [economia solidária] no território por membros do projeto",
         "1.8",
         "Identificação e mapeamento de iniciativas de [economia solidária], exceto modelagem dessas iniciativas. Exceto o mapeamento de instituições públicas, de oportunidades e vocações ou movimentos sociais que podem apoiar a economia solidária. Exceto a identificação de barreiras para a realização de [economia solidária]."
    ],
    [
         "Diagnóstico Territorial de [Economia Solidária]",
         "Identificação por membros do projeto de iniciativas de plataformização digital para [economia solidária]",
         "1.9",
         "Identificação e mapeamento de iniciativas digitais que estejam sendo usadas para beneficiar a [economia solidária], exceto modelagem dessas iniciativas."
    ],
    [
         "Diagnóstico Territorial de [Economia Solidária]",
         "Modelagem realizada por membros do projeto das iniciativas de [economia solidária], identificadas previamente no território, que tenha ênfase na modelagem de negócios, redes e cadeias produtivas, cabendo a modelagem de qualquer forma de atividade de economia solidária que vise a produção de bens e/ou serviços, bem como a comercialização dos mesmos, mas sempre observando as características da economia solidária",
         "1.10",
         "Deve envolver integral ou parcialmente métodos de modelagem de negócios, incluindo estudos sobre viabilidade econômica, sustentabilidade econômica, retornos, dinâmica de negócios, tributação, obrigações, entre outros, incluindo a modelagem de benefícios e direitos do trabalhador, incluindo a modelagem de abordagens digitais. Não deve envolver a identificação de iniciativas propriamente dita."
    ],
    [
         "Processos Formativos e Comunicação na [Economia Solidária]",
         "Participação dos membros do projeto como educandos em processos de formação continuada sobre Economia Popular e Solidária",
         "2.1",
         "Treinamentos regulares e atividades educativas para atualizar o conhecimento em [economia solidária], exceto as reuniões mais genéricas não caracterizadas como iniciativas de educação. Este item envolve a capacitação do bolsista."
    ],
    [
         "Processos Formativos e Comunicação na [Economia Solidária]",
         "Oferta e realização, pelos membros do projeto, de formação voltada para a qualificação de integrantes de empreendimentos de Economia Popular e Solidária, agentes de economia solidária, membros do projeto, trabalhadores e trabalhadoras de economia solidária no âmbito do [Programa Manuel Querino] de Qualificação, incluindo conteúdos de economia solidária, que deve ser citada em todas as frases. Execução do [Projeto Educar para Cooperar] no âmbito do SEBRAE para realização de qualificações e assessoramento técnico para empreendimentos solidários",
         "2.2",
         "Capacitação de integrantes das iniciativas de [economia solidária] locais para aprimorar suas operações sob os princípios da [economia solidária]."
    ],
    [
         "Processos Formativos e Comunicação na [Economia Solidária]",
         "Produção de materiais de comunicação para visibilidade da Economia Popular e Solidária por membros do projeto",
         "2.3",
         "Criação de materiais de divulgação para sensibilizar e informar a comunidade sobre [economia solidária], incluindo cartilhas, manuais, apostilas, audiovisuais, podcasts, videos no youtube/instagram/facebook, bem como outras redes sociais."
    ],
    [
         "Processos Formativos e Comunicação na [Economia Solidária]",
         "Distribuir materiais de comunicação no território",
         "2.4",
         "Distribuição física e digital de materiais informativos para aumentar a visibilidade da [economia solidária] local. No caso de distribuição digital essa se refere a alimentar as redes sociais digitais com os materiais produzidos, exceto a gerência das redes sociais digitais. Aqui as atividades devem se referia ao aspecto mais mecânico de distribuição dos materiais, seja fisicamente ou digitalmente."
    ],
    [
         "Processos Formativos e Comunicação na [Economia Solidária]",
         "Gerenciar redes sociais para promover a comunicação entre agentes, bolsistas e integrantes de iniciativas de [Economia Solidária]",
         "2.5",
         "Gerenciar redes sociais, grupos de whatsapp e telegram, canais de youtube, contas de instagram e facebook, dentre outras, para promover a comunicação entre os agentes de [economia solidária]. Não envolve a produção de conteúdo para as redes sociais, mas apenas a gestão das mesmas, recebendo material de quem produz."
    ],
    [
         "Processos Formativos e Comunicação na [Economia Solidária]",
         "Implementação do [Programa Paul Singer]",
         "2.6",
         "Envolve atividades como lançamento de editais, seleção de agentes, definições de atividades dos agentes, criação dos sistemas de acompanhamento e controle e restringe-se ao Programa de Formação Paul Singer de Agentes Populares de Economia Popular e Solidária que deve ser referido com o token substantivo próprio [Programa Paul Singer]."
    ],
    [
         "Processos Formativos e Comunicação na [Economia Solidária]",
         "Promover a formação dos integrantes de iniciativas de [economia solidária] no cadastro de suas iniciativas no CADSOL",
         "2.7",
         "Refere-se exclusivamente à formação para o cadastro de iniciativas de economia solidária no CADSOL."
    ],
    [
         "Identificação e cadastramento de Iniciativas no CADSOL",
         "Identificação de iniciativas de Economia Popular e Solidária que não estão cadastradas oficialmente no CADSOL",
         "3.1",
         "Identificação de iniciativas de [economia solidária] que ainda não estão cadastradas oficialmente. Não inclui ações de sensibilização e motivação para o cadastro, ou ações de mobilização e organização para criação de iniciativas de [economia solidária], muito menos ações para efetivar o cadastro. Não envolve o trabalho de diagnóstico de iniciativas existentes no território, que precisa ter sido feito previamente."
    ],
    [
         "Identificação e cadastramento de Iniciativas no CADSOL",
         "Identificação de redes locais que colaboram com a [economia solidária] mas que não estão cadastradas oficialmente no CADSOL",
         "3.2",
         "Mapeamento de redes locais que colaboram com a [economia solidária], mas que não estejam cadastradas no CADSOL. Não envolve a promoção de criação das redes propriamente ditas, nem o incentivo para o cadastro. Refere-se exclusivamente à identificação das redes não cadastradas e não envolve o trabalho de diagnóstico de redes existentes no território, que precisa ter sido feito previamente."
    ],
    [
         "Identificação e cadastramento de Iniciativas no CADSOL",
         "Incentivo ao cadastro no CADSOL para iniciativas cujo cadastro ainda não existe, conforme constatado numa etapa anterior de identificação de iniciativas não cadastradas.",
         "3.3",
         "Incentivo ao cadastro formal no CADSOL para fortalecer a presença dessas iniciativas no sistema. Não envolve as atividades de apoio ao cadastro junto aos conselhos, nem de identificação de iniciativas não cadastradas. NÃO ENVOLVE ATIVIDADES DE QUALIFICAÇÃO OU FORMAÇÂO PARA CADASTRO NO CADSOL. A formação para o cadastro no CADSOL é assunto do item 2.7 e não deve constar aqui"
    ],
    [
         "Identificação e cadastramento de Iniciativas no CADSOL",
         "Acompanhamento do processo de registro de iniciativas no CADSOL junto às instâncias pertinentes, como conselhos de [economia solidária]",
         "3.4",
         "Monitoramento contínuo do processo de registro das iniciativas e redes no CADSOL, apoiando as atividades."
    ],
    [
         "Identificação e cadastramento de Iniciativas no CADSOL",
         "Avaliação da qualidade do registro de iniciativas no CADSOL, usando como ponto de partida as informações levantadas previamente no território",
         "3.5",
         "Avaliar a qualidade dos registros que estão cadastrados no CADSOL, comparando as informações levantadas previamente no território com as informações presentes no CADSOL."
    ],
    [
         "Identificação e cadastramento de Iniciativas no CADSOL",
         "Apoio à formação de equipes gestoras do CADSOL em todo o território nacional",
         "3.6",
         "Identificação e proposição de perfis das equipes gestoras, critérios, indicadores de escolha de stake-holders, dentre outros. Apoio ao processo seletivo das equipes. Proposição de soluções  e ações para garantir a sustentabilidade das equipes gestoras. Busca de financiamento para as equipes gestoras. Criação de protocolos ou métodos de atuação das equipes gestoras."
    ],
    [
         "Fortalecimento da [Economia Solidária] no Território",
         "Mobilizar, organizar, estimular a criação e propor  iniciativas de Economia Popular e Solidária para atores do território",
         "4.1",
         "Atividades de mobilização e organização para fortalecer as iniciativas de [economia solidária] locais. Não envolve identificar iniciativas já existentes, mas aproveitar a identificação de iniciativas que porventura já tenha sido realizada."
    ],
    [
         "Fortalecimento da [Economia Solidária] no Território",
         "Fomentar redes, cadeias e arranjos produtivos de [Economia Solidária]",
         "4.2",
         "Desenvolvimento de redes e arranjos produtivos para sustentar a [economia solidária], exceto a mobilização de iniciativas de [Economia Solidária]."
    ],
    [
         "Fortalecimento da [Economia Solidária] no Território",
         "Estímulo à criação, à manutenção e ampliação de oportunidades de trabalho e acesso à renda",
         "4.3",
         "Atividades de estímulo às oportunidades de trabalho, que estejam relacionadas a empreendimentos autogestionados, organizados de forma coletiva e participativa, inclusive economia popular."
    ],
    [
         "Fortalecimento da [Economia Solidária] no Território",
         "Estabelecimento de colaboração formal, efetiva e regular com órgãos públicos em programas de desenvolvimento e combate ao desemprego e à pobreza por meio de instrumentos formais",
         "4.4",
         "Atividades de colaboração efetiva com órgãos públicos, envolvendo instrumentos formais, excluindo-se atividades informais de articulação, visitas, ou outras atividades que não envolvam a colaboração efetiva, sedimentada em avença, e regular. Não inclui a elaboração da avença propriamente dita."
    ],
    [
         "Fortalecimento da [Economia Solidária] no Território",
         "Apoio à realização de Chamada Pública para o apoio a empreendimentos de [economia solidária]",
         "4.5",
         "Apoio na concepção, definição de critérios, definição de processos e elaboração de documentos para realização de chamada pública visando o apoio a redes de [economia solidária]."
    ],
    [
         "Fortalecimento da [Economia Solidária] no Território",
         "Participação ativa em Conselhos, Assembléias, Fóruns e outras instâncias de tomada de decisão em empreendimentos de economia solidária, cooperativas, associações, redes e movimentos sociais",
         "4.6",
         "Deve envolver apenas a participação como conselheiro ou membro das instâncias decisórias coletivas, excluindo a participação como observadores e ouvinte."
    ],
    [
         "Sensibilização e Articulação Comunitária",
         "Articulação da atuação com demais agentes populares no território",
         "5.1",
         "Coordenação com outros agentes locais para promover a [economia solidária], exceto a coordenação com outros tipos de pessoas ou entidades que não sejam agentes locais."
    ],
    [
         "Sensibilização e Articulação Comunitária",
         "Apoio à participação de jovens nas conferências municipais",
         "5.2",
         "Engajamento das juventudes nas conferências, fortalecendo a voz jovem na [economia solidária], exceto as atividades que não envolvam jovens."
    ],
    [
         "Documentação das Atividades dos Bolsistas",
         "Elaboração e revisão de relatórios mensais e diários de bordo",
         "6.1",
         "Documentação detalhada das atividades e progresso mensal dos bolsistas, exceto registro de dados na plataforma do projeto. Refere-se à elaboração e revisão de relatórios, ou outros documentos equivalentes."
    ],
    [
         "Organização e Participação em Eventos",
         "Apoio à realização de eventos de [economia solidária], a exemplo de congressos, seminários, etc.",
         "7.1",
         "Apoio logístico e organizacional para eventos na área de [economia solidária], exceto feiras e conferências."
    ],
    [
         "Organização e Participação em Eventos",
         "Apoio à realização de feiras no contexto de [economia solidária], inclusive para a comercialização de produtos das atividades de [economia solidária].",
         "7.2",
         "Apoio para a realização de feiras e eventos assemelhados, exceto congressos, conferências, seminários, etc.."
    ],
    [
         "Organização e Participação em Eventos",
         "Apoio à realização das [Conferências Nacionais].",
         "7.3",
         "Apoio para a realização de Conferências Nacionais de Economia Popular e Solidária, que devem ser referidas pelo token substantivo [Conferências Nacionais], tanto no que se refere às etapas locais, quanto às estaduais e nacionais, a exemplo de educação popular, juventudes, mulheres, finanças solidárias, agroecologia, cultura, povos das águas, reciclagem, entre outros."
    ],
    [
         "Organização e Participação em Eventos",
         "Participação de membros do projeto em eventos como ouvinte ou observador, a exemplo de congressos, conferências, feiras, seminários, palestras, etc..",
         "7.4",
         "Participação em eventos como ouvinte, exceto a organização dos eventos. Exceto a participação em reuniões corriqueiras. Exceto a participação como orador, palestrante, apresentador ou equivalente."
    ],
    [
         "Organização e Participação em Eventos",
         "Participação de membros do projeto em eventos como palestrante, orador, apresentador, a exemplo de congressos, conferências, feiras, seminários, palestras, etc..",
         "7.5",
         "Participação em eventos como ouvinte, exceto a organização dos eventos. Exceto a participação em reuniões corriqueiras. Exceto a participação como ouvinte ou observador."
    ],
    [
         "Apoio aos processos intrínsecos à execução do projeto",
         "Revisão de listas de bolsistas e condições do termo de outorga, principalmente a validade de vigência dos termos de outorga de bolsas, a qualidade dos planos de trabalho e a regularidade dos relatórios de atividades, bem como a verificação dos vínculos e condições de atuação dos bolsistas, número de bolsas pagas, relatórios entregues, inadimplência na entrega de relatórios, avaliação da qualidade dos relatórios",
         "8.1",
         "Verificação dos vínculos e condições de atuação dos bolsistas."
    ],
    [
         "Apoio aos processos intrínsecos à execução do projeto",
         "Supervisão, orientação e coordenação das atividades de Secretaria-Executiva do [Conselho Nacional de Economia Solidária] - CNES",
         "8.2",
         "Exclusivamente as atividades que estiverem relacionadas à supervisão, orientação e coordenação das atividades de Secretaria-Executiva do CNES, que deve ser referido pelo token substantivado [Conselho Nacional de Economia Solidária]."
    ],
    [
         "Apoio aos processos intrínsecos à execução do projeto",
         "Apoio à elaboração e celebração de instrumentos públicos ou de qualquer natureza legal (avenças), com vistas a buscar sinergias institucionais e financiamento",
         "8.3",
         "Este item se refere à fase de elaboração e celebração de instrumentos públicos ou de qualquer natureza legal, tais como convênios, TEDs, ACTs, contratos, acordos, emendas parlamentares, etc., exceto a articulação, identificação de oportunidades, negociação, elaboração de minutas, revisão de minutas, etc., que devem realizadas previamente."
    ],
    [
         "Desenvolvimento e Avaliação de Políticas Públicas",
         "Proposição e revisão de minutas de normativos e pareceres técnicos",
         "9.1",
         "Análise, proposição e revisão de propostas normativas para a [economia solidária], exceto a elaboração de convêncios, ACTs, contratos e acordos. Refere-se exclusivamente a normativos (portarias, decretos, etc.) ou pareceres técnicos."
    ],
    [
         "Desenvolvimento e Avaliação de Políticas Públicas",
         "Análise e modelagem de políticas públicas para [economia solidária]",
         "9.2",
         "Elaboração de estudos e modelos sobre políticas públicas para a [economia solidária], nas esferas municipais, estaduais e federais. Não inclui a modelagem de negócios de qualquer natureza, restringindo-se à modelagem de políticas públicas. Não inclui modelagem de iniciativas de empreendimentos de [economia solidária]."
    ],
    [
         "Desenvolvimento e Avaliação de Políticas Públicas",
         "Definir características das atividades de coordenação da política de economia popular e solidária",
         "9.3",
         "Definições sobre as atividades de coordenação da política de economia popular e solidária."
    ],
    [
         "Desenvolvimento e Avaliação de Políticas Públicas",
         "Articular com representações da sociedade civil que contribuem para a determinação de diretrizes e prioridades nas políticas públicas de [economia solidária]",
         "9.4",
         "Exclusivamente atividades de articulação de políticas públicas, não envolvendo articulação de parceriais ou de iniciativas de economia solidária."
    ],
    [
         "Desenvolvimento e Avaliação de Políticas Públicas",
         "Apoio à concepção e implantação de políticas públicas para o pagamento de benefícios por meio de bancos comunitários, cooperativas de crédito solidário, com instrumentos de finanças solidárias",
         "9.5",
         "Apoio à concepção e implantação de políticas públicas para o pagamento de benefícios por meio de bancos comunitários, cooperativas de crédito solidário e outros instrumentos de finanças solidárias, excluindo outros aspectos não relacionados."
    ],
    [
         "Desenvolvimento e Avaliação de Políticas Públicas",
         "Apoio na elaboração da lei que cria a [Política Nacional de Economia Solidária] (PNES)",
         "9.6",
         "Apoio à concepção, ideação, estudos sobre a sociedade, estudos sobre a legalidade, bem como elaboração e revisão de minutas, com vistas a fomentar a discussão sobre como deveria ser a PNES, que deve ser referida por um token sustantivo único dado por [Política Nacional de Economia Solidária]."
    ],
    [
         "Desenvolvimento e Avaliação de Políticas Públicas",
         "Apoio na elaboração da lei que cria moedas sociais",
         "9.7",
         "Apoio à concepção, ideação, estudos sobre a sociedade, estudos sobre a legalidade, bem como elaboração e revisão de minutas, com vistas a fomentar a discussão sobre a criação de moedas sociais. Exclui qualquer outro aspecto que não esteja relacionado à criação de moedas sociais."
    ],
    [
         "Apoio à manutenção, recuperação ou desenvolvimento de sistemas de TI e Aplicativos",
         "Apoiar ou atuar no desenvolvimento de sistemas de TI para [economia solidária], com participação em qualquer etapa da engenharia de software: do levantamento de requisitos, etnografia, desenvolvimento de personas, especificação, codificação, testes, implantação à manutenção, etc.",
         "10.1",
         "Esta atividade pode incluir codificação em qualquer linguagem, modelagem do tipo MER, descrição da base de dados, especificação em ponto de função, especificação de rotinas de teste, colocar os produto de TI em produção, preparação de infraestruturas, desenvolvimento da documentação."
    ],
    [
         "Apoio à manutenção, recuperação ou desenvolvimento de sistemas de TI e Aplicativos",
         "Gerenciar equipes de software.",
         "10.2",
         "Aqui cabem descrições sobre as atividades de gerenciamento das equipes de software, com ou sem metodolia definida (scrum, ágil, PMBOK, etc)."
    ],
    [
         "Apoio à manutenção, recuperação ou desenvolvimento de sistemas de TI e Aplicativos",
         "Gestão do Cadastro Nacional de Iniciativas e Empreendimentos de [Economia Solidária] - CADSOL",
         "10.3",
         "Exclusivamente atividades que enolvam a gestão do cadastro nacional de iniciativas e empreendimentos de [economia solidária] no ambiente de produção."
    ],
    [
         "Inovação para [Economia Solidária]",
         "Desenvolver resultados inovadores para potencializar [economia solidária]",
         "11.1",
         "Proposição de novos métodos e ferramentas para ampliar o impacto da [economia solidária], com vistas a reorganizar as bases da [economia solidária]."
    ],
    [
         "Inovação para [Economia Solidária]",
         "Apresnetação por membros do projeto sobre oportunidades de pesquisa em tecnologias sociais e saberes comunitários para serem desenvolvidas com as informações levantadas previamente no território, com vistas a fortalecer a [economia solidária]",
         "11.2",
         "Identificação e indicação de temas de pesquisa sobre tecnologias e conhecimentos locais para fortalecer a [economia solidária], exceto modelagens de negócio, levantamentos, mapeamentos e identificações. A pesquisa deve ser no contexto de produzir inovações."
    ],
    [
         "Inovação para [Economia Solidária]",
         "Submissão de artigos científicos, patentes, registros de softwares, etc., bem como qualquer publicação bibliográfica típica do universo acadêmico, incluindo teses, dissertações, monografias, papers, reviews, editoração de revistas científicas, membro de corpo editorial, referee de revistas científicas, etc.",
         "11.3",
         "Não inclui material de divulgação, apostilas, ou qualquer outra produção relacionada à educação."
    ],
    [
         "Sensibilização sobre Saúde e Segurança do Trabalhador no âmbito da [Economia Solidária]",
         "Oferecer capacitação em saúde e segurança do trabalhador para iniciativas de [economia solidária]",
         "12.1",
         "Capacitação em saúde e segurança para assegurar condições seguras nas iniciativas de [economia solidária], exceto gestão de segurança no sentido mais amplo."
    ],
    [
         "Sensibilização sobre Saúde e Segurança do Trabalhador no âmbito da [Economia Solidária]",
         "Propor e desenvolver métodos e ferramentas para melhorar as condições de saúde e segurança do trabalhador nas iniciativas de [economia solidária]",
         "12.2",
         "Propor e desenvolver métodos e ferramentas para saúde e segurança do trabalhador, exceto a proposição de normas regulamentadoras."
    ],
    [
         "Sensibilização sobre Saúde e Segurança do Trabalhador no âmbito da [Economia Solidária]",
         "Promover estudos sobre normas regulamentadoras nacionais e seus equivalentes internacionais de saúde e segurança do trabalhador no contexto da [economia solidária]",
         "12.3",
         "Os estudos devem estar restritos à questão das normas regulamentadoras tanto nacionais quanto os equivalentes internacionais."
    ],
    [
         "Sensibilização sobre Saúde e Segurança do Trabalhador no âmbito da [Economia Solidária]",
         "Mapeamento, levantamento e diagnóstico analítico dos riscos à saúde e segurança do trabalhador nas iniciativas de [economia solidária] a partir das classificações consolidadas de riscos de acidentes e ameaças à saúde do trabalhador",
         "12.4",
         "Envolve o mapeamento de riscos de acidentes de ameaças à saúde do trabalhador no âmbito da [economia solidária], usando como base os riscos e ameaças que já são de conhecimento da comunidade da área."
    ],
    [
         "Sensibilização sobre Saúde e Segurança do Trabalhador no âmbito da [Economia Solidária]",
         "Propor novas normas regulametadoras para saúde e segurança do trabalhador no contexto da [economia solidária]",
         "12.5",
         "Proposição de novas normas regulamentadoras para saúde e segurança do trabalhador, exceto qualquer outro tipo de norma que não esteja relacionada diretamente ao mundo do trabalho."
    ],
    [
         "Sensibilização sobre Saúde e Segurança do Trabalhador no âmbito da [Economia Solidária]",
         "Promover pesquisas sobre saúde e segurança do trabalhador no contexto da [economia solidária]",
         "12.6",
         "As pesquisas não devem envolver o mapeamento de riscos da atividade específica no território, mas concentrar-se em estudos sobre saúde e segurança do trabalhador no contexto das ameaças e vulnerabilidades ainda desconhecidas nos campos químicos, físicos,  mecânicos, cognitivos, sensoriais, motores, ergonômicos, de higiene, etc., buscando novas informações para completar os mapas de riscos já existentes."
    ],
    [
         "Sensibilização sobre Saúde e Segurança do Trabalhador no âmbito da [Economia Solidária]",
         "Promover a capacitação em gestão de segurança do trabalho para agentes e trabalhadores envolvidos com iniciativas de [economia solidária]",
         "12.7",
         "Capacitação em gestão de segurança do trabalho para agentes e trabalhadores envolvidos com iniciativas de [economia solidária], concentrando-se na questão da gestão e não tratando de áreas específicas da saúde e segurança do trabalhador."
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
