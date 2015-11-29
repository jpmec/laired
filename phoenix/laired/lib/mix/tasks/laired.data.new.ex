defmodule Mix.Tasks.Laired.Data.New do
  use Mix.Task

  alias Laired.Bag
  alias Laired.Hero
  alias Laired.Repo
  alias Laired.Place
  alias Laired.Sprite
  alias Laired.SpriteSheet
  alias Laired.Stuff
  alias Laired.Tilemap
  alias Laired.TilemapLayer
  alias Laired.Tileset


  def run(_args) do
    IO.puts "Begin generating data"

    Mix.Task.run "ecto.drop",     ["Laired.Repo"]
    Mix.Task.run "ecto.create",   ["Laired.Repo"]
    Mix.Task.run "ecto.migrate",  ["Laired.Repo"]

    Repo.start_link


    hero = Repo.insert! %Hero {
      name: "Gyro"
    }


    bag = Repo.insert! %Bag {
      hero_id: hero.id,
      name: "Gyro's bag"
    }


    carrot = Repo.insert! %Stuff {
      name: "Carrot",
      description: "A tasty carrot",
      bag_id: bag.id
    }


    sprite_sheet = Repo.insert! %SpriteSheet {
      name: "Carrot",
      image: "carrot.png",
      imageheight: 21,
      imagewidth: 22
    }


    place = Repo.insert! %Place {
      name: "small_lair"
    }


    tilemap = Repo.insert! %Tilemap {
      place_id: place.id,
      name: "small_lair",
      tilewidth: 64,
      tileheight: 64,
      width: 10,
      height: 10,
      orientation: "orthogonal",
      version: 1
    }


    tilemap_background_layer = Repo.insert! %TilemapLayer {
      tilemap_id: tilemap.id,
      name: "background",
      width: 10,
      height: 10,
      x: 0,
      y: 0,
      type: "tilelayer",
      visible: true,
      opacity: 1,
      data: [
         2, 2, 2, 2, 2, 2, 1, 1, 1, 2,
         2, 1, 1, 1, 1, 1, 1, 1, 1, 2,
         2, 1, 1, 1, 1, 1, 1, 1, 1, 2,
         2, 1, 1, 1, 1, 1, 1, 1, 1, 2,
         2, 1, 1, 1, 1, 1, 1, 1, 1, 2,
         2, 1, 1, 1, 1, 1, 1, 1, 1, 2,
         2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
         2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
         2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
         2, 2, 2, 2, 2, 2, 2, 2, 2, 2
      ]
    }


    tilemap_ground_layer = Repo.insert! %TilemapLayer {
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
         2, 2, 2, 2, 2, 2, 2, 0, 2, 2,
         2, 5, 1, 1, 1, 1, 0, 0, 1, 2,
         2, 5, 5, 1, 1, 1, 0, 1, 5, 2,
         2, 5, 5, 5, 1, 1, 1, 5, 5, 2,
         2, 6, 5, 5, 5, 5, 5, 5, 5, 2,
         2, 6, 6, 6, 6, 6, 6, 6, 6, 2,
         2, 4, 4, 4, 4, 4, 4, 4, 4, 2,
         2, 2, 4, 4, 4, 2, 4, 4, 4, 2,
         2, 2, 2, 4, 2, 2, 2, 4, 3, 2,
         2, 2, 2, 2, 2, 2, 2, 2, 2, 2
      ]
    }


    Repo.insert! %Tileset {
      tilemap_id: tilemap.id,
      name: "underground_lair_background_tiles",
      firstgid: 1,
      image: "underground_lair_background_tiles.png",
      imageheight: 64,
      imagewidth: 128,
      tileheight: 64,
      tilewidth: 64,
      margin: 0,
      spacing: 0
    }


    Repo.insert! %Tileset {
      tilemap_id: tilemap.id,
      name: "underground_lair_ground_tiles",
      firstgid: 1,
      image: "underground_lair_ground_tiles.png",
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
