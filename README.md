<!-- markdownlint-disable first-line-h1 no-inline-html -->

<div align="center">

![CLI Tips Banner](assets/banner.png)

<p>

`cli-tips` is a command-line tool offering useful Linux tips and commands, which can be integrated as a **Message of the Day** (MOTD).

</p>

</div>

## ✨ Features

- Displays helpful Linux command tips
- Supports multiple languages
- Easy to install and use

## 📥 Installation

To install `cli-tips`, run the following command:

```bash
curl -sL https://bit.ly/cli-tips-installer | bash
```

<details>
<summary>
    <h4>🗑️ Uninstall</h4>
</summary>

To uninstall `cli-tips`, run the following command:

```bash
sudo rm -rf ${PREFIX:-/usr$([ "$(uname)" = "Darwin" ] && echo "/local")}/{bin,share}/cli-tips && hash -r
```

> **ℹ️ Note**:
>
> If you want to remove this tool from **Termux**, run the above command without `sudo`.

</details>

<details>
<summary>
    <h4>❄️ Nix</h4>
</summary>

For Nix the package manager, the package name is `cli-tips`. You should consult [the Nix manual](https://nixos.org/manual/nixpkgs/stable/#sec-declarative-package-management)
on how to properly install packages.

</details>

### Compatibility table

| <div><img src="https://upload.wikimedia.org/wikipedia/commons/f/f1/Icons8_flat_linux.svg" alt="Linux logo" width="30"/></div> **Linux** | <div><img src="https://upload.wikimedia.org/wikipedia/commons/b/b5/Termux.svg" alt="Termux logo" width="30"/></div> **Termux** | <div><img src="https://github.com/okineadev/dotload/raw/refs/heads/main/public/macos-dark-logo.svg#gh-light-mode-only" alt="macOS logo" width="30"/><img src="https://github.com/okineadev/dotload/raw/refs/heads/main/public/macos-light-logo.svg#gh-dark-mode-only" alt="macOS logo" width="30"/></div> **macOS** | <div><img src="https://github.com/okineadev/dotload/assets/81070564/99544c04-51e7-41b5-95f7-0828cfc97617" alt="Windows logo" width="30"/></div> **Windows** (on [msys shell](https://www.msys2.org/)) |
| :-------------------------------------------------------------------------------------------------------------------------------------: | :----------------------------------------------------------------------------------------------------------------------------: | :-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: |
|                                                                   ✅                                                                    |                                                               ✅                                                               |                                                                                                                                                         ✅                                                                                                                                                          |                                                                                                  ✅                                                                                                   |

## 🚀 Usage

To print a random tip, run:

```bash
cli-tips

# Output:
# Use 'uniq' to remove duplicate lines from a file
```

> [!NOTE]
>
> `cli-tips` automatically detects the user's language and displays tips in that language. You can also set the language manually using the `LANG` environment variable.

### Use Another Language

To display tips in a different language, use the `--lang` option:

```bash
cli-tips --lang=uk
# Output: Використовуйте 'uniq', щоб видалити дубльовані рядки з файлу
```

You can also use the `LANG` environment variable:

```bash
LANG=de cli-tips
# Output: Verwenden Sie 'uniq', um doppelte Zeilen aus einer Datei zu entfernen
```

### Use the `--about` Flag

To display a random tip containing a specific keyword, use the `--about` option:

```bash
cli-tips --about=git
# Output: Use 'git status' to check the status of your git repository
```

If no tips contain the specified keyword, no tip will be output.

### Available Languages

Here is a list of all available languages:

| Language                            | Code |
| ----------------------------------- | :--: |
| [🇸🇦 Arabic](translations/ar.txt)    | `ar` |
| [🇨🇳 Chinese](translations/cn.txt)   | `cn` |
| [🇩🇪 German](translations/de.txt)    | `de` |
| [🇬🇧 English](translations/en.txt)   | `en` |
| [🇮🇷 Farsi](translations/fa.txt)     | `fa` |
| [🇮🇹 Italian](translations/it.txt)   | `it` |
| [🇯🇵 Japanese](translations/ja.txt)  | `ja` |
| [🇰🇷 Korean](translations/ko.txt)    | `ko` |
| [🇵🇱 Polish](translations/pl.txt)    | `pl` |
| [🇪🇸 Spanish](translations/es.txt)   | `es` |
| [🇺🇦 Ukrainian](translations/uk.txt) | `uk` |

<!-- ### Specify a Custom Folder with Tips Translations

To use a custom folder with tips translations, set the `TIPS_FOLDER` environment variable:

```bash
TIPS_FOLDER=/path/to/tips cli-tips --lang=veryrarelanguage
# Output: <Tip in veryrarelanguage>
```

By default, `cli-tips` uses the built-in tips folder. The custom folder should contain text files in the following format:

```plaintext
tips_<lang_id>.txt
```

Example:

```plaintext
📂 translations/
 ├── 📄 tips_de.txt
 ├── 📄 tips_en.txt
 ├── 📄 tips_pl.txt
 └── 📄 tips_uk.txt
``` -->

## 📝 License

This project is fully free and you can do anything you want with it, even without mentioning this repository or license. Enjoy! 🚀

## ❤️ Support

If you like this project, consider supporting it by starring ⭐ it on GitHub, sharing it with your friends, or buying me a coffee ☕:

- <https://send.monobank.ua/jar/6rUVs4yasg>
- <https://donatello.to/okineadev>

## 🤝 Contributing

We welcome contributions from everyone. If you would like to contribute, please read our [CONTRIBUTING.md](CONTRIBUTING.md) file for detailed instructions on how to add translations and other contributions.
