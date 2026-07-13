.PHONY: help \
	client-dev client-prod client-apk-dev client-apk-prod client-ios-dev client-ios-prod \
	client-android-deploy-dev client-android-deploy-prod \
	client-ios-deploy-dev client-ios-deploy-prod \
	admin-dev admin-prod

.DEFAULT_GOAL := help

CLIENT_APP := apps/client_app
ADMIN_APP := apps/admin_app

CLIENT_CONFIG_DEVELOPMENT := config/run/config.development.json
CLIENT_CONFIG_PRODUCTION := config/run/config.production.json
ADMIN_CONFIG_DEVELOPMENT := config/run/config.development.json
ADMIN_CONFIG_PRODUCTION := config/run/config.production.json

help:
	@echo "Flutter project template commands"
	@echo ""
	@echo "Client"
	@echo "  make client-dev       Run client app with development config"
	@echo "  make client-prod      Run client app with production config"
	@echo "  make client-apk-dev   Build debug APK with development config"
	@echo "  make client-apk-prod  Build release APK with production config"
	@echo "  make client-ios-dev   Build iOS simulator app with development config"
	@echo "  make client-ios-prod  Build iOS simulator app with production config"
	@echo "  make client-android-deploy-dev|prod   Upload AAB with Fastlane"
	@echo "  make client-ios-deploy-dev|prod       Upload IPA to TestFlight with Fastlane (SPM)"
	@echo ""
	@echo "Admin"
	@echo "  make admin-dev        Run admin app with development config"
	@echo "  make admin-prod       Run admin app with production config"

client-dev:
	cd $(CLIENT_APP) && flutter run --dart-define-from-file=$(CLIENT_CONFIG_DEVELOPMENT)

client-prod:
	cd $(CLIENT_APP) && flutter run --dart-define-from-file=$(CLIENT_CONFIG_PRODUCTION)

client-apk-dev:
	cd $(CLIENT_APP) && flutter build apk --debug --dart-define-from-file=$(CLIENT_CONFIG_DEVELOPMENT)

client-apk-prod:
	cd $(CLIENT_APP) && flutter build apk --release --dart-define-from-file=$(CLIENT_CONFIG_PRODUCTION)

client-ios-dev:
	cd $(CLIENT_APP) && flutter build ios --simulator --debug --no-codesign --dart-define-from-file=$(CLIENT_CONFIG_DEVELOPMENT)

client-ios-prod:
	cd $(CLIENT_APP) && flutter build ios --simulator --debug --no-codesign --dart-define-from-file=$(CLIENT_CONFIG_PRODUCTION)

client-android-deploy-dev:
	cd $(CLIENT_APP)/android && bundle exec fastlane beta_development

client-android-deploy-prod:
	cd $(CLIENT_APP)/android && bundle exec fastlane beta_production

client-ios-deploy-dev:
	cd $(CLIENT_APP)/ios && bundle exec fastlane beta_development

client-ios-deploy-prod:
	cd $(CLIENT_APP)/ios && bundle exec fastlane beta_production

admin-dev:
	cd $(ADMIN_APP) && flutter run --dart-define-from-file=$(ADMIN_CONFIG_DEVELOPMENT)

admin-prod:
	cd $(ADMIN_APP) && flutter run --dart-define-from-file=$(ADMIN_CONFIG_PRODUCTION)
