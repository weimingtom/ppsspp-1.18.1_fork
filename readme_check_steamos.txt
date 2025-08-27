#include <cstdlib> // Required for getenv

// Function to check if the application is running on SteamOS
bool isRunningOnSteamOS() {
    // getenv returns a C-style string pointer to the value of the environment variable, or NULL if not found.
    char* steamOSVariable = std::getenv("SteamOS"); 
    return (steamOSVariable != nullptr); // Returns true if the "SteamOS" environment variable exists
}

// Function to check if the application is in Steam Deck's Gaming Mode
// This is an example of checking for a specific value in the SteamOS environment variable.
// The actual value might vary or not be explicitly set for Gaming Mode vs Desktop Mode.
// A more robust check might involve other environment variables or Steamworks API.
bool isRunningInGamingMode() {
    char* steamOSVariable = std::getenv("SteamOS");
    if (steamOSVariable != nullptr) {
        // You would need to determine the specific value that indicates Gaming Mode.
        // For demonstration, let's assume "1" or "true" indicates Gaming Mode.
        // This is a hypothetical example and might not be accurate for actual SteamOS.
        return (std::string(steamOSVariable) == "1" || std::string(steamOSVariable) == "true"); 
    }
    return false;
}

int main() {
    if (isRunningOnSteamOS()) {
        // Your code for Steam Deck specific behavior
        if (isRunningInGamingMode()) {
            // Your code for Gaming Mode specific behavior
        } else {
            // Your code for Desktop Mode specific behavior
        }
    } else {
        // Your code for non-Steam Deck environments
    }
    return 0;
}
