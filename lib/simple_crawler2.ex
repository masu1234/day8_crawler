defmodule SimpleCrawler2 do
  def main(top_url) do
    url_list = loop(top_url)
    # text_list =
    #   for url <- url_list do
    #     getText(url)
    #   end
    domain = "thewaggletraining.github.io/"

    Enum.map(url_list, fn x ->
      %{uri: x, domain: domain, body: getText(x)}
    end)

  end

  def loop(list) do
    all_list =
    list
    |> searchLinksFromURLLists()
    |> properList()
    |> List.flatten(list)
    |> Enum.uniq()
    if all_list == list do
      all_list
    else
      loop(all_list)
    end
  end

  def properList(list) do
    func = &String.contains?/2
    list
      |> List.flatten()
      |> Enum.filter(fn x -> x end)
      |> Enum.filter(fn x -> func.(x, "https://thewaggletraining.github.io/") end)
  end

  def searchLinksFromURL(url) do
    html = HTTPoison.get(url)
    {:ok, document} = Floki.parse_document(elem(html,1).body)
    document
      |> Floki.find("a")
      |> Floki.attribute("href")
  end

  def searchLinksFromURLLists(url_list) do
    for i <- url_list do
      searchLinksFromURL(i)
    end
  end

  def getText(url) do
    html = HTTPoison.get(url)
    {:ok, document} = Floki.parse_document(elem(html,1).body)
    document
    |> Floki.find("html")
    |> Floki.text()
  end
end
