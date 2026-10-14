//! The Pelago extension for Zed: colours come from the Tree-sitter grammar (see `extension.toml`),
//! the language server is `pelago lsp` from the compiler found on the user's PATH.

use zed_extension_api::{self as zed, Result};

struct PelagoExtension;

impl zed::Extension for PelagoExtension {
    fn new() -> Self {
        PelagoExtension
    }

    fn language_server_command(
        &mut self,
        _language_server_id: &zed::LanguageServerId,
        worktree: &zed::Worktree,
    ) -> Result<zed::Command> {
        let command = worktree.which("pelago").ok_or_else(|| {
            "the `pelago` tool is not on your PATH; install it, then restart the language server"
                .to_string()
        })?;
        Ok(zed::Command {
            command,
            args: vec!["lsp".to_string()],
            env: worktree.shell_env(),
        })
    }
}

zed::register_extension!(PelagoExtension);
