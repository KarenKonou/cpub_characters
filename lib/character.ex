defmodule CommonsPub.Characters.Character do

  use Pointers.Mixin,
    otp_app: :cpub_characters,
    source: "cpub_characters_character"

  alias Pointers.Changesets
  require Pointers.Changesets
  alias CommonsPub.Characters.Character
  alias Ecto.Changeset
  
  mixin_schema do
    field :username, :string
    field :username_hash, :string
  end

  @defaults [
    cast:     [:username],
    required: [:username],
    username: [ format: ~r(^[a-z][a-z0-9_]{2,30}$)i ],
  ]

  def changeset(char \\ %Character{}, attrs, opts \\ []) do
    Changesets.auto(char, attrs, opts, @defaults)
    |> Changesets.replicate_map_valid_change(:username, :username_hash, &hash/1)
    |> Changeset.unique_constraint(:username)
    |> Changeset.unique_constraint(:username_hash)
  end

  def hash(string), do: Base.encode64(:crypto.hash(:blake2b, string), padding: false)

  def redact(%Character{}=char), do: Changeset.change(char, username: nil)

end
defmodule CommonsPub.Characters.Character.Migration do

  import Ecto.Migration
  import Pointers.Migration
  alias CommonsPub.Characters.Character

  @character_table Character.__schema__(:source)

  def migrate_character(index_opts \\ [], dir \\ direction())

  def migrate_character(index_opts, :up) do
    create_mixin_table(Character) do
      add :username, :text
      add :username_hash, :text, null: false
    end
    create_if_not_exists(unique_index(@character_table, [:username], index_opts))
    create_if_not_exists(unique_index(@character_table, [:username_hash], index_opts))
  end

  def migrate_character(index_opts, :down) do
    drop_if_exists(unique_index(@character_table, [:username], index_opts))
    drop_if_exists(unique_index(@character_table, [:username_hash], index_opts))
    drop_mixin_table(Character)
  end

end
