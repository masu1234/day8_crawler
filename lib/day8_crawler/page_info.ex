defmodule Day8Crawler.PageInfo do
  use Ecto.Schema
  schema "page_info" do
    field :uri, :string
    field :domain, :string
    field :body, :string
  end

  def changeset(page_info, params \\ %{}) do
    page_info
      |> Ecto.Changeset.cast(params, [:uri, :domain, :body])
      |> Ecto.Changeset.validate_required([:uri, :domain, :body])
  end
end
