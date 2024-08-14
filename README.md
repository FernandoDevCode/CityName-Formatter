<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
<h1>Como a União Européia e a Apple me deram um emprego sem nem saberem que eu existo?&#x1F1EA;&#x1F1FA;</h1>
Com o Regulamento Geral sobre a Proteção de Dados,conhecida mundialmente como GDPR (no brasil temos a LGPD),a atualização do iOS 14 que praticamente obrigou a META a seguir a GDPR e o fim do suporte para cookies de terceiros por parte de navegadores e plataformas,houve mudanças significativas na forma como os dados dos usuários são coletados e tratados. <br></br>
Anteriormente, o Facebook e outras plataformas podiam coletar automaticamente uma série de informações dos usuários que acessavam anúncios,agora eles não podem mais, deixando essa responsabilidade nas mãos dos anunciantes.

Os anunciantes têm a possibilidade de coletar esses dados diretamente dos usuários e enviá-los para as plataformas de anúncios, como o Facebook, utilizando métodos alternativos, como a API de Conversões (Conversions API).

<h1>STAPE.io</h1>
O método mais comum para isso é usando a plataforma da Stape.io junto ao Google Tag Manager(GTM).<br>
<br>
Que coleta os dados que o facebook não coleta mais e envia para o GTM, para que lá o anunciante faça o tratamento de dados corretamente e envie finalmente ao facebook, para alimentar a inteligência de suas campanhas de anúncios dentro da plataforma META(Facebook e Instagram).

<img src="https://github.com/user-attachments/assets/8d9f8e78-75c5-4cba-9a17-bbcd627f085b" alt="Descrição da Imagem">


<h1>O GRANDE PROBLEMA:</h1>

A maioria dos parâmetros que vieram da stape funcionaram, mas teve um que não funcionava 100% das vezes, esse parâmetro é o do nome das cidades.




<h2>O Parâmetro : X-GEO- CITY</h2>

<img>![image](https://github.com/user-attachments/assets/97ef798f-f625-4406-82ed-73d53340a200)</img>

<p>Por algum motivo, quando havia qualquer acento no nome da cidade, como em " Santo Andr<mark>é</mark> " o nome da cidade chegava para o GTM com caracteres estranhos ("Ã©"),o que inviabilizava o envio desse parâmetro para a Meta. Em vez de ajudar na inteligência de dados, isso poderia prejudicar a análise, tornando os dados menos confiáveis.</p>


<h1>O primeiro passo para a solução!</h1>
Ao pesquisar mais afundo descobri que aqueles caracteres estranhos são causados quando um caractere acentuado como "é" em UTF-8 (que é representado por dois bytes) é interpretado incorretamente como se estivesse em ISO-8859-1 (que interpretra no máximo 1 byte por caractere), ou seja a stape estava enviando os dados sempre em ISO-8859-1.
<br></br>
Mexi dentro da plataforma Stape.io e não encontrei um jeito de trocar a codificação dos dados,então me concentrei em traduzir esses assim que chegarem no Google Tag Manager.


<h1>Dentro do Google Tag Manager</h1>
<br></br>
<div align="center">Dentro do conteiner Server Side, pensei em procurar um modelo de variável que transformasse a codificação ISO-8859-1 dos dados recebidos da stape para UTF-8<br></br>
<img src="https://github.com/user-attachments/assets/4386ee4d-e5e1-4c85-83df-4b6f826211bb">
<br></br>
Depois de passar por milhões de variáveis tendo que ler uma por uma <b>(inclusive as que estavam em chinês)</b> e entender o que cada uma fazia, descobri que...
<br></br>
<br></br>
<img src="https://pa1.aminoapps.com/6815/c5d42ffab0a558ea1380635f59d56153d8148d9b_hq.gif">
<h3><b>NÃO EXISTE NENHUM MODELO DE VARIÁVEL que faça essa tradução de codificação</b></h3></div>
<br></br>
<h1><b>O plano B</b></h1>

<h2>Se não existe, então crie!</h2>

Foi um processo bem legal,criar o meu primeiro modelo de variável GTM Server Side,pois é bem diferente.<br>
A documentação é um pouco confusa, o JavaScript que podemos usar é bastante limitado (SandBox), então acabei tendo que aprender algumas coisas a partir do código das variáveis que já estavam escritas pelas empresas parceiras do Google,as mesmas que mostrei agora pouco.
<br>


</body>


