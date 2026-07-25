# 🎨 Sammly — AI Interior Design

[![Flutter Version](https://img.shields.io/badge/Flutter-%E2%89%A5%203.22-02569B?style=for-the-badge&logo=flutter)](https://flutter.dev)
[![Dart Version](https://img.shields.io/badge/Dart-%E2%89%A5%203.9-0175C2?style=for-the-badge&logo=dart)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-green.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-blue?style=for-the-badge&logo=android)](https://flutter.dev)

---

## 📱 Description

**Sammly** is an AI-powered mobile application built with Flutter that democratizes professional interior design. Using state-of-the-art Generative AI and Computer Vision, the app enables users to visualize, transform, and execute their living space ideas — all from their phone.

Sammly offers **Text-to-Image** generation from scratch, **Image-to-Image** room restyling, **Inpainting** for intelligent object removal, and **Smart Lens** for identifying real-world furniture from generated designs. The app also features a community-driven **Explore** section for sharing inspiration and a token-based reward system.

Whether you're redesigning your living room or looking for furniture that matches a style you love, Sammly bridges the gap between digital ideation and real-world execution.

---

## ✨ Key Features

### 🖼️ AI Design Generation
- **Text-to-Image**: Generate photorealistic interior designs from text prompts describing your dream space
- **Restyle (Image-to-Image)**: Upload a photo of your room and transform it into any style (Modern, Boho, Coastal, Rustic, Traditional)
- **Full Home Design**: Complete room-level design generation with style control
- Step-by-step guided generation flow with room type and style selection

### ✂️ Smart Object Removal (Inpainting)
- Paint over unwanted objects to intelligently remove them from any design
- AI reconstructs the background seamlessly, maintaining environmental integrity
- Interactive mask painting interface for precise editing control

### 🔍 Smart Lens — Visual Furniture Search
- Scan furniture items detected within AI-generated or uploaded designs
- Instantly find similar, purchasable real-world products
- Bridge the gap between inspiration and execution

### 🌍 Explore Community
- Browse and discover community-shared interior designs
- Like, save, and interact with other users' creations
- Static curated design collections for instant inspiration
- Follow designers and build your creative network

### ⭐ Favorites & History
- Save your favorite designs for quick access
- Complete generation history with easy retrieval
- Optimistic UI updates for instant, responsive interactions

### 👤 User Profiles & Social
- Full user registration and authentication (Email + OTP verification)
- Editable profiles with avatar upload via Cloudinary
- Follow/unfollow system for community engagement
- In-app notifications for social interactions

### 🎁 Token & Subscription System
- Token-based economy for AI generation credits
- Free tokens upon registration to get started
- Earn tokens by sharing designs with the community
- Package purchasing system for additional credits

### 🌍 Bilingual Support
- Full **Arabic (العربية)** and **English** interface
- RTL (Right-to-Left) support for Arabic text
- Easy locale switching without app restart
- Comprehensive translation files for all UI elements

### 🎨 Modern UI/UX
- Responsive design using **ScreenUtil** for all screen sizes
- Beautiful gradient-based design system (primary blue to teal)
- Smooth Lottie animations and page transitions
- Professional **Material Design 3** interface
- Custom Manrope font family throughout the app

---

## 🛠️ Tech Stack

### Architecture
- **Clean Architecture** with BLoC/Cubit pattern
- **MVVM** (Model-View-ViewModel) with Cubit
- **Repository Pattern** for data layer abstraction
- Feature-based modular folder structure

### Core Dependencies

| Package | Version | Purpose |
| :--- | :--- | :--- |
| `flutter_bloc` | `9.1.1` | State management (BLoC/Cubit) |
| `dio` | `5.9.2` | HTTP client for API communication |
| `flutter_screenutil` | `5.9.3` | Responsive UI scaling |
| `flutter_svg` | `2.2.4` | SVG rendering support |
| `hive` / `hive_flutter` | `2.2.3` / `1.1.0` | Local data persistence |
| `shared_preferences` | `2.5.4` | Lightweight key-value storage |
| `image_picker` | `1.0.7` | Camera and gallery image selection |
| `crop_your_image` | `2.0.0` | In-app image cropping |
| `lottie` | `3.1.0` | High-quality animations |
| `connectivity_plus` | `7.1.1` | Network connectivity monitoring |
| `internet_connection_checker_plus` | `3.0.0` | Internet availability detection |
| `flutter_dotenv` | `6.0.1` | Environment variable management |
| `dartz` | `0.10.1` | Functional programming (Either type) |
| `crypto` | `3.0.7` | Cryptographic utilities |
| `intl` | `0.20.2` | Internationalization & date formatting |
| `pinput` | `3.0.1` | OTP input fields |
| `dotted_border` | `2.1.0` | Decorative dotted borders |
| `flutter_staggered_grid_view` | `0.7.0` | Masonry/staggered grid layouts |
| `smooth_page_indicator` | `1.1.0` | Page indicator dots |
| `url_launcher` | `6.3.2` | Open URLs externally |
| `share_plus` | `13.1.0` | Native sharing functionality |
| `image_gallery_saver_plus` | `5.0.0` | Save images to device gallery |
| `image` | `4.8.0` | Image manipulation library |
| `package_info_plus` | `10.1.0` | App version information |
| `flutter_mask_painter` | `1.0.2` | Mask painting for inpainting feature |
| `path_provider` | `2.1.2` | File system paths |

### Development Tools
- `flutter_native_splash` — Custom animated splash screen
- `flutter_lints` — Static code analysis and linting
- `flutter_test` — Unit & widget testing framework
- `intl_utils` — Internationalization code generation

---

## 📋 Requirements

- **Flutter SDK:** `>= 3.22`
- **Dart SDK:** `^3.9.0`
- **Minimum Android:** API 21 (Android 5.0)
- **Minimum iOS:** 11.0
- **Device Permissions Required:**
  - Camera (for room photo capture)
  - Photo Gallery (for image selection)
  - Storage (for saving generated designs)
  - Internet (for AI generation & API access)

---

## 🚀 Getting Started

### 1️⃣ Installation
```bash
# Clone the repository
git clone https://github.com/yourusername/sammly.git
cd sammly

# Install dependencies
flutter pub get

# Run on connected device or emulator
flutter run
```

### 2️⃣ Environment Setup
Create a `.env` file in the project root with the following variables:
```env
BASE_URL=your_backend_api_url
CLOUDINARY_CLOUD_NAME=your_cloudinary_cloud_name
CLOUDINARY_API_KEY=your_cloudinary_api_key
CLOUDINARY_API_SECRET=your_cloudinary_api_secret
```

### 3️⃣ Run on Specific Device
```bash
# List available devices
flutter devices

# Run on specific device
flutter run -d <device_id>
```

### 4️⃣ Run with Flavor (if configured)
```bash
flutter run --flavor development -t lib/main.dart
```

---

## 📦 Building Release APK

### Standard Release APK
```bash
# Build release APK for all ABIs
flutter build apk --release

# Output location: build/app/outputs/flutter-apk/app-release.apk
```

### Split APK Per ABI (Recommended for Smaller Downloads)
```bash
# Build split APKs for different architectures
flutter build apk --release --split-per-abi

# Output location: build/app/outputs/flutter-apk/
# Files:
# - app-armeabi-v7a-release.apk      (32-bit ARM, smallest, older devices)
# - app-arm64-v8a-release.apk         (64-bit ARM, modern Android devices)
# - app-x86_64-release.apk            (64-bit Intel, emulators)
```

### App Bundle (AAB) for Play Store
```bash
# Build app bundle
flutter build appbundle --release

# Output location: build/app/outputs/bundle/release/app-release.aab
```

### Build Flags Explained

| Flag | Purpose |
| :--- | :--- |
| `--release` | Optimized production build, disabled debugging |
| `--split-per-abi` | Separate APK per device architecture |
| `--obfuscate` | Code obfuscation for security |
| `--split-debug-info` | Split debug symbols for smaller build |

---

## 📁 Project Structure

```text
sammly/
├── lib/
│   ├── main.dart                          # App entry point & BLoC providers
│   │
│   ├── core/
│   │   ├── constant/                      # App colors, gradients & constants
│   │   ├── functions.dart                 # Utility helper functions
│   │   ├── localization/                  # Locale cubit & language management
│   │   ├── networking/                    # Dio setup, API constants, Cloudinary
│   │   │   ├── api_constants.dart         # All API endpoint definitions
│   │   │   ├── dio_helper.dart            # HTTP client configuration
│   │   │   ├── cloudinary_service.dart    # Image upload service
│   │   │   └── network_cubit/             # Connectivity state management
│   │   ├── routing/                       # Navigation & route definitions
│   │   ├── shared_pref/                   # SharedPreferences wrapper
│   │   ├── theme/                         # App theme & text styles
│   │   ├── utils/                         # Backend message translator & helpers
│   │   └── widgets/                       # Reusable widgets (image cropper, etc.)
│   │
│   ├── features/
│   │   ├── Auth/                          # Authentication module
│   │   │   ├── cubit/                     # Login, Register, Password cubits
│   │   │   ├── data/                      # Auth models & repository
│   │   │   └── presentation/              # Login, Signup, OTP, Password views
│   │   ├── home/                          # Home screen & dashboard
│   │   ├── generate/                      # AI Design Generation
│   │   │   ├── cubit/                     # Generation state management
│   │   │   ├── data/                      # Generation models & repository
│   │   │   └── presentation/views/        # Text-to-Image, Restyle, Mask, 
│   │   │       │                          #   Full Home, Result views
│   │   │       └── widgets/               # Generation UI components
│   │   ├── generate_loading/              # Generation progress & loading
│   │   ├── smart_lens/                    # Visual furniture search
│   │   ├── Explore/                       # Community designs feed
│   │   ├── History/                       # Design generation history
│   │   ├── favorite/                      # Saved favorite designs
│   │   ├── following/                     # Follow system & user network
│   │   ├── notifications/                 # In-app notifications
│   │   ├── profile/                       # User profile management
│   │   ├── search/                        # Design & user search
│   │   ├── subscrition/                   # Token packages & earning
│   │   ├── support/                       # Customer support & feedback
│   │   ├── onboarding/                    # First-time user experience
│   │   ├── splash/                        # Splash screen
│   │   └── layout/                        # Bottom navigation layout
│   │
│   ├── generated/                         # Auto-generated localization code
│   └── l10n/                              # Translation files
│       ├── intl_en.arb                    # English translations
│       └── intl_ar.arb                    # Arabic translations
│
├── assets/
│   ├── images/                            # App images, icons & illustrations
│   │   └── room_style/                    # Room style preview images
│   │       ├── boho/                      # Boho style samples
│   │       ├── coastal/                   # Coastal style samples
│   │       ├── modern/                    # Modern style samples
│   │       ├── rustic/                    # Rustic style samples
│   │       └── trad/                      # Traditional style samples
│   └── fonts/                             # Manrope font family (200–800 weights)
│
├── android/                               # Android native configuration
├── ios/                                   # iOS native configuration
├── .env                                   # Environment variables (not committed)
├── pubspec.yaml                           # Dependencies & assets
└── analysis_options.yaml                  # Lint rules
```

---

## 🔐 Environment Variables

### Backend API
The app connects to a custom backend API. Configure the base URL in your `.env` file:
```env
BASE_URL=https://your-backend-url.com
```

### Cloudinary (Image Upload)
Sammly uses Cloudinary for user avatar and design image uploads:
```env
CLOUDINARY_CLOUD_NAME=your_cloud_name
CLOUDINARY_API_KEY=your_api_key
CLOUDINARY_API_SECRET=your_api_secret
```

> ⚠️ **Important:** Never commit your `.env` file to version control. Make sure it's listed in `.gitignore`.

---

## 🔗 API Endpoints Overview

| Category | Endpoint | Description |
| :--- | :--- | :--- |
| **Auth** | `POST /api/auth/register` | User registration |
| **Auth** | `POST /api/auth/login` | User login |
| **Auth** | `POST /api/auth/email/verify` | Email OTP verification |
| **Auth** | `POST /api/auth/password/forgot` | Forgot password flow |
| **Design** | `POST /api/designs/generate` | Text-to-Image generation |
| **Design** | `POST /api/designs/restyle` | Image-to-Image restyling |
| **Design** | `POST /api/designs/full-home` | Full home design generation |
| **Design** | `POST /api/designs/mask` | Object removal / inpainting |
| **Design** | `GET /api/designs/history` | User's generation history |
| **Social** | `GET /api/designs/shared` | Community shared designs |
| **Smart Lens** | `GET /api/designs/search/{id}` | Visual furniture search |
| **Favorites** | `GET /api/designs/favorites` | User's saved designs |
| **Profile** | `GET /api/profile` | Get user profile |
| **Payment** | `GET /api/payment/packages` | Available token packages |

---

## 📝 Contributing

We welcome contributions! Please follow these guidelines:

### 1. Fork & Clone
```bash
git clone https://github.com/yourusername/sammly.git
cd sammly
```

### 2. Create Feature Branch
```bash
git checkout -b feature/your-feature-name
# or
git checkout -b fix/your-bug-fix
```

### 3. Code Standards
- Follow [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Use meaningful variable and function names
- Add comments for complex logic
- Run `flutter analyze` before committing

```bash
# Check code quality
flutter analyze

# Format code
dart format lib/

# Run tests
flutter test
```

### 4. Commit & Push
```bash
git add .
git commit -m "feat: Add your feature description"
git push origin feature/your-feature-name
```

### 5. Create Pull Request
- Provide clear description of changes
- Reference related issues
- Ensure all tests pass

---

## 📄 License

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for details.

**Copyright © 2026 Ahmed A. Alawadhi**

You are free to:

✅ Use commercially and privately
✅ Modify the code
✅ Distribute the code
✅ Use for patent purposes

Under the condition of:

📋 License and copyright notice included

---

## 🙏 Acknowledgments

### Libraries & Frameworks
- **[Flutter](https://flutter.dev)** & **[Dart](https://dart.dev)** — Cross-platform mobile framework
- **[BLoC Pattern](https://bloclibrary.dev)** — Predictable state management
- **[Dio](https://pub.dev/packages/dio)** — Powerful HTTP networking
- **[Cloudinary](https://cloudinary.com)** — Cloud-based image management

### Contributors
- **Ahmed A. Alawadhi** — Project Lead

### Special Thanks
- The Flutter community for continuous support and packages
- All contributors and beta testers

---

## 📞 Support

For issues, questions, or suggestions:

- 🐛 **Issues:** [GitHub Issues](https://github.com/yourusername/sammly/issues)
- 📧 **Email:** ahmedalaa10204@gmail.com

---

## 🔄 Version History

### v1.0.0 (2026-07-25)
✅ Initial release
✅ AI-powered Text-to-Image design generation
✅ Image-to-Image room restyling (5 styles)
✅ Smart object removal with inpainting
✅ Smart Lens visual furniture search
✅ Community Explore feed with likes & sharing
✅ User authentication with OTP verification
✅ Favorite designs & generation history
✅ Follow system & social notifications
✅ Token-based economy with earning & purchasing
✅ Bilingual support (Arabic & English) with RTL
✅ Responsive Material Design 3 interface
✅ Cloudinary-powered image uploads
✅ Offline-capable local storage with Hive
