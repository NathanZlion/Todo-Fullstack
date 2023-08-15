# APIS TO USE

## USER RELATED APIS
### Register User
New user registration

`http://127.0.0.1:5000/api/user/register`

- The body  is json that could look like this
``` json
{
    "userName": "NathanD",
    "email": "nathandere1357@gmail.com",
    "password": "$Anbesaw1"
}
```

### Login User
Login for existing user

`http://127.0.0.1:5000/api/user/login`
``` json
{
    "email": "nathandere1357@gmail.com",
    "password": "$Anbesaw1"
}
```

### Getting One Self

_get_ `http://127.0.0.1:5000/api/user/`
- _token required_

### Updating One Self

_patch_ `http://127.0.0.1:5000/api/user/`
- _token required_
- _body_: a json with 'userName' key

```json
{
    "userName": "NathanD"
}
```

### Deleting user
_delete_ `http://127.0.0.1:5000/api/user/`

- _token required_


## TODO RELATED APIS
### Create Todo
_post_ `http://127.0.0.1:5000/api/todo/`
- _token requried_
``` json
{
    "title": "Third to do."
}
```

### Get All Todos
_get_ `http://127.0.0.1:5000/api/todo/`
- _token required_

### Get Todo By Id
_get_ `http://127.0.0.1:5000/api/todo/:id`
- _token required_

### Update Todo By Id
_patch_ `http://127.0.0.1:5000/api/todo/:id`
- _token required_


```json
{
    "title": "third todo",
    "description": "I have now added some description"
}
```

### Delete todo
_delete_ `http://127.0.0.1:5000/api/todo/:id`
- _token required_
