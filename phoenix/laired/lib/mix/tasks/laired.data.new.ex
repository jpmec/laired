defmodule Mix.Tasks.Laired.Data.New do
  use Mix.Task

  alias Laired.Bag
  alias Laired.DisplayGroup
  alias Laired.Hero
  alias Laired.HeroAbility
  alias Laired.HeroSkill
  alias Laired.Repo
  alias Laired.PhaserPhysicsBody
  alias Laired.Place
  alias Laired.Sprite
  alias Laired.SpriteAnimation
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


    hero_ability = Repo.insert! %HeroAbility {
      hero_id: hero.id,
      name: "run",
      data: %{"velocity" => 100}
    }


    hero_ability = Repo.insert! %HeroAbility {
      hero_id: hero.id,
      name: "jump",
      data: %{"velocity" => 200}
    }


    hero_skill = Repo.insert! %HeroSkill {
      hero_id: hero.id,
      name: "bunny_hop",
      data: %{
        "affects" => "jump",
        "modifier" => "linear",
        "gain" => 1.1,
        "bias" => 100
      }
    }


    hero_display_group = Repo.insert! %DisplayGroup {
      hero_id: hero.id,
      name: "HeroDisplayGroup"
    }


    bag = Repo.insert! %Bag {
      hero_id: hero.id,
      name: "Gyro's bag"
    }


    carrot_stuff = Repo.insert! %Stuff {
      name: "Carrot",
      description: "A tasty carrot",
      bag_id: bag.id
    }

    carrot_display_group = Repo.insert! %DisplayGroup {
      name: "CarrotDisplayGroup",
      stuff_id: carrot_stuff.id
    }

    carrot_sprite = Repo.insert! %Sprite {
      name: "Carrot",
      display_group_id: carrot_display_group.id
    }


    carrot_spritesheet = Repo.insert! %SpriteSheet {
      sprite_id: carrot_sprite.id,

      name: "Carrot",
      image: "carrot.png",
      imageheight: 21,
      imagewidth: 22
    }


    hero_sprite = Repo.insert! %Sprite {
      name: "Hero",
      display_group_id: hero_display_group.id
    }


    hero_sprite_body = Repo.insert! %PhaserPhysicsBody {
      sprite_id: hero_sprite.id,

      collideWorldBounds: true,
      bounce: %{
        y: 0.2
      },
      gravity: %{
        y: 250
      }
    }

    hero_spritesheet = Repo.insert! %SpriteSheet {
      sprite_id: hero_sprite.id,

      name: "Hero",
      image: "hero.png",
      imageheight: 28,
      imagewidth: 288
    }


    spriteanimation = Repo.insert! %SpriteAnimation {
      sprite_id: hero_sprite.id,

      name: "run_left",
      frames: [0, 1, 2, 3],
      framerate: 10,
      loop: true
    }


    spriteanimation = Repo.insert! %SpriteAnimation {
      sprite_id: hero_sprite.id,

      name: "run_right",
      frames: [5, 6, 7, 8],
      framerate: 10,
      loop: true
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
