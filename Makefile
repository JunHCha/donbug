# Init Project
init:
	/bin/bash scripts/init.sh

# Inside Continaer
run-server:
	scripts/start-dev.sh
update-db:
	scripts/update-db.sh
migrations:
	python src/manage.py makemigrations $(app)
migrate:
	python src/manage.py migrate $(app)

# Outside Container
dev-up:
	docker-compose -f docker-compose.dev.yml up --build
dev-down:
	docker-compose -f docker-compose.dev.yml down $(args)
dev-shell:
	docker-compose -f docker-compose.dev.yml run --rm app /bin/bash
dev-migrations:
	docker-compose -f docker-compose.dev.yml run --rm app \
	/bin/bash -c "python src/manage.py makemigrations $(app)"
dev-migrate:
	docker-compose -f docker-compose.dev.yml run --rm app \
	/bin/bash -c "python src/manage.py migrate $(app)"

# test
test-shell:
	docker-compose -f docker-compose.test.yml run --rm app /bin/bash

test:
	docker-compose -f docker-compose.test.yml run --rm app /bin/bash -c "scripts/test.sh"
	docker-compose -f docker-compose.test.yml down

# push
staging-push:
	docker build -t alphaprime0401/alphasquare-backend:staging .
	docker push alphaprime0401/alphasquare-backend:staging

prod-push:
	docker build -t alphaprime0401/alphasquare-backend:latest .
	docker tag alphaprime0401/alphasquare-backend:latest alphaprime0401/alphasquare-backend:$(version)
	docker push alphaprime0401/alphasquare-backend:latest
	docker push alphaprime0401/alphasquare-backend:$(version)

clean:
	docker container prune -f
	docker rmi $$(docker images -f "dangling=true" -q) -f

# git
commit:
	cz c