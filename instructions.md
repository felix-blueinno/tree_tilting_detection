# 1. Firebase Setup

- [ ] Create Firebase project (Official Website >> "Go to Console" >> Sign in).

- [ ] Initialize firestore and create a collection and a document (e.g. `data/sensor1`).
Where `data` is the collection name and `sensor1` is the document name.

- [ ] Wait until the Web API key is generated in Project Setting.

- [ ] Get the latest version of PICO program [here](https://drive.google.com/file/d/15fmJ92MJg62hIqkVQqG4TL3z_BKmg1Tu/view?usp=share_link).

- [ ] Update the following constants in the program:
    ```python
    # firebase information
    FIREBASE_API_KEY = "..."
    FIREBASE_PROJECT_ID = "..."
    FIREBASE_DOCUMENT_PATH = "data/sensor1"
    ```

	
- [ ] Upload the modified program to PICO and run.

- [ ] Go to Firestore Database and see if the document is updated successfully (interval ~4 seconds).

# 2. Flutter SDK Setup
- [ ] SDK Installation:
    - for [Mac](https://docs.google.com/document/d/1l362eOPtEYM5DO1z5XTK8kTGLoO4FPk8bZe4MSL41p0/edit?usp=share_link)
    - for [Windows 10](https://docs.google.com/document/d/1YYaWW-OdI0mAO0D3WycaCf9Pe4GTDuqgaTZcb24n0k8/edit?usp=share_link)
    - **OR** official manual ([Mac](https://docs.flutter.dev/get-started/install/macos)/[Win](https://docs.flutter.dev/get-started/install/windows))

- [ ] Install [VS Code](https://code.visualstudio.com/download).
- [ ] VS Code extensions install:
    - Flutter
    - Dart (Usually installed along with Flutter extension)

# 3. App Setup
- [ ] Download the template program [here](https://github.com/felix-blueinno/tree_tilting_detection).
- [ ] Unzip the download file.
- [ ] Open the unzipped folder with VS Code.
- [ ] ***CMD + J*** to open the terminal.
- [ ] Run the following commands

    ```bash
    flutter pub get
    flutter pub run build_runner build --delete-conflicting-outputs
    ```

- [ ] Download [npm](https://nodejs.org/en/download/).
- [ ] Run the following commands
    ```bash
    npm install -g firebase-tools
    firebase login
    ```

- [ ] Run the following commands
    ```bash
    dart pub global activate flutterfire_cli
    ```

- [ ] Run the following commands
    ```bash
    firebase init
    ```

- [ ] Select the platform you want to use (e.g. Android/iOS/MacOS/Web) and press `Enter` to confirm.
- [ ] Use space to select `Firestore` and `Hosting: Configure files for Firebase Hosting` and press `Enter` to confirm.
- [ ] Select `Use an existing project` and press `Enter` to confirm.
- [ ] Use arrow keys to select the project you created in Firebase console and press `Enter` to confirm.
- [ ] Wait until the initialization is done.
- [ ] When asked `What do you want to use as your public directory?`, type `build/web` and press `Enter` to confirm.
- [ ] When asked `Configure as a single-page app (rewrite all urls to /index.html)?`, type `Y` and press `Enter` to confirm.
- [ ] When asked `File build/web/index.html already exists. Overwrite?`, type `Y` and press `Enter` to confirm.
- [ ] Try run the Flutter app.

# 4. Deploy the App
- [ ] Run the following commands
    ```bash
    flutter build web
    firebase deploy
    ```
- [ ] Wait until the deployment is done.
- [ ] Copy the URL of the deployed app and paste it in the browser.
- [ ] You should see the app running.
