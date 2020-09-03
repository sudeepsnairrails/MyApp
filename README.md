READ ME

- Authentication API only using Redis and and no Relational DB.
- User CRUD is possible.
- All the operation requests and responses are in JSON
- Server responds with corresponding HTTP status codes.
- Application server is PUMA.
- Authentication is through JWT.
- Did not use Active redords.
- Only used Active Model to facilitate validations.

Technical Configuration
- ruby 2.4.0p0
- Rails 5.2.4.3
- redis-cli 4.0.9


Testing done
- Manual only

Areas to be improved
- Need to write proper logs.
- Need to handle exceptions.
- Need to do automation tests.
