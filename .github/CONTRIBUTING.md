# Contributing to the Project

Thank you for considering contributing to this project! Your contributions help improve the project for everyone. Please follow these guidelines to ensure a smooth collaboration.

## ✨ Commit Message Guidelines
This project follows the **[Conventional Commits](https://www.conventionalcommits.org/)** specification. Please use the following format when making commits:

```
type(scope): description
```

Examples:
- `feat(api): add new endpoint for fetching user data`
- `fix(parser): correct error handling in XML parsing`
- `docs(readme): update installation instructions`

Common commit types:
- `feat`: A new feature
- `fix`: A bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, missing semi-colons, etc.)
- `refactor`: Code refactoring without changing functionality
- `test`: Adding or updating tests
- `chore`: Maintenance tasks (e.g., dependency updates)

## 🔨 Running Tasks
This project uses a task runner defined in `Taskfile.yml`. Below are the key tasks you might need to run during development.

### Cleaning Build Artifacts
```sh
task clean
```

### Running Tests
Run all tests:
```sh
task test
```
Run Rust-specific tests:
```sh
task test-rust
```
Run R-specific tests:
```sh
task test-r
```

### Generating Documentation
```sh
task document
```

### Installing the Project
```sh
task install
```

### Checking the Package
```sh
task check
```

## 🛠️ Submitting a Contribution
1. **Fork** the repository.
2. **Create** a new branch with a descriptive name:
   ```sh
   git checkout -b feature/new-feature
   ```
3. **Make changes** and commit using [Conventional Commits](#✨-commit-message-guidelines).
4. **Push** the changes to your fork:
   ```sh
   git push origin feature/new-feature
   ```
5. **Create a Pull Request** on GitHub.

## ✅ Review Process
- All PRs must pass the automated tests before merging.
- At least one project maintainer must approve the changes.

Thank you for your contribution! 🚀

