# IthringVest - Copilot Instructions

## Regras gerais
- Utilize e mantenha as implementações utilizando Clean Architecture do jeito que está configurado no projeto.
- Utilize SOLID.
- Sempre desenvolva com base no inglês.
- Evite comentários redundantes.
- Sempre utilize aspas duplas para strings.
- Sempre declare as funções com parametros da seguinte forma: `void functionName( String value )
- Sempre utilize o padrão de nomenclatura do projeto.

## Flutter
- Mantenha as gerencias de estados já implementadas (Mobx e Cubit).
- Prefira extension methods ao invés de helpers globais.
- Evite código duplicado.
- Siga as boas práticas de desenvolvimento Flutter.
- Mantenha a consistência do código.
- Evite rebuilds desnecessários.
- Sempre trate exceptions.
- Evite hardcoded Strings, utilize as traduções disponíveis no projeto (assets/languages), caso não tenha crie-as e as utilize.
- Evite hardcoded colors, utilize as cores disponíveis através do Theme.of(context).
- Sempre utilize o widget VerifyConnectionWidget como widget pai de todas as telas.
- Utilize a tela LoginPage como exemplo de espaçamento, organização e estrutura de código.

## Android
- Compatível com Android 7 até Android 14.
- Evite APIs deprecated.
- Siga as boas práticas de desenvolvimento Android.
- Mantenha a consistência do código.

## Código
- Prefira código performático.
- Evite rebuilds desnecessários.
- Sempre trate exceptions.
- Mantenha o código limpo e organizado.
- Evite código duplicado.
- Siga as boas práticas de desenvolvimento.
- Mantenha a consistência do código.