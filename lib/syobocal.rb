require "open-uri"
require "rexml/document"
require "delegate"
require "json"
require "rss"
require "syobocal/version"

require "syobocal/util"
require "syobocal/calchk"
require "syobocal/db"
require "syobocal/json"
require "syobocal/rss"
require "syobocal/rss2"
require "syobocal/comment/element/blank"
require "syobocal/comment/element/header1"
require "syobocal/comment/element/header2"
require "syobocal/comment/element/link"
require "syobocal/comment/element/list"
require "syobocal/comment/element/row"
require "syobocal/comment/element/text"
require "syobocal/comment/element/text_node"
require "syobocal/comment/element/root"
require "syobocal/comment/parser"
require "syobocal/comment/staff"
require "syobocal/comment/cast"
require "syobocal/comment/person"
require "syobocal/comment/music"
require "syobocal/comment/music_data"
require "syobocal/comment/section"
require "syobocal/sub_titles/sub_title"
require "syobocal/sub_titles/parser"

module Syobocal; end
