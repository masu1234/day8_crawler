defmodule Day8Crawler do

  def main do
    ["https://thewaggletraining.github.io/"]
    |> SimpleCrawler2.main()
    |> insertData()
  end

  def insertData(data) do
    page_info = %Day8Crawler.PageInfo{}
    Enum.each(data, fn x ->
      Day8Crawler.PageInfo.changeset(page_info, x)
      |> Day8Crawler.Repo.insert()
    end)
  end
end
