# ithring_vest

deixar de ter dor com o dinheiro para alcançar a liberdade financeira.

## Origem do nome

- Ithring = Liberdade
- Vest = Invest
- Zar'roc = Miséria / Dor

O nome "ithringVest" é uma combinação de "ithring", que é uma palavra retirada do livro Murtagh (cronologia de Eragon) que significa "Liberdade" e "vest", que vem de "Invest".
Juntos, eles refletem a missão do projeto de ajudar as pessoas a controlar suas finanças de forma inteligente e alcançar a liberdade financeira.

O peso de Ithring na história de Eragon é significativo, pois representa uma transformação enorme do personagem
a fim de se aceitar a ponto de conseguir alterar o verdadeiro nome de sua espada,  originalmente chamada de Zar'roc.

## :gear: Gerenciamento de versão

```sh
# Versionamento
#
# ┌────── Marcos: Mudanças importantes
# │ ┌─────── Épicos: Funcionalidade nova. (Indica quantas novas funcionalidades foram adicionadas na versão)
# │ │ ┌──────── Incrementado a cada ajuste de bug. (Indica a quantidade de bugs resolvido por versão)
# │ │ │ ┌──────── Incrementado a cada alteração no arquivo pubspec.yaml (indica a versão do código) 
# │ │ │ │   
# 1.1.X+XXX

```

---

### :star2: Versões utilizadas

Este projeto foi desenvolvido utilizando Flutter, logo as versões que foram utilizadas são:

<bold>Flutter:</bold> 3.35.2
<bold>Dart:</bold> 3.9.0
<bold>DevTools:</bold> 2.48.0

---

### :gear: .ENV exemplo

```sh
BASE_URL=TODO
CLIENT_NAME=TODO
X_API_KEY=TODO
    
ONESIGNAL_APP_ID=TODO
ONESIGNAL_TEMPLATE_UPD_CATEGORY=TODO
ONESIGNAL_TEMPLATE_BILLING_EXPIRED=TODO

AWESOME_API_URL=TODO
AWESOME_API_KEY=TODO
```

### :star: Compilação Bundle release da loja android

```sh
    flutter build appbundle --release --dart-define-from-file=.env
```

### :star2: Compilação APK release com ofuscação de codigo

```sh
    flutter build apk --split-per-abi --release --dart-define-from-file=.env
```

## :gear: Flutter Setup
```sh
    flutter pub get
    flutter pub run flutter_native_splash:create
    flutter pub run flutter_launcher_icons
    dart run build_runner build
    flutter run --dart-define-from-file=.env
```

## :bulb: Caso algo não estiver funcionando adequadamente
```sh
    flutter clean
    rm -rf pubspec.lock
    flutter pub get
    flutter pub run flutter_native_splash:create
    flutter pub run flutter_launcher_icons
    dart run build_runner build --delete-conflicting-outputs
    flutter run --dart-define-from-file=.env
```

### :gear: MacOS Setup

```sh
cd ios/

pod clean
pod cache
pod deintegrate
pod install
```

### :gear: Configurações do firebase debug - ANDROID
Para que os dados do firebase não sejam poluidos com dados do desenvolvimento precisa ser utilizado o comando abaixo para que todos os logs e ações dentro do app de desenvolvimento seja realocada no setor de dev do proprio firebase. Este comando ativará o modo depuração do analytics até que seja desativado.

```
adb shell setprop debug.firebase.analytics.app dev.tiagobruckmann.ithringvest

Execute o app em modo debug -> Vá para as opções de desenvolvedor -> Selecione app debug -> selecione o app IthringVest

o processo acima irá exibir o dispositivo no debugview.
```

Desativar depuração

```
adb shell setprop debug.firebase.analytics.app .none.
```
