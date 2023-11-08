install:
	npm ci

start:
	npm run dev

build:
	npm run build

start-build:
	npm run preview

prettier:
	npx prettier . --write

prettier-check:
	npx prettier . --check