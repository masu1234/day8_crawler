defmodule Day8Crawler.Repo.Migrations.CreatePageInfo do
  use Ecto.Migration

  def change do
    create table(:page_info) do
      add :domain, :string
      add :uri, :string
      add :body, :string
    end

  end
end
