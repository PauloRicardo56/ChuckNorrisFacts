# ChuckNorrisFacts

## Decisões

### Não inserir o Pods/ no .gitignore
- A máquina que executará o projeto não necessitará de ter o CocoaPods instalado.
- Depois que o avaliador clonar o repositório, o projeto já estará pronto para ser executado.
- A documentação do CocoaPods recomendo não adicionar a pasta do Pods no .gitignore.

### Código
- Foi mudado a maneira da ViewController se comunicar com a ViewModel, do jeito que o Observable não é mais um retorno de função, mas sim um bind para a propriedade da ViewModel (facts). Isso foi feito com o objetivo de ter a mesma comunicação com os erros da API, e também para deixar mais definido os inputs/outputs da ViewModel. 

## Execução do projeto

- Versão mínima do iOS: 14.0


