// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "deps/phoenix_html/web/static/js/phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

import socket from "./socket"


var lairedApp = angular.module('lairedApp',
    [
        'ngResource',
        'laired.Angel',
        'laired.Bag',
        'laired.BagViewer',
        'laired.Chat',
        'laired.DisplayGroup',
        'laired.DisplayGroupViewer',
        'laired.Game',
        'laired.Hero',
        'laired.HeroViewer',
        'laired.Images',
        'laired.Place',
        'laired.PlaceViewer',
        'laired.Sprite',
        'laired.SpriteViewer',
        'laired.SpriteSheet',
        'laired.SpriteSheetViewer',
        'laired.Stuff',
        'laired.StuffViewer',
        'laired.Stuff.Shovel',
        'laired.Tile',
        'laired.TileViewer',
        'laired.Tilemap',
        'laired.TilemapViewer',
        'laired.Tileset',
        'laired.TilesetTileSelecter',
        'laired.TilesetViewer',
        'laired.Thing.Dirt'
    ]
);
