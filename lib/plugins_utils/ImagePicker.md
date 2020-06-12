#Image Picker plugin for Flutter
pub package

A Flutter plugin for iOS and Android for picking images from the image library, and taking new pictures with the camera.

Add this to your package's pubspec.yaml file:

````
dependencies:
  image_picker:
````
2. Install it
You can install packages from the command line:

with Flutter:

````
$ flutter pub get
````

###iOS

Add the following keys to your Info.plist file, located in <project root>/ios/Runner/Info.plist:

NSPhotoLibraryUsageDescription - describe why your app needs permission for the photo library. This is called Privacy - Photo Library Usage Description in the visual editor.
NSCameraUsageDescription - describe why your app needs access to the camera. This is called Privacy - Camera Usage Description in the visual editor.
NSMicrophoneUsageDescription - describe why your app needs access to the microphone, if you intend to record videos. This is called Privacy - Microphone Usage Description in the visual editor.

###Android

No configuration required - the plugin should work out of the box.