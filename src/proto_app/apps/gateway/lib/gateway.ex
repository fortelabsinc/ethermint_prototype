defmodule Gateway do
  @moduledoc """
  Documentation for Gateway.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Gateway.hello()
      :world

  """
  def hello do
    Gateway.Portal.test()
  end
end
