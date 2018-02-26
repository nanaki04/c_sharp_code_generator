defmodule CSharpCodeGenerator.Exporter do

  @type file :: String.t
  @type path :: String.t
  @type ok :: :ok
  @type error :: {:error, term}

  @spec export(file, path) :: ok | error
  def export(file, path) do
    path
    |> String.replace(~r/[\w\.]+(?=$)/, "")
    |> File.mkdir_p
    |> write_file(file, path)
  end

  @spec write_file(ok | error, file, path) :: ok | error
  defp write_file({:error, _reason}, _, path) do
    IO.puts("ERROR: failed to make dir \"" <> path <> "\"")
    {:error, :failed_to_make_dir}
  end

  defp write_file(:ok, file, path) do
    File.write(path, file)
    |> (fn
      {:error, _} ->
        IO.puts("ERROR: failed to write file \"" <> path <> "\"")
        {:error, :failed_to_write_file}
      :ok ->
        IO.puts("Generated file: " <> path)
        :ok
    end).()
  end
end
