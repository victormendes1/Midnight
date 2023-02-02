# Midnight

O Midnight é onde você pode encontrar os filmes mais populares do momento e as novidades que estão para chegar.

![home](https://user-images.githubusercontent.com/44198473/216245026-e463fbad-9aa2-4533-91f2-7cb4f1af2d15.png)
![details](https://user-images.githubusercontent.com/44198473/216245011-766b8c94-5648-4597-9a7e-8b9b11d8189c.png)

Quer mais detalhes?</br>
Assista ao trailer do seu filme tão esperado ou veja os filmes similares.

![upcoming](https://user-images.githubusercontent.com/44198473/216245256-92aa92e6-ca3b-465d-b3ba-adbeb79d6d6b.png)
![search](https://user-images.githubusercontent.com/44198473/216245245-765c31f2-4ab2-44fd-acc9-139bf345ef79.png)
![trailer](https://user-images.githubusercontent.com/44198473/216245251-dd01dd5c-7c49-46ea-b779-6fff4da8b0f0.png)

Tenha um cantinho só seu, os filmes que você curtiu estarão disponiveis nesta lista de favortios.

![favorites](https://user-images.githubusercontent.com/44198473/216245379-e985ae0f-2076-4652-b2e6-8a2430fecd3b.png){width=100}
![remove](https://user-images.githubusercontent.com/44198473/216245389-b6273f1e-80dc-4fb7-accb-bcbcc661be82.png)

## Sobre o projeto  
Este app consome a API do [The Movie BD](https://www.themoviedb.org) para mostrar todas as informações.
Ainda precisa de muita refatoração, por conta do periodo para entrega não foi possível realizar todos os testes unitarios, mas tem um breve exemplo. 
Por conta da arquitetura ser algo novo, preciso estudar mais para refatorar e conseguir utilizar todo poder da arquitetura. 

## Especificações de desenvolvimento
*  Padrão de arquitetura
* VIP (Clean Architecture) 

#

## Bibliotecas 
* Kingfisher
* Lottie
* Youtube iOS Helper

#

## Ambiente 
Para uma melhor experiência abra o app em um dispositivo com o iOS 15.0 
Atualizações futuras devem corrigir algumas divergencias de layout

* Xcode 13.2.1
* iOS 15.0

#

## OBS
* Para rodar o projeto é necessario adicionar a [chave](https://www.themoviedb.org/settings/api) da API The Movie DB no Xcode. 

Ao abrir o projeto para adicionar a chave, é só clicar no ícone de "Run" + tecla Option, ir em "Arguments" e adicionar uma nova propriedade em "Environment Variables".

#

```
Name = "api_key" Value = "Sua chave da API" 
```

#