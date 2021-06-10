defmodule SimpleCrawler2 do
  def main() do
    top_url = ["https://thewaggletraining.github.io/"]
    url_list1 =
      top_url
        |> searchLinksFromURLLists()
        |> properList()
    url_list2 =
      url_list1
        |> searchLinksFromURLLists()
        |> properList()
    url_list3 =
      url_list2
        |> searchLinksFromURLLists()
        |> properList()
    url_list4 =
      url_list3
        |> searchLinksFromURLLists()
        |> properList()
    url_list =
      [top_url, url_list1, url_list2, url_list3, url_list4]
        |> List.flatten()
        |> Enum.uniq()
    text_list =
      for url <- url_list do
        getText(url)
      end
    IO.inspect(url_list)
    IO.inspect(text_list)
  end

  def loop(list) do
    all_list = Enum.uniq(list ++ List.flatten(searchLinksFromURLLists(list)))
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

  def sample(n) do
    if n == 0 do
      n
    else
      sample(n-1)
    end
  end

end
