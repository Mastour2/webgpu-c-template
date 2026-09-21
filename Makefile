BUILD_DIR = build
DAWN_DIR ?= C:/libs/dawn/install

.PHONY: all build run clean help

all: build

build:
	cmake -B $(BUILD_DIR) -S . -DDAWN_DIR="$(DAWN_DIR)"
	cmake --build $(BUILD_DIR)

run: build
	@echo "Running $(BUILD_DIR)/WebGPU_Engine..."
	@if [ -f "./$(BUILD_DIR)/WebGPU_Engine" ]; then \
		./$(BUILD_DIR)/WebGPU_Engine; \
	elif [ -f "./$(BUILD_DIR)/Debug/WebGPU_Engine.exe" ]; then \
		./$(BUILD_DIR)/Debug/WebGPU_Engine.exe; \
	elif [ -f "./$(BUILD_DIR)/Release/WebGPU_Engine.exe" ]; me \
		./$(BUILD_DIR)/Release/WebGPU_Engine.exe; \
	elif [ -f "./$(BUILD_DIR)/WebGPU_Engine.exe" ]; then \
		./$(BUILD_DIR)/WebGPU_Engine.exe; \
	fi

clean:
	cmake --build $(BUILD_DIR) --target clean 2>/dev/null || true
	rm -rf $(BUILD_DIR)

help:
	@echo "Available commands:"
	@echo "  make build  - Configure and build the project"
	@echo "  make run    - Build and execute the binary"
	@echo "  make clean  - Remove build directory"
