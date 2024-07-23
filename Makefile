.PHONY: createdb dropdb postgres migrateup migratedown forceversion cleanmigrations sqlc

createdb:
	docker exec -it postgres12 createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it postgres12 dropdb simple_bank

postgres:
	docker run --name postgres12 -p 5434:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:12-alpine

migrateup:
	migrate -path db/migration -database "postgres://root:secret@localhost:5434/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgres://root:secret@localhost:5434/simple_bank?sslmode=disable" -verbose down

forceversion:
	migrate -path db/migration -database "postgres://root:secret@localhost:5434/simple_bank?sslmode=disable" -verbose force 1

cleanmigrations:
	psql -h localhost -p 5434 -U root -d simple_bank -c "DELETE FROM schema_migrations WHERE version = 1;"

sqlc:
	sqlc generate
