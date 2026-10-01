defmodule KaneIranaiApi do
  @moduledoc """
  Provides domain layers for the application. Implements HEX architecture.

  This module defines the four core layers of the Hexagonal Architecture:
  - Models (Domain Models) - Entities and Value Objects
  - Actions (Domain Services) - Business Logic
  - Services (Application Services) - Use Cases
  - Repositories - Persistence Adapters

  From outside to inside: Repository -> Service -> Action -> Model

  Which layer should use entities from layers on the right side.
  """

  @doc """
  Domain model layer
  """
  def model do
    quote do
      @self __MODULE__
      use Ecto.Schema
    end
  end

  @doc """
  Domain service layer
  """
  def action do
    quote do
    end
  end

  @doc """
  Application service layer
  """
  def service do
    quote do
      alias KaneIranaiApi.Repo
    end
  end

  @doc """
  Repository layer
  """
  def repository do
    quote do
      alias KaneIranaiApi.Repo
      import Ecto.Query, warn: false
      import Ecto.Changeset
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
