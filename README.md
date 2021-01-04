# Chuck Norris Facts

## Decisões

### Código
- Foi mudado a maneira da ViewController se comunicar com a ViewModel, do jeito que o Observable não é mais um retorno de função, mas sim um bind para a propriedade da ViewModel (facts). Isso foi feito com o objetivo de ter a mesma comunicação com os erros da API, e também para deixar mais definido os inputs/outputs da ViewModel. 
- O observable do query da search bar foi alterado para uma trait (Drive) para que não seja passado um evento para cada subscription, e sim compartilhar o mesmo evento para todas as subscriptions.
- O setup das subscriptions da View Controller foram passadas para um método, para que este seja chamado depois de instanciar a View Controller. Isso foi feito por conta dos testes com screenshots, quando um screenshot era tirado o viewDidLoad era chamado novamente (fazendo novas subscriptions), isso fazia com que os eventos emitidos anteriormente (PublishObject) não fossem capitados pelas 'novas' subscriptions.
- O método de requisição do URLSession foi mudado do .data(request:) para .response(request:) a fim de processar os erros REST retornados.
- Lane customizada criada para que, em uma única linha, todos os testes da aplicação sejam rodados, incluindo a opção de tirar, ou não, as screenshots durante os testes.
- A princípio seria utilizado o Nimble-Snapshots para os testes de view, mas como esse já foi utilizado em projetos anteriores, decidi usar o FBSnapshotTestCase para o aprendizado.
- 

### UI
- Palheta de cores foi escolhida em cima da logo da API.
- Fontes usadas foram baseadas na utilizadas na documentação da API
-  

### Não inserir o Pods/ no .gitignore
- A máquina que executará o projeto não necessitará de ter o CocoaPods instalado.
- Depois que o avaliador clonar o repositório, o projeto já estará pronto para ser executado.
- A documentação do CocoaPods recomenda não adicionar a pasta do Pods no .gitignore.


## Execução do projeto
- Versão mínima do iOS: 14.0
