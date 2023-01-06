# Midnight

#### Sobre o projeto

Um App onde você pode ver os filmes mais populares no momento, os filmes que serão lançados, seus detalhes e assistir os trailer.
O App consome a API do [The Movie BD](https://www.themoviedb.org) para mostrar todas as informações.
Em ```develop``` possui o desenvolvimento de novas features.

## Especificações de desenvolvimento
#### Padrão de arquitetura
- VIP (Clean Architecture) 

#### Bibliotecas 
- Kingfisher
- Lottie
- Youtube iOS Helper

#### Ambiente 
- Xcode 13.2.1
- iOS 15

#### OBS
- Para rodar o projeto é necessario adicionar a [chave](https://www.themoviedb.org/settings/api) da API The Movie DB no Xcode. 
Ao abrir o projeto para adicionar a chave, é só clicar no ícone de "Run" + tecla Option, ir em "Arguments" e adicionar uma nova propriedade em "Environment Variables".

```
Name = "api_key" Value = "Sua chave da API" 
```
