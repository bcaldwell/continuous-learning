# Umask

- controls file creation mode
- value is subtracted from 0777 file mode. Ex 0222 -> 755
- **NOTE: linux files cannot be created with execution permission**

## Usage
- `umask` output current umask value (022)
- `umask xxx` set umask to xxx value
- `umask -S` output current umask value using symbolic notation

### Octal Value Refresher

| Octal | Binary | Meaning                 |
|-------|--------|-------------------------|
| 0     | 000    | no permissions          |
| 1     | 001    | execute only            |
| 2     | 002    | write only              |
| 3     | 003    | execute and write       |
| 4     | 004    | read only               |
| 5     | 005    | read and execute        |
| 6     | 006    | read and write          |
| 7     | 007    | read, write and execute |

