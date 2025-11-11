#!/bin/bash
docker exec -i ask_rabbi_db pg_dump -U admin -d ask_rabbi -s > "schema.sql"
docker exec -i ask_rabbi_db pg_dump -U admin -d ask_rabbi -a > "data.sql"

echo "Database export completed!"
