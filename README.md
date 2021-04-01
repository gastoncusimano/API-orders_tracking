# Order Tracking API

The idea is the implementation of a microservice that allows tracking shipments made by couriers such as FedEx.

The API provides an endpoint for creating shipments and a task for synchronization. (with a cronjob)
### Prerequisites to build the project

- Ruby 3.0.0
- Rails 6.1.3
- PostgreSQL

### Install the dependencies

```bash
$ bundle install
```

Will be installed extra gems such as:
- fedex (fedex service)
- rspec-rails (Testing)
- shoulda-matchers (Testing)
- whenever (Cronjob)
- dotenv (Environment vars)

### Create and setup the database

Important: postgres will use the default role. This is the same name as the operating system user that initialized the database.

```bash
$ rails db:create db:migrate
```

If you want to have existing orders to track you could do an extra step:
```bash
$ rails db:seeds
```

### Create a .env.development file to add your postgresql username
```bash
DB_USERNAME=postgres_username
```

### Run the tests

```bash
$ bundle exec rspec
```
### Create cronjob (optional)
To have a cronjob that executes the synchronization script once in an hour do:
```bash
$ whenever --update-crontab
```
### Run the server

```bash
$ rails server
```
If you want to create a new shipment request you can do it through:

POST http://localhost:3000/create_shipment

```json
{
  "courier": "fedex",
  "tracking_reference": "--tracking_reference--"
}
```

### Run the synchronization script

```bash
$ rake shipments:synchronize_fedex
```
