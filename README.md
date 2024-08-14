<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
<h1>Como a União Européia e a Apple me deram um emprego sem nem saberem que eu existo?&#x1F1EA;&#x1F1FA;</h1>
Com o Regulamento Geral sobre a Proteção de Dados,conhecida mundialmente como GDPR (no brasil temos a LGPD),a atualização do iOS 14 que praticamente obrigou a META a seguir a GDPR e o fim do suporte para cookies de terceiros por parte de navegadores e plataformas,houve mudanças significativas na forma como os dados dos usuários são coletados e tratados. Anteriormente, o Facebook e outras plataformas podiam coletar automaticamente uma série de informações dos usuários que acessavam anúncios, como a cidade de origem, utilizando cookies de terceiros. No entanto, com as novas regulamentações e o crescente foco na privacidade dos dados, isso deixou de ser possível.

Agora, os anunciantes têm a responsabilidade de coletar esses dados diretamente dos usuários e enviá-los para as plataformas de anúncios, como o Facebook, utilizando métodos alternativos, como a API de Conversões (Conversions API).


O método mais comum para isso é usando a plataforma da Stape.io junto ao Google Tag Manager(GTM).
Que coleta os dados que o facebook não coleta mais e envia para o GTM, para que lá o anunciante faça o tratamento de dados corretamente e envie finalmente ao facebook, para alimentar a intenligência de suas campanhas de anuncios dentro da plataforma META(facebook e instagram).




<h1>O GRANDE PROBLEMA:</h1>

A maioria dos parâmetros que vieram da stape funcionaram, mas teve um que não funcionava 100% das vezes, esse parâmetro é o do nome das cidades.




<h2>O Parâmetro : X-GEO- CITY</h2>

<img>![image](https://github.com/user-attachments/assets/97ef798f-f625-4406-82ed-73d53340a200)</img>

<p>Por algum motivo, quando havia qualquer acento no nome da cidade, como em " Santo Andr<mark>é</mark> " o nome da cidade chegava para o GTM com caracteres estranhos,o que inviabilizava o envio desse parâmetro para a Meta. Em vez de ajudar na inteligência de dados, isso poderia prejudicar a análise, tornando os dados menos confiáveis.</p>


<h1>O primeiro passo para a solução!</h1>
Ao pesquisar mais afundo descobri que aqueles caracteres estranhos são causados quando um caractere acentuado como "é" em UTF-8 (que é representado por dois bytes) é interpretado incorretamente como se estivesse em ISO-8859-1 (que interpretra no máximo 1 byte por caractere), ou seja a stape estava enviando os dados sempre em ISO-8859-1.

Mexi dentro da plataforma Stape.io e não encontrei um jeito de trocar a codificação dos dados,então me concentrei em traduzir esses assim que chegarem no Google Tag Manager.






</body>



