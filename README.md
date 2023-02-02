# Midnight

O Midnight é onde você pode encontrar os filmes mais populares do momento e as novidades que estão para chegar.
<img width="500" alt="home" src="https://user-images.githubusercontent.com/44198473/216310708-621c47b0-7978-464a-a680-ed7cd04a442d.png">
<img width="500" alt="detail" src="https://user-images.githubusercontent.com/44198473/216310675-596f5434-136a-4542-860f-0465db1e4bf4.png">

Quer mais detalhes?</br>
Assista ao trailer do seu filme tão esperado ou veja os filmes similares.

<p align="left">
<img width="330" alt="upcoming" src="https://user-images.githubusercontent.com/44198473/216311045-ddd8e0fd-ade0-4769-a1eb-6675efc3da91.png">
<img width="330" alt="search" src="https://user-images.githubusercontent.com/44198473/216311364-ed65a7b5-1161-41e1-b407-426d670989df.png">
<img width="330" alt="trailer" src="https://user-images.githubusercontent.com/44198473/216311035-9dcace1d-d234-4865-9bcb-d9a23d8341ba.png">
</p>

Tenha um cantinho só seu, os filmes que você curtiu estarão disponiveis nesta lista de favortios.
<img width="350" alt="favorites" src="https://user-images.githubusercontent.com/44198473/216311017-10577c56-5121-453b-bac9-5ba4b344e522.png">
<img width="350" alt="remove" src="https://user-images.githubusercontent.com/44198473/216311543-f24c4166-d48f-44e7-b523-806ec7db46f8.png">

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
