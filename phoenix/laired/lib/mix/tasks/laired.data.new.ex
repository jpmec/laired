defmodule Mix.Tasks.Laired.Data.New do
  use Mix.Task

  alias Laired.Repo
  alias Laired.Tilemap
  alias Laired.TilemapLayer
  alias Laired.Tileset


  def run(_args) do
    IO.puts "Begin generating data"

    Mix.Task.run "ecto.drop",     ["Laired.Repo"]
    Mix.Task.run "ecto.create",   ["Laired.Repo"]
    Mix.Task.run "ecto.migrate",  ["Laired.Repo"]

    Repo.start_link

    tilemap = Repo.insert! %Tilemap {
      name: "small_lair",
      tilewidth: 64,
      tileheight: 64,
      width: 10,
      height: 10,
      orientation: "orthogonal",
      version: 1
    }

    tilemap_layer = Repo.insert! %TilemapLayer {
      tilemap_id: tilemap.id,
      name: "ground",
      width: 10,
      height: 10,
      x: 0,
      y: 0,
      type: "tilelayer",
      visible: true,
      opacity: 1,
      data: [
         1,  2,  3,  4,  5, 1,  2,  3,  4,  5,
         1,  2,  3,  4,  5, 1,  2,  3,  4,  5,
         1,  2,  3,  4,  5, 1,  2,  3,  4,  5,
         1,  2,  3,  4,  5, 1,  2,  3,  4,  5,
         1,  2,  3,  4,  5, 1,  2,  3,  4,  5,
         1,  2,  3,  4,  5, 1,  2,  3,  4,  5,
         1,  2,  3,  4,  5, 1,  2,  3,  4,  5,
         1,  2,  3,  4,  5, 1,  2,  3,  4,  5,
         1,  2,  3,  4,  5, 1,  2,  3,  4,  5,
         1,  2,  3,  4,  5, 1,  2,  3,  4,  5
      ]
    }

    tileset = Repo.insert! %Tileset {
      tilemap_id: tilemap.id,
      name: "underground_lair_tiles",
      firstgid: 1,
      image: "underground_lair_tiles.png",
      imageheight: 64,
      imagewidth: 384,
      tileheight: 64,
      tilewidth: 64,
      margin: 0,
      spacing: 0
    }

    IO.puts "End generating data"
  end

end
