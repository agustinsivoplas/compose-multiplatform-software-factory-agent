# 🚀 Google Antigravity Factory: KMP/CMP AI Architect (Experimental)

Welcome to the **Google Antigravity Factory**. This repository contains the initialization scripts and skill definitions for a specialized AI Agent designed to bootstrap and manage production-ready **Kotlin Multiplatform (KMP)** and **Compose Multiplatform (CMP)** projects.

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
   ```
3. The script will generate a `.agent/skills` directory containing all the Markdown skill files and a `.cursorrules` file with global architectural directives.
4. Open the folder in your AI-powered IDE (like Cursor) or attach the `.agent` folder to your preferred AI chat interface.

---

## 🎯 Example Usage (The Master Prompt)

To bootstrap a brand new KMP project from scratch, use the following Master Prompt. Just replace `[APP_NAME]` and `[PACKAGE_NAME]` with your actual project details:

> Act as my Lead KMP Architect and execute a complete project bootstrap for the app named **'[APP_NAME]'** utilizing the exact Package Name / Bundle ID **'[PACKAGE_NAME]'**, targeting **[Android, iOS, Web]**. 
> 
> Strictly follow your skills sequentially: `@cmp-git-setup`, `@cmp-project-setup`, `@cmp-architect`, `@cmp-linter-ktlint`, `@cmp-testing-coverage`, `@cmp-di-koin`, `@cmp-networking`, `@cmp-navigation`, and `@cmp-ui-standard`. 
> 
> **CRITICAL CHECKLIST BEFORE YOU WRITE CODE:**
> 1. Ensure you use the exact Package Name **'[PACKAGE_NAME]'** for the Android `applicationId`, `namespace`, iOS Bundle ID, and the entire Kotlin directory structure.
> 2. Ensure you use exactly **Gradle 8.12** in the `gradle-wrapper.properties`.
> 3. Ensure **Kotlin 2.0.21** and apply the `composeCompiler` plugin in both build files. 
> 4. Use the modern `@file:OptIn(org.jetbrains.kotlin.gradle.ExperimentalWasmDsl::class)` syntax at the top of `composeApp/build.gradle.kts`. Do NOT use the deprecated `.targets.js.dsl.` path.
> 5. Use the new Android `compilerOptions` syntax inside the `androidTarget` block.
> 6. **TOML STRUCTURE RULES 🚨:**
>    - You MUST put `navigation-compose = { module = "org.jetbrains.androidx.navigation:navigation-compose", version.ref = "navigationCompose" }` strictly inside the **`[libraries]`** block. 
>    - You MUST put `composeCompiler = { id = "org.jetbrains.kotlin.plugin.compose", version.ref = "kotlin" }` strictly inside the **`[plugins]`** block. Do not mix them.
> 7. Automatically generate the `composeApp/src/wasmJsMain/resources/index.html` file with the exact `<script type="importmap">` configuration specified in your `@cmp-project-setup`.
> 8. **Navigation Demo:** In your `@cmp-navigation` phase, create a Type-Safe `NavHost` in `App.kt` with two routes (`HomeRoute` and `DetailRoute(val id: Int)`). Add a button on the Home screen that navigates to the Detail screen to prove the setup works.
> 
> Please generate all files autonomously. When you are done, let me know so I can verify by running `.\gradlew wasmJsBrowserRun`.

## ⚠️ Known WebAssembly Caveats
When testing the Web target locally (`.\gradlew wasmJsBrowserRun`), if you encounter a blank screen or a `LinkError: WebAssembly.instantiate()`, clear your browser cache (or use Incognito mode) to ensure the Skiko engine re-syncs with your latest compiled binaries.

---

## 🤝 Contributing

We welcome contributions to make the **Google Antigravity Factory** even smarter! If you have ideas for new skills, prompt optimizations, or bug fixes for newer Kotlin versions, please feel free to contribute:

1. **Fork** the repository.
2. **Create a new branch** for your feature or fix (`git checkout -b feature/amazing-new-skill`).
3. **Commit** your changes with clear, descriptive messages (`git commit -m 'Add new skill for SQLDelight setup'`).
4. **Push** your branch to your fork (`git push origin feature/amazing-new-skill`).
5. **Open a Pull Request** against the `main` branch of this repository.

Please ensure any new AI skills follow the standard markdown format and include clear, sequential instructions.

---

## 📄 License

This project is licensed under the **MIT License**.

```text
MIT License

Copyright (c) 2026 Agustin Sivoplas

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
