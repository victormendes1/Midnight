# inChurch Recruitment Process 2021 - iOS Developer

Nessa parte do processo de recrutamento você desenvolverá uma aplicação iOS. O desafio deve ser desenvolvido em Swift e utilizando libs conhecidas de mercado. A aplicação será um catálogo dos filmes populares, utilizando a [API](https://developers.themoviedb.org/3/getting-started/introduction) do [TheMovieDB](https://www.themoviedb.org/).

* * *

## Requisitos

+ ### O que deve ter:
	* Tela de Home com duas abas:
		- **Filmes:** Um grid exibindo os filmes melhores classificados. Utilizar esse [endpoint](https://developers.themoviedb.org/3/movies/get-popular-movies).
		- **Favoritos:** Uma listagem dos filmes marcados como favorito.
	* Loading no carregamento da listagem de filmes.
	* Tela de tratamento de erros(falta de internet e erro na api) na tela de Filmes.
	* Tela de detalhe do filme. Para as informações de gêneros do filme, utilize esse [endpoint](https://developers.themoviedb.org/3/genres/get-movie-list).
	* Ação de favoritar um filme na tela de detalhe. Todo o controle será em armazenamento local.
	
#
+ ### Pontos extras:
	* Paginação com scroll infinito na tela de filmes.
	* Filtro de busca pelo nome do filme na tela de Favoritos. Exibir uma tela diferente para quando não houver resultado na busca.
	* Ação de remover o filme da lista de Favoritos.
	* Testes unitários.
	* Testes funcionais.
	
#
* * *

## Sugestão de layout

Para facilitar a sua vida, padronizar e explorar algumas habilidades suas, estamos disponibilizando um mockup para que você possa segui-lo. Lembre-se, você pode(e deve) mudar cor, tipo e tamanho de fonte, ícones e outras coisa que fizerem sentido, mas não esqueça de seguir a estrutura proposta.  

![Alt text](https://bitbucket.org/inradar/inchurch-ios-challenge/raw/16a4cbc5d6a811d1ed9659c50e465273a593a3a0/images/home_movies_loading.png) ![Alt text](https://bitbucket.org/inradar/inchurch-ios-challenge/raw/16a4cbc5d6a811d1ed9659c50e465273a593a3a0/images/home_movies.png) ![Alt text](https://bitbucket.org/inradar/inchurch-ios-challenge/raw/16a4cbc5d6a811d1ed9659c50e465273a593a3a0/images/home_movies_error.png)

![Alt text](https://bitbucket.org/inradar/inchurch-ios-challenge/raw/16a4cbc5d6a811d1ed9659c50e465273a593a3a0/images/home_favorites_empty.png) ![Alt text](https://bitbucket.org/inradar/inchurch-ios-challenge/raw/16a4cbc5d6a811d1ed9659c50e465273a593a3a0/images/home_favorites.png) ![Alt text](https://bitbucket.org/inradar/inchurch-ios-challenge/raw/16a4cbc5d6a811d1ed9659c50e465273a593a3a0/images/home_favorites_search_not_found.png) 

![Alt text](https://bitbucket.org/inradar/inchurch-ios-challenge/raw/16a4cbc5d6a811d1ed9659c50e465273a593a3a0/images/movie_detail.png)

* * *

## O que devo fazer?

* Realizar o fork desse repositório.
* Desenvolver a aplicação usando as melhores práticas de desenvolvimento e totalmente em inglês. 
* Sobrescreva o README falando sobre o que foi utilizado na arquitetura e libs - com uma pequena explicação das decisões adotadas.
* Enviar seu pull request para o nosso repositório quando finalizar.

* * *

## O que será avaliado?

* Qualidade do código.
* Organização do projeto.
* Arquitetura utilizada.
* Boas práticas de desenvolvimento iOS.
* Crash-safe code, consumo de memória e desempenho. 

***É uma avaliação, desenvolva o projeto com qualidade de produção. ;)**

* * *

## Alguma dúvida?

* E-mail: fernando.lima@inchurch.com.br