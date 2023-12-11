@echo off

CALL flutter build web --web-renderer canvaskit --target "lib/main_demo.dart" -o "build/sandfriends_web_demo"