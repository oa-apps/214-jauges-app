# Jauge ST214 : application Android hors ligne

FMS TEAM - HOUNDE GOLD OPÉRATIONS. Aucune connexion ni serveur : les opérateurs et l'historique sont enregistrés dans la mémoire du téléphone.

Contenu : `www/index.html` (l'application), `capacitor.config.json`, `package.json`, `build-apk.bat`.

## Compiler l'APK sous Windows (une seule fois à préparer)

1. Installer **Node.js 20 LTS** : https://nodejs.org
2. Installer **JDK 17** (Temurin) : https://adoptium.net
3. Installer **Android Studio** : https://developer.android.com/studio
   Au premier lancement, laisser l'assistant installer le SDK Android.
4. Variables d'environnement Windows (Paramètres > Variables d'environnement) :
   - `JAVA_HOME` = dossier du JDK 17, par exemple `C:\Program Files\Eclipse Adoptium\jdk-17...`
   - `ANDROID_HOME` = `C:\Users\VOTRE_NOM\AppData\Local\Android\Sdk`
5. Accepter les licences Android, dans PowerShell :
   ```
   & "$env:ANDROID_HOME\cmdline-tools\latest\bin\sdkmanager.bat" --licenses
   ```
   Si `cmdline-tools` est absent : Android Studio > More Actions > SDK Manager > onglet SDK Tools > cocher « Android SDK Command-line Tools ».

## Générer l'APK

Ouvrir PowerShell dans le dossier du projet, puis :

```
.\build-apk.bat
```

Ou, commande par commande :

```
npm install
npx cap add android
npx cap sync android
cd android
.\gradlew.bat assembleDebug
```

Le fichier se trouve ici : `android\app\build\outputs\apk\debug\app-debug.apk`

## Installer sur le téléphone

1. Copier `app-debug.apk` sur le téléphone (câble USB, WhatsApp, e-mail).
2. L'ouvrir et autoriser « Installer des applications inconnues » pour l'application utilisée.
3. Lancer **Jauge ST214**. Tout fonctionne sans réseau.

## Sans installer Android Studio (option)

Déposer ce dossier dans un dépôt GitHub privé : le fichier `.github/workflows/build-apk.yml` compile l'APK. Onglet Actions > Build APK > Run workflow, puis télécharger `jauge-st214-apk`.

## Mise à jour de l'application

Modifier `www/index.html`, relancer `.\build-apk.bat`, puis réinstaller l'APK par-dessus l'ancien : l'historique est conservé. Désinstaller l'application efface l'historique et les opérateurs ajoutés.
