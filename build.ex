# Remove previous versions
["../cjkinni.github.io", "../cjkinni.github.io/words"] |>
Enum.map(fn x -> BlogEngine.clear_directory(x) end)

site_info = %{
	title: "CJKinni.com",
	subtitle: "😊",
	url: "https://cjkinni.com",
	author: %{
		name: "CJKinni",
		email: "chris@cjkinni.com"
	}
}

# Generate Blog Posts & Index & Atom
BlogEngine.get_folder_contents("./words") |>
Enum.reverse() |>
Enum.map(fn x -> BlogEngine.read_blogpost(x) end) |>
Enum.map(fn x -> BlogEngine.split_header(x, "/words/") end) |>
BlogEngine.remove_drafts() |>
Enum.map(fn x -> BlogEngine.write_post(x) end) |>
BlogEngine.write_index() |>
BlogEngine.write_atom(site_info)

# Copy static files
BlogEngine.get_folder_contents("./static") |>
Enum.map(fn x -> File.copy(x, "../cjkinni.com/#{Path.basename(x)}") end)