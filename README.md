# inChurch Recruitment Process 2021 - iOS Developer

Nessa parte do processo de recrutamento voc� desenvolver� uma aplica��o iOS. O desafio deve ser desenvolvido em Swift e utilizando libs conhecidas de mercado. A aplica��o ser� um cat�logo dos filmes populares, utilizando a [API](https://developers.themoviedb.org/3/getting-started/introduction) do [TheMovieDB](https://www.themoviedb.org/).

* * *

## Requisitos

+ ### O que deve ter:
	* Tela de Home com duas abas:
		- **Filmes:** Um grid exibindo os filmes melhores classificados. Utilizar esse [endpoint](https://developers.themoviedb.org/3/movies/get-popular-movies).
		- **Favoritos:** Uma listagem dos filmes marcados como favorito.
	* Loading no carregamento da listagem de filmes.
	* Tela de tratamento de erros(falta de internet e erro na api) na tela de Filmes.
	* Tela de detalhe do filme. Para as informa��es de g�neros do filme, utilize esse [endpoint](https://developers.themoviedb.org/3/genres/get-movie-list).
	* A��o de favoritar um filme na tela de detalhe. Todo o controle ser� em armazenamento local.
	
#
+ ### Pontos extras:
	* Pagina��o com scroll infinito na tela de filmes.
	* Filtro de busca pelo nome do filme na tela de Favoritos. Exibir uma tela diferente para quando n�o houver resultado na busca.
	* A��o de remover o filme da lista de Favoritos.
	* Testes unit�rios.
	* Testes funcionais.
	
#
* * *

## Sugest�o de layout

Para facilitar a sua vida, padronizar e explorar algumas habilidades suas, estamos disponibilizando um mockup para que voc� possa segui-lo. Lembre-se, voc� pode(e deve) mudar cor, tipo e tamanho de fonte, �cones e outras coisa que fizerem sentido, mas n�o esque�a de seguir a estrutura proposta.  

![Alt text](https://bitbucket.org/inradar/inchurch-ios-challenge/raw/16a4cbc5d6a811d1ed9659c50e465273a593a3a0/images/home_movies_loading.png) ![Alt text](https://bitbucket.org/inradar/inchurch-ios-challenge/raw/16a4cbc5d6a811d1ed9659c50e465273a593a3a0/images/home_movies.png) ![Alt text](https://bitbucket.org/inradar/inchurch-ios-challenge/raw/16a4cbc5d6a811d1ed9659c50e465273a593a3a0/images/home_movies_error.png)

![Alt text](https://bitbucket.org/inradar/inchurch-ios-challenge/raw/16a4cbc5d6a811d1ed9659c50e465273a593a3a0/images/home_favorites_empty.png) ![Alt text](https://bitbucket.org/inradar/inchurch-ios-challenge/raw/16a4cbc5d6a811d1ed9659c50e465273a593a3a0/images/home_favorites.png) ![Alt text](https://bitbucket.org/inradar/inchurch-ios-challenge/raw/16a4cbc5d6a811d1ed9659c50e465273a593a3a0/images/home_favorites_search_not_found.png) 

![Alt text](https://bitbucket.org/inradar/inchurch-ios-challenge/raw/16a4cbc5d6a811d1ed9659c50e465273a593a3a0/images/movie_detail.png)

* * *

## O que devo fazer?

* Realizar o fork desse reposit�rio.
* Desenvolver a aplica��o usando as melhores pr�ticas de desenvolvimento e totalmente em ingl�s. 
* Sobrescreva o README falando sobre o que foi utilizado na arquitetura e libs - com uma pequena explica��o das decis�es adotadas.
* Enviar seu pull request para o nosso reposit�rio quando finalizar.

* * *

## O que ser� avaliado?

* Qualidade do c�digo.
* Organiza��o do projeto.
* Arquitetura utilizada.
* Boas pr�ticas de desenvolvimento iOS.
* Crash-safe code, consumo de mem�ria e desempenho. 

***� uma avalia��o, desenvolva o projeto com qualidade de produ��o. ;)**

* * *

## Alguma d�vida?

* E-mail: fernando.lima@inchurch.com.br