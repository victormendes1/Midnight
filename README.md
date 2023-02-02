# Midnight

<p align="left">
O Midnight é onde você pode encontrar os filmes mais populares do momento e as novidades que estão para chegar.

<p align="left">
<img width="310" alt="home" src="https://user-images.githubusercontent.com/44198473/216233575-e2708616-460e-4097-857e-248849e58e1d.png">
<img width="310" alt="detail" src="https://user-images.githubusercontent.com/44198473/216233589-a2997924-4d6c-4623-a9ca-cbc44c482ed3.png">
</p>

<p align="left">
Quer mais detalhes?</br>
Assista ao trailer do seu filme tão esperado ou veja os filmes similares.
</p>

<p align="left">
<img width="310" alt="upcoming" src="https://user-images.githubusercontent.com/44198473/216233662-455aaf1a-c4af-4d6d-9227-ce8f6ed02e28.png">
<img width="310" alt="search" src="https://user-images.githubusercontent.com/44198473/216233734-9256da3b-dd5a-4cf6-983c-66df5913f8fc.png">
<img width="310" alt="trailer" src="https://user-images.githubusercontent.com/44198473/216233635-302ee2f4-db87-4f2a-8dc8-68c9f297f84a.png">
</p>

<p align="left">
Tenha um cantinho só seu, os filmes que você curtiu estarão disponiveis nesta lista de favortios.
<img width="310" alt="favorites" src="https://user-images.githubusercontent.com/44198473/216234394-7b12a244-c16c-4e25-bdf1-3ba0f52816ab.png">
<img width="310" alt="remove" src="https://user-images.githubusercontent.com/44198473/216234407-35dcd077-d48e-4384-8268-82747f1f681f.png">
</p>

## Sobre o projeto  
Este app consome a API do [The Movie BD](https://www.themoviedb.org) para mostrar todas as informações.
Ainda precisa de muita refatoração, por conta do periodo para entrega não foi possível realizar todos os testes unitarios, mas tem um breve exemplo. 
Por conta da arquitetura ser algo novo, preciso estudar mais para refatorar e conseguir utilizar todo poder da arquitetura. 

## Especificações de desenvolvimento
#### Padrão de arquitetura
- VIP (Clean Architecture) 

#### Bibliotecas 
- Kingfisher
- Lottie
- Youtube iOS Helper

#### Ambiente 
Para uma melhor experiência abra o app em um dispositivo com o iOS 15.0 
Atualizações futuras devem corrigir algumas divergencias de layout
- Xcode 13.2.1
- iOS 15.0

#### OBS
- Para rodar o projeto é necessario adicionar a [chave](https://www.themoviedb.org/settings/api) da API The Movie DB no Xcode. 
Ao abrir o projeto para adicionar a chave, é só clicar no ícone de "Run" + tecla Option, ir em "Arguments" e adicionar uma nova propriedade em "Environment Variables".

```
Name = "api_key" Value = "Sua chave da API" 
```
