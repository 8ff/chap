![logo](media/logo_600x200.svg "CHAP: Secure Your Data with Ease")
# CHAP: Secure Your Data with Ease

**CHAP** (short for *chachapoly*) is a tool for encryption, decryption, and secure file wiping. It leverages the [cipherbox](https://github.com/8ff/cipherbox) library as a wrapper for the **ChaCha20-Poly1305** cipher and **scrypt** key derivation, providing strong data protection.

## Features
- **Encrypt** (`e`): Secure your data with strong encryption. (Requires `CKEY` environment variable)
- **Decrypt** (`d`): Decrypt your data to restore it to its original form. (Requires `CKEY` environment variable)
- **Wipe** (`w`,`wipe`): Permanently and securely erase files, leaving no trace behind.

## Installation
Download the latest release of CHAP from the [GitHub Releases](https://github.com/8ff/chap/releases/tag/latest).

1. Download the binary for your platform.
2. Make it executable:

    ```bash
    chmod +x chap
    ```

3. Run the binary from the download location or place it in your system PATH for easy access.

## Usage
### Encrypting Data
To encrypt a file, ensure the `CKEY` environment variable is set with a 32-byte key. If the key is shorter, it will be padded using a Fibonacci sequence, which is not secure. It is highly recommended to use a random key of the correct length.

```bash
CKEY="your-32-byte-key" ./chap e < plaintext.txt > encrypted.txt
```

### Decrypting Data
Decrypt your previously encrypted files with the correct key:

```bash
CKEY="your-32-byte-key" ./chap d < encrypted.txt > plaintext.txt
```

### Securely Wiping Files
To securely delete a file, use the wipe command:

```bash
./chap wipe /path/to/your/file.txt
```
### Dont prompt for confirmation
```bash
FORCE_WIPE=true ./chap wipe /path/to/your/file.txt
```

### Help
For assistance and a summary of available commands:

```bash
./chap help
```

## Key Length Requirement
Your encryption key must be exactly 32 bytes long. If it's shorter, it will be padded using a Fibonacci sequence, which is not recommended for secure encryption. Ensure your key is the correct length to maintain the highest level of security.

## Contributing
Contributions are welcome. If you encounter any issues or have suggestions for improvements, please open an issue or submit a pull request.
