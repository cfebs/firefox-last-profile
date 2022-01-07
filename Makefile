# TODO make ~/.local
PREFIX := .local

.PHONY: help
help:
	echo TODO

.PHONY: install
install:
	mkdir -p $(PREFIX) && \
		install -D -t $(PREFIX)/bin $(shell find ./local/bin -type f) && \
		install -m644 -D -t $(PREFIX)/share/applications $(shell find ./local/share/applications -type f) && \
		install -m644 -D -t $(PREFIX)/share/systemd/user $(shell find ./local/share/systemd/user -type f)

.PHONY: clean
clean:
	rm -rf .local/
