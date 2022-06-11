
# Ta Te Ti - backend :x: :o:
Api for the classic game "TA TE TI".


## Run Locally

Clone the project

```bash
  git clone https://github.com/MLuzTejada/tateti-backend.git
```

Go to the project directory

```bash
  cd tateti-backend
```

Install dependencies

```bash
  bundle install
```

Start the server

```bash
  rails s -b 'ssl://localhost:3000?key=localhost.key&cert=localhost.crt'
```


## API Reference

#### Register

  ##### Request
  
  ```http
    POST /register
  ```

  | Body | Type     | Description                |
  | :-------- |  :------- | :------------------------- |
  | `name` | `string` | **Required**. Name to register |
  | `password` | `string` | **Required**. Password to register |


  ##### Request example
  ```
  curl --location --request POST 'https://localhost:3000/register' \
  --header 'Content-Type: application/json' \
  --data-raw '{
      "name": "Pepe",
      "password": "pepehonguito19"
  }'
  ```

  ##### Sucess Response

  ```
  {
    "id": 3,
    "name": "Pepe",
    "password": "pepehonguito19",
    "token": "27d5f2f8-7b3d-4d6d-9e88-e07f1edf26ae",
    "score": 0,
    "color": null,
    "piece": null,
    "created_at": "2022-06-11T14:41:51.703Z",
    "updated_at": "2022-06-11T14:41:51.703Z"
}
  ```

  ##### Error Response
  ```
  {
    "name": [
        "can't be blank"
    ],
    "password": [
        "Must be a valid password"
    ]
}
  ```


#### Log in

##### Request

```http
  POST /login
```

  | Body | Type     | Description                |
  | :-------- |  :------- | :------------------------- |
  | `name` | `string` | **Required**. Name to register |
  | `password` | `string` | **Required**. Password to register |


##### Request example
```
  curl --location --request POST 'https://localhost:3000/login' \
--header 'Content-Type: application/json' \
--header 'Cookie: _tateti_backend_session=9XL5ff2nNfdh4K12IqnDoBFcHkxGW%2BfDVOCzAJqk7PujNVQr3ePnDqc%2Bu0v%2BYzEBFTJ9XcVuDEQOc3Bx0DloeNQXcUHpRTrXYqs62q8whnp4jjZZJiAQAVVkMJP4KCFyL41TlaWbg6hMbgnHjFhZArjKkzbW4vL69TnnsZGitJRqVu5ium%2FFmK7zMfIVOtUaulDWk2UvTxGct1piagsI--OE4ITPlnCe08zA1l--LRUqAD4Tjpm243ryhqGUJg%3D%3D' \
--data-raw '{
    "name": "Pepe",
    "password": "pepehonguito19"
}'
```

  ##### Sucess Response

  ```
  {
    "id": 3,
    "name": "Pepe",
    "password": "pepehonguito19",
    "token": "27d5f2f8-7b3d-4d6d-9e88-e07f1edf26ae",
    "score": 0,
    "color": null,
    "piece": null,
    "created_at": "2022-06-11T14:41:51.703Z",
    "updated_at": "2022-06-11T14:41:51.703Z"
}
  ```

  ##### Error Response
  ```
  {
    "message": "Jugador no encontrado""
}
  ```


#### Log out

```http
  GET /logout/:id
```

| Headers | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `Authorization`      | `string` | **Required**. Your API token|

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `id` | `string` | **Required**. Id of the player to logout|

##### Request example
```
  curl --location --request GET 'https://localhost:3000/logout/3' \
--header 'Authorization: 27d5f2f8-7b3d-4d6d-9e88-e07f1edf26ae' \
--header 'Cookie: _tateti_backend_session=FBpAG7d8L%2BYWCJ5pdNzBmdigXj
q8MM%2Fae4A1kFvH%2Fv7NFDjWLMml7IQixHtosyb8DR0lj%2BSYDbBmZPWL9pHRWd9Wy59
cMR9Jg2HdECaCfQex%2ByXG5LaDvhHoFHKaapXJdLDNeUCoB%2BP2bM1m6TwlWprYSeEJCl
IWGa9Iacn8AA9i4KXRG19zth2Oca2iJIk%3D--V1dBfKQE11YOS%2B3A--EZmfcNfM46X6giT4wT8gOw%3D%3D'
```

  ##### Sucess Response

  ```
  {
    "message": "Cerro sesion satisfactoriamente"
  }
  ```

#### Create a new game

```http
  GET /api/items
```

| Headers | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `Authorization` | `string` | **Required**. Your API token |

#### Join a game

```http
  GET /api/items
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `api_key` | `string` | **Required**. Your API key |

#### Make a move

```http
  GET /api/items
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `api_key` | `string` | **Required**. Your API key |

#### Start other round

```http
  GET /api/items
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `api_key` | `string` | **Required**. Your API key |


#### Get a board by id
##### Request

```http
  GET /boards/:id
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `api_key` | `string` | **Required**. Your API key |
| `id` | `string` | **Required**. Id of the player you want to find |

##### Request example
```
curl --location --request GET 'https://localhost:3000/boards/1' \
--header 'Cookie: _tateti_backend_session=FBpAG7d8L%2BYWCJ5pdNzBmd
igXjq8MM%2Fae4A1kFvH%2Fv7NFDjWLMml7IQixHtosyb8DR0lj%2BSYDbBmZPWL9p
HRWd9Wy59cMR9Jg2HdECaCfQex%2ByXG5LaDvhHoFHKaapXJdLDNeUCoB%2BP2bM1m6
TwlWprYSeEJClIWGa9Iacn8AA9i4KXRG19zth2Oca2iJIk%3D--V1dBfKQE11YOS%2B
3A--EZmfcNfM46X6giT4wT8gOw%3D%3D'
```

##### Sucess Response

  ```
  {
    "id": 1,
    "token": "944f7a9c-df20-4fe5-9e67-d6d9b7fe9ebd",
    "turn": null,
    "winner": 1,
    "squares": [
        "X",
        null,
        "O",
        null,
        "X",
        "O",
        null,
        null,
        "X"
    ],
    "colors": [
        "#EC7063",
        null,
        "#5DADE2",
        null,
        "#EC7063",
        "#5DADE2",
        null,
        null,
        "#EC7063"
    ],
    "tie": false,
    "created_at": "2022-06-01T23:45:50.955Z",
    "updated_at": "2022-06-01T23:46:57.591Z"
  }
  ```

  ##### Error Response
  ```
  {
    "message": "Tablero no encontrado"
  }
  ```

#### Get a player by id

##### Request

```http
  GET /players/:id
```

| Headers | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `Authorization`      | `string` | **Required**. Your API token|


| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `id` | `string` | **Required**. Id of the player you want to find |


##### Request example
```
 curl --location --request GET 'https://localhost:3000/players/3' \
--header 'Authorization: 27d5f2f8-7b3d-4d6d-9e88-e07f1edf26ae' \
--header 'Cookie: _tateti_backend_session=FBpAG7d8L%2BYWCJ5pdNzBmdigXjq8MM
%2Fae4A1kFvH%2Fv7NFDjWLMml7IQixHtosyb8DR0lj%2BSYDbBmZPWL9pHRWd9Wy59cMR9Jg2H
dECaCfQex%2ByXG5LaDvhHoFHKaapXJdLDNeUCoB%2BP2bM1m6TwlWprYSeEJClIWGa9Iacn8AA9
i4KXRG19zth2Oca2iJIk%3D--V1dBfKQE11YOS%2B3A--EZmfcNfM46X6giT4wT8gOw%3D%3D'
```

  ##### Sucess Response

  ```
  {
    "id": 3,
    "name": "Pepe",
    "password": "pepehonguito19",
    "token": "27d5f2f8-7b3d-4d6d-9e88-e07f1edf26ae",
    "score": 0,
    "color": null,
    "piece": null,
    "created_at": "2022-06-11T14:41:51.703Z",
    "updated_at": "2022-06-11T14:41:51.703Z"
}
  ```

  ##### Error Response
  ```
  {
    "message": "Jugador no encontrado"
  }
  ```

  ```
  {
    "message": "Player unauthorize"
  }
  ```






## Authors

- [@MLuzTejada](https://github.com/MLuzTejada)


