# `auth_plug` _Example_

Example using
[`auth_plug`](https://github.com/dwyl/auth_plug)
for authenticated routes.

## How?

### 1. Create New Phoenix App

```
mix phx.new app --no-ecto --no-webpack
```
When asked if you want to `Fetch and install dependencies? [Yn]`
Type <kbd>Y</kbd> and the <kbd>Enter</kbd> key.

> This example only needs the bare minimum Phoenix;
we don't need any JavaScript or Database. <br />
For more info, see:
https://hexdocs.pm/phoenix/Mix.Tasks.Phx.New.html

Change into the `app` directory (`cd app`)
and open the project in your editor.
e.g: `atom .`


### 2. Add `auth_plug` to `deps`

Open the `mix.exs` file
and locate the `defp deps do` section.
Add the line:

```
{:auth_plug, "~> 0.9.0"}
```

E.g:
[mix.exs#L44-L45](https://github.com/dwyl/auth_plug_example/blob/b454443b1a1618d3831fab3d5f7db81fe2e59586/mix.exs#L44-L45)
