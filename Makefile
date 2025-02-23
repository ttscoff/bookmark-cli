# Makefile for building and installing an Xcode project

# Variables
PROJECT_NAME = bookmark
TARGET = bookmark
BUILD_DIR = Build/Release

# Determine Homebrew prefix
ifeq ($(HOMEBREW_PREFIX),)
    ifeq ($(shell command -v brew),)
        HOME_BREW_PREFIX := /usr/local
    else
        HOME_BREW_PREFIX := $(shell brew --prefix)
    endif
else
    HOME_BREW_PREFIX := $(HOMEBREW_PREFIX)
endif

INSTALL_DIR = $(HOME_BREW_PREFIX)/bin

# Default target
all: build install

# Build the project using xcodebuild
build:
	xcodebuild -project $(PROJECT_NAME).xcodeproj -target $(TARGET) -configuration Release

# Install the built binary
install:
	cp $(BUILD_DIR)/$(TARGET) $(INSTALL_DIR)/

# Clean build artifacts
clean:
	xcodebuild -project $(PROJECT_NAME).xcodeproj -target $(TARGET) clean

.PHONY: all build install clean