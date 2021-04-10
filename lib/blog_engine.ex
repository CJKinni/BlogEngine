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
  def get_folder_contents(folder) do
    Path.wildcard("#{folder}/*")
  end

  def read_blogpost(filename) do
    {_, contents} = File.read(filename)
    %{filename: filename, contents: contents}
  end

  def split_header(text) do
    [header | body] = String.split(text[:contents], "---")
    {_, yaml} = YamlElixir.read_from_string(header)
    %{yaml: yaml, body: body, basename: Path.basename(text[:filename])}
  end

  def write_post(post) do
    # cjkinni.com is our base directory
    File.write("../cjkinni.com/words/#{post[:basename]}", render_post(post))
    post
  end

  def write_index(posts) do
    # cjkinni.com is our base directory
    File.write("../cjkinni.com/index.html", render_index(posts))
    posts
  end

  def get_template(filename) do
    {_, contents} = File.read("./templates/#{filename}")
    contents
  end

  def render_post(post) do
    [body] = post[:body]
    yaml = post[:yaml]
    IO.inspect(yaml)
    IO.inspect(yaml["title"])
    html_doc = Earmark.as_html!(body, compact_output: true, escape: false, smartypants: false)
    EEx.eval_string(BlogEngine.get_template("words.html"), body: html_doc, title: yaml["title"])
  end

  def render_index(posts) do
    EEx.eval_string(BlogEngine.get_template("index.html"), posts: posts)
  end
end
