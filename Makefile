
all: run-quickcheck

deps/stdlib:
	@mkdir -p deps/
	@git clone --branch traits --depth 1 https://github.com/anoma/juvix-stdlib.git deps/stdlib

.PHONY: deps
deps: deps/stdlib

build/Random: Data/Random.juvix deps
	juvix compile Data/Random.juvix -o build/Random
	@rm $(TEMP_FILE)

build/Example: $(wildcard ./**/*.juvix) Example.juvix deps
	@mkdir -p build
	juvix compile Example.juvix -o build/Example

.PHONY: run-random
run-random: build/Random
	od -An -N2 -t u2 /dev/urandom | xargs | ./build/Random

.PHONY: run-quickcheck
run-quickcheck: build/Example
	od -An -N2 -t u2 /dev/urandom | xargs | ./build/Example

.PHONY: clean-build
clean-build:
	@rm -rf build/

.PHONY: clean-deps
clean-deps:
	@rm -rf deps/

.PHONY: clean
clean: clean-deps clean-build
