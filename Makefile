########################
### Makefile Helpers ###
########################

BOLD := \033[1m
CYAN := \033[36m
GREEN := \033[32m
RESET := \033[0m

REPO_SKILLS := $(CURDIR)/skills
SHARE_TARGETS := $(HOME)/.gemini/antigravity/skills $(HOME)/.codex/skills

.PHONY: help
.DEFAULT_GOAL := help
help: ## Prints all the targets in the Makefile
	@echo ""
	@echo "$(BOLD)$(CYAN)Grove Agent Skills$(RESET)"
	@echo ""
	@echo "$(BOLD)=== Skills ===$(RESET)"
	@grep -h -E '^(link|list|publish).*:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "$(CYAN)%-40s$(RESET) %s\n", $$1, $$2}'
	@echo ""
	@echo "$(BOLD)=== Info ===$(RESET)"
	@grep -h -E '^(help|status|test).*:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "$(CYAN)%-40s$(RESET) %s\n", $$1, $$2}'
	@echo ""

########################
### Skills           ###
########################

ALL_TARGETS := $(HOME)/.claude/skills $(SHARE_TARGETS)

.PHONY: link-skills
link-skills: ## Symlink repo skills into Claude, Gemini, and Codex
	@for target_dir in $(ALL_TARGETS); do \
		mkdir -p "$$target_dir"; \
		echo "=== $$target_dir ==="; \
		for skill in $(REPO_SKILLS)/*/; do \
			name=$$(basename "$$skill"); \
			link="$$target_dir/$$name"; \
			if [ -L "$$link" ]; then \
				current=$$(readlink "$$link"); \
				if [ "$$current" != "$$skill" ]; then \
					rm "$$link"; \
					ln -s "$$skill" "$$link"; \
					echo "  ~ $$name (repointed)"; \
				fi; \
			elif [ -d "$$link" ]; then \
				rm -rf "$$link"; \
				ln -s "$$skill" "$$link"; \
				echo "  ~ $$name (replaced real dir)"; \
			else \
				ln -s "$$skill" "$$link"; \
				echo "  + $$name"; \
			fi; \
		done; \
		for link in "$$target_dir"/*; do \
			[ -L "$$link" ] || continue; \
			readlink "$$link" | grep -q "$(REPO_SKILLS)" || continue; \
			[ -e "$$link" ] || { echo "  - $$(basename $$link) (stale)"; rm -f "$$link"; }; \
		done; \
	done
	@echo "Done"

.PHONY: list-skills
list-skills: ## List all skills with descriptions
	@echo ""
	@echo "$(BOLD)$(CYAN)Published Skills$(RESET)"
	@echo ""
	@for skill in $(REPO_SKILLS)/*/SKILL.md; do \
		name=$$(grep "^name:" "$$skill" | sed 's/name: *//'); \
		desc=$$(grep "^description:" "$$skill" | sed 's/description: *//; s/^"//; s/"$$//'); \
		printf "  $(CYAN)%-35s$(RESET) %s\n" "$$name" "$$desc"; \
	done
	@echo ""

.PHONY: publish
publish: ## Install all skills globally via npx, then restore local symlinks
	@echo "Installing all skills globally via npx..."
	@cd ~ && npx skills add buildwithgrove/agent-skills --all -g -y
	@echo ""
	@echo "Restoring local symlinks..."
	@$(MAKE) link-skills

########################
### Info             ###
########################

.PHONY: status
status: ## Show repository status
	@echo "Repository Status:"
	@echo "  Skills: $$(find skills -maxdepth 1 -mindepth 1 -type d 2>/dev/null | wc -l | tr -d ' ') skills"

.PHONY: test
test: ## Validate skill frontmatter and repo consistency
	@echo "Running checks..."
	@errors=0; \
	for skill in $(REPO_SKILLS)/*/SKILL.md; do \
		name=$$(grep "^name:" "$$skill" | sed 's/name: *//'); \
		desc=$$(grep "^description:" "$$skill" | sed 's/description: *//'); \
		dir_name=$$(basename $$(dirname "$$skill")); \
		if [ -z "$$name" ]; then \
			echo "  FAIL $$dir_name: missing 'name' in frontmatter"; errors=$$((errors+1)); \
		elif [ "$$name" != "$$dir_name" ]; then \
			echo "  FAIL $$dir_name: name '$$name' doesn't match directory"; errors=$$((errors+1)); \
		fi; \
		if [ -z "$$desc" ]; then \
			echo "  FAIL $$dir_name: missing 'description' in frontmatter"; errors=$$((errors+1)); \
		fi; \
	done; \
	skill_count=$$(find skills -maxdepth 1 -mindepth 1 -type d | wc -l | tr -d ' '); \
	skillmd_count=$$(find skills -name SKILL.md | wc -l | tr -d ' '); \
	if [ "$$skill_count" != "$$skillmd_count" ]; then \
		echo "  FAIL skill dir count ($$skill_count) != SKILL.md count ($$skillmd_count)"; errors=$$((errors+1)); \
	fi; \
	echo "  $$skill_count skills checked"; \
	if [ $$errors -gt 0 ]; then \
		echo "FAILED: $$errors error(s)"; exit 1; \
	else \
		echo "All checks passed"; \
	fi
