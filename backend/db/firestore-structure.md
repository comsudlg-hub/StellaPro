# Estrutura do Firestore - StellaPro

Este documento define a estrutura completa de dados do Firestore para a plataforma StellaPro, seguindo o modelo B2B2C e as regras de negócio definidas pela equipe.

## Coleções Principais

### `clientes`
*   **Descrição:** Cadastro detalhado para gestão do cliente e controle de serviços.
*   **Campos:**
    *   `nomeCompleto` (string)
    *   `cpf` (string)
    *   `dataNascimento` (timestamp)
    *   `enderecoCompleto` (string)
    *   `telefones` (array)
    *   `email` (string)
    *   `historicoServicos` (array)
    *   `comentarios` (string)

### `estofarias`
*   **Descrição:** Permite gestão completa da estofaria, seus colaboradores, custos e logística.
*   **Campos:**
    *   `nomeEmpresa` (string)
    *   `cnpj` (string)
    *   `enderecos` (array)
    *   `telefones` (array)
    *   `custosFixos` (map)
    *   `logistica` (map)
    *   `configuracoesTributarias` (map)

#### Subcoleção: `funcionarios`
*   **Campos:**
    *   `nomeCompleto` (string)
    *   `cpf` (string)
    *   `cargoFuncao` (string)
    *   `permissoesSistema` (array)
    *   `contato` (map)

### `fornecedores`
*   **Descrição:** Vinculado ao tecido escolhido pelo cliente e para pedidos de compra.
*   **Campos:**
    *   `nomeEmpresa` (string)
    *   `cnpj` (string)
    *   `produtosFornecidos` (array)
    *   `telefones` (array)
    *   `endereco` (string)

#### Subcoleção: `tecidos`
*   **Campos:**
    *   `nomeTecido` (string)
    *   `codigoInterno` (string)
    *   `imagens` (array)
    *   `disponibilidade` (boolean)

### `estofados`
*   **Descrição:** Base para vincular todos os processos, desde orçamento até entrega e pós-venda.
*   **Campos:**
    *   `codigoEstofado` (string)
    *   `tipoEstofado` (string)
    *   `descricaoServico` (string)
    *   `tecidoEscolhido` (reference)
    *   `fotosAntesDepois` (array)
    *   `statusProcessoInterno` (string)

### `pedidos_os`
*   **Descrição:** Facilita rastreamento financeiro, histórico e geração de contrato.
*   **Campos:**
    *   `codigoPadronizado` (string)
    *   `dataHora` (timestamp)
    *   `clienteVinculado` (reference)
    *   `estofadoVinculado` (reference)
    *   `valoresEstimados` (map)
    *   `status` (string)
    *   `mensagensAutomaticas` (map)
    *   `comissaoAplicativo` (number)

### `contratos`
*   **Descrição:** Vinculado a OS e ao cliente, possibilitando rastreabilidade completa.
*   **Campos:**
    *   `codigoContrato` (string)
    *   `ordemServicoVinculada` (reference)
    *   `clienteVinculado` (reference)
    *   `termosCondicoes` (string)
    *   `assinaturaDigital` (string)
    *   `dataGeracao` (timestamp)

### `producao_interna`
*   **Descrição:** Permite monitoramento de cada estofado internamente.
*   **Campos:**
    *   `dataHoraChegada` (timestamp)
    *   `dataInicioProducao` (timestamp)
    *   `checklistQualidade` (map)
    *   `statusAprovadoEntrega` (boolean)

### `logistica`
*   **Descrição:** Permite rastrear transporte diário e otimizar rotas.
*   **Campos:**
    *   `veiculoPlacaMotorista` (map)
    *   `tipoDeslocamento` (string)
    *   `quilometragemInicialFinal` (map)
    *   `combustivelGasto` (number)
    *   `locaisAtendidos` (array)
    *   `estofadosTransportados` (array)

### `gestao_financeira`
*   **Descrição:** Base para relatórios financeiros detalhados.
*   **Campos:**
    *   `custosFixos` (map)
    *   `custosVariaveis` (map)
    *   `receitaServicoFornecedor` (map)
    *   `comissoesAplicativo` (number)

### `gestao_tributaria`
*   **Descrição:** Auxilia clientes e estofarias a manter conformidade fiscal.
*   **Campos:**
    *   `regrasTributacaoServicos` (map)
    *   `salariosEncargosFuncionarios` (map)
    *   `historicoTributosPagos` (array)

### `pos_venda`
*   **Descrição:** Garantir satisfação e acompanhamento do serviço entregue.
*   **Campos:**
    *   `notificacoesAtraso` (map)
    *   `comunicacaoAutomaticaCliente` (map)
    *   `avisoAntecipadoEntrega` (map)
    *   `responsavelContato` (string)

## Numeração Padronizada

*   **PO** - Pedido de Orçamento Inicial (ex: PO00010825)
*   **OE** - Orçamento Enviado (ex: OE00010825)
*   **OP** - Orçamento Aprovado (ex: OP00010825)
*   **OS** - Ordem de Serviço (ex: OS00010825)
*   **CT** - Contrato (ex: CT00010825)

## Fluxo do Processo

1.  Cliente solicita orçamento (PO)
2.  Orçamento enviado (OE)
3.  Orçamento aprovado pelo cliente (OP)
4.  Ordem de serviço gerada (OS)
5.  Contrato assinado (CT)
6.  Coleta do estofado
7.  Chegada ao estoque
8.  Início da produção
9.  Checklist de qualidade
10. Estofado aprovado para entrega
11. Entrega ao cliente
12. Pós-venda

## Boas Práticas Implementadas

*   Uso de códigos padronizados para rastreabilidade
*   Subcoleções para dados relacionados
*   Campos de múltiplos contatos e endereços
*   Status detalhado para cada processo
*   Registro de datas e horários para rastreio completo
*   Vinculação entre coleções usando references
*   Estrutura para automatização de comunicação
