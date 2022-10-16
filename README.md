# Sistema de Frete

Sistema logístico criado para gerenciamento de ordens de serviço e cálculo de frete. Projeto desenvolvido durante o programa TreinaDev oferecido pela Campus Code.
Este sistema é responsável por gerenciar a frota de entrega para um e-commerce com alcance nacional. É possível cadastrar diferentes tipos de transporte definindo as cidades de atuação, os prazos e os custos. Além disso, o administrador do sistema pode cadastrar novas ordens de serviço sendo realizados os cálculos de frete de acordo com os tipos de transporte que atendem ao perfil do pedido. Por fim, o administrador do sistema é capaz controlar as ordens de serviço em andamento, encerrar ordens de serviço e consultar o status da frota de veículos da empresa.

# Tarefas
<h2>Configuração do projeto</h2>

- [x] Inicializar projeto
- [x] Incluir gem do devise para autenticação
- [x] Definir usuário e administrador
- [x] Incluir bootstrap
- [ ] i18n -- WIP
      
<h2>Modalidades de transporte</h2>

- [x] Usuário visualiza modalidades de transporte
- [x] Usuário vê detalhes de modalidades de transporte
- [x] Administrador cadastra modalidade de transporte
- [x] Administrador edita/desabilita modalidade de transporte

<h3>Validações</h3>

- [x] Configuração de preço por peso
- [x] Configuração de preço por distância
- [x] Configuração de prazos
                
<h2>Gestão da frota</h2>

- [x] Usuário visualiza frota
- [x] Administrador cadastra veículo para frota
- [x] Administrador altera status de veículo
- [x] Usuário vê detalhes de veículo
- [x] Usuário busca por veículo específico
- [x] Validações

<h2>Criação de ordem de serviço</h2>

- [x] Administrador cadastra ordem de serviço
- [x] Validações - pendentes testes unitários para ordem de serviço

<h2>Inicialização de ordem de serviço</h2>

- [x] Usuário vê ordens de serviço pendentes
- [x] Usuário vê detalhes de ordem de serviço
- [x] Usuário inicia ordem de serviço
- [x] Configuração de preços
- [x] Configuração de prazos
- [x] Demais validações - pendentes testes unitários para ordem de serviço

<h2>Encerrar ordem de serviço</h2>

- [x] Usuário vê ordens de serviço em andamento
- [x] Usuário finaliza ordens de serviço
- [x] Validações --pendentes testes unitários para ordem de serviço
  
<h2>Consultar entrega</h2>

- [x] Usuário não autenticado consulta status de entrega

<h2>Outros</h2>

- [ ] Refatorar código -- (I18n !!)
- [ ] Layout do sistema


# Configuração e instalação do projeto

Gems adicionais presentes no projeto: devise e bootstrap;

<h2>Gem 'devise'</h2> 
Utilizada no processo de autenticação e criação de usuários

<h2>Gem 'bootstrap'</h2> 
Provê componentes CSS, SASS, LESS e JS auxiliando na criação do layout do sistema de forma personalizada

<h2>Instalação do projeto</h2>

1) Executar o seguinte comando no terminal para download do projeto: ```git@github.com:lcallefe/shipping_management_system.git```
2) Abrir a pasta principal do projeto (shipping_management_system) no terminal e executar comando abaixo para instalação das gems:
```    
bundle install
```
3) Carregando massa de dados empregada no projeto:
```
rails db:seed
```

4) Para rodar os testes, utilize o comando abaixo:

```    
rspec
```
5) Acesso à aplicação: 
```
rails s
```
Uma vez que for exibida uma mensagem no terminal informando que o servidor está operante:
Acessar aplicação por meio da url [http://localhost:3000](http://localhost:3000)  para consultar entrega. Caso deseje se autenticar e ter acesso às demais funcionalidades do sistema, entrar em [http://localhost:3000/users/sign_in](http://localhost:3000/users/sign_in)




