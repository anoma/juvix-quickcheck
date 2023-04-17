.PHONY : random-gen

TEMP_FILE := $(shell mktemp)
random-gen:
	juvix compile Data/Random.juvix -o $(TEMP_FILE)
	od -An -N2 -t u2 /dev/urandom | xargs | $(TEMP_FILE)
	@rm $(TEMP_FILE)

run-quickcheck:
	juvix compile Example.juvix -o $(TEMP_FILE)
	od -An -N2 -t u2 /dev/urandom | xargs | $(TEMP_FILE)
	@rm $(TEMP_FILE)
