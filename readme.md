# EcommerceLatest

## Overview
EcommerceLatest is a full-stack e-commerce application with separate backend and frontend components. This project aims to provide a seamless shopping experience with a robust backend and an intuitive frontend (both mobile and web).

## Table of Contents
- [Backend](#backend)
    - [Technologies](#technologies-backend)
    - [Setup](#setup-backend)
    - [Usage](#usage-backend)
- [Frontend](#frontend)
    - [Technologies](#technologies-frontend)
    - [Setup](#setup-frontend)
    - [Usage](#usage-frontend)
- [Mobile Frontend](#mobile-frontend)
    - [Technologies](#technologies-mobile-frontend)
    - [Setup](#setup-mobile-frontend)
    - [Usage](#usage-mobile-frontend)
- [Contributing](#contributing)
- [License](#license)

## Backend

### Technologies
- Python
- Django
- MongoDB
- PyMongo

### Setup
1. Clone the repository:
    ```sh
    git clone https://github.com/Adistar964/ecommerce-latest.git
    cd ecommerceBackend
    ```
2. Install dependencies:
    ```sh
    pip install django pymongo[srv]
    ```
3. Set up environment variables:
    Create a `.env` file in the `backend` directory and add the following:
    ```env
    MONGO_URI=your_mongodb_uri
    ```

### Usage
1. Start the server:
    ```sh
    python manage.py runserver
    ```
2. The backend server will run on `http://localhost:8000`.

## Frontend

### Technologies
- JavaScript
- React.js
- Bootstrap

### Setup
1. Navigate to the frontend directory:
    ```sh
    cd ecommerceFrontend
    ```
2. Install dependencies:
    ```sh
    npm install
    ```

### Usage
1. Start the development server:
    ```sh
    npm run dev
    ```
2. The frontend application will run on `http://localhost:3000`.

## Mobile Frontend

### Technologies
- Dart
- Flutter

### Setup
1. Navigate to the mobile frontend directory:
    ```sh
    cd ecommerceMobile
    ```
2. Install dependencies:
    ```sh
    flutter pub get
    ```

### Usage
1. Start the development server:
    ```sh
    flutter run
    ```
2. The mobile application will run on your connected device or emulator.

## Contributing
Contributions are welcome! Please fork the repository and create a pull request with your changes.

## Contact
Author: [Mohammed Abdullah Amaan](mailto:abdullah@abdullahamaan.com)