BlogEngine.get_folder_contents("./words") |>
Enum.map(fn x -> BlogEngine.read_blogpost(x) end) |>
Enum.map(fn x -> BlogEngine.split_header(x) end) |>
Enum.map(fn x -> BlogEngine.write_post(x) end) |>
BlogEngine.write_index()

