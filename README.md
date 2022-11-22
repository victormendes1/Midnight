# Movie2You

### Sobre o projeto

Criei esse projeto com base no App [TodoMovies](https://apps.apple.com/br/app/todomovies-4/id792499896), este projeto contém somente a tela de detalhe. 
O Movie2You consome a API do The Movie BD para mostrar a tela de detalhe contendo um filme principal (utilizei o endpoint getDetails), e uma lista de filmes semelhantes (utilizei o endpoint getSimilarMovies).

Em ```develop``` possui o desenvolvimento da tela de inicio (utilizando o endpoint getPopular), também estou mudando a arquitetura do projeto para VIP, entendo que essa arquitetura é mais aplicada em grandes projetos, mas essa escolha é em pró aos estudos, conhecimento próprio e pensando em adicionar novas features futuramente. 

## Especificações de desenvolvimento
#### Design Pattern
- MVVM -> VIP

#### Bibliotecas 
- RxSwift
- Alamofire
- Moya
- Resolver
- Kingfisher
- Lottie

#### Ambiente 
- Xcode 13.2.1
- iOS 15

#### OBS
- Para rodar o projeto é necessario adicionar a [chave](https://www.themoviedb.org/settings/api) da API The Movie DB no Xcode. 
Ao abrir o projeto para adicionar a chave, é só clicar no ícone de "Run" + tecla Option, ir em "Arguments" e adicionar uma nova propriedade em "Environment Variables".

```
Name = "api_key" Value = "Sua chave da API" 
```
