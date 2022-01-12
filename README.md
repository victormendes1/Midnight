# Movie2You

### Sobre o projeto

Criei esse projeto com base no App [TodoMovies](https://apps.apple.com/br/app/todomovies-4/id792499896), este projeto contém somente a tela de detalhe (futuramente irei extender o restante). 
O Movie2You consome a API do The Movie BD para mostrar a tela de detalhe contendo um filme principal (utilizei o endpoint getMovieDetails), e uma lista de filmes semelhantes (utilizei o endpoint getSimilarMovies).


## Especificações de desenvolvimento
### Design Pattern
- MVVM 

### Bibliotecas 
- RxSwift
- Alamofire
- Moya
- Resolver
- Kingfisher
- Lottie

### Ambiente 
- Xcode 13.2.1
- iOS 15

### OBS
- Para rodar o projeto é necessario adicionar a [chave](https://www.themoviedb.org/settings/api) da API The Movie DB no Xcode. 
Ao abrir o projeto para adicionar a chave, é só clicar no ícone de "Run" + tecla Option, ir em "Arguments" e adicionar uma nova propriedade em "Environment Variables".

```
Name = "api_key" Value = "Sua chave da API" 
```

## Resultado final 
No momento não adicionei testes, estou estudando o assunto e futuramente adicionarei como melhoria.
O nome do app é referência a Mobile2You que propôs esse projeto como desafio e gostaria demostrar como curti esse projeto, adicionei uma animação ao ícone de like. 👀
