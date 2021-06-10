defmodule Day8Crawler do

  def main do
    ["https://thewaggletraining.github.io/"]
    |> SimpleCrawler2.main()
    |> insertData()
    |> IO.inspect()
    |> (&List.flatten(["uri", "domain", "body"], &1)).()
    |> IO.inspect()
    |> CSV.encode()
    |> Enum.take(5)
    |> Enum.join()
    |> (&File.write("page_info.csv",&1)).()
    #|> IO.inspect()
  end

  def insertData(data) do
    page_info = %Day8Crawler.PageInfo{}
    Enum.map(data, fn x ->
      Day8Crawler.PageInfo.changeset(page_info, x)
      |> Day8Crawler.Repo.insert()
      |> dataToList()

      # |> IO.inspect()
    end)
  end

  def dataToList(data) do
    # struct = elem(data, 1)
    {:ok, struct} = data
    [struct.uri, struct.domain, struct.body]
  end
end
