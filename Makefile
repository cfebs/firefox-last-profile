PREFIX = ~/.local

.PHONY: help
help: ## prints this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: enable
enable: ## enables service, sets default browser
	systemctl daemon-reload --user
	systemctl --user enable --now firefox-track-focus.service
	xdg-settings set default-web-browser firefox-last-profile.desktop

.PHONY: install
install: ## installs files
	mkdir -p $(PREFIX)
	install -D -t $(PREFIX)/bin $(shell find ./local/bin -type f)
	install -m644 -D -t $(PREFIX)/share/applications $(shell find ./local/share/applications -type f)
	install -m644 -D -t $(PREFIX)/share/systemd/user $(shell find ./local/share/systemd/user -type f)

.PHONY: clean
clean:
	@rm -rf .local/
