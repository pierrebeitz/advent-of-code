defmodule Pierre.MixProject do
  use Mix.Project

  def project do
    [
      app: :pierre,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application, do: [extra_applications: [:logger]]
  defp deps, do: []
end
