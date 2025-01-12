# Desafio QA Gherkin

Este projeto contém cenários de teste escritos em Gherkin.

## Estrutura do Projeto
- `features/`: arquivos `.feature` com os casos de teste.
- `cypress/`: diretório de testes automatizados.
- `docs/`: documentação adicional (bugs, melhorias).

## Como Executar
1. Clonar o repositório.
2. Instalar as dependências (npm install).
3. Abrir o Cypress (`npx cypress open`) para rodar os testes.


## Testes de Desempenho

Neste projeto, realizamos testes de desempenho para avaliar o comportamento da aplicação sob diferentes quantidades de usuários simultâneos.

### Ferramenta e Configuração
- **Ferramenta:** [Apache JMeter](https://jmeter.apache.org/)
- **Plano de Teste:** [`jmeter/teste-desempenho.jmx`](./jmeter/teste-desempenho.jmx)
- **Como Executar:**
  1. Instale o JMeter.
  2. Abra o arquivo `.jmx` no JMeter.
  3. Ajuste o número de Threads (usuários) e Ramp-Up conforme desejar.
  4. Adicione **Listeners** (ex.: Summary Report) para visualizar resultados.
  5. Clique em “Start”.

### Cenários Testados

1. **2 usuários, Ramp-Up 2s**
   - **Resultado:** 0% falhas, tempo médio ~300 ms.
   - **Observação:** Nenhum erro reportado.

2. **5 usuários, Ramp-Up 20s**
   - **Resultado:** 0% falhas, tempo médio ~400 ms.
   - **Observação:** Tudo estável, sem erros.

3. **8 usuários, Ramp-Up 15s**
   - **Resultado:** 1 falha (12,5%) com erro `ConnectionClosedException`.
   - **Tempo médio:** ~450 ms.
   - **Possível Causa:** Premature end of chunked message body quando muitas requisições chegam simultaneamente.

4. **10 usuários, Ramp-Up 10s**
   - **Resultado:** 40% de falhas.
   - **Erros:** `ConnectionClosedException`, tempo médio ~426 ms.
   - **Possível Causa:** Servidor encerrando conexões cedo ou falta de recurso sob carga.

### Conclusões
- O sistema funciona sem falhas até 5 usuários simultâneos com um ramp-up de 20 segundos.
- A partir de 8 usuários e ramp-up menor, surgem falhas de conexão.
- Em 10 usuários, a taxa de falhas foi de 40%, indicando um gargalo ou necessidade de ajustes.

### Recomendações
- Aumentar o ramp-up ao testar 8+ usuários para reduzir picos simultâneos.
- Investigar configurações de chunked encoding e keep-alive no servidor.
- Verificar logs do servidor para detalhes de por que fecha as conexões precocemente.
