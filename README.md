<div align="center">

# `auth_plug` _example_

A working example of
[**`auth_plug`**](https://github.com/dwyl/auth_plug)
showing you how simple it is
to use
[**`auth`**](https://github.com/dwyl/auth)
in your Phoenix App!

[![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/dwyl/auth_plug_example/ci.yml?label=build&style=flat-square&branch=main)](https://github.com/dwyl/auth_plug_example/actions)
[![codecov.io](https://img.shields.io/codecov/c/github/dwyl/auth_plug_example/master.svg?style=flat-square)](https://codecov.io/github/dwyl/auth_plug_example?branch=master)
[![Hex.pm](https://img.shields.io/hexpm/v/auth_plug?color=brightgreen&style=flat-square)](https://hex.pm/packages/auth_plug)
[![HitCount](https://hits.dwyl.com/dwyl/auth_plug_example.svg)](https://hits.dwyl.com/dwyl/auth_plug_example)
[![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat-square)](https://github.com/dwyl/auth_plug/issues)
</div>
<br />


## Why?

The purpose of this project/repo is to demonstrate how simple
it is to integrate **`auth_plug`** into _any_ Phoenix Web App/API.
Our objective was to build a re-useable auth _system_
that we could add to any Phoenix App in less than 5 minutes.

## What?

The most basic example of using **`auth_plug`**
to add Authentication to a Phoenix App
and showcase a protected route.

Before you attempt to use the **`auth_plug`**,
try the Heroku example version so you know what to expect:
https://auth-plug.fly.dev/admin

You will be redirected to:

![auth_demo](https://user-images.githubusercontent.com/194400/202489883-16d727f4-8f18-4fba-9e27-00ea01329482.png)

Once you have logged in, you will be redirected back:


![auth_plug_example-logged-in](https://user-images.githubusercontent.com/194400/202489177-47c53d17-d4e4-44eb-a923-c64e14ad214c.png)



## Who?

This example is for us @dwyl who will be using **`auth_plug`**
in all our projects and more specifically for our
[`App`](https://github.com/dwyl/app).
But we have made it as _generic_ as possible
to show that _anyone_ can use (an instance of the) Auth Service
to add Auth to _any_ app in less than 2 minutes!


## How?

### 1. Create New Phoenix App

```sh
mix phx.new app --no-ecto --no-webpack
```

When asked if you want to `Fetch and install dependencies? [Yn]`
Type <kbd>Y</kbd> followed by the <kbd>Enter</kbd> key.

> This example only needs the bare minimum Phoenix;
we don't need any JavaScript or Database. <br />
For more info, see:
https://hexdocs.pm/phoenix/Mix.Tasks.Phx.New.html <br />
> The beauty is that this simple use-case
is identical to the advanced one.
Once you understand these basic principals,
you "grock" how to use `auth_plug` _anywhere_!


Change into the `app` directory (`cd app`)
and open the project in your text editor (or IDE). <br />
e.g: `atom .`


### 2. Add `auth_plug` to `deps`

Open the `mix.exs` file
and locate the `defp deps do` section.
Add the line:

```
{:auth_plug, "~> 1.4"}
```

> E.g:
[`mix.exs#L45`](https://github.com/dwyl/auth_plug_example/blob/36f2fbf4d74dd3932119c5ca3f3562106dae08c4/mix.exs#L45)

### 3. Add `AuthPlug` to Your `router.ex` file to Protect a Route

Open the `lib/app_web/router.ex` file and locate the section:

```elixir
  scope "/", AppWeb do
    pipe_through :browser

    get "/", PageController, :index
  end
```

Immediately below this add the following lines of code:

```elixir
  pipeline :auth, do: plug(AuthPlug)

  scope "/", AppWeb do
    pipe_through :browser
    pipe_through :auth
    get "/admin", PageController, :admin
  end
```

> E.g:
[`/lib/app_web/router.ex#L23-L29`](https://github.com/dwyl/auth_plug_example/blob/8ce0f10e656b94a93b8f02af240b3897ce23c006/lib/app_web/router.ex#L23-L29)


#### _Explanation_

There are two parts to this code:

1. Create a new pipeline called `:auth` which will execute the `AuthPlug`
passing in the `auth_url` as an initialisation option.
2. Create a new scope where we `pipe_through`
both the `:browser` and `:auth` pipelines.

This means that the `"/admin"` route is protected by `AuthPlug`.


### 4. Add the `admin` function to the `PageController`

Open the `/lib/app_web/controllers/page_controller.ex` file
and locate the `def index` function:

```elixir
  def index(conn, _params) do
    render(conn, "index.html")
  end
```

Directly below it, add the following code:

```elixir
  def admin(conn, _param) do
    render(conn, "admin.html")
  end
```

> E.g:
[`/lib/app_web/controllers/page_controller.ex#L8-L10`](https://github.com/dwyl/auth_plug_example/blob/e0e31dbf341f4b8877bca0a9ec846b538e04406a/lib/app_web/controllers/page_controller.ex#L8-L10)


This just means when the `admin/2` function is invoked,
render the `admin.html` template. <br />
Speaking of which, let's create it!



### 5. Create the `admin.html.eex` Template

Create a new file at the following path:
`/lib/app_web/templates/page/admin.html.eex`

And paste the following code into it:

```html
<section class="phx-hero">
  <h1> Welcome <%= @conn.assigns.person.givenName %>!
  <img width="32px" src="<%= @conn.assigns.person.picture %>" />
  </h1>
  <p> You are <strong>signed in</strong>
    with your <strong><%= @conn.assigns.person.auth_provider %> account</strong> <br />.
  </p>
</section>
```

> E.g:
[`/lib/app_web/templates/page/admin.html.eex`](https://github.com/dwyl/auth_plug_example/blob/7b8ff52fd091e3cee2d3540b6701e68bbf42e179/lib/app_web/templates/page/admin.html.eex)


### 6. Get and Set the `AUTH_API_KEY` Environment Variable

Visit: 
[authdemo.fly.dev](https://authdemo.fly.dev/apps/new)
and create a New App:


![dwyl-auth-app-api-key-setup](https://user-images.githubusercontent.com/194400/202491060-6c2d015b-1313-4f94-8a8c-cdb52bd8aa5f.png)


Save the key as an environment variable named `AUTH_API_KEY`.
Remember to `export` the environment variable
or add it to an `.env` file which should be in your `.gitignore` file.

> **Note**: If you are new to Environment Variables,
please see:
https://github.com/dwyl/learn-environment-variables


### 7. Run the App!

Run your phoenix app on localhost:

```
mix phx.server
```

Now open your web browser to: http://localhost:4000/admin

Given that you are not yet authenticated,
your request will be redirected to
https://authdemo.fly.dev/?referer=http://localhost:4000/admin&auth_client_id=etc

Once you have successfully authenticated with your GitHub or Google account,
you will be redirected back to `localhost:4000/admin`
where the `/admin` route will be visible.

![admin-route](https://user-images.githubusercontent.com/194400/80760439-d23b1580-8b30-11ea-8941-160ece8a4a5f.png)

## That's it!! 🎉

You just setup auth in a brand new phoenix app using **`auth_plug`**!

If you got stuck or have any questions,
please
[open an issue](https://github.com/dwyl/auth_plug/issues),
we are here to help!
