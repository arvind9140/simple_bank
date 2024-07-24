.PHONY: createdb dropdb postgres migrateup migratedown forceversion cleanmigrations sqlc test

# Create a new database named 'simple_bank'
createdb:
	docker exec -it postgres12 createdb --username=root --owner=root simple_bank

# Drop the 'simple_bank' database
dropdb:
	docker exec -it postgres12 dropdb simple_bank

# Run a PostgreSQL 12 Docker container
postgres:
	docker run --name postgres12 -p 5434:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:12-alpine

# Apply all up migrations
migrateup:
	migrate -path db/migration -database "postgres://root:secret@localhost:5434/simple_bank?sslmode=disable" -verbose up

# Rollback all migrations
migratedown:
	migrate -path db/migration -database "postgres://root:secret@localhost:5434/simple_bank?sslmode=disable" -verbose down

# Force the migration version to 1
forceversion:
	migrate -path db/migration -database "postgres://root:secret@localhost:5434/simple_bank?sslmode=disable" -verbose force 1

# Delete migration version 1 entry from the schema_migrations table
cleanmigrations:
	psql -h localhost -p 5434 -U root -d simple_bank -c "DELETE FROM schema_migrations WHERE version = 1;"

# Generate Go code from SQL queries using sqlc
sqlc:
	sqlc generate

# Run Go tests with verbose output and coverage
test:
	go test -v -cover ./...
