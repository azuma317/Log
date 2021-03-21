.PHONY: format lint
format:
	swift-format --mode format --recursive --in-place .
lint:
	swift-format --mode lint --recursive .
