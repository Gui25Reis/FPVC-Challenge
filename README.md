# FPVC App
![Plataforma](https://img.shields.io/badge/plataforma-IOS-lightgrey?logo=ios)
![Framework](https://img.shields.io/badge/framework-UIKit-red?logo=uikit)
[![Swift Versão](https://img.shields.io/badge/swift-v5.5+-blue?logo=swift)](https://swift.org/download/#releases)
[![Licença](https://img.shields.io/badge/licença-GNU%20v3.0-brightgreen?)](/LICENSE)

<!-- 
![Capa]()

<p align="center">
    <a href="">
        <img src=""/>
    </a>
</p> 
-->

Uma aplicativo que consome o a api da Marvel, focando apenas no endpoint characters

- [FPVC App](#fpvc-app)
  - [Frameworks](#frameworks)
    - [Nativos](#nativos)
    - [Internos](#internos)
  - [Documentação](#documentação)
  - [Instalação](#instalação)
  - [Idiomas disponíveis](#idiomas-disponíveis)
  - [Plataforma e requerimentos](#plataforma-e-requerimentos)
  - [Licença](#licença)
  - [Autor](#autor)


## Frameworks 

### Nativos
O app foi feito sem dependências externas!


| **Framework** |   **Uso**  
|---------------|-----------
| UIKit         | Aplicação com view code
| Security      | Uso do KeyChain
| CoreData      | Dados persistentes
| Photos        | Solicitação para baixar fotos na galeria


### Internos
Foram criados módulos dentro do aplicativo!

| **Framework** |   **Uso**  
|---------------|-----------
| FPVCAssets      | Centralização dos assets utilizado na aplicação
| KingsCryptor    | Criptografia de dados
| KingsDS         | Design System
| KingsFoundation | Camada que consome o nativo
| KingsNetwork    | Realiza requests
| KingsStorage    | Armazenamento de dados/arquivos


## Documentação
A documentação está centralizada no [notion](https://kings-gui.notion.site/Investigate-453e4f5831924689b1036c4509758258?pvs=4) do projeto.
> IMPORTANTE: O link do Notion está marcado para expirar no dia 15 de Setembro de 2024!


## Instalação
Para poder utilizar o app é necessário adicionar um arquivo .plist chamado `MarvelInfos.plist`, tendo como target o `iOSApp`. O arquivo precisa ter esse dados:

| **Chave** |   **Valor**  
|---------------|-----------
| marvelPriv      | sua-chave-privada
| marvelPublic    | sua-chave-pública


## Idiomas disponíveis
|     **Idiomas**     |
|---------------------|
| Português - Brasil  |
| Inglês              |


## Plataforma e requerimentos
| **Plataforma** |   **OS**    |
|----------------|:-----------:|
iPhone           | iOS 15.5+   |


## Licença
Esse projeto é open source e licenciado pela [GNU General Public License v3.0](/LICENSE).


## Autor
<table>
    <tr>
        <td align="center">
            <a href="https://github.com/Gui25Reis">
                <img src="https://avatars1.githubusercontent.com/u/48360732" width="100px;" alt="Foto do Gui Reis no GitHub"/><br>
                <sub>
                    <b>Gui Reis</b>
                </sub>
            </a>
        </td>
    </tr>
</table>
