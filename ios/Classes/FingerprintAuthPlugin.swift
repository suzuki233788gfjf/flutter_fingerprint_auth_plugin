import Flutter
import UIKit
import LocalAuthentication // Importez le framework LocalAuthentication

public class FingerprintAuthPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "fingerprint_auth_plugin", binaryMessenger: registrar.messenger())
    let instance = FingerprintAuthPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if call.method == "authenticateFingerprint" {
      authenticateBiometric(result: result)
    } else {
      result(FlutterMethodNotImplemented)
    }
  }

  private func authenticateBiometric(result: @escaping FlutterResult) {
    let context = LAContext()
    var error: NSError?

    // Vérifie si l'authentification biométrique est disponible
    if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
      let reason = "Veuillez utiliser votre empreinte digitale pour accéder."

      context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
        DispatchQueue.main.async { // Important: retour sur le thread principal pour les mises à jour UI
          if success {
            result(true) // Authentification réussie
          } else {
            // Gérer les différents types d'erreurs d'authentification
            if let err = authenticationError as? LAError {
                switch err.code {
                case .userCancel, .appCancel, .userFallback:
                    result(false) // Annulé par l'utilisateur ou l'application
                case .authenticationFailed:
                    result(false) // Échec de l'authentification (empreinte non reconnue)
                default:
                    result(false) // Autre erreur
                }
            } else {
                result(false) // Erreur inconnue
            }
          }
        }
      }
    } else {
      // La biométrie n'est pas disponible sur cet appareil ou n'est pas configurée
      result(false)
      // Vous pouvez renvoyer un message d'erreur plus spécifique ici
      // print("Biometric authentication not available: \(error?.localizedDescription ?? "Unknown error")")
    }
  }
}
