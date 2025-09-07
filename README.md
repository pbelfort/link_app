# link_app

This exercise aims at creating a small application that allows you to shorten links and display a history of the recently shortened links to your favorite websites.
An already implemented service handles all backend logic — it accepts the links and returns an alias for them.

## Architecture and Code Structure

The project follows a layered architecture to ensure maintainability, scalability, and testability. Implemented with Provider, enabling efficient UI updates while keeping logic decoupled from the interface.

### **lib/core/**

- `adapters/` → Core abstractions and adapters  
- `di/` → Dependency injection configuration  
- `error/` → Error handling and custom exceptions  

### **lib/data/**

- `mappers/` → Maps data between API models and domain models  
- `models/` → Data transfer objects (DTOs)  
- `remote/` → Handles API communication and data sources  

### **lib/domain/**

- `entities/` → Core business objects, independent of frameworks  
- `repositories/` → Abstract contracts implemented by the data layer  
- `usecases/` → Business rules encapsulated as application use cases  

### **lib/presentation/**

- `providers/` → State management (using **Provider**)  
- `screens/` → App screens (UI pages)  
- `widgets/` → Reusable UI components  

### **tests/**

- `unit` and `widget` tests aligned with the architecture  
- `integration_test/` → End-to-end feature tests, validating user flows  

## Main packages used in the project

- **provider** → Simple and reactive state management  
- **flutter_riverpod** → Modern alternative for state management  
- **http** → HTTP requests to communicate with the API  
- **get_it** → Service Locator for dependency injection  
- **flutter_dotenv** → Environment variables management (.env)  
- **dartz** → Functional programming utilities, `Either` for error/success handling  
- **mockito** → Mocking framework for unit tests  

## Dev Dependencies

- **flutter_test** → Unit and widget testing  
- **integration_test** → End-to-end (E2E) testing  
- **build_runner** → Code generation (when required)  
- **flutter_lints** → Linting rules and best practices  

### Integration Test Structure

The integration tests are organized by feature for clarity:

- **common/**
  - `build_home_test.dart` → Helper to build and prepare the home screen before running feature tests.  

- **features/**
  - `create_alias_feature.dart` → Tests creating a new alias (shortened link).  
  - `find_last_item_feature.dart` → Verifies scroll behavior and ability to find the last list item.  
  - `insert_alias_items_feature.dart` → Inserts multiple shortened links and checks the list updates correctly.  
  - `insert_invalid_url_feature.dart` → Ensures invalid inputs are handled properly.  
  - `ui_widgets_feature.dart` → Validates the presence and behavior of UI components.  
  - `app_test.dart` → Main test suite that orchestrates all feature tests.

### Unit Test Structure

The unit tests are organized by domain for clarity and maintainability:

- **models/**
  - `alias_entity_test.dart` → Tests the `AliasEntity` model, including construction and equality.

- **providers/**
  - `provider_alias_test.dart` → Tests the `AliasProvider` logic, state transitions, and error handling.
  - `provider_alias_test.mocks.dart` → Auto-generated mocks for provider tests.

- **remote/**
  - `post_alias_test.dart` → Tests remote data source logic for posting aliases.
  - `post_alias_test.mocks.dart` → Auto-generated mocks for remote tests.
  - `post_alias.dart` → (Helper or additional remote logic for tests.)

- **usecase/**
  - `create_alias_usecase_test.dart` → Tests the business logic for creating aliases.
  - `create_alias_usecase_test.mocks.dart` → Auto-generated mocks for usecase tests.

Each test file is focused on a single responsibility, making it easy to maintain and extend as the project grows.
