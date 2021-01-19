db:
	docker run --name my_pg -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:13.1-alpine

exec:
	docker exec -it my_pg psql -U root

createdb:
	docker exec -it my_pg createdb --username=root --owner=root simple_bank

mic:
	migrate create -ext sql -dir db/migration -seq init_schema

miup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose up

midown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

.PHONY: db exec createdb create_migrate miup midown sqlc test