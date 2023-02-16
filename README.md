# Running Elixir in a Container

## Kick off Container running EIX REPL
User this command to run the official Elixir container with a bind-mount to the local directory.
>
> docker run -it --rm --mount type=bind,src=$(pwd),target=/data elixir
>
This command should run the container in an interactive shell with the local directory visible within the container at the path `/data/*`

## Add a persisant volume for Mix Packages
In order to avoid re-fetching mix packages and the Hex package manager, create a volume, and then attach that to the container
>
> docker volume create elixir-mix
>
and then...
>
> docker run -it --rm --mount type=bind,src=$(pwd),target=/data -v elixir-mix:/root/.mix elixir
>

## Kick off Elixir Container in Linux BASH Shell
Add `bash` at the end of the docker run command to enter the shell in bash instead of in iex.
>
> docker run -it --rm --mount type=bind,src=$(pwd),target=/data -v elixir-mix:/root/.mix elixir bash
>
Then, within the elixir container, the current local (host os) directory will appear at the path `/data`
