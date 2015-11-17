defmodule Mix.Tasks.Laired.Data.New do
  use Mix.Task

  alias Laired.Repo
  alias Laired.Tilemap
  alias Laired.TilemapLayer


  def run(_args) do
    IO.puts "Begin generating data"

    Mix.Task.run "ecto.drop",     ["Laired.Repo"]
    Mix.Task.run "ecto.create",   ["Laired.Repo"]
    Mix.Task.run "ecto.migrate",  ["Laired.Repo"]

    Repo.start_link

    tilemap = Repo.insert! %Tilemap {
      name: "small_lair",
      tile_width: 16,
      tile_height: 16,
      width: 4,
      height: 4,
      orientation: "orthogonal"
    }

    tilemap_layer = Repo.insert! %TilemapLayer {
      tilemap_id: tilemap.id,
      name: "things",
      width: 4,
      height: 4,
      x: 0,
      y: 0,
      type: "tilelayer",
      visible: true,
      opacity: 100,
      data: [
        1, 1, 1, 1,
        1, 1, 1, 1,
        1, 1, 1, 1,
        1, 1, 1, 1
      ]
    }

    # user = Repo.insert! %User {
    #   name: "perceptr", password: "perceptr"
    # }

    # guest = Repo.insert! %User {
    #   name: "guest", password: "guest"
    # }

    # std_module = Repo.insert! %Module {
    #   name: "standard",
    #   version: "0.0.0",
    #   visibility: "public",
    #   user_id: user.id
    # }

    # and_perceptron = Repo.insert! %Perceptron {
    #   name: "and",
    #   version: "0.0.0",
    #   module_id: std_module.id,
    #   input_size: 1,
    #   output_size: 1
    # }

    # and_perceptron_layer_0 = Repo.insert! %PerceptronLayer {
    #   input_count: 8,
    #   output_count: 8,
    #   layer_index: 0,
    #   perceptron_id: and_perceptron.id
    # }


    # and_perceptron_layer_1 = Repo.insert! %PerceptronLayer {
    #   input_count: 8,
    #   output_count: 8,
    #   layer_index: 1 ,
    #   perceptron_id: and_perceptron.id
    # }


    IO.puts "End generating data"
  end

end
