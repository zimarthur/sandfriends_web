@echo off

CALL flutter build web --web-renderer canvaskit --target "lib/main_dev.dart" -o "build/sandfriends_web_dev"

CALL flutter build web --web-renderer canvaskit --target "lib/main_demo.dart" -o "build/sandfriends_web_demo"

CALL flutter build web --web-renderer canvaskit --target "lib/main_prod.dart" -o "build/sandfriends_web_prod"