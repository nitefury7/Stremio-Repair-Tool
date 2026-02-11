# Stremio Repair Tool for macOS

A simple tool to fix the "Stremio is damaged and can't be opened" or "Apple cannot check it for malicious software" errors on macOS.

## Use Cases

- Stremio crashes on launch
- "Stremio.app is damaged and can't be opened" error
- "Apple cannot check it for malicious software" error
- Stuck on verifying

## Usage

### Option 1: Download the Repair App (Easiest)

1. Go to the [Releases](../../releases) page.
2. Download `Stremio Repair.zip` (or `.app`).
3. Extract the file if needed.
4. **Right-click** on `Stremio Repair.app` and select **Open**.
    - _Note: You might need to confirm "Open" in the security dialog._
5. Follow the on-screen prompts to repair Stremio.

If the app is blocked:
1. Open System Settings -> Privacy & Security.
2. Scroll down to the Security section.
3. Look for the message about "Stremio Repair.app" being blocked.
4. Click "Open Anyway".

### Option 2: Run via Command Script

1. Download `StremioRepair.command` from the repository.
2. Double-click the file.
3. It will open a Terminal window automatically.
4. Enter your password when prompted.

### Option 3: AppleScript (Source)

If you want to run the AppleScript source directly:

1. Open `StremioRepair.applescript` in Script Editor.
2. Click the **Run** (Play) button.

### Option 4: Run via Terminal (Manual)

If you prefer using the command line manually:

1. Open Terminal.
2. Clone this repository or download `stremio_repair.sh`.
3. Make the script executable:
    ```bash
    chmod +x stremio_repair.sh
    ```
4. Run the script:
    ```bash
    ./stremio_repair.sh
    ```

## What it does

This tool performs the following actions to clean up the installation:

1. **Removes Quarantine Attributes**: Removes the `com.apple.quarantine` extended attribute that prevents gatekeeper from allowing the app to run.
    - `xattr -cr /Applications/Stremio.app`
2. **Cleans Metadata**: Removes hidden system files that might be corrupted or causing conflicts.
    - Deletes `._*` files
    - Deletes `.DS_Store` files
3. **Re-signs the Application**: Ad-hoc signs the application to ensure integrity checks pass.
    - `codesign --force --deep --sign - /Applications/Stremio.app`

## Requirements

- macOS
- Stremio installed in `/Applications/Stremio.app`
- Administrator privileges (password required for execution)
