# Desafio de Backend com Ruby/Rails da Estante Virtual

Esse repositório contém o [desafio de backend proposto pela Estante Virtual](https://github.com/estantevirtual/vagas/blob/master/desafios/backend.md). A aplicação em questão foi desenvolvida com o Ruby on Rails, e consiste de uma API para gerenciar competições e seus resultados.

## Versões do Ruby/Rails

No desenvolvimento desta aplicação foram utilizadas as últimas versões do Ruby e do Rails: Ruby 2.5.1 e Rails 5.2.0.

## Instalação

### Clone inicial

Para instalar a aplicação deve-se fazer um clone do seu repositório:

```
git clone https://github.com/elomarns/desafio_backend_ruby_estante_virtual.git
```

### Instalação das dependências

Feito o clone da aplicação, é preciso instalar as suas dependências. Para fazer isso, digite a instrução abaixo dentro do diretório da aplicação:

```
bundle install
```

### Preparação do banco de dados

A aplicação utiliza o SQLite 3 como banco de dados, logo é preciso antes criá-lo, juntamente com as tabelas e registros necessários. Para tal, é necessário executar as seguintes rake tasks:

```
bundle install rake db:create (cria o banco de dados)
bundle install rake db:migrate (cria as tabelas das competições, atletas e resultados)
bundle install rake db:seeds (insere algumas competições, atletas e resultados)
```

## Rodando a suite de testes

Para rodar todos os testes da aplicação deve-se executar o comando abaixo no diretório da aplicação:

```
bundle exec rspec
```

## Iniciando a aplicação

Para iniciar a aplicação, basta executar o comando abaixo dentro do diretório da aplicação:

```
bundle exec rails
```

Feito isso, a aplicação irá rodar na porta 3000.

## API

A API gerencia competições e seus resultados.

### Competições

As competições possuem os seguintes campos:

* **name**: nome da competição (obrigatório)
* **unit**: unidade de medida do resultado (obrigatório)
* **finished**: flag que indica se a competição foi finalizada (default: false)
* **results_limit_per_athlete**: limite de resultados por atleta dentro de uma competição (default: 1)
* **criterion_for_best_result**: critério para selecionar o melhor resultado, sendo *max* e *min* os possíveis valores (default: max). Caso o valor seja *min*, um resultado numericamente inferior terá uma melhor colocação sobre resultados maiores, e vice-versa.

#### Cadastro de competições: POST /competicoes.json

Exemplo

```
curl -X "POST" -d "name=Cuspe a distância&unit=m" http://localhost:3000/competicoes.json
```

##### Retorno:

```
{
    "id": 3,
    "name": "Cuspe a distância",
    "unit": "m",
    "finished": false,
    "results_limit_per_athlete": 1,
    "criterion_for_best_result": "max",
    "created_at": "2018-05-11T19:39:03.858-03:00",
    "updated_at": "2018-05-11T19:39:03.858-03:00",
    "ranking": [],
    "url": "http://localhost:3000/competicoes/3"
}
```

#### Visualização de competições: GET /competicoes/id.json

A visualização de uma competição exibe todos os seus dados, o ranking dos resultados, do melhor para o pior, e o resultado vencedor (caso a competição esteja finalizada).

Exemplo:

```
curl http://localhost:3000/competicoes/1.json
```

Retorno:

```
{
    "id": 1,
    "name": "100m rasos classificatoria 1",
    "unit": "s",
    "finished": false,
    "results_limit_per_athlete": 1,
    "criterion_for_best_result": "min",
    "created_at": "2018-05-11T19:38:51.657-03:00",
    "updated_at": "2018-05-11T19:38:51.657-03:00",
    "ranking": [
        {
            "id": 1,
            "athlete": {
                "id": 1,
                "name": "João das Neves",
                "created_at": "2018-05-11T19:38:51.678-03:00",
                "updated_at": "2018-05-11T19:38:51.678-03:00"
            },
            "value": 9.5,
            "created_at": "2018-05-11T19:38:51.743-03:00",
            "updated_at": "2018-05-11T19:38:51.743-03:00"
        },
        {
            "id": 2,
            "athlete": {
                "id": 2,
                "name": "João das Selvas",
                "created_at": "2018-05-11T19:38:51.681-03:00",
                "updated_at": "2018-05-11T19:38:51.681-03:00"
            },
            "value": 9.9,
            "created_at": "2018-05-11T19:38:51.746-03:00",
            "updated_at": "2018-05-11T19:38:51.746-03:00"
        }
    ],
    "url": "http://localhost:3000/competicoes/1"
}
```

#### Listagem de competições: GET /competicoes.json

A listagem de competições exibe apenas os dados da competição, não incluindo o ranking e nem o resultado vencedor.

Exemplo:

```
curl http://localhost:3000/competicoes.json
```

Retorno:

```
[
    {
        "id": 1,
        "name": "100m rasos classificatoria 1",
        "unit": "s",
        "finished": false,
        "results_limit_per_athlete": 1,
        "criterion_for_best_result": "min",
        "created_at": "2018-05-11T19:38:51.657-03:00",
        "updated_at": "2018-05-11T19:38:51.657-03:00",
        "url": "http://localhost:3000/competicoes/1"
    },
    {
        "id": 2,
        "name": "Lançamento de Dardo final",
        "unit": "m",
        "finished": false,
        "results_limit_per_athlete": 3,
        "criterion_for_best_result": "max",
        "created_at": "2018-05-11T19:38:51.660-03:00",
        "updated_at": "2018-05-11T19:38:51.660-03:00",
        "url": "http://localhost:3000/competicoes/2"
    },
    {
        "id": 3,
        "name": "Cuspe a distância",
        "unit": "m",
        "finished": false,
        "results_limit_per_athlete": 1,
        "criterion_for_best_result": "max",
        "created_at": "2018-05-11T19:39:03.858-03:00",
        "updated_at": "2018-05-11T19:39:03.858-03:00",
        "url": "http://localhost:3000/competicoes/3"
    }
]
```

#### Atualização de competições: PATCH/PUT /competicoes/id.json

Exemplo:

```
curl -X "PATCH" -d "name=Arremesso de saliva a distância" http://localhost:3000/competicoes/3.json
```

Retorno:

```
{
    "id": 3,
    "name": "Arremesso de saliva a distância",
    "unit": "m",
    "finished": false,
    "results_limit_per_athlete": 1,
    "criterion_for_best_result": "max",
    "created_at": "2018-05-11T19:39:03.858-03:00",
    "updated_at": "2018-05-11T19:43:46.140-03:00",
    "ranking": [],
    "url": "http://localhost:3000/competicoes/3"
}
```

#### Finalização de competições: PATCH/PUT /competicoes/id/finalizar.json

Exemplo:

```
curl -X "PATCH" http://localhost:3000/competicoes/2/finalizar.json
```

Retorno:

```
{
    "id": 2,
    "name": "Lançamento de Dardo final",
    "unit": "m",
    "finished": true,
    "results_limit_per_athlete": 3,
    "criterion_for_best_result": "max",
    "created_at": "2018-05-11T19:38:51.660-03:00",
    "updated_at": "2018-05-11T19:44:27.641-03:00",
    "ranking": [
        {
            "id": 5,
            "athlete": {
                "id": 3,
                "name": "João dos Pântanos",
                "created_at": "2018-05-11T19:38:51.684-03:00",
                "updated_at": "2018-05-11T19:38:51.684-03:00"
            },
            "value": 87.1,
            "created_at": "2018-05-11T19:38:51.756-03:00",
            "updated_at": "2018-05-11T19:38:51.756-03:00"
        },
        {
            "id": 8,
            "athlete": {
                "id": 4,
                "name": "João das Montanhas",
                "created_at": "2018-05-11T19:38:51.687-03:00",
                "updated_at": "2018-05-11T19:38:51.687-03:00"
            },
            "value": 85.5,
            "created_at": "2018-05-11T19:38:51.767-03:00",
            "updated_at": "2018-05-11T19:38:51.767-03:00"
        }
    ],
    "winner_result": {
        "id": 5,
        "athlete": {
            "id": 3,
            "name": "João dos Pântanos",
            "created_at": "2018-05-11T19:38:51.684-03:00",
            "updated_at": "2018-05-11T19:38:51.684-03:00"
        },
        "value": 87.1,
        "created_at": "2018-05-11T19:38:51.756-03:00",
        "updated_at": "2018-05-11T19:38:51.756-03:00"
    },
    "url": "http://localhost:3000/competicoes/2"
}
```

#### Remoção de competições: DELETE /competicoes/id.json

Exemplo:

```
curl -X "DELETE" http://localhost:3000/competicoes/3.json
```

Retorno:

```
```

É importante notar que a remoção de competições não retorna nenhum conteúdo, uma vez que ela retorna 204 como código de status. Esse código indica que a solicitação foi bem sucedida, e não haverá nenhum retorno.

### Resultados

A API de resultados é bastante flexível, permitindo cadastrar resultados tanto para competições e atletas já existentes, como também cadastrar a competição, o atleta e o resultado numa só requisição.

#### Competição e/ou atleta previamente existentes

Caso a competição e/ou o atleta já estejam cadastrados, basta passar os seguintes parâmetros:

* **competition_id**: id da competição a qual pertence o resultado (obrigatório)
* **athlete_id**: id do atleta a qual pertence o resultado (obrigatório)
* **value**: valor do resultado (obrigatório)

#### Competição e/ou atleta ainda não cadastrados

Se a competição e/ou o atleta ainda não foram inseridos, pode-se passar os parâmetros abaixo para inseri-los juntamente com o resultado

* **competition**: nome da competição a qual pertence o resultado (obrigatório)
* **unit**: unidade de medida da competição a qual pertence o resultado (obrigatório)
* **athlete**: nome do atleta a qual pertence o resultado (obrigatório)
* **value**: valor do resultado (obrigatório)

No entanto, é importante observar que caso a competição seja criada na API de resultados, ela será criada com os valores default:

* finished: false
* results_limit_per_athlete: 1
* criterion_for_best_result: max

#### Cadastro de resultados: POST /resultados.json

Exemplo com competição e atletas existentes:

```
curl -X "POST" -d "competition_id=1&athlete_id=3&value=9.7" http://localhost:3000/resultados.json
```

Retorno:

```
{
    "id": 9,
    "competition": {
        "id": 1,
        "name": "100m rasos classificatoria 1",
        "unit": "s",
        "finished": false,
        "results_limit_per_athlete": 1,
        "criterion_for_best_result": "min",
        "created_at": "2018-05-11T19:38:51.657-03:00",
        "updated_at": "2018-05-11T19:38:51.657-03:00",
        "url": "http://localhost:3000/competicoes/1"
    },
    "athlete": {
        "id": 3,
        "name": "João dos Pântanos",
        "created_at": "2018-05-11T19:38:51.684-03:00",
        "updated_at": "2018-05-11T19:38:51.684-03:00"
    },
    "value": 9.7,
    "created_at": "2018-05-11T20:00:53.620-03:00",
    "updated_at": "2018-05-11T20:00:53.620-03:00"
}
```

Exemplo com apenas a competição existente:

```
curl -X "POST" -d "competition_id=1&athlete=Elomar&value=9.5" http://localhost:3000/resultados.json
```

Retorno:

```
{
    "id": 10,
    "competition": {
        "id": 1,
        "name": "100m rasos classificatoria 1",
        "unit": "s",
        "finished": false,
        "results_limit_per_athlete": 1,
        "criterion_for_best_result": "min",
        "created_at": "2018-05-11T19:38:51.657-03:00",
        "updated_at": "2018-05-11T19:38:51.657-03:00",
        "url": "http://localhost:3000/competicoes/1"
    },
    "athlete": {
        "id": 5,
        "name": "Elomar",
        "created_at": "2018-05-11T20:03:58.200-03:00",
        "updated_at": "2018-05-11T20:03:58.200-03:00"
    },
    "value": 9.5,
    "created_at": "2018-05-11T20:03:58.219-03:00",
    "updated_at": "2018-05-11T20:03:58.219-03:00"
}
```

Exemplo com apenas o atleta existente:

```
curl -X "POST" -d "competition=200m rasos&unit=m&athlete_id=5&value=18.7" http://localhost:3000/resultados.json
```

Retorno:

```
{
    "id": 11,
    "competition": {
        "id": 4,
        "name": "200m rasos",
        "unit": "m",
        "finished": false,
        "results_limit_per_athlete": 1,
        "criterion_for_best_result": "max",
        "created_at": "2018-05-11T20:04:55.270-03:00",
        "updated_at": "2018-05-11T20:04:55.270-03:00",
        "url": "http://localhost:3000/competicoes/4"
    },
    "athlete": {
        "id": 5,
        "name": "Elomar",
        "created_at": "2018-05-11T20:03:58.200-03:00",
        "updated_at": "2018-05-11T20:03:58.200-03:00"
    },
    "value": 18.7,
    "created_at": "2018-05-11T20:04:55.275-03:00",
    "updated_at": "2018-05-11T20:04:55.275-03:00"
}
```

#### Visualização de resultados: GET /resultados/id.json

Exemplo:

```
curl http://localhost:3000/resultados/1.json
```

Retorno:

```
{
    "id": 1,
    "competition": {
        "id": 1,
        "name": "100m rasos classificatoria 1",
        "unit": "s",
        "finished": false,
        "results_limit_per_athlete": 1,
        "criterion_for_best_result": "min",
        "created_at": "2018-05-11T19:38:51.657-03:00",
        "updated_at": "2018-05-11T19:38:51.657-03:00",
        "url": "http://localhost:3000/competicoes/1"
    },
    "athlete": {
        "id": 1,
        "name": "João das Neves",
        "created_at": "2018-05-11T19:38:51.678-03:00",
        "updated_at": "2018-05-11T19:38:51.678-03:00"
    },
    "value": 9.5,
    "created_at": "2018-05-11T19:38:51.743-03:00",
    "updated_at": "2018-05-11T19:38:51.743-03:00"
}
```

## Possibilidades de melhoria

Buscando manter a aplicação mais simples, e dentro do prazo, eu evitei fazer certas coisas que, embora não foram solicitadas, poderiam melhorar a aplicação. Abaixo eu listo algumas delas:

* Colocar a API num namespace, e versioná-la, de forma que suas URLs sejam precedidas por /api/v1/
* Aumentar a cobertura de testes
* Permitir que os usuários da API passem parêmetros adicionais, como limite, ordenação dos resultados, e até filtros
* Não carregar os módulos do Rails que não estão sendo utilizados: ActiveJob, ActiveStorage, ActionMailer e ActionCable.
