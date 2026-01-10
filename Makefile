# Makefile for applock-macos
# Build Touch ID gated app launcher

SWIFT = swiftc
# Use Xcode's SDK if available (fixes toolchain mismatch issues)
XCODE_SDK := $(shell xcrun --show-sdk-path 2>/dev/null)
ifdef XCODE_SDK
SWIFT_FLAGS = -O -whole-module-optimization -sdk $(XCODE_SDK)
else
SWIFT_FLAGS = -O -whole-module-optimization
endif
PREFIX ?= /usr/local
BIN_DIR = $(PREFIX)/bin

# Source files
SOURCES = Sources/applock.swift
TARGET = applock

.PHONY: all build clean install uninstall test help

all: build

build: $(TARGET)

$(TARGET): $(SOURCES)
	@echo "→ Building $(TARGET)..."
	$(SWIFT) $(SWIFT_FLAGS) -o $(TARGET) $(SOURCES)
	@echo "✓ Build complete: $(TARGET)"

# Build universal binary (Intel + Apple Silicon)
universal: $(SOURCES)
	@echo "→ Building universal binary..."
	$(SWIFT) $(SWIFT_FLAGS) -target x86_64-apple-macosx10.12 -o $(TARGET)-x86_64 $(SOURCES)
	$(SWIFT) $(SWIFT_FLAGS) -target arm64-apple-macosx11.0 -o $(TARGET)-arm64 $(SOURCES)
	lipo -create -output $(TARGET) $(TARGET)-x86_64 $(TARGET)-arm64
	rm -f $(TARGET)-x86_64 $(TARGET)-arm64
	@echo "✓ Universal binary created: $(TARGET)"

clean:
	@echo "→ Cleaning..."
	rm -f $(TARGET) $(TARGET)-x86_64 $(TARGET)-arm64
	@echo "✓ Clean complete"

install: build
	@echo "→ Installing to $(BIN_DIR)..."
	@mkdir -p $(BIN_DIR)
	cp $(TARGET) $(BIN_DIR)/$(TARGET)
	chmod +x $(BIN_DIR)/$(TARGET)
	@echo "✓ Installed: $(BIN_DIR)/$(TARGET)"

uninstall:
	@echo "→ Uninstalling..."
	rm -f $(BIN_DIR)/$(TARGET)
	@echo "✓ Uninstalled"

test: build
	@echo "→ Running tests..."
	./$(TARGET) --help
	./$(TARGET) --version
	@echo "✓ Basic tests passed"

help:
	@echo "applock-macos Makefile"
	@echo ""
	@echo "Targets:"
	@echo "  build      Build the binary (default)"
	@echo "  universal  Build universal binary (Intel + Apple Silicon)"
	@echo "  install    Install to PREFIX/bin (default: /usr/local/bin)"
	@echo "  uninstall  Remove installed binary"
	@echo "  clean      Remove build artifacts"
	@echo "  test       Run basic tests"
	@echo "  help       Show this help"
	@echo ""
	@echo "Variables:"
	@echo "  PREFIX     Installation prefix (default: /usr/local)"
	@echo ""
	@echo "Examples:"
	@echo "  make                    # Build"
	@echo "  make install            # Install to /usr/local/bin"
	@echo "  make PREFIX=~/.local install  # Install to ~/.local/bin"
