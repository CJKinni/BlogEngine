defmodule BlogEngine do
  @moduledoc """
  Documentation for `BlogEngine`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> BlogEngine.hello()
      :world

  """

  def clear_directory(folder) do
    BlogEngine.get_folder_contents(folder) |>
    Enum.map(fn x -> File.rm(x) end)
  end

  def get_folder_contents(folder) do
    Path.wildcard("#{folder}/*")
  end

  def read_blogpost(filename) do
    {_, contents} = File.read(filename)
    %{filename: filename, contents: contents}
  end

  def split_header(text, url_prefix) do
    [header | body_array] = String.split(text[:contents], "---")
    [body] = body_array
    basename = Path.basename(text[:filename])
    url = url_prefix <> basename
    {_, yaml} = YamlElixir.read_from_string(header)
    Map.merge(yaml, %{body: body, url: url, basename: basename})
  end

  def remove_drafts(posts) do
    Enum.reject(posts, fn x -> Map.has_key?(x, "draft") end)
  end

  def write_post(post) do
    File.write("../cjkinni.com/words/#{post[:basename]}", render_post(post))
    post
  end

  def write_index(posts) do
    File.write("../cjkinni.com/index.html", render_index(posts))
    posts
  end

  def write_atom(posts, site_info) do
    File.write("../cjkinni.com/atom.xml", render_atom(posts, site_info))
    posts
  end

  def get_template(filename) do
    {_, contents} = File.read("./templates/#{filename}")
    contents
  end

  def md_to_html(markdown) do
    Earmark.as_html!(markdown, compact_output: true, escape: false, smartypants: false)
  end

  def render_post(post) do
    html_doc = md_to_html(post[:body])
    EEx.eval_string(BlogEngine.get_template("words.html"), body: html_doc, title: post[:title])
  end

  def render_index(posts) do
    EEx.eval_string(BlogEngine.get_template("index.html"), posts: posts)
  end

  def render_atom(posts, site_info) do
    last_updated = List.first(posts)["date"] <> "T05:00:00.Z"
    EEx.eval_string(BlogEngine.get_template("atom.xml"), posts: posts, site: site_info, last_updated: last_updated)
  end
end
