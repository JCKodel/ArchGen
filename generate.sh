#! /bin/bash
clear
echo "##################################################################################################################################################################"
flutter pub global run index_generator
echo "##################################################################################################################################################################"
flutter pub run build_runner build --delete-conflicting-outputs
