.PHONY : random-gen

TEMP_FILE := $(shell mktemp)
random-gen:
	juvix compile Data/Random.juvix -o $(TEMP_FILE)
	od -An -N8 -t u8 /dev/urandom | xargs | $(TEMP_FILE)
	@rm $(TEMP_FILE)

run-quickcheck:
	juvix compile Test/QuickCheck.juvix -o $(TEMP_FILE)
	od -An -N8 -t u8 /dev/urandom | xargs | $(TEMP_FILE)
	@rm $(TEMP_FILE)
