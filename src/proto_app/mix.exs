defmodule ProtoApp.MixProject do
  use Mix.Project

  #----------------------------------------------------------------------------
  # Project spec
  def project do
    [
      apps_path: "apps",
      version: "0.1.0",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      releases: [
        marketplace: marketplaceReleaseSpec(),
        bot: botReleaseSpec()
      ]
    ]
  end

  #----------------------------------------------------------------------------
  # Dependencies listed here are available only for this
  # project and cannot be accessed from applications inside
  # the apps folder.
  #
  # Run "mix help deps" for examples and options.
  defp deps do
    []
  end

  #----------------------------------------------------------------------------
  # Release spec for the Marketplace build
  #----------------------------------------------------------------------------
  defp marketplaceReleaseSpec() do
    [
      include_executables_for: [:unix],
      applications: [runtime_tools: :permanent]
    ]
  end

  #----------------------------------------------------------------------------
  # Release spec for the Bot build
  #----------------------------------------------------------------------------
  defp botReleaseSpec() do
    [
      include_executables_for: [:unix],
      applications: [runtime_tools: :permanent]
    ]
  end
end
