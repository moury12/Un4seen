testflight : https://testflight.apple.com/join/F9cp7b39
git checkout -b production
git push origin production
cd ios
fastlane beta
cd android
fastlane internal