# Midnight

O Midnight é onde você pode encontrar os filmes mais populares do momento e as novidades que estão para chegar.</br>
<img width="240" alt="home" src="https://user-images.githubusercontent.com/44198473/224747429-d741702d-6b2e-4152-931a-39bd267359e1.png">
<img width="250" alt="popularSearch" src="https://user-images.githubusercontent.com/44198473/224748694-ed569ac1-255b-4013-ac2d-04a022fa410f.png">
<img width="250" alt="details" src="https://user-images.githubusercontent.com/44198473/224747412-e76f4782-6735-4355-8615-83e1f492d302.png">

Quer mais detalhes?</br>
Assista ao trailer do seu filme tão esperado ou veja os filmes similares.

<p align="left">
<img width="250" alt="upcoming" src="https://user-images.githubusercontent.com/44198473/224746366-47b486a9-ff57-4dc7-866e-63f6af0e2a69.png">
<img width="250" alt="upcomingSearch" src="https://user-images.githubusercontent.com/44198473/224746374-20de8f82-176d-4d7e-81cb-f1fcb0b3efeb.png">
<img width="250" alt="trailer" src="https://user-images.githubusercontent.com/44198473/224746344-5e0ea7eb-37b6-4988-9d2d-164361d4b5fc.png">
</p>

<p align="left">
Tenha um cantinho só seu, os filmes que você curtiu estarão disponiveis nesta lista de favortios.</br>
<img width="250" alt="favorites" src="https://user-images.githubusercontent.com/44198473/224745768-2da1f173-fe0c-44b9-8ba9-cc5e55fbe348.png">
<img width="250" alt="favoritesDelete" src="https://user-images.githubusercontent.com/44198473/224745787-d9a12565-c8f8-4bdf-b5f8-26e258af8735.png">
</p>

## Sobre o projeto  
Este app consome a API do [The Movie BD](https://www.themoviedb.org) para mostrar todas as informações.
Ainda precisa de refatoração, estou adicioando os testes unitarios, mas tem um breve exemplo no projeto. 
Por conta da arquitetura ser algo novo, preciso estudar mais para refatorar e conseguir utilizar todo potencial dela. 

## Especificações de desenvolvimento
*  Padrão de arquitetura
* VIP (Clean Architecture) 

## Bibliotecas 
* Kingfisher
* Lottie
* Youtube iOS Helper

## Ambiente 
Para uma melhor experiência abra o app em um dispositivo com o iOS 15.0.</br>
Atualizações futuras devem corrigir algumas divergencias de layout.

* Xcode 13.2.1
* iOS 15.0

## OBS
* Para rodar o projeto é necessario adicionar a [chave](https://www.themoviedb.org/settings/api) da API The Movie DB no Xcode. 

Ao abrir o projeto para adicionar a chave, é só clicar no ícone de "Run" + tecla Option, ir em "Arguments" e adicionar uma nova propriedade em "Environment Variables".

```
Name = "api_key" Value = "Sua chave da API" 
```
