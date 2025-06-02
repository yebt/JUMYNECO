
# Colors for output
RED := \033[0;31m
GREEN := \033[1;32m
YELLOW := \033[0;33m
BLUE := \033[0;34m
NC := \033[0m # No Color

# Default target
.PHONY: help
help: ## Show help
	@echo -e "$(GREEN) ===== Actions ====$(NC)"
	@echo -e "$(YELLOW) clean $(NC)"
	@echo -e "$(YELLOW) format $(NC)"
	# @echo -e ""
	# @echo -e "$(GREEN)🚀 Development:$(NC)"
	# @grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | grep -E "(serve|dev)" | awk 'BEGIN {FS = ":.*?## "}; {printf "  $(YELLOW)%-20s$(NC) %s\n", $$1, $$2}'
	# @echo -e ""

.PHONY: clean
clean:
	rm -rf $(HOME)/.local/share/nvim
	rm -rf $(HOME)/.local/state/nvim
	rm -rf $(HOME)/.cache/nvim

.PHONY: format
format:
	@echo -e "$(BLUE) Cleaning $(NC)"
	stylua ./{init.lua,lua/**/*.lua,after/**/*.lua,lsp/**/.lua,plugin/**/.lua}

# Not use files like target
%: force
	@:
force: ;
