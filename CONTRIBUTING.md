# Contributing to cli-tips

Thank you for considering contributing to cli-tips! We welcome contributions from everyone. By participating in this project, you agree to abide by our [Code of Conduct](CODE_OF_CONDUCT.md).

## How to Contribute

### Reporting Issues

If you encounter any issues or have suggestions for improvements, please [open an issue on GitHub](https://github.com/cli-stuff/cli-tips/issues/new/choose). Provide as much detail as possible to help us understand and address the problem.

### Adding Translations for Tips

We appreciate your help in adding translations for tips. Follow these steps to add a new translation:

1. **Fork the Repository**: Click the "Fork" button at the top right corner of the repository page to create a copy of the repository in your GitHub account.

2. **Clone the Repository**: Clone the forked repository to your local machine using the following command:
   ```bash
   git clone https://github.com/<your-username>/cli-tips.git
   ```

3. **Create a New Branch**: Create a new branch for your translation using the following command:
   ```bash
   git checkout -b add-translation-<language-code>
   ```

4. **Add Translation File**: Navigate to the `translations` directory and add a new file named `<language-code>.txt` (e.g., `es.txt` for Spanish). Add your translations to this file, following the format of existing translation files.

5. **Commit Your Changes**: Commit your changes with a descriptive commit message using the following commands:
   ```bash
   git add translations/<language-code>.txt
   git commit -m "Add translations for <language>"
   ```

6. **Push Your Changes**: Push your changes to your forked repository using the following command:
   ```bash
   git push origin add-translation-<language-code>
   ```

7. **Create a Pull Request**: Go to the original repository on GitHub and click the "New Pull Request" button. Select your branch and submit the pull request. Provide a clear description of the changes you made.

### Code Style

Please follow these guidelines to maintain a consistent code style:

- Write clear and descriptive commit messages.
- Ensure your code working before submitting a pull request.

### Submitting Pull Requests

When submitting a pull request, please ensure the following:

- Your code follows the project's code style.
- Your changes are well-documented.
- Your pull request includes a clear description of the changes and the reasons for them.

Thank you for your contributions!
