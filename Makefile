BUILD_DIR = build

DAWN_DIR ?=

.PHONY: all build run clean help

all: build


build:
	cmake -B $(BUILD_DIR) -S . -DDAWN_DIR="$(DAWN_DIR)"
	cmake --build $(BUILD_DIR)


run: build
	@echo "Running Graphics..."

	@if [ -f "./$(BUILD_DIR)/Graphics" ]; then \
		./$(BUILD_DIR)/Graphics; \
	elif [ -f "./$(BUILD_DIR)/Debug/Graphics.exe" ]; then \
		./$(BUILD_DIR)/Debug/Graphics.exe; \
	elif [ -f "./$(BUILD_DIR)/Release/Graphics.exe" ]; then \
		./$(BUILD_DIR)/Release/Graphics.exe; \
	elif [ -f "./$(BUILD_DIR)/Graphics.exe" ]; then \
		./$(BUILD_DIR)/Graphics.exe; \
	else \
		echo "Executable not found."; \
		exit 1; \
	fi


clean:
	rm -rf $(BUILD_DIR)


help:
	@echo "Available commands:"
	@echo "  make build  - Configure and build the project"
	@echo "  make run    - Build and execute the binary"
	@echo "  make clean  - Remove build directory"
	@echo "  make help   - Show this help"
