import Foundation
import LocalAuthentication

/// applock - Touch ID gated app launcher for macOS
/// Author: vdutts7 (https://vd7.io)
/// Source: https://github.com/vdutts7/applock-macos
/// License: MIT

let VERSION = "1.0.0"
let AUTHOR = "vdutts7"
let HOMEPAGE = "https://vd7.io"
let REPO = "https://github.com/vdutts7/applock-macos"

struct AppLock {
    
    enum AuthPolicy: String {
        case biometrics = "biometrics"
        case biometricsOrWatch = "biometricsOrWatch"
        case deviceOwner = "deviceOwner"
    }
    
    static func main() {
        let args = CommandLine.arguments
        
        // Parse arguments
        guard args.count >= 2 else {
            printUsage()
            exit(1)
        }
        
        let appPath = args[1]
        let reason = args.count >= 3 ? args[2] : "authenticate to open app"
        
        // Handle flags
        if appPath == "--help" || appPath == "-h" {
            printUsage()
            exit(0)
        }
        
        if appPath == "--version" || appPath == "-v" {
            print("applock \(VERSION)")
            print("Author: \(AUTHOR) (\(HOMEPAGE))")
            print("Source: \(REPO)")
            exit(0)
        }
        
        // Verify app exists
        let fileManager = FileManager.default
        guard fileManager.fileExists(atPath: appPath) else {
            fputs("Error: App not found at path: \(appPath)\n", stderr)
            exit(1)
        }
        
        // Authenticate
        authenticate(reason: reason) { success in
            if success {
                openApp(at: appPath)
            } else {
                fputs("Authentication failed\n", stderr)
                exit(1)
            }
        }
        
        // Keep running until authentication completes
        RunLoop.main.run()
    }
    
    static func authenticate(reason: String, completion: @escaping (Bool) -> Void) {
        let context = LAContext()
        var error: NSError?
        
        // Check if biometric authentication is available
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            if let error = error {
                fputs("Biometric authentication not available: \(error.localizedDescription)\n", stderr)
            }
            
            // Fall back to device owner authentication (password)
            if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
                evaluatePolicy(context: context, policy: .deviceOwnerAuthentication, reason: reason, completion: completion)
            } else {
                fputs("No authentication method available\n", stderr)
                completion(false)
            }
            return
        }
        
        // Use biometric authentication
        evaluatePolicy(context: context, policy: .deviceOwnerAuthenticationWithBiometrics, reason: reason, completion: completion)
    }
    
    static func evaluatePolicy(context: LAContext, policy: LAPolicy, reason: String, completion: @escaping (Bool) -> Void) {
        context.evaluatePolicy(policy, localizedReason: reason) { success, error in
            DispatchQueue.main.async {
                if success {
                    completion(true)
                } else {
                    if let error = error as? LAError {
                        switch error.code {
                        case .userCancel:
                            fputs("Authentication cancelled by user\n", stderr)
                        case .userFallback:
                            fputs("User chose fallback authentication\n", stderr)
                        case .biometryNotAvailable:
                            fputs("Biometry not available\n", stderr)
                        case .biometryNotEnrolled:
                            fputs("No biometric data enrolled\n", stderr)
                        case .biometryLockout:
                            fputs("Biometry is locked out\n", stderr)
                        default:
                            fputs("Authentication error: \(error.localizedDescription)\n", stderr)
                        }
                    }
                    completion(false)
                }
            }
        }
    }
    
    static func openApp(at path: String) {
        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/usr/bin/open")
        process.arguments = [path]
        
        do {
            try process.run()
            process.waitUntilExit()
            exit(0)
        } catch {
            fputs("Failed to open app: \(error.localizedDescription)\n", stderr)
            exit(1)
        }
    }
    
    static func printUsage() {
        let usage = """
        applock - Touch ID gated app launcher for macOS
        
        Author: \(AUTHOR) (\(HOMEPAGE))
        Source: \(REPO)
        
        USAGE:
            applock <app_path> [reason]
        
        ARGUMENTS:
            app_path    Path to the .app bundle to open
            reason      Optional message shown in Touch ID prompt
        
        OPTIONS:
            -h, --help      Show this help message
            -v, --version   Show version
        
        EXAMPLES:
            applock /Applications/Signal.app
            applock /Applications/Signal.app "Unlock Signal"
            applock ~/Apps/MyApp.app "Authenticate to continue"
        
        EXIT CODES:
            0   Success - app opened
            1   Failure - authentication failed or error
        """
        print(usage)
    }
}

// Entry point
AppLock.main()
