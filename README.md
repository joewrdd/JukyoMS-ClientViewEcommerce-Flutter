# JukyoMS - Flutter E-commerce App

A modern and feature-rich e-commerce mobile application built with Flutter and Firebase, offering a seamless shopping experience with robust user management and product handling capabilities.

## Features

🛍️ **Advanced Shopping Experience**

- Product categorization and filtering
- Variant selection system
- Detailed product views
- Rating and review system
- Wishlist functionality
- Smart cart management

💳 **Order Management**

- Multiple payment methods
- Order tracking
- Delivery status updates
- Order history
- Multiple shipping addresses

👤 **User Management**

- Secure authentication system
- Profile management
- Address management
- Order tracking
- Review management

🎨 **Modern UI/UX**

- Responsive design
- Dark/Light theme
- Custom animations
- Interactive components
- Intuitive navigation

## Technical Stack

### Frontend

- Flutter for cross-platform development
- GetX for state management
- Custom widgets and animations
- Firebase UI components
- Image handling and caching

### Backend

- Firebase Authentication
- Cloud Firestore
- Firebase Storage
- Firebase Cloud Functions
- Real-time data synchronization

## Getting Started

### Prerequisites

- Flutter (latest version)
- Firebase account
- Android Studio / VS Code
- Git

### Installation

1. Clone the repository

```bash
git clone https://github.com/joewrdd/jukyo_ms.git
```

2. Install dependencies

```bash
cd jukyo_ms
flutter pub get
```

3. Configure Firebase

- Create a new Firebase project
- Add Android & iOS apps in Firebase console
- Download and add configuration files
- Enable Authentication methods
- Set up Cloud Firestore rules

4. Run the app

```bash
flutter run
```

## Project Structure

```
lib/
├── bin/                  # App bindings
├── common/              # Shared widgets
├── data/               # Data layer
│   ├── repos/         # Repositories
│   └── services/      # Services
├── utils/             # Utility functions
├── views/             # UI screens
│   ├── auth/         # Authentication
│   ├── shop/         # Shopping
│   └── profile/      # User profile
└── main.dart         # Entry point
```

## Features in Detail

### Shopping Features

- Product categorization
- Advanced filtering
- Variant selection
- Image zooming
- Related products
- Stock management

### User Features

- Email & social authentication
- Profile management
- Multiple addresses
- Order tracking
- Review management

### Cart Features

- Real-time updates
- Variant management
- Quantity controls
- Price calculation
- Coupon system

## Few Screenshots For Quick Overview

<div align="center">
  <!-- OnBoarding Screen -->
  <div style="display: flex; flex-direction: column; align-items: center;">
    <div style="flex: 2; padding: 10px;">
      <p><strong>OnBoarding Screen (Light & Dark)</strong></p>
      <div style="display: flex; gap: 10px;">
        <img src="lib/screenshots/light/onboardingL.png" width="250" alt="OnBoarding Light"/>
        <img src="lib/screenshots/dark/onboardingD.png" width="250" alt="OnBoarding Dark"/>
      </div>
    </div>
    <!-- Login Screen -->
    <div style="display: flex; align-items: flex-start; margin-top: 20px;">
      <div style="flex: 2; padding: 10px;">
        <p><strong>Login Screen (Light & Dark)</strong></p>
        <div style="display: flex; gap: 10px;">
          <img src="lib/screenshots/light/loginL.png" width="250" alt="Login Light"/>
          <img src="lib/screenshots/dark/loginD.png" width="250" alt="Login Dark"/>
        </div>
      </div>
    </div>
    <!-- SignUp Screen -->
    <div style="display: flex; align-items: flex-start; margin-top: 20px;">
      <div style="flex: 2; padding: 10px;">
        <p><strong>SignUp Screen (Light & Dark)</strong></p>
        <div style="display: flex; gap: 10px;">
          <img src="lib/screenshots/light/signupL.png" width="250" alt="SignUp Light"/> 
          <img src="lib/screenshots/dark/signupD.png" width="250" alt="SignUp Dark"/>
        </div>
      </div>
    </div>
    <!-- Home Screen -->
    <div style="display: flex; align-items: flex-start; margin-top: 20px;">
      <div style="flex: 2; padding: 10px;">
        <p><strong>Home Screen (Light & Dark)</strong></p>
        <div style="display: flex; gap:     10px;">
          <img src="lib/screenshots/light/homeL.png" width="250" alt="Home Light"/>
          <img src="lib/screenshots/dark/homeD.png" width="250" alt="Home Dark"/>
        </div>
      </div>
    </div>
    <!-- Product Details Screen -->
    <div style="display: flex; align-items: flex-start; margin-top: 20px;">
      <div style="flex: 2; padding: 10px;">
        <p><strong>Product Details Screen (Light & Dark)</strong></p>
        <div style="display: flex; gap: 10px;">
          <img src="lib/screenshots/light/product_details_light.png" width="250" alt="Product Details Light"/>
          <img src="lib/screenshots/dark/product_details_dark.png" width="250" alt="Product Details Dark"/>
        </div>
      </div>
    </div>
    <!-- Store Screen -->
    <div style="display: flex; align-items: flex-start; margin-top: 20px;">
      <div style="flex: 2; padding: 10px;">
        <p><strong>Store Screen (Light & Dark)</strong></p>
        <div style="display: flex; gap: 10px;">
          <img src="lib/screenshots/light/storeL.png" width="250" alt="Store Light"/>
          <img src="lib/screenshots/dark/storeD.png" width="250" alt="Store Dark"/>
        </div>
      </div>
    </div>
    <!-- Cart Screen -->
    <div style="display: flex; align-items: flex-start; margin-top: 20px;">
      <div style="flex: 2; padding: 10px;">
        <p><strong>Cart Screen (Light & Dark)</strong></p>
        <div style="display: flex; gap: 10px;">
          <img src="lib/screenshots/light/cartL.png" width="250" alt="Cart Light"/>
          <img src="lib/screenshots/dark/cartD.png" width="250" alt="Cart Dark"/>
        </div>
      </div>
    </div>
    <!-- Wishlist Screen -->
    <div style="display: flex; align-items: flex-start; margin-top: 20px;">
      <div style="flex: 2; padding: 10px;">
        <p><strong>Wishlist Screen (Light & Dark)</strong></p>
        <div style="display: flex; gap: 10px;">
          <img src="lib/screenshots/light/wishlistL.png" width="250" alt="Wishlist Light"/>
          <img src="lib/screenshots/dark/wishlistD.png" width="250" alt="Wishlist Dark"/>
        </div>
      </div>
    </div>
    <!-- Profile Screen -->
    <div style="display: flex; align-items: flex-start; margin-top: 20px;">
      <div style="flex: 2; padding: 10px;">
        <p><strong>Profile Screen (Light & Dark)</strong></p>
        <div style="display: flex; gap: 10px;">
          <img src="lib/screenshots/light/profileL.png" width="250" alt="Profile Light"/>
          <img src="lib/screenshots/dark/profileD.png" width="250" alt="Profile Dark"/>
        </div>
      </div>
    </div>
    <!-- User Profile Screen -->
    <div style="display: flex; align-items: flex-start; margin-top: 20px;">
      <div style="flex: 2; padding: 10px;">
        <p><strong>Profile Screen (Light & Dark)</strong></p>
        <div style="display: flex; gap: 10px;">
          <img src="lib/screenshots/light/cprofileL.png" width="250" alt="Profile Light"/>
          <img src="lib/screenshots/dark/cprofileD.png" width="250" alt="Profile Dark"/>
        </div>
      </div>
    </div>
    <!-- Checkout Screen -->
    <div style="display: flex; align-items: flex-start; margin-top: 20px;">
      <div style="flex: 2; padding: 10px;">
        <p><strong>Checkout Screen (Light & Dark)</strong></p>
        <div style="display: flex; gap: 10px;">
          <img src="lib/screenshots/light/checkoutL.png" width="250" alt="Checkout Light"/>
          <img src="lib/screenshots/dark/checkoutD.png" width="250" alt="Checkout Dark"/>
        </div>
      </div>
    </div>
    <!-- Sub Categories Screen -->
    <div style="display: flex; align-items: flex-start; margin-top: 20px;">
      <div style="flex: 2; padding: 10px;">
        <p><strong>Sub Categories Screen (Light & Dark)</strong></p>
        <div style="display: flex; gap: 10px;">
          <img src="lib/screenshots/light/subcategoriesL.png" width="250" alt="Sub Categories Light"/>
          <img src="lib/screenshots/dark/subcategoriesD.png" width="250" alt="Sub Categories Dark"/>
        </div>
      </div>
    </div>
     <!-- Address Screen -->
    <div style="display: flex; align-items: flex-start; margin-top: 20px;">
      <div style="flex: 2; padding: 10px;">
        <p><strong>Address Screen (Light & Dark)</strong></p>
        <div style="display: flex; gap: 10px;">
          <img src="lib/screenshots/light/addressL.png" width="250" alt="Address Light"/>
          <img src="lib/screenshots/dark/addressD.png" width="250" alt="Address Dark"/>
        </div>
      </div>
    </div>

  </div>
</div>

## Youtube Link For Demo Of The App

[Watch The Demo On YouTube](https://www.youtube.com/wrd70z)

## Contributing

Contributions are welcome! Please feel free to submit a pull request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

```

```
