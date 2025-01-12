Feature: Cadastro da pessoa usuária
    As pessoas usuárias podem se cadastrar no sistema para terem acesso as
    funcionalidades disponíveis como a busca de profissionais.

Scenario: Cadastro com informações válidas
    Given estou na página de cadastro
    When eu preencho os campos "Nome civil ou social", "Sobrenome", "E-mail", "Confirmar e-mail", "Senha" e "Confirmar senha" com dados válidos
    And eu aceito os "Termos de uso e Políticas de Privacidade"
    And eu marco a opção "Tenho 18 anos ou mais"
    And eu clico no botão "Cadastrar"
    Then devo ver uma mensagem "Agradecemos! Verifique seu e-mail para ativar sua conta"
    And devo receber um e-mail de verificação contendo um link para ativar minha conta
Feature: Busca de um profissional de saúde
  As pessoas usuárias podem buscar profissionais de saúde no sistema e entrar em contato com eles.

  Scenario: Busca e contato com um profissional de fisioterapia
    Given estou logado no sistema com meu e-mail e senha cadastrados
    And vejo a mensagem de boas-vindas e o botão "Continuar cadastro"
    And após clicar no botão "Continuar cadastro" eu sou respondo as perguntas e finalizo meu pós cadastro
    And sou redirecionado para a página de busca de profissionais
    When eu clico no botão "Buscar Profissional"
    And eu pesquiso por "Fisioterapia" no campo de busca
    And eu seleciono um profissional listado nos resultados
    Then devo ver a página com as informações do profissional
    And devo ver o botão "Exibir contato"
    When eu clico no botão "Exibir contato"
    And insiro um número de telefone válido no formato brasileiro
    And recebo um código via SMS e insiro o código corretamente
    Then o contato do profissional deve ser exibido

Feature: Edição de perfil da pessoa usuária
  As pessoas usuárias podem atualizar suas informações de cadastro para mantê-las atualizadas no sistema.

  Scenario: Atualização de informações do perfil com dados válidos
    Given estou logado no sistema com meu e-mail e senha cadastrados
    And acesso a página de perfil
    When eu clico no botão "Editar dados"
    And atualizo os campos do perfil com novas informações válidas
    And eu salvo as alterações
    Then devo ser redirecionado para a página com a mensagem "Alterações salvas com sucesso"
    But sou redirecionado novamente para a página de edição com as mesmas perguntas, solicitando confirmação das informações
    # Observação: Este comportamento é redundante e pode ser confuso para o usuário.
Feature: Recuperação de senha
  As pessoas usuárias podem redefinir sua senha caso a tenham esquecido, garantindo acesso contínuo ao sistema.

  Scenario: Redefinição de senha sem confirmação e falha no login
    Given estou na página de login
    And eu clico no link "Esqueci minha senha"
    When sou redirecionado para a página de recuperação de senha
    And eu digito meu e-mail "usuario@email.com" no campo solicitado
    And clico no botão "Enviar e-mail"
    Then devo receber um e-mail com o link para redefinir minha senha
    When eu clico no link no e-mail
    And sou redirecionado para a página de cadastro da nova senha
    And eu digito uma nova senha "senhaSegura123"
    And confirmo a nova senha "senhaSegura123"
    And clico no botão "Cadastrar nova senha"
    Then o sistema não exibe uma mensagem de confirmação
    And a nova senha não é salva corretamente
    When eu tento fazer login com "usuario@email.com" e a nova senha "senhaSegura123"
    Then o sistema deve exibir uma mensagem de erro "E-mail ou senha inválidos"
    # Observação: A falta de feedback ao cadastrar a senha e a falha no login indicam um problema crítico no fluxo de redefinição de senha.










    