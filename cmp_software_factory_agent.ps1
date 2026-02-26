Write-Host "Initializing the Antigravity software factory (V14 - 100% Full, Custom Package & Navigation)..." -ForegroundColor Cyan

# ---------------------------------------------------------
# 0. Global Rules (.cursorrules)
# ---------------------------------------------------------
Write-Host "Generating global rules (.cursorrules)..." -ForegroundColor Yellow
$CursorRulesContent = @'
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
'@
Set-Content -Path ".cursorrules" -Value $CursorRulesContent -Encoding UTF8

$BaseDir = ".agent/skills"
if (!(Test-Path $BaseDir)) { New-Item -ItemType Directory -Force -Path $BaseDir | Out-Null }

# ---------------------------------------------------------
# 1. Project Architect
# ---------------------------------------------------------
$dir = "$BaseDir/cmp-architect"
New-Item -ItemType Directory -Force -Path $dir | Out-Null
$content = @'
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
'@
Set-Content -Path "$dir/SKILL.md" -Value $content -Encoding UTF8

# ---------------------------------------------------------
# 2. Navigation Architect
# ---------------------------------------------------------
$dir = "$BaseDir/cmp-navigation"
New-Item -ItemType Directory -Force -Path $dir | Out-Null
$content = @'
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
'@
Set-Content -Path "$dir/SKILL.md" -Value $content -Encoding UTF8

# ---------------------------------------------------------
# 3. Project Bootstrapper
# ---------------------------------------------------------
$dir = "$BaseDir/cmp-project-setup"
New-Item -ItemType Directory -Force -Path $dir | Out-Null
$content = @'
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
'@
Set-Content -Path "$dir/SKILL.md" -Value $content -Encoding UTF8

# ---------------------------------------------------------
# 4. Test Coverage (Modern Kover)
# ---------------------------------------------------------
$dir = "$BaseDir/cmp-testing-coverage"
New-Item -ItemType Directory -Force -Path $dir | Out-Null
$content = @'
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
'@
Set-Content -Path "$dir/SKILL.md" -Value $content -Encoding UTF8

# ---------------------------------------------------------
# 5. Dependency Injection (Koin)
# ---------------------------------------------------------
$dir = "$BaseDir/cmp-di-koin"
New-Item -ItemType Directory -Force -Path $dir | Out-Null
$content = @'
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
'@
Set-Content -Path "$dir/SKILL.md" -Value $content -Encoding UTF8

# ---------------------------------------------------------
# 6. Networking & Data
# ---------------------------------------------------------
$dir = "$BaseDir/cmp-networking"
New-Item -ItemType Directory -Force -Path $dir | Out-Null
$content = @'
---
name: cmp-networking
description: Networking expert using Ktor Client and Kotlinx Serialization in KMP.
---
# Instructions
1. Setup Ktor Client in a Koin module (`commonMain`). Use CIO for Android, Darwin for iOS, and JS for Web.
2. Create `@Serializable` Data Classes in domain/model.
3. Repositories in domain, implementations in data. Wrap API calls in `try/catch`.
'@
Set-Content -Path "$dir/SKILL.md" -Value $content -Encoding UTF8

# ---------------------------------------------------------
# 7. UI Standard
# ---------------------------------------------------------
$dir = "$BaseDir/cmp-ui-standard"
New-Item -ItemType Directory -Force -Path $dir | Out-Null
$content = @'
---
name: cmp-ui-standard
description: Frontend developer expert in Compose Multiplatform and reactive state management.
---
# Instructions
1. ViewModels must expose a single `StateFlow<UiState>`.
2. Use Material Design 3.
3. Use JetBrains `composeResources` for all assets.
'@
Set-Content -Path "$dir/SKILL.md" -Value $content -Encoding UTF8

# ---------------------------------------------------------
# 8. Linter Ktlint
# ---------------------------------------------------------
$dir = "$BaseDir/cmp-linter-ktlint"
New-Item -ItemType Directory -Force -Path $dir | Out-Null
$content = @'
---
name: cmp-linter-ktlint
description: Code Quality Specialist responsible for integrating Pinterest's Ktlint.
---
# Instructions
1. Add `org.jlleitschuh.gradle.ktlint` to `libs.versions.toml`.
2. Apply `alias(libs.plugins.ktlint) apply false` in root `build.gradle.kts`.
3. Apply `alias(libs.plugins.ktlint)` in `composeApp/build.gradle.kts`.
4. Create `.editorconfig` with standard Kotlin rules.
'@
Set-Content -Path "$dir/SKILL.md" -Value $content -Encoding UTF8

# ---------------------------------------------------------
# 9. Git Setup & .gitignore
# ---------------------------------------------------------
$dir = "$BaseDir/cmp-git-setup"
New-Item -ItemType Directory -Force -Path $dir | Out-Null
$content = @'
---
name: cmp-git-setup
description: Source Control Specialist responsible for initializing Git and generating a comprehensive .gitignore.
---
# Instructions
1. Run `git init` in the root directory.
2. Generate `.gitignore` including rules for Gradle, IntelliJ/Android Studio, Xcode/iOS, Mac, Web (`*.wasm`, `*.js`), and Fastlane.
3. Stage files (`git add .`) but DO NOT commit automatically.
'@
Set-Content -Path "$dir/SKILL.md" -Value $content -Encoding UTF8

# ---------------------------------------------------------
# 10. CI/CD Fastlane
# ---------------------------------------------------------
$dir = "$BaseDir/cmp-ci-fastlane"
New-Item -ItemType Directory -Force -Path $dir | Out-Null
$content = @'
---
name: cmp-ci-fastlane
description: DevOps specialist for CircleCI pipelines, Fastlane, and Firebase App Distribution.
---
# Instructions
1. Create `Gemfile` with fastlane.
2. Create `fastlane/Fastfile` with lanes (`distribute_dev`, `distribute_rc`, `distribute_prod`).
3. Create `.circleci/config.yml` handling Android SDK licenses, caching, and triggering Fastlane based on git branch.
'@
Set-Content -Path "$dir/SKILL.md" -Value $content -Encoding UTF8

# ---------------------------------------------------------
# 11. Testing
# ---------------------------------------------------------
$dir = "$BaseDir/cmp-testing"
New-Item -ItemType Directory -Force -Path $dir | Out-Null
$content = @'
---
name: cmp-testing
description: Quality Assurance (QA) Engineer specialized in Kotlin Multiplatform.
---
# Instructions
1. Place tests in `commonTest`.
2. Use `kotlinx-coroutines-test` for ViewModels.
'@
Set-Content -Path "$dir/SKILL.md" -Value $content -Encoding UTF8

# ---------------------------------------------------------
# 12. UI Vision
# ---------------------------------------------------------
$dir = "$BaseDir/cmp-ui-vision"
New-Item -ItemType Directory -Force -Path $dir | Out-Null
$content = @'
---
name: cmp-ui-vision
description: Specialist in converting visual mockups directly into Compose Multiplatform code.
---
# Trigger
Activate ONLY when the user provides an image and explicitly requests UI code generation.
# Instructions
1. Generate a self-contained, stateless Composable replicating the design using Material 3.
'@
Set-Content -Path "$dir/SKILL.md" -Value $content -Encoding UTF8

Write-Host "`nFactory successfully rebuilt with ALL 12 skills complete and intact!" -ForegroundColor Green