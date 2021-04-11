# Identicon

An Elixir project that receives a string and return a GitHub like identicon profile image.

## Installation

```shell
  git clone https://github.com/marciovalim/elixir-identicon.git
  cd elixir-identicon
  mix deps.get
```

## Run

```elixir
  iex -S mix
  iex(1)> Identicon.create("some_string_here")
  :ok
```

See results in _outputs_ folder.

## Example

```elixir
  iex -S mix
  iex(1)> Identicon.create("marciovalim")
  :ok
```

Identicon generated for "marciovalim": <br>
<img width="180" src="./outputs/marciovalim.png" alt="Identicon output exaple"/>

