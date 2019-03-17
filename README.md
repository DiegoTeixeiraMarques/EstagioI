# O que é?

Este é um jogo desenvolvido em **[Corona](https://docs.coronalabs.com/)** para disciplina de Estágio I da **[Universidade Sete de Setembro](https://www.uni7.edu.br/)**.

## Descrição do jogo...

### Nome

>Resgate dos Bichos.

### Gênero

>Aventura.

### Objetivo Geral

>Resgatar os animais em extinção o mais rápido possível.

### Objetivo Específico

>Controlar o jogador principal pelo cenário em busca das chaves para liberar as jaulas em que estão os animais. Cada jaula só pode ser aberta com sua chave específica. É necessário evitar contato com os caçadores que estarão andando pelo território.

### Enredo e personagens

>Existe uma área usada por caçadores para prender 
animais em extinção no Brasil. Joe, um habitante das proximidades da área e amante de bichos resolve se aventurar neste cenário e resgatar o máximo de animais possível, mas seu tempo é curto e os animais dependerão de sua agilidade para não serem extintos.
- **Personagens**

  - [Joe (personagem principal)](https://drive.google.com/open?id=1HpktowbjDTLrPSbdgYumgZDmEZsy75SK)
  - [Caçadores (inimigos)](https://drive.google.com/open?id=10zQ5OSvCkUTpR6BeyL3HXcUuOYZ6g7_4)
  - **[Animais em extinção no Brasil](https://www.pensamentoverde.com.br/meio-ambiente/animais-em-extincao-no-brasil/)**
    - Arara Azul
    - Lobo-guará
    - Macaco-aranha
    - Onça-pintada
    - Guaruba
    - Mico-leão-dourado
    - Tartaruga-oliva

### Iteração do jogador

> O jogador precisa ter agilidade para desviar dos caçadores, memorizar o cenário no decorrer do jogo para encontrar as 7 chaves e liberar os animais presos nas jaulas.

### Controles

>O jogador utilaza controles para andar pelo cenário, um botão para consultar a intensidade em que ocorre a extinção, um botão para selecionar a chave e outro para abrir a jaula dos animais.

### Diagrama de navegação

... Em Construção
- **Telas de jogo**
  - Em construção...

### Regras do jogo

>O jogador precisa coletar as chaves e liberar os animais nas jaulas evitando contato com os caçadores. Cada jaula só pode ser aberta por uma chave específica na qual o jogador escolhe para acionar o comando de abertura. Caso não seja a chave correta será apresentada uma mensagem informando o fato. Caso a chave esteja correta o animal é liberado e caminha pelo cenário procurando uma saída. O jogador precisa executar esta ação num tempo máximo de 5:00 minutos. Após a conclusão do tempo ou abertura de todas as jaulas, o jogo é redirecionado a uma tela que representa a fuga e só estarão nesta tela os animais que foram resgatados a tempo.

- **Sistema de pontuação**
> O jogo começa com 100 animais de cada espécie e com o passar do tempo este número decresce com ritmos diferentes para cada animal. No final do jogo a pontuação do jogador será calculada pela seguinte fórmula: 

#### `número de bichos restantes + nível de vida x 10`

- **Sistema de vidas**

> O jogador começa com 3 corações que representam o número de vidas total. As vidas diminuem quando o jogado entra em contato com algum caçador no cenário.

- **Como o jogo acaba**

> Após conclusão do tempo de 5:00 minutos ou abertura de todas as jaulas, o jogador é redirecionado para uma tela que representa a fuga e precisa evitar que os caçadores atinjam os animais, caso atinjam, é subtraído uma animal do total resgatado no cenário anterior. Esta fase se segue por 2:00 até que os animais atinjam seu habitat natural. Após concluído o jogador recebe a pontuação de acordo com a fórmula descriçaõ no tópico **Regras do jogo** desta documentação.