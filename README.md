🔐 KmmFirebaseAuth
A Kotlin Multiplatform (KMP) authentication library that provides a clean, shared authentication layer for Android and iOS, powered by Firebase Authentication.
This library exposes use-case driven APIs, a reactive auth state, and Swift-friendly wrappers for ergonomic consumption in SwiftUI.

✨ Features
✅ Email & password authentication
✅ Google Sign-In
✅ Logout
✅ Reactive auth state (Flow → Swift observer)
✅ Clean domain models (AuthResult, AuthError)
✅ SwiftUI-friendly ViewModel usage
✅ No Firebase logic in SwiftUI views

## Installation

### 1. Add KmmFirebaseAuth Package

In Xcode:
- **File** → **Add Package Dependencies**
- URL: `https://github.com/developerroshan09/kmm-firebase-auth-spm`
- Version: 1.0.0+

### 2. Add Firebase SDK (Required)

⚠️ **Important**: You must also add Firebase to your iOS app.

**Via Swift Package Manager:**
- **File** → **Add Package Dependencies**
- URL: `https://github.com/firebase/firebase-ios-sdk`
- Select: **FirebaseAuth**, **FirebaseCore**

**Or via CocoaPods:**
```ruby
pod 'Firebase/Auth'
pod 'Firebase/Core'
```

### 3. Configure Firebase

## Installation

### 1. Add KmmFirebaseAuth Package

In Xcode:
- **File** → **Add Package Dependencies**
- URL: `https://github.com/developerroshan09/kmm-firebase-auth-spm`
- Version: 1.0.0+

### 2. Add Firebase SDK (Required)

⚠️ **Important**: You must also add Firebase to your iOS app.

**Via Swift Package Manager:**
- **File** → **Add Package Dependencies**
- URL: `https://github.com/firebase/firebase-ios-sdk`
- Select: **FirebaseAuth**, **FirebaseCore**

**Or via CocoaPods:**
```ruby
pod 'Firebase/Auth'
pod 'Firebase/Core'
```

### 3. Configure Firebase
🔧 Firebase Setup (iOS)
1️⃣ Create Firebase Project
Go to Firebase Console
Create a new project
Add an iOS app
Download GoogleService-Info.plist

2️⃣ Add GoogleService-Info.plist
Add it to your iOS app target
Ensure “Copy items if needed” is checked

3️⃣ Enable Auth Providers
In Firebase Console → Authentication → Sign-in method:
Enable Email / Password
Enable Google

4️⃣ Configure URL Types (IMPORTANT)
Open GoogleService-Info.plist
Copy REVERSED_CLIENT_ID
In Xcode:
Target → Info → URL Types
Add new URL Type
Paste the reversed client ID
This is required for Google Sign-In to work.

🚀 AppDelegate Setup (iOS)
Your main app must configure Firebase once at launch.
import SwiftUI
import KmmFirebaseAuth
import FirebaseCore
import GoogleSignIn

class AppDelegate: NSObject, UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {

        // ✅ Configure Firebase via KMP AuthComponent
        AuthComponent().configure()

        // ✅ Configure Google Sign-In
        if let clientID = FirebaseApp.app()?.options.clientID {
            GIDSignIn.sharedInstance.configuration =
                GIDConfiguration(clientID: clientID)
        }

        return true
    }

    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey: Any] = [:]
    ) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
}

@main
struct ConsumerAppApp: App {
@UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
⚠️ Do not call FirebaseApp.configure() directly in the app.
The library handles this internally.

🧠 Using the Library (SwiftUI)
AuthViewModel (Provided Example)
@MainActor
final class AuthViewModel: ObservableObject {

    @Published private(set) var authState: AuthState = AuthState.LoggedOut()
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let authComponent = AuthComponent()
    private var observer: AuthStateObserver?

    init() {
        observer = AuthStateObserver(
            scope: KmmScope().main,
            flow: authComponent.authState
        ) { [weak self] state in
            self?.authState = state
        }
    }

    func login(email: String, password: String) {
        isLoading = true
        Task {
            defer { isLoading = false }

            let result = try await authComponent
                .loginUseCase
                .invokeWrapper(email: email, password: password)

            switch result {
            case let success as UserResult.Success:
                errorMessage = nil

            case let failure as UserResult.Failure:
                errorMessage = failure.error.toUIError().message

            default:
                errorMessage = "Unexpected error"
            }
        }
    }

    func logout() {
        isLoading = true
        Task {
            defer { isLoading = false }

            let result = try await authComponent
                .logoutUseCase
                .invokeWrapper()

            switch result {
            case _ as LogoutResult.Success:
                errorMessage = nil

            case let failure as LogoutResult.Failure:
                errorMessage = failure.error.toUIError().message

            default:
                errorMessage = "Unexpected error"
            }
        }
    }

    deinit {
        observer?.cancel()
    }
}
