#!/bin/bash
docker exec -i ask_rabbi_db pg_dump -U admin -d ask_rabbi > "full_dump.sql"
