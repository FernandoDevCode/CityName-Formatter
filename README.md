<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
<h1>Como solucionei um problema que a União Europeia e a Apple criaram?&#127822;</h1>
Com o Regulamento Geral sobre a Proteção de Dados criado pela União Europeia,conhecida mundialmente como GDPR (no Brasil temos a LGPD,inspirada na GDPR),a atualização do iOS 14 que praticamente obrigou a META a seguir a GDPR e o fim do suporte para cookies de terceiros por parte de navegadores e plataformas(efeito do GDPR),houve mudanças significativas na forma como os dados dos usuários são coletados e tratados. <br></br>
Anteriormente, o Facebook e outras plataformas podiam coletar automaticamente uma série de informações dos usuários que acessavam anúncios,agora eles não podem mais, deixando essa responsabilidade nas mãos dos anunciantes.

Os anunciantes têm a possibilidade de coletar esses dados diretamente dos usuários e enviá-los para as plataformas de anúncios, como o Facebook, utilizando métodos alternativos, como Advanced Matching usando API de Conversões (Conversions API).
<br></br>
O problema é que é um processo tão complexo de se fazer para um usuário comum,que faz muitos anunciantes acreditarem que inserir esses dados em suas campanhas de anúncios da META é impossível, e é ai que a minha história começa!

<h1>STAPE.io</h1>
O método mais comum para executar tudo isso é usando a plataforma da Stape.io junto ao Google Tag Manager(GTM).<br>
<br>
O stape coleta os dados que o Facebook não coleta mais e envia para o GTM, para que lá o anunciante faça o tratamento de dados corretamente e envie finalmente ao facebook, para alimentar a inteligência de suas campanhas de anúncios dentro da plataforma META (Facebook e Instagram).<br></br>

<img src="https://github.com/user-attachments/assets/8d9f8e78-75c5-4cba-9a17-bbcd627f085b" alt="Descrição da Imagem">


<h1>O GRANDE PROBLEMA:</h1>

A maioria dos parâmetros que vieram da stape funcionaram, mas teve um que não funcionava 100% das vezes, esse parâmetro é o responsável por receber o nome de todas as cidades dos visitantes do site do anunciante.




<h2>O Parâmetro : X-GEO- CITY</h2>

<img>![image](https://github.com/user-attachments/assets/97ef798f-f625-4406-82ed-73d53340a200)</img>

<p>Por algum motivo, quando havia qualquer acento no nome da cidade, como em " Santo Andr<mark>é</mark> " o nome da cidade chegava para o GTM com caracteres estranhos ("Ã©"),o que inviabilizava o envio desse parâmetro para a Meta. Em vez de ajudar na inteligência de dados, isso poderia prejudicar a análise, tornando os dados menos confiáveis.</p>


<h1>O primeiro passo para a solução!</h1>
Ao pesquisar mais afundo descobri que aqueles caracteres estranhos são causados quando um caractere acentuado como "é" em UTF-8 (que é representado por dois bytes) é interpretado incorretamente como se estivesse em ISO-8859-1 (que é capaz de interpretar no máximo 1 byte por caractere), ou seja a stape estava enviando os dados sempre em ISO-8859-1.
<br></br>
Explorei toda a plataforma da Stape.io mas não encontrei um jeito de trocar a codificação dos dados,então me concentrei em traduzir esses dados assim que chegassem no Google Tag Manager.


<h1>Dentro do Google Tag Manager</h1>
<br></br>
<div align="center">Dentro do conteiner Server Side, pensei em procurar um modelo de variável que transformasse a codificação ISO-8859-1 para UTF-8<br></br>
<img src="https://github.com/user-attachments/assets/4386ee4d-e5e1-4c85-83df-4b6f826211bb">
<br></br>
Depois de passar por milhões de variáveis tendo que ler uma por uma <b>(inclusive as que estavam em chinês)</b> e entender o que cada uma fazia, descobri que...
<br></br>
<br></br>
<img src="https://pa1.aminoapps.com/6815/c5d42ffab0a558ea1380635f59d56153d8148d9b_hq.gif">
<h3><b>✨NÃO EXISTE NENHUM MODELO DE VARIÁVEL que faça essa tradução de codificação!!✨</b></h3></div>
<br></br>
<h1><b>O plano B</b></h1>

<h2>Se não existe, então crie!</h2>
<div align="center">Foi um processo bem legal,criar o meu primeiro modelo de variável GTM Server Side,pois o GTM é algo bem diferente,<br>(Não é só código,como estamos acostumados).<br></br><br></br>
<img src="https://github.com/user-attachments/assets/aa5a3787-ec33-4e3f-a9e5-0943a70e4d2a"></div>
A documentação do GTM é um pouco confusa e não me ajudou muito, o JavaScript do qual podemos usar é bastante limitado (SandBox), então acabei tendo que aprender algumas coisas a partir do código das variáveis que já estavam escritas pelas empresas parceiras do Google,as mesmas que mostrei agora pouco.
<br>

<h1>A primeira descoberta</h1>
Eu precisava entender como incluir em meu código a variável da cidade, recebida via HTTP Request através do Stape.<br></br>
<div align="center"><img src="https://github.com/user-attachments/assets/eeeb102f-0f18-46f6-8aa3-e29c1ddfa1f4">
(Tipo...como eu acesso isso?)</div>

<br></br>
<br></br>

Após estudar alguns códigos de modelos prontos da galeria do google,eu descobri como eu acesso não só a variável da cidade mas qualquer outra variável enviada para meu GTM Server, e assim nasce as 2 primeiras linhas do meu código:<br>
<div align="center"><img src="https://github.com/user-attachments/assets/6c9cbfca-f1a4-4f64-8656-69ef4c2a66a1"></div>

<h1>Finalizando o código</h1>
Com acesso a variável da cidade,eu precisava apenas transformar ISO-8859-1 para UTF-8<br></br>
A primeira coisa que me veio à mente foi usar o <b>TextDecoder</b> e <b>TextEncoder</b> no JavaScript para fazer todo o processo de transformação das codificações e por fim retornar o X-GEO-CITY como UTF-8 (Perfeito!😁)
<br></br>
<h2>Se não fosse por um detalhe...</h2>

![0814](https://github.com/user-attachments/assets/0f620cab-f20f-4888-a353-4568a65ee7b8)
<div align="center"><b>O JavaScript SandBox Limita quase tudo, **incluindo as APIs** de Decoder e Encoder</b><br>
Por isso o erro acima😫
</div>


<h1>Como se fosse a primeira vez...</h1>

Assim fui obrigado a escrever o código como se estivesse novamente nas primeiras semanas aprendendo programação<br> 
(Tive que codar o mais simples possivel).
<br></br>
<h2>Para isso...</h2>

Abri um codificador/decodificador online de ISO-8859-1 para UTF-8 (vice-versa) e, com isso, identifiquei os caracteres correspondentes em ISO-8859-1 para cada acento usado em nosso idioma (UTF-8), incluindo o "ç".

Em seguida, apliquei a seguinte lógica de "se" e "então":
<br></br>
<blockquote>Verifique cada caractere na variável `cityName`. Se identificar "Ã©" (ISO-8859-1), converta-o para "é" (UTF-8). Após finalizar a verificação de todos os caracteres, retorne `cityName` com todas as substituições efetuadas. Dessa forma, garantimos que a variável estará em UTF-8, sem erros de acentuação, eliminando qualquer risco de prejudicar a inteligência das campanhas de anúncios do nosso cliente.
</blockquote>

<br></br>
<h2>O código final ficou assim:</h2>
<img src="https://github.com/user-attachments/assets/ec515026-b5ce-4df7-a513-97ff9f8005d8">

</body>


