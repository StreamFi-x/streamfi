[![License](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/license/MIT)

# StreamFi

## Overview

StreamFi is a decentralized live-streaming platform that empowers content creators and viewers through blockchain technology. Our mission is to create a fair, transparent, and user-driven streaming ecosystem where creators retain full ownership of their content and earnings. 

It is designed for content creators and gamers that empowers users with Web3-native monetization, eliminating middlemen through direct crypto tipping and blockchain-based interactions, while ensuring transparency, security, and censorship resistance in content creation and distribution.

### 🌍 Ecosystem and Integrations

- Integrates with **StarkNet** for blockchain scalability.
- Engages with **Worldcoin** for user identity verification.

## 🏗 Project Structure

- **Frontend**: Built with React, Next.js (Web), Flutter (Mobile).
- **Backend**: Node.js, FastAPI, GraphQL.
- **Smart Contracts**: Cairo (StarkNet).
- **Storage**: IPFS/Filecoin integration for decentralized content storage.

## Installation
### Running with MakeFile

```bash
make clean
```

This command will remove the build folder and the .dart_tool folder.

```bash
make build
```

This command will build the project.

```bash
make run
```

Generate all freezed files and generated files

```bash
make gen
```

### Running with Flutter Commands

```bash
flutter clean
```

This command will remove the build folder and the .dart_tool folder.

```bash
flutter build apk
```

This command will build the project.

```bash
flutter run
```

Generate all freezed files and generated files

```bash
flutter pub run build_runner build
```

## Testing

```bash
flutter test
```

This command will run all the tests in the test folder.

```bash
flutter test --coverage
```

This command will run all the tests using the makefile

```bash
make test
```


## 🛠 Branch Naming Convention

We follow a structured branch naming format:

```
[fix|feat|chore]-[issue-number]-[short-description]
```

Example:

```
feat-23-livepeer-integration
fix-45-streaming-bug
```

## 🤝 Contributing

We are always excited to welcome passionate developers and contributors to help shape the future of StreamFi. Whether you're improving existing features, fixing bugs, or bringing innovative ideas to the table, your contributions are invaluable. To get started, check out our [📜 Contribution Guide](https://github.com/StreamFi-x/streamfi-frontend/blob/main/CONTRIBUTING.md) for detailed instructions on how to contribute effectively.

## 💬 Community & Support

- Join our [Telegram](https://t.me/+slCXibBFWF05NDQ0) for discussions and support.

## 📜 License

This project is licensed under the MIT License.

