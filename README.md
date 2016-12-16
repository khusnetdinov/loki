# Loki [![Code Triagers Badge](https://www.codetriage.com/khusnetdinov/loki/badges/users.svg)](https://www.codetriage.com/khusnetdinov/loki) [![Build Status](https://travis-ci.org/khusnetdinov/loki.svg?branch=master)](https://travis-ci.org/khusnetdinov/loki) [![Hex.pm](https://img.shields.io/hexpm/v/plug.svg)](https://hex.pm/packages/loki)

Loki is a toolkit for building powerful command-line interfaces.

![img](http://res.cloudinary.com/dtoqqxqjv/image/upload/v1481907831/loki.jpg)

## Instalation

Add `loki` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:loki, "~> 0.1.0"}]
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

### Shell
  
### Cmd

### Directory

### File

### FileManipulation

## Documentation

  [Read hexdocs.pm](https://hexdocs.pm/loki/api-reference.html)
  
## Contribution

Clone repo, implement additional helpers, write tests and PR welcome!

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
