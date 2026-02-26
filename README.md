# 🚀 Antigravity Factory: KMP/CMP AI Architect

Welcome to the **Antigravity Factory**. This repository contains the initialization scripts and skill definitions for a specialized AI Agent designed to bootstrap and manage production-ready **Kotlin Multiplatform (KMP)** and **Compose Multiplatform (CMP)** projects.

This agent is configured to handle the bleeding edge of the Kotlin ecosystem, specifically tailored for **Android, iOS, and WebAssembly (Wasm)** targets, avoiding common compiler pitfalls and ensuring strict architectural standards.

## 🛠️ Features
* **Zero Data Loss Rule:** Enforces strict safe-refactoring rules.
* **Modern Stack:** Kotlin 2.0.21, Gradle 8.12, and Compose 1.7.3.
* **Type-Safe Routing:** Pre-configured with the official JetBrains Navigation Compose.
* **WebAssembly Ready:** Automatically scaffolds the required `index.html` and Skiko engine bridges.
* **Clean Architecture:** Enforces separation of concerns using `commonMain`, strict `StateFlow` UI patterns, and proper dependency management via `libs.versions.toml`.

---

## 🧠 Agent Skills Breakdown

The agent is divided into 12 highly specialized skills. When prompting the AI, you can call these skills sequentially to orchestrate a perfect project build:

1. **`@cmp-architect`**: Core dependency manager. Generates a strict `libs.versions.toml` separating plugins and libraries, mapping exact stable versions (Koin 4.0, Ktor 3.0, Coroutines 1.9, etc.).
2. **`@cmp-navigation`**: Implements official JetBrains Navigation Compose using `@Serializable` Type-Safe routes.
3. **`@cmp-project-setup`**: Handles custom Package Names / Bundle IDs, configures modern Android compiler options, and generates WebAssembly HTML scaffolding.
4. **`@cmp-testing-coverage`**: Integrates modern JetBrains Kover (0.9.x) for code coverage reports.
5. **`@cmp-di-koin`**: Configures Koin Dependency Injection modules across all active platforms (Android, iOS, and Wasm).
6. **`@cmp-networking`**: Sets up Ktor HTTP client and `kotlinx.serialization` for network requests.
7. **`@cmp-ui-standard`**: Enforces Material Design 3 and reactive state management using `StateFlow<UiState>`.
8. **`@cmp-linter-ktlint`**: Integrates Pinterest's Ktlint via Gradle to enforce Kotlin coding standards.
9. **`@cmp-git-setup`**: Initializes the repository and generates a comprehensive `.gitignore` for KMP/Wasm projects.
10. **`@cmp-ci-fastlane`**: DevOps skill for configuring CircleCI, Fastlane, and Firebase App Distribution.
11. **`@cmp-testing`**: Sets up `commonTest` environments using `kotlinx-coroutines-test`.
12. **`@cmp-ui-vision`**: Converts visual mockups directly into stateless, Material 3 Compose code.

---

## ⚙️ Setup & Installation

1. Clone this repository or copy the `cmp_software_factory_agent.ps1` script to your desired workspace folder.
2. Run the PowerShell script:
   ```powershell
   .\cmp_software_factory_agent.ps1
