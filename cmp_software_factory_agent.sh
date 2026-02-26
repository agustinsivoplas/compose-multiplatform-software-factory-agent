#!/bin/bash

# Terminal colors
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${CYAN}Initializing the Antigravity software factory (V14 - 100% Full, Mac/Linux Edition)...${NC}"

# ---------------------------------------------------------
# 0. Global Rules (.cursorrules)
# ---------------------------------------------------------
echo -e "${YELLOW}Generating global rules (.cursorrules)...${NC}"
cat << 'EOF' > .cursorrules
# Role and Philosophy
You are a Senior Architect expert in Kotlin Multiplatform (KMP) and Compose Multiplatform (CMP).
Your code must be clean, modular, and strictly adhere to Clean Architecture and SOLID principles.

# 🚨 GOLDEN RULE: Safe Refactoring (ZERO Data Loss)
NEVER delete existing files, complex business logic, or legacy UI components without my explicit confirmation.

# 🏗️ KMP Project Structure
- All UI code, ViewModels, and Use Cases must ALWAYS be placed in `commonMain`.
- Platform-specific implementations belong in their respective sourceSets (`androidMain`, `iosMain`, `wasmJsMain`) ONLY if those targets are enabled in the project.
- Use `expect`/`actual` only when strictly necessary.
- For resources, always use the official JetBrains resources library for KMP (`composeResources`).

# 📦 Dependency Management
- Manage dependencies EXCLUSIVELY via `gradle/libs.versions.toml`.
- NEVER hardcode dependencies directly inside the `build.gradle.kts` files.

# 🎨 Compose & UI Rules
- Use Material Design 3 by default (`androidx.compose.material3`).
- ViewModels must expose their state through a single immutable `StateFlow<UiState>`.
- Keep Composables pure and Stateless whenever possible (State Hoisting).
EOF

BASE_DIR=".agent/skills"
mkdir -p "$BASE_DIR"

# ---------------------------------------------------------
# 1. Project Architect
# ---------------------------------------------------------
mkdir -p "$BASE_DIR/cmp-architect"
cat << 'EOF' > "$BASE_DIR/cmp-architect/SKILL.md"
---
name: cmp-architect
description: Expert in KMP/CMP project structure and dynamic dependency management based on target platforms.
---
# Instructions
1. **Dynamic Target Resolution:** Read requested platforms (Android, iOS, Web/Wasm). Only configure sourceSets for requested platforms.
2. **Version Catalog 🚨 CRITICAL:** You MUST generate `gradle/libs.versions.toml` with these EXACT stable versions:
   - `agp = "8.7.2"`, `kotlin = "2.0.21"`, `compose = "1.7.0"`, `koin = "4.0.0"`, `ktor = "3.0.1"`, `coroutines = "1.9.0"`, `serialization = "1.7.3"`, `kover = "0.9.7"`, `ktlint = "12.1.0"`, `navigationCompose = "2.9.2"`
   - 🚨 In the `[plugins]` block, map: `composeCompiler = { id = "org.jetbrains.kotlin.plugin.compose", version.ref = "kotlin" }`
   - 🚨 In the `[libraries]` block, map: `navigation-compose = { module = "org.jetbrains.androidx.navigation:navigation-compose", version.ref = "navigationCompose" }`
3. Use type-safe catalog syntax: `implementation(libs.library.name)`.
EOF

# ---------------------------------------------------------
# 2. Navigation Architect
# ---------------------------------------------------------
mkdir -p "$BASE_DIR/cmp-navigation"
cat << 'EOF' > "$BASE_DIR/cmp-navigation/SKILL.md"
---
name: cmp-navigation
description: Specialist in the Official JetBrains Navigation Compose for KMP, utilizing Type-Safe Routing.
---
# Instructions
1. Ensure `navigation-compose` is added to `commonMain` dependencies.
2. Ensure the `kotlinx-serialization` plugin is applied to the project because Type-Safe routing requires it.
3. Create a `navigation` package inside `commonMain`.
4. Define your routes using `@Serializable` objects and data classes. Example:
   ~~~kotlin
   import kotlinx.serialization.Serializable
   @Serializable data object HomeRoute
   @Serializable data class DetailRoute(val id: Int)
   ~~~
5. Set up the `NavHost` in your main `App.kt` composable using `rememberNavController()`.
EOF

# ---------------------------------------------------------
# 3. Project Bootstrapper
# ---------------------------------------------------------
mkdir -p "$BASE_DIR/cmp-project-setup"
cat << 'EOF' > "$BASE_DIR/cmp-project-setup/SKILL.md"
---
name: cmp-project-setup
description: Bootstraps a dynamic Compose Multiplatform project with strict SDK, Kotlin 2.0, Gradle 8.12 versions, and custom Bundle ID routing.
---
# Role
Expert Project Scaffolder. Initialize a clean CMP architecture ONLY for the platforms requested by the user.

# Instructions
1. **Package Name & Bundle ID 🚨 CRITICAL:** You MUST extract the `PACKAGE_NAME` / `BUNDLE_ID` provided by the user in the prompt. Use this EXACT string for:
   - The Android `namespace` and `applicationId` in `composeApp/build.gradle.kts`.
   - The iOS Bundle Identifier.
   - The Kotlin directory structure (e.g., `src/commonMain/kotlin/com/user/app/...`).
2. **Root Config & Gradle Wrapper 🚨 CRITICAL:** - Create `gradle/wrapper/gradle-wrapper.properties` and set exactly: `distributionUrl=https\://services.gradle.org/distributions/gradle-8.12-bin.zip`.
   - In the root `build.gradle.kts`, you MUST declare `alias(libs.plugins.composeCompiler) apply false` in the `plugins` block.
3. **Shared Module (`composeApp/build.gradle.kts`) 🚨 CRITICAL RULES:**
   - **Wasm OptIn:** Line 1 MUST be EXACTLY: `@file:OptIn(org.jetbrains.kotlin.gradle.ExperimentalWasmDsl::class)`. Do NOT use the deprecated `.targets.js.dsl.` path.
   - **Kotlin 2.0 Compiler:** Apply `alias(libs.plugins.composeCompiler)` at the top. Do NOT use the `composeOptions` block inside `android { }`.
   - **Android SDKs:** Set `compileSdk = 36`, `minSdk = 30`, `targetSdk = 36`.
   - **Android Target Syntax:** Inside `kotlin { }`, use the modern compilerOptions syntax:
     ~~~kotlin
     androidTarget {
         @OptIn(org.jetbrains.kotlin.gradle.ExperimentalKotlinGradlePluginApi::class)
         compilerOptions { jvmTarget.set(org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17) }
     }
     ~~~
   - **Wasm Target:** Declare `wasmJs { browser() }` safely inside the `kotlin` block.
4. **Web Target Scaffolding (Wasm) 🚨 CRITICAL:** If Web is requested, you MUST generate `composeApp/src/wasmJsMain/resources/index.html` with this EXACT content to fix module resolutions and load the `.mjs` file:
   ~~~html
   <!DOCTYPE html>
   <html lang="en">
   <head>
       <meta charset="UTF-8">
       <meta name="viewport" content="width=device-width, initial-scale=1.0">
       <title>Compose App</title>
       <style>
           html, body { width: 100%; height: 100%; margin: 0; padding: 0; overflow: hidden; background-color: #FAFAFA; }
           canvas { width: 100%; height: 100%; outline: none; }
       </style>
       <script type="importmap">
       { "imports": { "@js-joda/core": "https://cdn.jsdelivr.net/npm/@js-joda/core@3.2.0/dist/js-joda.esm.js" } }
       </script>
   </head>
   <body>
       <canvas id="ComposeTarget"></canvas>
       <script type="module" src="composeApp.mjs"></script>
   </body>
   </html>
   ~~~
   AND ensure `composeApp/src/wasmJsMain/kotlin/main.kt` uses `CanvasBasedWindow("Compose App", canvasElementId = "ComposeTarget")`.
EOF

# ---------------------------------------------------------
# 4. Test Coverage (Modern Kover)
# ---------------------------------------------------------
mkdir -p "$BASE_DIR/cmp-testing-coverage"
cat << 'EOF' > "$BASE_DIR/cmp-testing-coverage/SKILL.md"
---
name: cmp-testing-coverage
description: Configure JetBrains Kover for code coverage.
---
# Instructions
1. Add Kover plugin to `libs.versions.toml`.
2. Apply plugin in root (`apply false`) and `composeApp` build files.
3. 🚨 CRITICAL RULE: You MUST use the modern Kover 0.9.x syntax at the bottom of `composeApp/build.gradle.kts`. Do NOT use `koverReport`:
   ~~~kotlin
   kover {
       reports {
           filters {
               excludes {
                   classes("*.MainActivity*", "*.AppKt*")
               }
           }
       }
   }
   ~~~
EOF

# ---------------------------------------------------------
# 5. Dependency Injection (Koin)
# ---------------------------------------------------------
mkdir -p "$BASE_DIR/cmp-di-koin"
cat << 'EOF' > "$BASE_DIR/cmp-di-koin/SKILL.md"
---
name: cmp-di-koin
description: Specialist in Koin dependency injection configuration for Kotlin Multiplatform.
---
# Instructions
1. Define Koin modules inside `commonMain/di/`.
2. For CMP ViewModels, use `viewModelOf(::MyViewModel)` or `factory { MyViewModel(...) }`.
3. **Initialization based on active targets:**
   - `commonMain`: Create `fun initKoin(appDeclaration: KoinAppDeclaration = {})`.
   - `androidMain`: Call `initKoin` in Android Application class.
   - `iosMain`: Create helper `fun initKoinIOS() = initKoin {}` for Swift.
   - `wasmJsMain`: Call `initKoin {}` directly inside `main()` function before rendering Compose.
EOF

# ---------------------------------------------------------
# 6. Networking & Data
# ---------------------------------------------------------
mkdir -p "$BASE_DIR/cmp-networking"
cat << 'EOF' > "$BASE_DIR/cmp-networking/SKILL.md"
---
name: cmp-networking
description: Networking expert using Ktor Client and Kotlinx Serialization in KMP.
---
# Instructions
1. Setup Ktor Client in a Koin module (`commonMain`). Use CIO for Android, Darwin for iOS, and JS for Web.
2. Create `@Serializable` Data Classes in domain/model.
3. Repositories in domain, implementations in data. Wrap API calls in `try/catch`.
EOF

# ---------------------------------------------------------
# 7. UI Standard
# ---------------------------------------------------------
mkdir -p "$BASE_DIR/cmp-ui-standard"
cat << 'EOF' > "$BASE_DIR/cmp-ui-standard/SKILL.md"
---
name: cmp-ui-standard
description: Frontend developer expert in Compose Multiplatform and reactive state management.
---
# Instructions
1. ViewModels must expose a single `StateFlow<UiState>`.
2. Use Material Design 3.
3. Use JetBrains `composeResources` for all assets.
EOF

# ---------------------------------------------------------
# 8. Linter Ktlint
# ---------------------------------------------------------
mkdir -p "$BASE_DIR/cmp-linter-ktlint"
cat << 'EOF' > "$BASE_DIR/cmp-linter-ktlint/SKILL.md"
---
name: cmp-linter-ktlint
description: Code Quality Specialist responsible for integrating Pinterest's Ktlint.
---
# Instructions
1. Add `org.jlleitschuh.gradle.ktlint` to `libs.versions.toml`.
2. Apply `alias(libs.plugins.ktlint) apply false` in root `build.gradle.kts`.
3. Apply `alias(libs.plugins.ktlint)` in `composeApp/build.gradle.kts`.
4. Create `.editorconfig` with standard Kotlin rules.
EOF

# ---------------------------------------------------------
# 9. Git Setup & .gitignore
# ---------------------------------------------------------
mkdir -p "$BASE_DIR/cmp-git-setup"
cat << 'EOF' > "$BASE_DIR/cmp-git-setup/SKILL.md"
---
name: cmp-git-setup
description: Source Control Specialist responsible for initializing Git and generating a comprehensive .gitignore.
---
# Instructions
1. Run `git init` in the root directory.
2. Generate `.gitignore` including rules for Gradle, IntelliJ/Android Studio, Xcode/iOS, Mac, Web (`*.wasm`, `*.js`), and Fastlane.
3. Stage files (`git add .`) but DO NOT commit automatically.
EOF

# ---------------------------------------------------------
# 10. CI/CD Fastlane
# ---------------------------------------------------------
mkdir -p "$BASE_DIR/cmp-ci-fastlane"
cat << 'EOF' > "$BASE_DIR/cmp-ci-fastlane/SKILL.md"
---
name: cmp-ci-fastlane
description: DevOps specialist for CircleCI pipelines, Fastlane, and Firebase App Distribution.
---
# Instructions
1. Create `Gemfile` with fastlane.
2. Create `fastlane/Fastfile` with lanes (`distribute_dev`, `distribute_rc`, `distribute_prod`).
3. Create `.circleci/config.yml` handling Android SDK licenses, caching, and triggering Fastlane based on git branch.
EOF

# ---------------------------------------------------------
# 11. Testing
# ---------------------------------------------------------
mkdir -p "$BASE_DIR/cmp-testing"
cat << 'EOF' > "$BASE_DIR/cmp-testing/SKILL.md"
---
name: cmp-testing
description: Quality Assurance (QA) Engineer specialized in Kotlin Multiplatform.
---
# Instructions
1. Place tests in `commonTest`.
2. Use `kotlinx-coroutines-test` for ViewModels.
EOF

# ---------------------------------------------------------
# 12. UI Vision
# ---------------------------------------------------------
mkdir -p "$BASE_DIR/cmp-ui-vision"
cat << 'EOF' > "$BASE_DIR/cmp-ui-vision/SKILL.md"
---
name: cmp-ui-vision
description: Specialist in converting visual mockups directly into Compose Multiplatform code.
---
# Trigger
Activate ONLY when the user provides an image and explicitly requests UI code generation.
# Instructions
1. Generate a self-contained, stateless Composable replicating the design using Material 3.
EOF

echo -e "${GREEN}\nFactory successfully rebuilt with ALL 12 skills for Mac/Linux!${NC}"