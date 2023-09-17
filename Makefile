
all: run-quickcheck

build/Random: Data/Random.juvix
	juvix compile Data/Random.juvix -o build/Random

build/Example: $(wildcard ./**/*.juvix) Example.juvix
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
	juvix clean

.PHONY: clean
clean: clean-deps clean-build
