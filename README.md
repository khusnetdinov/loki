# Loki [![Code Triagers Badge](https://www.codetriage.com/khusnetdinov/loki/badges/users.svg)](https://www.codetriage.com/khusnetdinov/loki) [![Build Status](https://travis-ci.org/khusnetdinov/loki.svg?branch=master)](https://travis-ci.org/khusnetdinov/loki) [![Hex.pm](https://img.shields.io/hexpm/v/plug.svg)](https://hex.pm/packages/loki) [![Ebert](https://ebertapp.io/github/khusnetdinov/loki.svg)](https://ebertapp.io/github/khusnetdinov/loki)

Loki is a toolkit for building powerful command-line interfaces.

![img](http://res.cloudinary.com/dtoqqxqjv/image/upload/v1481907831/loki.jpg)

## Example

![img](http://res.cloudinary.com/dtoqqxqjv/image/upload/c_scale,w_469/v1481959955/1._khusnetdinov_khusnetdinov_Desktop_project_zsh_2016-12-17_09-51-12_rdjqni.png)

## Instalation

Add `loki` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:loki, "~> 1.2.0"}]
end
```

## Usage

Import all or desired module to scope:

```elixir
defmodule Project do
  use Loki

  import Loki.Shell
  import Loki.Cmd
  import Loki.Directory
  import Loki.File
  import Loki.FileManipulation

  ...

end
```

## Modules

### Loki.Shell
Helpers for interaction with user and printing message to shell.

 - `ask/2` - Ask user input with given message. Returns tuple with parsed options.
 - `yes?/1` - Ask about positive user input with given message.
 - `no?/1` - Ask about negative user input with given message.
 - `say/1` - Printing message to shell.
 - `say_create/1` - Printing message about create file to shell.
 - `say_force/1` -  Printing message about force action to shell.
 - `say_identical/1` - Printing message about identical files content to shell.
 - `say_skip/1` - Printing message about skipping action to shell.
 - `say_error/1` - Printing message about to shell.
 - `say_conflict/1` - Printing message about conflict to shell.
 - `say_exists/1` - Printing message about existance to shell.
 - `say_rename/2` - Printing message about rename files to shell.
 - `say_copy/2` - Printing message about copy files to shell.
 - `say_remove/1` - Printing message about removing file to shell.

### Loki.Cmd
Executing terminal commands helpers.

  - `execute/1` - Execute shell command with Env variables as options.
  - `execute_in_path/2` - Execute shell command with Env variables as options in given path.
  - `format_output/1` - Format execution output for reading in shell.

### Loki.Directory
Working with folders helpers.

  - `create_directory/1` - Helper for create directory.
  - `exists_directory?/1` - Helper for checking if file exists.
  - `copy_directory/2` - Helper for copy directory.
  - `remove_directory/1` - Helper for remove directory.

### Loki.File
Helpers for working with file.

  - `create_file/1` - Helper for create file.
  - `create_file_force/1` - Helper for create file in force mode.
  - `exists_file?/1` - Helper check if file exists.
  - `identical_file?/2` - Helper check if file identical.
  - `copy_file/2` - Helper for copy files.
  - `create_link/2` - Helper for create link.
  - `remove_file/1` - Helper for remove file.
  - `rename/2` - Helper for rename files and dirs.

### Loki.FileManipulation
Helpers for content manipulation injecting, appending, and other.

   - `append_to_file/2` - Helper appends lines to file.
   - `prepend_to_file/2` - Helper prepends lines to file.
   - `remove_from_file/2` - Helper removes lines from file.
   - `inject_into_file/3` - Helper injecting lines to file with `before` and `after` options.
   - `replace_in_file/3` - Helper replaces lines in file.
   - `comment_in_file/2` - Helper comments line in file.
   - `uncomment_in_file/2` - Helper uncomments lines in file.

## Documentation

  [Read hexdocs.pm](https://hexdocs.pm/loki/api-reference.html)

## Contribution

Clone repo, implement additional helpers, write tests and PR welcome!

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
