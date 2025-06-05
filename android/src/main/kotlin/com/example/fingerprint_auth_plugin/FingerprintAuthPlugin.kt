package com.example.fingerprint_auth_plugin // Vérifiez que ce package correspond à votre dossier

import android.content.Context
import android.os.Build
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi
import androidx.biometric.BiometricPrompt
import androidx.fragment.app.FragmentActivity
import java.util.concurrent.Executor
import java.util.concurrent.Executors

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding

/** FingerprintAuthPlugin */
class FingerprintAuthPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {

  private lateinit var channel: MethodChannel
  private var activity: FragmentActivity? = null // Pour BiometricPrompt, nous avons besoin d'une FragmentActivity
  private var pendingResult: Result? = null // Pour stocker le résultat de la méthode Flutter

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "fingerprint_auth_plugin")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "authenticateFingerprint") {
      if (activity == null) {
        result.error("UNAVAILABLE", "Activity not available.", null)
        return
      }
      pendingResult = result // Stocke le résultat pour l'utiliser dans le callback biométrique
      authenticateBiometric()
    } else {
      result.notImplemented()
    }
  }

  // BiometricPrompt est recommandé depuis API 28 (Android 9.0)
  @RequiresApi(Build.VERSION_CODES.P)
  private fun authenticateBiometric() {
    val executor: Executor = Executors.newSingleThreadExecutor()

    val biometricPrompt = BiometricPrompt(activity!!, // 'activity!!' car nous nous assurons qu'il n'est pas nul avant
        executor, object : BiometricPrompt.AuthenticationCallback() {
          override fun onAuthenticationError(errorCode: Int, @NonNull errString: CharSequence) {
            super.onAuthenticationError(errorCode, errString)
            pendingResult?.success(false) // Échec de l'authentification
            pendingResult = null
          }

          override fun onAuthenticationSucceeded(@NonNull authResult: BiometricPrompt.AuthenticationResult) {
            super.onAuthenticationSucceeded(authResult)
            pendingResult?.success(true) // Authentification réussie
            pendingResult = null
          }

          override fun onAuthenticationFailed() {
            super.onAuthenticationFailed()
            // Cela se produit si l'empreinte digitale est reconnue mais ne correspond pas
            pendingResult?.success(false) // Échec de l'authentification
            pendingResult = null
          }
        })

    val promptInfo = BiometricPrompt.PromptInfo.Builder()
        .setTitle("Authentification biométrique")
        .setSubtitle("Veuillez utiliser votre empreinte digitale pour continuer")
        .setNegativeButtonText("Annuler") // Important pour permettre l'annulation
        .build()

    biometricPrompt.authenticate(promptInfo)
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onAttachedToActivity(@NonNull binding: ActivityPluginBinding) {
    // Obtenez l'activité Android pour BiometricPrompt
    if (binding.activity is FragmentActivity) {
      activity = binding.activity as FragmentActivity
    } else {
      // Gérer le cas où l'activité n'est pas une FragmentActivity (rare pour Flutter)
      System.err.println("FingerprintAuthPlugin: Activity is not a FragmentActivity. BiometricPrompt may not work correctly.")
    }
  }

  override fun onDetachedFromActivityForConfigChanges() {
    activity = null
  }

  override fun onReattachedToActivityForConfigChanges(@NonNull binding: ActivityPluginBinding) {
    if (binding.activity is FragmentActivity) {
      activity = binding.activity as FragmentActivity
    }
  }

  override fun onDetachedFromActivity() {
    activity = null
  }
}
