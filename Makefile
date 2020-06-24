PHONY: \
	__build-ci-image \
	clean \
	lint \
	update-requirements

DOCKER_RUN_ARGS = -v $(shell pwd):/code -u $$(stat -c "%u:%g" $(shell pwd))
CI_DOCKER_IMAGE_NAME = mypy-issue
DOCKER_RUN = @docker run $(DOCKER_RUN_ARGS) $(CI_DOCKER_IMAGE_NAME)

__build-ci-image:
	@docker build -q -f .docker/ci.Dockerfile -t $(CI_DOCKER_IMAGE_NAME) .

clean:
	@find . -name '*.pyc' -delete
	@find . -name '__pycache__' -exec rm -rf {} +
	@rm -rf .cache
	@rm -rf .mypy_cache

reproduce: __build-ci-image
	$(DOCKER_RUN) mypy mypy_issue.py

update-requirements: __build-ci-image
	$(DOCKER_RUN) scripts/update_requirements.sh
