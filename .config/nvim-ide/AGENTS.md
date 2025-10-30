# Agent Guidelines for LazyVim Configuration

## Commands
- **Format**: Use `stylua .` for Lua formatting (configured in stylua.toml)
- **Test**: No automated tests - verify by opening Neovim and checking plugin functionality
- **Check**: Validate syntax with `luacheck lua/` or `nvim --headless -c "luafile init.lua" -c "qa"`

## Code Style
- **Indentation**: 2 spaces (lua, yaml), 4 spaces (default) - configured via tabset.nvim
- **Line width**: 120 characters (stylua.toml)
- **Strings**: Use double quotes for consistency
- **Tables**: Trailing commas required, align values vertically
- **Comments**: Use `--` for single line, avoid inline comments unless necessary

## Structure & Patterns
- **Plugin config**: Each plugin in separate file under `lua/plugins/`
- **Keymaps**: Define in plugin config using `keys` table, not global keymaps.lua
- **Options**: Plugin-specific opts table, avoid global vim.opt in plugin files
- **Lazy loading**: Use `event`, `ft`, `keys` for optimal startup performance

## Naming Conventions
- **Files**: snake_case.lua
- **Functions**: camelCase for Lua functions, snake_case for Neovim commands
- **Variables**: snake_case
- **Plugin specs**: Use full plugin name as table key when overriding LazyVim defaults