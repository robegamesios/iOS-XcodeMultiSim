#!/bin/bash

# Description: Script to build once and run app on multiple simulators
# Run on terminal: /bin/sh buildAndRunMultipleSimulators.sh (uncomment all UDIDs on simulators section of this script)
# Author: Rob Enriquez
# Last Update: 8/31/2024

# Example project
# project name = SwiftUI-WeatherApp
# app name = SwiftUI-WeatherApp
# scheme = SwiftUI-WeatherApp
# bundle identifier = com.robe.games.ios.SwiftUI-WeatherApp

# Define your project and scheme
project_name="SwiftUI-WeatherApp"
scheme="SwiftUI-WeatherApp"
app_name="SwiftUI-WeatherApp"
bundle_identifier="com.robe.games.ios.SwiftUI-WeatherApp"
sdk="iphonesimulator"
configuration="Debug"
project_path="$(dirname "$0")/${app_name}.xcodeproj"  # Relative path to the Xcode project

# Define simulators (open Run Destinations in Xcode Cmd+Shift+2 and check the device identifier)
simulators=(
    "F4CF5FA5-3DEB-40A0-BEC7-EF8B119BAF2A"  # iPad Pro M4 13 inch
    "196CC12E-FC60-40D6-A225-2D569C4DA4E5"  # iPad Mini 6th gen
    "DEBDE3E9-A4B8-412C-A400-2D4C3F560F6D"  # iPhone SE (3rd gen)
    # "B9B91B7C-D1C1-490F-BF70-2B089A5A82EC"  # iPhone 15 (comment if running on Xcode, otherwise uncomment to use on CLI)

)

# Build the Xcode project
echo "Building the Xcode project..."
xcodebuild -project "$project_path" -scheme "$scheme" -sdk "$sdk" -configuration "$configuration" build

# Find the .app file
app_path=$(find ~/Library/Developer/Xcode/DerivedData/${project_name}-*/Build/Products/Debug-iphonesimulator -name "${app_name}.app" | head -n 1)

if [ -z "$app_path" ]; then
    echo "Error: .app file not found."
    exit 1
fi

echo "App found at: $app_path"

# Install and launch the app on each simulator
for simulator in "${simulators[@]}"; do
    # Check if the simulator is already booted
    if ! xcrun simctl list booted | grep -q "$simulator"; then
        echo "Booting simulator $simulator..."
        xcrun simctl boot "$simulator"
    else
        echo "Simulator $simulator is already booted."
    fi

    echo "Installing app on simulator $simulator..."
    xcrun simctl install "$simulator" "$app_path"

    echo "Launching app on simulator $simulator..."
    xcrun simctl launch "$simulator" "$bundle_identifier"
done

echo "All operations completed."
