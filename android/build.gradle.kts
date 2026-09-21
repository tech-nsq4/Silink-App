allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    // Override compileSdk for Android library subprojects (Flutter plugins) to
    // ensure compatibility with AndroidX dependencies that require compileSdk 34+.
    // Some plugins (e.g., geocoding_android 3.3.1) hardcode compileSdk to 33,
    // which causes CheckAarMetadata failures when their transitive dependencies
    // (androidx fragment, activity, lifecycle, core, etc.) require 34+.
    // compileSdk is backward-compatible, so bumping to 36 (Flutter's default) is safe.
    // This must be registered BEFORE the evaluationDependsOn block below to avoid
    // "project already evaluated" errors.
    afterEvaluate {
        val androidExtension = extensions.findByName("android")
        if (androidExtension is com.android.build.api.dsl.LibraryExtension) {
            val currentSdk = androidExtension.compileSdk
            if (currentSdk != null && currentSdk < 36) {
                androidExtension.compileSdk = 36
            }
        }
    }
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
