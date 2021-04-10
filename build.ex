# Remove previous versions
["../cjkinni.com", "../cjkinni.com/words"] |>
Enum.map(fn x -> BlogEngine.clear_directory(x) end)

# Generate Blog Posts & Index
BlogEngine.get_folder_contents("./words") |>
Enum.reverse() |>
Enum.map(fn x -> BlogEngine.read_blogpost(x) end) |>
Enum.map(fn x -> BlogEngine.split_header(x) end) |>
Enum.map(fn x -> BlogEngine.write_post(x) end) |>
BlogEngine.write_index()

# Copy static files
BlogEngine.get_folder_contents("./static") |>
Enum.map(fn x -> File.copy(x, "../cjkinni.com/#{Path.basename(x)}") end)