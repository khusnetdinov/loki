import Loki.Directory

temp = "temp"

if exists_directory?(temp), do: remove_directory(temp)

ExUnit.start()
